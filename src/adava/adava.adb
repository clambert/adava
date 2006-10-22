--------------------------------------------------------------------------------
--  *  Body name adava.adb
--  *
--  *  Created by Charles Lambert on 10/11/06.
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
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Strings; use Ada.Strings;
with Ada.Text_IO;
with Ada.Command_Line;
with Ada.Directories;
procedure adava is
	----------------------------------------------------------------------------
	procedure Print_Usage is
		package IO renames Ada.Text_IO;
	begin
		IO.Put_Line("adava [-c <c_path>] [-a <a_path>] [-t <t_path>]");
		IO.Put_Line("   or");
		IO.Put_Line("adava -h");
		IO.Put_Line("   or");
		IO.Put_Line("adava -gpl");
		IO.New_Line;
		IO.Put_Line("-h : print this message and quit");
		IO.Put_Line("-gpl : print warranty and license information");
		IO.Put_Line("-c <c_path> : output C files to the path specified in <c_path>");
		IO.Put_Line("-a <a_path> : output Ada files to the path specified in <a_path>");
		IO.Put_Line("-t <t_path> : specify that adava should look in the path ");
		IO.Put_Line("              <t_path> for template files");
	end Print_Usage;
	----------------------------------------------------------------------------
	procedure Print_Error(Message : String) is
		package IO renames Ada.Text_IO;
	begin
		IO.Put_Line(Message);
		IO.New_Line;
		Print_Usage;
	end Print_Error;
	----------------------------------------------------------------------------
	procedure Print_Gpl is
		package IO renames Ada.Text_IO;
	begin
		IO.Put_Line("adava version 0.5 Copyright (C) 2006  Charles Lambert");
		IO.New_Line;
		IO.Put_Line("This program is free software; you can redistribute it and"
			& "/or");
		IO.Put_Line("modify it under the terms of the GNU General Public "
			& "License");
		IO.Put_Line("as published by the Free Software Foundation; either "
			& "version 2");
		IO.Put_Line("of the License, or (at your option) any later version.");
		IO.New_Line;
		IO.Put_Line("This program is distributed in the hope that it will be "
			& "useful,");
		IO.Put_Line("but WITHOUT ANY WARRANTY; without even the implied "
			& "warranty of");
		IO.Put_Line("MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See "
			& "the");
		IO.Put_Line("GNU General Public License for more details.");
		IO.New_Line;
		IO.Put_Line("You should have received a copy of the GNU General Public "
			& "License");
		IO.Put_Line("along with this program; if not, write to the Free "
			& "Software");
		IO.Put_Line("Foundation, Inc., 51 Franklin Street, Fifth Floor, "
			& "Boston, MA  02110-1301, USA.");
	end Print_Gpl;
	----------------------------------------------------------------------------
	procedure Get_Option(
			--------------------------------------------------------------------
			Name          : in     String; 
			Value         :    out Unbounded_String;
			Option_Exists :    out Boolean) is
			--------------------------------------------------------------------
		package CL renames Ada.Command_Line;
		Count : Natural := CL.Argument_Count;
	begin
		Option_Exists := False;
		if Count = 0 then
			Option_Exists := False;
			Value := Null_Unbounded_String;
		else
			for K in 1..Count loop
				if CL.Argument(K) = Name then
					Option_Exists := True;
					if K+1 > Count then
						Value := Null_Unbounded_String;
					else
						Value := To_Unbounded_String(CL.Argument(K+1));
					end if;
				end if;
				exit when Option_Exists = True;
			end loop;
		end if;
	end Get_Option;
	----------------------------------------------------------------------------
	procedure Split(Source : in String; Left, Right : out String) is
		Equal_Index : Natural := Index(To_Unbounded_String(Source), "=");
		Left_Length : Natural;
		Right_Length : Natural;
	begin
		Left_Length := Equal_Index - Source'First;
		Right_Length := Source'Last - Equal_Index;
		Left := Trim(Head(Source, Left_Length), Both);
		Right := Trim(Tail(Source, Right_Length), Both); 
	end Split;
	----------------------------------------------------------------------------
	procedure Read_From_File(
			--------------------------------------------------------------------
			File_Name : String;
			C_Option : out Unbounded_String;
			Ada_Option : out Unbounded_String;
			Template_Option : out Unbounded_String) is
			--------------------------------------------------------------------
		package IO renames Ada.Text_IO;
		File : IO.File_Type;
	begin
		IO.Open(File, IO.In_File, File_Name);
		while not IO.End_Of_File(File) loop
			declare
				Line : String := IO.Get_Line(File);
				Left, Right : Unbounded_String;
				K : Natural;
			begin
				K := Index(Line, "=");
				Left := Head(To_Unbounded_String(Line), K-1);
				Right := Tail(To_Unbounded_String(Line), Line'Length-K);
				IO.Put_Line("Left : " & To_String(Left));
				IO.Put_Line("Right : " & To_String(Right));
				if Left = "c" then
					C_Option := Right;
				elsif Left = "ada" then
					Ada_Option := Right;
				elsif Left = "template" then
					Template_Option := Right;
				end if;
			end;
		end loop;
		IO.Close(File);
	exception
		when Ada.Text_IO.Name_Error =>
			IO.Put_Line(File_Name);
	end Read_From_File;
	----------------------------------------------------------------------------
	package CL renames Ada.Command_Line;
	package Dir renames Ada.Directories;
	C_Option : Unbounded_String := Null_Unbounded_String;
	Ada_Option : Unbounded_String := Null_Unbounded_String;
	Template_Option : Unbounded_String := Null_Unbounded_String;
	Config_Option : Unbounded_String := Null_Unbounded_String;
	C_File_Option : Unbounded_String := Null_Unbounded_String;
	Ada_File_Option : Unbounded_String := Null_Unbounded_String;
	Template_File_Option : Unbounded_String := Null_Unbounded_String;
	Placeholder : Unbounded_String;
	Option_Exists : Boolean;
	----------------------------------------------------------------------------
begin
	-- help option
	Get_Option("-h",Placeholder, Option_Exists);
	if Option_Exists then
		Print_Usage;
		return;
	end if;
	-- gpl option
	Get_Option("-gpl", Placeholder, Option_Exists);
	if Option_Exists then
		Print_Gpl;
		return;
	end if;
	-- config file option
	Get_Option("-config", Config_Option, Option_Exists);
	if Option_Exists and then Config_Option = Null_Unbounded_String then
		Print_Error("No path specified for -config option");
		return;
	elsif Option_Exists and then not Dir.Exists(To_String(Config_Option)) then
		Print_Error("Invalid path '" & To_String(Config_Option) & "' for "
			& "-config option");
		return;
	elsif not Option_Exists then
		Config_Option := To_Unbounded_String("../../etc/adava");
	end if;
	Read_From_File(To_String(Config_Option), C_File_Option, Ada_File_Option, Template_File_Option);
	-- c output option
	Read_From_File(To_String(Config_Option), C_File_Option, Ada_File_Option,
		Template_File_Option);
	Get_Option("-c", C_Option, Option_Exists);
	if Option_Exists and then C_Option = Null_Unbounded_String then
		Print_Error("No path specified for -c option.");
		return;
	elsif Option_Exists and then not Dir.Exists(To_String(C_Option)) then
		Print_Error("Invalid path '" & To_String(C_Option) & "' for -c option");
		return;
	elsif not Option_Exists then
		C_Option := C_File_Option;
	else
		Ada.Text_IO.Put_Line("c path is: '" & To_String(C_Option) & "'");
	end if;
	-- ada output option
	Get_Option("-a", Ada_Option, Option_Exists);
	if Option_Exists and then Ada_Option = Null_Unbounded_String then
		Print_Error("No path specified for -a option.");
		return;
	elsif Option_Exists and then not Dir.Exists(To_String(Ada_Option)) then
		Print_Error("Invalid path '" & To_String(Ada_Option) & "' for -a option");
		return;
	elsif not Option_Exists then
		Ada_Option := Ada_File_Option;
	else
		Ada.Text_IO.Put_Line("ada path is: '" & To_String(Ada_Option) & "'");
	end if;
	-- template file location
	Get_Option("-t", Template_Option, Option_Exists);
	if Option_Exists and then Template_Option = Null_Unbounded_String then
		Print_Error("No path specified for -t option");
		return;
	elsif Option_Exists and then not Dir.Exists(To_String(Template_Option)) then
		Print_Error("Invalid path '" & To_String(Template_Option) & "' for -t option");
		return;
	elsif not Option_Exists then
		Template_Option := Template_File_Option;
	else
		Ada.Text_IO.Put_Line("template path is: '" & To_String(Template_Option) & "'");
	end if;
	-- we have all the options now generate the files
	Ada.Text_IO.Put_Line("C => " & To_String(C_Option));
	Ada.Text_IO.Put_Line("Ada => " & To_String(Ada_Option));
	Ada.Text_IO.Put_Line("Template => " & To_String(Template_Option));
end adava;
