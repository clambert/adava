--------------------------------------------------------------------------------
--  *  Spec name variable_arguments-for_implementors-auto_geneneration.ads
--  *
--  *  Created by Charles Lambert on 10/5/06.
--  *  Copyright (c) 2006 Charles Lambert.
--------------------------------------------------------------------------------
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
package Variable_Arguments.For_Implementors.Auto_Generation is
	function Load_File(File_Name : String) return Unbounded_String;
	procedure Load_File_Tags(Template : in out Unbounded_String);
	procedure Replace_All(
		Template    : in out Unbounded_String;
		To_Replace  :        String;
		Replacement :        String);
	procedure Replace_Tag(
		Template    : in out Unbounded_String;
		Tag_Name    :        String;
		Replacement :        String);
	procedure Replace_Insertion_Point(
		Template        : in out Unbounded_String;
		Insertion_Point :        String;
		Replacement     :        String);
private
end Variable_Arguments.For_Implementors.Auto_Generation;
