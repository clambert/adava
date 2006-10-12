--------------------------------------------------------------------------------
--  *  Body name test_avcall_register_type.adb
--  *
--  *  Created by Charles Lambert on 9/30/06.
--  *  Copyright (c) 2006 Charles Lambert.
--------------------------------------------------------------------------------
with avcall; use avcall;
with Ada.Text_IO; use Ada.Text_IO;
with System; use System;
with avcall.register_type;
with ir; use ir;
--------------------------------------------------------------------------------
procedure test_avcall_register_type is
	
	avpa : avp_Access := Av_Param'Access;
	package Int_Registered is new avcall.register_type(Any_Type => Integer,
		avpa => avpa);
	--Av_Param_Instance => Av_Param);
begin
	Put_Line("FOO");
end test_avcall_register_type;
--------------------------------------------------------------------------------
