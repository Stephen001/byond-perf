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

Item

var/list/L = new()

client
	verb
		Run_LRU_Cache_Tests()
			var/Cache/LRUCache/C = new(5)
			var/Item/I1 = new()
			var/Item/I2 = new()
			var/Item/I3 = new()
			var/Item/I4 = new()
			var/Item/I5 = new()
			var/Item/I6 = new()
			C.put("1", I1)
			C.put("2", I2)
			C.put("3", I3)
			C.put("4", I4)
			C.put("5", I5)
			C.put("6", I6)
			if (!isnull(C.get("1")))
				src << "The Cache did not clear out 1"
			src << "LRU Cache tests completed."

		Run_LRU_Cache_Profile_Prepare(var/N as num)
			L = new()
			for (var/I in 0 to N)
				L.Add(new/Item())

		Run_LRU_Cache_Profile_Sequential_Put(var/cache_size as num, var/runs as num)
			var/Cache/LRUCache/C = new(cache_size)
			for (var/A in 0 to (runs - 1))
				for (var/Item/I in L)
					C.put("\ref[I]", I)