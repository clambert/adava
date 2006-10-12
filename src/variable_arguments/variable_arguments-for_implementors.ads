--------------------------------------------------------------------------------
--  *  Spec name variable_arguments-for_implementors.ads
--  *
--  *  Created by Charles Lambert on 10/3/06.
--  *  Copyright (c) 2006 Charles Lambert.
--------------------------------------------------------------------------------
with General_Access; use General_Access;
--------------------------------------------------------------------------------
package Variable_Arguments.For_Implementors is
	----------------------------------------------------------------------------
	-- This will access your C function.
	type C_Function_Access is access procedure;
	pragma Convention(C, C_Function_Access);
	----------------------------------------------------------------------------
	-- This is used to access the correct av_start_<type> C function
	-- Av_List : pass in your Argument_List.Av_List member
	-- Function_To_Call : an access to the av_start_<type> C function
	-- Return_Value : an access to where you want the return value (if any)
	--                stored
	type Register_Function_Access is access
		procedure(
			Av_AList          : Void_Access;
			Function_To_Call : C_Function_Access;
			Return_Value     : Void_Access);
	pragma Convention(C, Register_Function_Access);
	----------------------------------------------------------------------------
	-- This calls the C_Function_Access C function supplied
	--**************************************************************************
	--* WARNING: after calling this procedure you cannot use AList anymore. It 
	--*          will be in an invalid state. You can consider this procedure
	--*          the equivilant of calling Unchecked_Deallocation on AList.
	--**************************************************************************
	generic
		type Return_Type is private;
		Register_Function : Register_Function_Access;
		C_Function        : C_Function_Access;
	function Call(AList : Argument_List) return Return_Type;
	----------------------------------------------------------------------------
	generic
		C_Function        : C_Function_Access;
	procedure Call_No_Return(AList : Argument_List);
	----------------------------------------------------------------------------
end Variable_Arguments.For_Implementors;
--------------------------------------------------------------------------------
