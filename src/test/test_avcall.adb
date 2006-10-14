--------------------------------------------------------------------------------
--  *  Body name test_avcall.adb
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

