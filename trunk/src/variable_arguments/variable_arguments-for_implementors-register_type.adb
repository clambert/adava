--------------------------------------------------------------------------------
--  *  Body name variable_arguments-for_implementors-register_type.adb
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
with Ada.Unchecked_Deallocation;
with General_Access; use General_Access;
package body Variable_Arguments.For_Implementors.Register_Type is
	------------------------------------------------------------------------
	package Conversion is new Void_Conversion(
		Any_Convention_C_Type => Any_Convention_C_Type,
		Convert_From_Access   => Any_Access);
	use Conversion;
	------------------------------------------------------------------------
	function Get_Argument(
			Arg : Any_Convention_C_Type) 
			return Argument_Instance is
		--------------------------------------------------------------------
		Info : Argument_Instance;
		--------------------------------------------------------------------
	begin
		Info.Instance_Value := new Any_Convention_C_Type;
		Info.Instance_Value.all := Arg;
		Info.Value := To_Void_Access(Info.Instance_Value);
		Info.Add_Argument := Add_Argument;
		return Info;
	end Get_Argument;
	------------------------------------------------------------------------
	function Append(
			AList : Argument_List; 
			Arg   : Any_Convention_C_Type)
			return Argument_List is
		--------------------------------------------------------------------
		Info : Argument_Instance := Get_Argument(Arg);
		--------------------------------------------------------------------
	begin
		AList.Count.all := AList.Count.all + 1;
		AList.Arguments(AList.Count.all) := Argument(Info);
		return AList;
	end Append;
	------------------------------------------------------------------------
	procedure Prepend(
			AList : in out Argument_List;
			Arg   :        Any_Convention_C_Type) is
		--------------------------------------------------------------------
		Info : Argument_Instance := Get_Argument(Arg);
		--------------------------------------------------------------------
	begin
		if AList.Count.all /= 0 then
			-- scoot them over one
			AList.Arguments(2..AList.Count.all+1) := 
					AList.Arguments(1..AList.Count.all);
		end if;
		-- stick the new one on the front
		AList.Arguments(1) := Argument(Info);
		AList.Count.all := AList.Count.all+1;
	end Prepend;
	------------------------------------------------------------------------
	procedure Free_Arg is new Ada.Unchecked_Deallocation(
		Object => Any_Convention_C_Type,
		Name   => Any_Access);
	procedure Free_Argument(Arg : Argument_Instance) is
		Tmp : Any_Access := Arg.Instance_Value;
	begin
		Free_Arg(Tmp);
	end Free_Argument;
end Variable_Arguments.For_Implementors.Register_Type;
