--------------------------------------------------------------------------------
--  *  Spec name General_Access.ads
--  *
--  *  Created by Charles Lambert on 10/3/06.
--  *  Copyright (c) 2006 Charles Lambert.
--------------------------------------------------------------------------------
with Ada.Unchecked_Conversion;
--------------------------------------------------------------------------------
-- Allows you to convert any access type to a Void_Access type
package General_Access is
	----------------------------------------------------------------------------
	-- These comprise the equivilant of a C void pointer
	type Void is null record;
	type Void_Access is access all Void;
	pragma Convention(C, Void_Access);
	----------------------------------------------------------------------------
	-- This package allows for the Unchecked_Conversion of the type you want
	-- to convert to Void_Access
	generic
		------------------------------------------------------------------------
		-- The type whose access you want to convert to a Void_Access
		type Any_Convention_C_Type is private;
		------------------------------------------------------------------------
		-- make this your access type
		type Convert_From_Access is access all Any_Convention_C_Type;
		------------------------------------------------------------------------
	package Void_Conversion is
		------------------------------------------------------------------------
		-- then call this to do the conversion
		function To_Void_Access is new Ada.Unchecked_Conversion(
			Source => Convert_From_Access,
			Target => Void_Access);
		------------------------------------------------------------------------
	end Void_Conversion;
	----------------------------------------------------------------------------
end General_Access;
--------------------------------------------------------------------------------
