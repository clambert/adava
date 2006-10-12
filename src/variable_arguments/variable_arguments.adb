--------------------------------------------------------------------------------
--  *  Body name avcall.adb
--  *
--  *  Created by Charles Lambert on 9/29/06.
--  *  Copyright (c) 2006 Charles Lambert.
--------------------------------------------------------------------------------
with General_Access;
with Ada.Text_IO; use Ada.Text_IO;
--------------------------------------------------------------------------------
package body Variable_Arguments is
	use General_Access;
	----------------------------------------------------------------------------
	-- calls c's malloc for the av_alist * that is stored in Var_Args.Av_List
	function Av_AList_Malloc return Void_Access;
	pragma Import(C, Av_AList_Malloc, "av_alist_malloc");
	----------------------------------------------------------------------------
	-- The returning of Empty creates an initialized instance of Var_Args.
	-- Controlled is not used because Initialize and Finalize are called during
	-- assignment (with intermediate objects, see RM). Since this is how users
	-- get an instance of Var_Args, we want to be sure that Var_Arg.Av_List only
	-- gets malloc'd once (by calling Av_List_Malloc). The procedure Call is
	-- responsible for freeing Av_List (by calling Av_List_Free).
	function Start_Argument_List return Argument_List is
		Empty : Argument_List;
	begin
		Empty.Count := new Argument_Count'(0);
		Empty.Av_AList := Av_AList_Malloc;
		return Empty;
	end Start_Argument_List;
	----------------------------------------------------------------------------
	function Has_Max_Arguments(AList : Argument_List) return Boolean is
	begin
		return AList.Count.all = Max_Arguments;
	end Has_Max_Arguments;
	----------------------------------------------------------------------------
	procedure Free_Argument(Arg : Argument) is begin null; end Free_Argument;
	procedure Free(Arg : Argument'Class) is
	begin
		Free_Argument(Arg);
	end Free;
end Variable_Arguments;
--------------------------------------------------------------------------------
