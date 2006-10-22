--------------------------------------------------------------------------------
--  *  Body name variable_arguments-auto_geneneration.adb
--  *
--  *  Created by Charles Lambert on 10/6/06.
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
with Variable_Arguments.For_Implementors.Auto_Generation;
use Variable_Arguments.For_Implementors.Auto_Generation;
with Ada.Text_IO;
package body variable_arguments.auto_generation is
	function Get_Parameters(ID, AdaType, CType : String) return Parameters is
		P : Parameters :=
			(To_Unbounded_String(ID), To_Unbounded_String(AdaType),
			To_Unbounded_String(CType));
	begin
		return P;
	end Get_Parameters;
	
	function Get_ID(P : Parameters) return String is begin
		return To_String(P.ID);
	end Get_ID;
	
	function Get_AdaType(P : Parameters) return String is begin
		return To_String(P.AdaType);
	end Get_AdaType;
	
	function Get_CType(P : Parameters) return String is begin
		return To_String(P.CType);
	end Get_CType;
	
	procedure Replace_Tags(Template : in out Unbounded_String;
		P : Parameters) is
	begin
		Replace_Tag(Template, "ID", Get_ID(P));
		Replace_Tag(Template, "AdaType", Get_AdaType(P));
		Replace_Tag(Template, "CType", Get_CType(P));
	end Replace_Tags;
	
	procedure Write_Template(P : Parameters_Array; Outer_Template, Inner_Template, File_Name : String) is
		package IO renames Ada.Text_IO;
		Const : constant Unbounded_String := Load_File(Inner_Template);
		Outer_File : Unbounded_String := Load_File(Outer_Template);
		Inner_File : Unbounded_String;
		Inner_Buffer : Unbounded_String;
		File : IO.File_Type;
	begin
		for K in P'Range loop
			Inner_File := Const;
			Replace_Tags(Inner_File, P(K));
			Append(Inner_Buffer, To_String(Inner_File));
		end loop;
		Replace_Insertion_Point(Outer_File, "code", To_String(Inner_Buffer));
		IO.Create(File, IO.Out_File, File_Name);
		IO.Put(File, To_String(Outer_File));
		IO.Close(File);
	end Write_Template;
	
	procedure Write_Templates_IC(P : Parameters_Array) is
	begin
		Write_Template(
			P => P,
			Outer_Template => "./Templates/va_fi_ag_ic.adb",
			Inner_Template => "./Templates/Av_Template.adb",
			File_Name      => "./Ada_Source"
						   &  "/variable_arguments-"
						   &  "for_implementors-"
						   &  "auto_generation-interfaces_C.ads");
		Write_Template(
			P => P,
			Outer_Template => "./Templates/Wrapper.c",
			Inner_Template => "./Templates/Av_Wrapper_Template.c",
			File_Name      => "./C_Source/wrapper.c");
	end Write_Templates_IC;
	
	procedure Write_Templates(P : Parameters_Array) is
	begin
		Write_Template(
			P => P,
			Outer_Template => "./Templates/va_fi_ag_ex.adb",
			Inner_Template => "./Templates/Av_Ptr_Template.adb",
			File_Name      => "./Ada_Source"
						   &  "/variable_arguments-"
						   &  "for_implementors-"
						   &  "auto_generation-extensions.ads");
		Write_Template(
			P => P,
			Outer_Template => "./Templates/Wrapper_Ptr.c",
			Inner_Template => "./Templates/Av_Ptr_Wrapper_Template.c",
			File_Name      => "./C_Source/extension_wrapper.c");
	end Write_Templates;
	
	procedure Write_Templates_IC(
			--------------------------------------------------------------------
			P                       : Parameters_Array;
			C_Output_Location       : String;
			Ada_Output_Location     : String;
			Template_Location       : String) is
			--------------------------------------------------------------------
		Outer_Template : String := Template_Location & "va_fi_ag_ic.adb";
	begin
		Write_Template(
			P => P,
			Outer_Template => Template_Location & "va_fi_ag_ic.adb",
			Inner_Template => Template_Location & "Av_Template.adb",
			File_Name      => Ada_Output_Location
						   &  "/variable_arguments-"
						   &  "for_implementors-"
						   &  "auto_generation-interfaces_C.ads");
		Write_Template(
			P => P,
			Outer_Template => Template_Location & "Wrapper.c",
			Inner_Template => Template_Location & "Av_Wrapper_Template.c",
			File_Name      => C_Output_Location & "wrapper.c");
	exception
		when Ada.Text_IO.Name_Error =>
			Ada.Text_IO.Put_Line(Outer_Template);
			raise;
	end Write_Templates_IC;	
	----------------------------------------------------------------------------
	procedure Write_Templates(
			--------------------------------------------------------------------
			P                       : Parameters_Array;
			C_Output_Location       : String;
			Ada_Output_Location     : String;
			Template_Location       : String) is
			--------------------------------------------------------------------
	begin
		Write_Template(
			P => P,
			Outer_Template => Template_Location & "va_fi_ag_ex.adb",
			Inner_Template => Template_Location & "Av_Ptr_Template.adb",
			File_Name      => Ada_Output_Location
						   &  "/variable_arguments-"
						   &  "for_implementors-"
						   &  "auto_generation-extentions.ads");
		Write_Template(
			P => P,
			Outer_Template => Template_Location & "Wrapper_Ptr.c",
			Inner_Template => Template_Location & "Av_Ptr_Wrapper_Template.c",
			File_Name      => C_Output_Location & "extention_wrapper.c");
	end Write_Templates;
end variable_arguments.auto_generation;
