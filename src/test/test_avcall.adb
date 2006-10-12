--------------------------------------------------------------------------------
--  *  Body name test_avcall.adb
--  *
--  *  Created by Charles Lambert on 9/30/06.
--  *  Copyright (c) 2006 Charles Lambert.
--------------------------------------------------------------------------------
with AvCall; use AvCall;
with Ada.Text_IO; use Ada.Text_IO;
with System; use System;
with System.Storage_Elements; use System.Storage_Elements;
with Ada.Finalization; use Ada.Finalization;
procedure test_avcall is
	va : Var_Args := Start_Var_Args;
	procedure My_Av_Param(Av_List : System.Address; Value : System.Address) is
	begin
		null;
	end My_Av_Param;
begin
	Put_Line("test");
	va.Count.all := va.Count.all + 1;
	va.List.all(va.Count.all).Value_Address := System.Null_Address;
	va.List.all(va.Count.all).Av_Param := My_Av_Param'Access;
	Put_Line(Integer'Image(va.Count.all));
	Put_Line("address: " & Integer'Image(Integer(To_Integer(va.Av_List))));
	Clean_Up(va);
end test_avcall;

