--------------------------------------------------------------------------------
--  *  Body name variable_arguments-for_implementors-auto_geneneration.adb
--  *
--  *  Created by Charles Lambert on 10/5/06.
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
with Ada.Text_IO; use Ada.Text_IO;
--------------------------------------------------------------------------------
package body Variable_Arguments.For_Implementors.Auto_Generation is
	package ub renames ada.strings.unbounded;
	----------------------------------------------------------------------------
	-- returns an Unbounded_String that is the contents of the file specified
	-- by file name
	function Load_File(File_Name : String) return Unbounded_String is
		------------------------------------------------------------------------
		File : File_Type;
		Result : Unbounded_String;
		------------------------------------------------------------------------
	begin
		Open(File, In_File, File_Name);
		while not End_Of_File(File) loop
			Append(Result, Get_Line(File));
			Append(Result, Character'Val(10));
		end loop;
		Close(File);
		return Result;
	end Load_File;
	----------------------------------------------------------------------------
	procedure Load_File_Tags(
			Template : in out Unbounded_String) is
		------------------------------------------------------------------------
		Tag_Start_Index       : Natural;
		Tag_End_Index         : Natural;
		File_Name_Start_Index : Natural;
		File_Name_End_Index   : Natural;
		File_Name             : Unbounded_String;
		File_Tag_Start        : String := "<<[File:";
		File_Tag_End          : String := "]>>";
		File                  : File_Type;
		File_Data             : Unbounded_String;
		------------------------------------------------------------------------
	begin
		loop
			Tag_Start_Index       := Index(Source  => Template,
									   Pattern => File_Tag_Start,
									   From    => 1);
			exit when Tag_Start_Index = 0;
			File_Name_End_Index   := Index(Source  => Template,
									   Pattern => File_Tag_End,
									   From    => 1) - 1;
			Tag_End_Index         := File_Name_End_Index + File_Tag_End'Length;
			File_Name_Start_Index := Tag_Start_Index + File_Tag_Start'Length;
			File_Name             := Unbounded_Slice(
										Source => Template,
										Low    => File_Name_Start_Index,
										High   => File_Name_End_Index);
			Open(File, Out_File, To_String(File_Name));
			while not End_Of_File(File) loop
				Append(File_Data, Get_Line(File));
			end loop;
			Close(File);
			Replace_Slice(Source => Template,
						Low    => Tag_Start_Index,
						High   => Tag_End_Index,
						By     => To_String(File_Data));
		end loop;
	end Load_File_Tags;
	----------------------------------------------------------------------------
	procedure Replace_All(
			Template    : in out Unbounded_String;
			To_Replace  :        String;
			Replacement :        String) is
		------------------------------------------------------------------------
		Current_Index       : Natural;
		Number_Of_Instances : Natural;
		------------------------------------------------------------------------
	begin
		Number_Of_Instances := ub.Count(Template, To_Replace);
		if Number_Of_Instances /= 0 then
			for K in 1..Number_of_Instances loop
				Current_Index := Index(
					Source  => Template,
					Pattern => To_Replace,
					From    => 1);
				Replace_Slice(
					Source => Template,
					Low    => Current_Index,
					High   => Current_Index + To_Replace'Length - 1,
					By     => Replacement);
			end loop;
		end if;
	end Replace_All;
	----------------------------------------------------------------------------
	procedure Replace_Tag(
			Template    : in out Unbounded_String;
			Tag_Name    :        String;
			Replacement :        String) is
		------------------------------------------------------------------------
		Tag : Unbounded_String;
		------------------------------------------------------------------------
	begin
		Append(Tag, "<<[");
		Append(Tag, Tag_Name);
		Append(Tag, "]>>");
		Replace_All(Template, To_String(Tag), Replacement);
	end Replace_Tag;
	----------------------------------------------------------------------------
	procedure Replace_Insertion_Point(
			Template        : in out Unbounded_String;
			Insertion_Point :        String;
			Replacement     :        String) is
		------------------------------------------------------------------------
		Tag : Unbounded_String;
		------------------------------------------------------------------------
	begin
		Append(Tag, "<<[Insert:");
		Append(Tag, Insertion_Point);
		Append(Tag, "]>>");
		Replace_All(Template, To_String(Tag), Replacement);
	end Replace_Insertion_Point;
	----------------------------------------------------------------------------
end Variable_Arguments.For_Implementors.Auto_Generation;
