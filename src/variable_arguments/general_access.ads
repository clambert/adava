--------------------------------------------------------------------------------
--  *  Spec name General_Access.ads
--  *
--  *  Created by Charles Lambert on 10/3/06.
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
