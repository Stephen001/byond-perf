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
		var/__max_size		= 0
		var/list/__entries 	= new()
		var/list/__keys 	= new()

		New(var/size as num)
			src.__max_size = size

		proc
			get(var/key)
				if (key in src.__keys)
					src.__keys -= key
					src.__keys.Insert(1, key)
					return src.__entries[key]

			put(var/key, var/value)
				var/old = get(key)
				if (old != value)
					if (!(key in src.__keys))
						src.__keys.Insert(1, key)
						var/length = length(src.__keys)
						if (length >= src.__max_size)
							for (var/i in 1 to (length - src.__max_size + 1))
								remove(src.__keys[length(src.__keys)])
					src.__entries[key] = value

			remove(var/key)
				if (key in src.__keys)
					src.__keys -= key
					src.__entries[key] = null

			set_size(var/I as num)
				if (!isnum(I) || I < 1)
					return
				src.__keys.len = I
				src.__max_size = I
				for (var/key in src.__entries)
					if (!(key in src.__keys))
						src.__entries[key] = null
