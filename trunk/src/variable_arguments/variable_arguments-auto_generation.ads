--------------------------------------------------------------------------------
--  *  Spec name variable_arguments-auto_geneneration.ads
--  *
--  *  Created by Charles Lambert on 10/6/06.
--  *  Copyright (c) 2006 Charles Lambert.
--------------------------------------------------------------------------------
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
package variable_arguments.auto_generation is
	type Parameters is private;
	type Parameters_Array is array(Positive range <>) of Parameters;
	function Get_Parameters(ID, AdaType, CType : String) return Parameters;
	procedure Replace_Tags(Template : in out Unbounded_String; P : Parameters);
	procedure Write_Templates(P : Parameters_Array);
	procedure Write_Templates_IC(P : Parameters_Array);
private
	type Parameters is record
		ID : Unbounded_String;
		AdaType : Unbounded_String;
		CType : Unbounded_String;
	end record;
end variable_arguments.auto_generation;
