--------------------------------------------------------------------------------
--  *  Spec name variable_arguments-auto_geneneration.ads
--  *
--  *  Created by Charles Lambert on 10/6/06.
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
package variable_arguments.auto_generation is
	type Parameters is private;
	type Parameters_Array is array(Positive range <>) of Parameters;
	function Get_Parameters(ID, AdaType, CType : String) return Parameters;
	procedure Replace_Tags(Template : in out Unbounded_String; P : Parameters);
	procedure Write_Templates(P : Parameters_Array);
	procedure Write_Templates_IC(P : Parameters_Array);
private
	type Parameters is record
		ID : Unbounded_String;
		AdaType : Unbounded_String;
		CType : Unbounded_String;
	end record;
end variable_arguments.auto_generation;
