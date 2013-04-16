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
		var/__max_size     = 0
		var/list/__entries = null
		
		New(var/size as num)
			src.__max_size = size
			
		proc
			get(var/key)
				if (src.__contains(key))
					src.__hit(key)
					return src.__entries[key]
				return null
			
			put(var/key, var/value)
				src.__insert(key)
				if (src.__entries == null)
					src.__entries = new()
				src.__entries[key] = value
			
			remove(var/key)
				src.__evict(key)
				if (src.__entries != null)
					src.__entries[key] = null
					if (length(src.__entries) < 1)
						src.__entries = null
			
			set_size(var/I as num)
				if (!isnum(I) || I < 1)
					return
				var/list/keys = src.__set_size(I - src.__max_size)
				if (keys != null)
					for (var/key in keys)
						src.__entries[key] = null
					if (length(src.__entries) < 1)
						src.__entries = null
				src.__max_size = I
			
			__contains(var/key)
				return FALSE
			
			__hit(var/key)
				return null
			
			__put(var/key)
				return
			
			__evict(var/key)
				return
			
			__set_size(var/I as num)
				return null