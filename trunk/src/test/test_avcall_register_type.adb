--------------------------------------------------------------------------------
--  *  Body name test_avcall_register_type.adb
--  *
--  *  Created by Charles Lambert on 9/30/06.
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
