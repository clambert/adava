--------------------------------------------------------------------------------
--  *  Body name variable_arguments-for_implementors.adb
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
with General_Access;
with Ada.Unchecked_Deallocation;
--------------------------------------------------------------------------------
package body Variable_Arguments.For_Implementors is
	----------------------------------------------------------------------------
	use General_Access;
	----------------------------------------------------------------------------
	-- calls c's free for the av_list * that is stored in Var_Args.Av_List
	procedure Av_AList_Free(Av_List : Void_Access);
	pragma Import(C, Av_AList_Free, "av_alist_free");
	----------------------------------------------------------------------------
	procedure Av_Call(Av_AList : Void_Access);
	pragma Import(C, Av_Call, "av_call_wrapper");
	----------------------------------------------------------------------------
	procedure Av_Start_Void(
			Av_AList   : Void_Access; 
			C_Function : C_Function_Access);
	pragma Import(C, Av_Start_Void, "av_start_void_wrapper");
	----------------------------------------------------------------------------
	-- When this is implemented it must call Av_List_Free
	function Call(AList : Argument_List) return Return_Type is
		type Return_Type_Access is access all Return_Type;
		package Conversion is new Void_Conversion(
			Any_Convention_C_Type => Return_Type,
			Convert_From_Access => Return_Type_Access);
		use Conversion;
		procedure Free is new Ada.Unchecked_Deallocation(
			Object => Return_Type,
			Name   => Return_Type_Access);
		Return_Value  : aliased Return_Type;
		Value         : Void_Access;
		Av_AList      : Void_Access         := AList.Av_AList;
		Count         : Argument_Count      := AList.Count.all;
		Return_Access : Return_Type_Access := Return_Value'Access;
		Return_Void_Access : Void_Access := To_Void_Access(Return_Access);
	begin
		Register_Function(Av_AList, C_Function, Return_Void_Access);
		for K in 1..Count loop
			Value := AList.Arguments(K).Value;
			AList.Arguments(K).Add_Argument(Av_AList, Value);
		end loop;
		Av_Call(Av_AList);
		for K in 1..Count loop
			Free(AList.Arguments(K));
		end loop;
		Av_AList_Free(Av_AList);
		return Return_Value;
	end Call;
	----------------------------------------------------------------------------
	procedure Call_No_Return(AList : Argument_List) is
		Value    : Void_Access;
		Av_AList : Void_Access    := AList.Av_AList;
		Count    : Argument_Count := AList.Count.all;
	begin
		Av_Start_Void(Av_AList, C_Function);
		for K in 1..Count loop
			Value := AList.Arguments(K).Value;
			AList.Arguments(K).Add_Argument(Av_AList, Value);
		end loop;
		Av_Call(Av_AList);
		for K in 1..Count loop
			Free(AList.Arguments(K));
		end loop;
		Av_AList_Free(Av_AList);
	end Call_No_Return;
end Variable_Arguments.For_Implementors;
