--------------------------------------------------------------------------------
--  *  Spec name variable_arguments-for_implementors-register_type.ads
--  *
--  *  Created by Charles Lambert on 10/3/06.
--  *  Copyright (c) 2006 Charles Lambert.
--------------------------------------------------------------------------------
with General_Access; use General_Access;
--------------------------------------------------------------------------------
generic
	----------------------------------------------------------------------------
	type Any_Convention_C_Type is private;
	Add_Argument : Add_Argument_Access;
	----------------------------------------------------------------------------
package Variable_Arguments.For_Implementors.Register_Type is
	----------------------------------------------------------------------------
	function Append (
		AList : Argument_List;
		Arg   : Any_Convention_C_Type)
		return Argument_List;
	----------------------------------------------------------------------------
	procedure Prepend (
		AList : in out Argument_List;
		Arg   :        Any_Convention_C_Type);
	----------------------------------------------------------------------------
private
	type Any_Access is access all Any_Convention_C_Type;
	----------------------------------------------------------------------------
	type Argument_Instance is new Argument with
		record
			Instance_Value : Any_Access;
		end record;
	procedure Free_Argument(Arg : Argument_Instance);
	----------------------------------------------------------------------------
end Variable_Arguments.For_Implementors.Register_Type;
