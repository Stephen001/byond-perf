/*****************************************************************************************
 * This file is part of the BYOND Performance Library.                                   *
 *                                                                                       *
 * The BYOND Performance Library is free software: you can redistribute it and/or modify *
 * it under the terms of the GNU Lesser General Public License as published by           *
 * the Free Software Foundation, either version 3 of the License, or                     *
 * (at your option) any later version.                                                   *
 *                                                                                       *
 * The BYOND Performance Library is distributed in the hope that it will be useful,      *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of                        *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                         *
 * GNU Lesser General Public License for more details.                                   *
 *                                                                                       *
 * You should have received a copy of the GNU Lesser General Public License              *
 * along with the BYOND Performance Library. If not, see <http://www.gnu.org/licenses/>. *
 *****************************************************************************************/

Cache
	LRUCache
		var/list/__keys = null
		
		__contains(var/key)
			return src.keys != null && (key in src.__keys)
		
		__hit(var/key)
			src.__keys -= key
			src.__keys.Insert(1, key)
		
		__insert(var/key)
			if (src.__keys != null)
				if (length(src.__keys.len == src._max_size)
					src.remove(src.__keys[src._max_size])
			else
				src.__keys = new()
			src.__hit(key)
		
		__evict(var/key)
			src.__keys -= key
			if (src.__keys.len < 1)
				src.__keys = null
		
		__set_size(var/I as num)
			if (I > -1 || src.__keys == null)
				return null
			var/list/result = src.__keys.Copy(src._max_size + I)
			src.__keys.len = src._max_size + I
			return result