--------------------------------------------------------------------------------
--  *  Spec name variable_arguments-for_implementors-register_type.ads
--  *
--  *  Created by Charles Lambert on 10/3/06.
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
with General_Access; use General_Access;
--------------------------------------------------------------------------------
generic
	----------------------------------------------------------------------------
	type Any_Convention_C_Type is private;
	Add_Argument : Add_Argument_Access;
	----------------------------------------------------------------------------
package Variable_Arguments.For_Implementors.Register_Type is
	----------------------------------------------------------------------------
	function Append (
		AList : Argument_List;
		Arg   : Any_Convention_C_Type)
		return Argument_List;
	----------------------------------------------------------------------------
	procedure Prepend (
		AList : in out Argument_List;
		Arg   :        Any_Convention_C_Type);
	----------------------------------------------------------------------------
private
	type Any_Access is access all Any_Convention_C_Type;
	----------------------------------------------------------------------------
	type Argument_Instance is new Argument with
		record
			Instance_Value : Any_Access;
		end record;
	procedure Free_Argument(Arg : Argument_Instance);
	----------------------------------------------------------------------------
end Variable_Arguments.For_Implementors.Register_Type;
