--------------------------------------------------------------------------------
--  *  Body name AutoGen.adb
--  *
--  *  Created by Charles Lambert on 10/3/06.
--  *  Copyright (c) 2006 Charles Lambert.
--------------------------------------------------------------------------------
with Variable_Arguments.Auto_Generation; use Variable_Arguments.Auto_Generation;
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
	Write_Templates_IC(Params);
end AutoGen;
