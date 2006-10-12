--------------------------------------------------------------------------------
--  *  Spec name avcall.ads
--  *
--  *  Created by Charles Lambert on 9/29/06.
--  *  Copyright (c) 2006 Charles Lambert.
--------------------------------------------------------------------------------
with General_Access;
--------------------------------------------------------------------------------
-- This package and its child packages wrap ffcall's avcall functionality. It
-- allows you to call variable argument c function. This package contains only
-- the types and functions used by the child packages of this package. If you
-- are only looking for documentation on usage then look at the comments of
-- Example.ads and UseExample.adb. The comments that follow assume you know how
-- ffcall's avcall api works. See avcall.adb for additional comments on the 
-- implementation of the procedures and functions in this package.
package Variable_Arguments is
	use General_Access;
	----------------------------------------------------------------------------
	-- This exeption is thrown when you try to add more than Max_Arguments to
	-- the Variable_Argument type
	Max_Argument_Limit_Surpassed : exception;
	----------------------------------------------------------------------------
	-- The maximum number of arguments that can be used by avcall
	Max_Arguments : constant := 50;
	----------------------------------------------------------------------------
	-- This is the type that holds all of your variable arguments.
	type Argument_List is private;
	----------------------------------------------------------------------------
	-- This is how you get an instance of Argument_List. It is used to start the 
	-- Argument_List call (e.g. Start_Argument_List & Item1 & Item2 & etc)
	function Start_Argument_List return Argument_List;
	----------------------------------------------------------------------------
	-- returns true if the number of arguments in AList are equal to 
	-- Max_Arguments, and false otherwise
	function Has_Max_Arguments(AList : Argument_List) return Boolean;
	----------------------------------------------------------------------------
	-- This is the access type for the correct av_<type> function to call
	type Add_Argument_Access is access procedure (
		Av_List, Value : Void_Access);
	pragma Convention(C, Add_Argument_Access);
	----------------------------------------------------------------------------
private
	use General_Access;
	----------------------------------------------------------------------------
	-- this is the number of arguments in the Var_Args list
	subtype Argument_Count        is        Natural range 0..Max_Arguments;
	type    Argument_Count_Access is access Argument_Count;
	----------------------------------------------------------------------------
	-- This is the range used by the Var_Args list
	subtype Argument_Range is Natural range 1..Max_Arguments;
	----------------------------------------------------------------------------
	-- this represents an argument held in the Arg_List
	type Argument is tagged
		record
		------------------------------------------------------------------------
		-- This holds the correct av_<type> c function to call.
		Add_Argument : Add_Argument_Access;
		------------------------------------------------------------------------
		-- This accesses the value to be used in the call to Add_Argument
		Value : Void_Access;
		------------------------------------------------------------------------
		end record;
	procedure Free_Argument(Arg : Argument);
	procedure Free(Arg : Argument'Class);
	----------------------------------------------------------------------------
	-- This type is used by the Variable_Argument type to hold all of the arguments.
	type Argument_Array        is array(Argument_Range range <>) of Argument;
	type Argument_Array_Access is access Argument_Array;
	----------------------------------------------------------------------------
	-- This is the Var_Args type. This is used to hold all of the arguments to
	-- the c function (the ... and all the arguments before that). 
	-- The Start_Var_Args, "&", and Prepend methods and functions are used to
	-- add arguments to Var_Args. 
	type Argument_List is
		record
		------------------------------------------------------------------------
		-- this is a pointer to the c data type that makes this work. 
		-- Av_List_Malloc and Av_List_Free (defined in the body) are used to
		-- obtain the reference and free it respectivly
		Av_AList : Void_Access;
		------------------------------------------------------------------------
		-- This is the number of arguments in the Argument_List_Array
		Count : Argument_Count_Access;
		------------------------------------------------------------------------
		-- This is what holds all of the arguments.
		Arguments : Argument_Array_Access := 
			new Argument_Array(Argument_Range'Range);
		------------------------------------------------------------------------
		end record;
	----------------------------------------------------------------------------
end Variable_Arguments;
--------------------------------------------------------------------------------
