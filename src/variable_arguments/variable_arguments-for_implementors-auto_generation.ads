--------------------------------------------------------------------------------
--  *  Spec name variable_arguments-for_implementors-auto_geneneration.ads
--  *
--  *  Created by Charles Lambert on 10/5/06.
--  *  Copyright (c) 2006 Charles Lambert.
--  * 
--  * This program is free software; you can redistribute it and/or
--  * modify it under the terms of the GNU General Public License
--  * as published by the Free Software Foundation; either version 2
--  * of the License, or (at your option) any later version.
--  * 
--  * This program is distributed in the hope that it will be useful,
--  * but WITHOUT ANY WARRANTY; without even the implied warranty of
--  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  * GNU General Public License for more details.
--  * 
--  * You should have received a copy of the GNU General Public License
--  * along with this program; if not, write to the Free Software
--  * Foundation, Inc., 51 Franklin Street, Fifth Floor, 
--  * Boston, MA  02110-1301, USA.
--------------------------------------------------------------------------------
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
package Variable_Arguments.For_Implementors.Auto_Generation is
	function Load_File(File_Name : String) return Unbounded_String;
	procedure Load_File_Tags(Template : in out Unbounded_String);
	procedure Replace_All(
		Template    : in out Unbounded_String;
		To_Replace  :        String;
		Replacement :        String);
	procedure Replace_Tag(
		Template    : in out Unbounded_String;
		Tag_Name    :        String;
		Replacement :        String);
	procedure Replace_Insertion_Point(
		Template        : in out Unbounded_String;
		Insertion_Point :        String;
		Replacement     :        String);
private
end Variable_Arguments.For_Implementors.Auto_Generation;
