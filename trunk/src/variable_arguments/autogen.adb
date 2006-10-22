--------------------------------------------------------------------------------
--  *  Body name AutoGen.adb
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
with Variable_Arguments.Auto_Generation; use Variable_Arguments.Auto_Generation;
with Ada.Text_IO;
procedure AutoGen is
	Params : Parameters_Array := (
		Get_Parameters("uchar", "Unsigned_Char", "unsigned char"),
		Get_Parameters("char", "Signed_Char", "char"),
		Get_Parameters("ushort", "Unsigned_Short", "unsigned short"),
		Get_Parameters("short", "Short", "short"),
		Get_Parameters("uint", "Unsigned", "unsigned int"),
		Get_Parameters("int", "Int", "int"),
		Get_Parameters("ulong", "Unsigned_Long", "unsigned long"),
		Get_Parameters("long", "Long", "long"),
		Get_Parameters("float", "C_Float", "float"),
		Get_Parameters("double", "Double", "double"),
		Get_Parameters("longdouble", "Long_Double", "long double")
		);
	
begin
	Write_Templates_IC(Params, "../src/variable_arguments/","../src/variable_arguments/","../templates/");
end AutoGen;
