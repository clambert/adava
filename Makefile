#-------------------------------------------------------------------------------
#--  *  File Name: Makefile
#--  *
#--  *  Created by Charles Lambert on 10/11/06.
#--  *  Copyright (c) 2006 Charles Lambert.
#--  * 
#--  * This program is free software; you can redistribute it and/or
#--  * modify it under the terms of the GNU General Public License
#--  * as published by the Free Software Foundation; either version 2
#--  * of the License, or (at your option) any later version.
#--  * 
#--  * This program is distributed in the hope that it will be useful,
#--  * but WITHOUT ANY WARRANTY; without even the implied warranty of
#--  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#--  * GNU General Public License for more details.
#--  * 
#--  * You should have received a copy of the GNU General Public License
#--  * along with this program; if not, write to the Free Software
#--  * Foundation, Inc., 51 Franklin Street, Fifth Floor, 
#--  * Boston, MA  02110-1301, USA.
#-------------------------------------------------------------------------------
all: adava doc check

check:

install:
	mv ./bin/adava ./tmp_install/adava
	
uninstall:
	rm ./tmp_install/adava

clean:
	gnat clean -Padava.gpr
	gnat clean -Pautogen.gpr
	
doc:

adava:
	gcc -c ./src/variable_arguments/avcall_wrapper.c -o ./build/avcall_wrapper.o
	gnat make -Pautogen.gpr -largs ./build/avcall_wrapper.o;
	echo "calling autogen"
	cd ./bin && chmod +x autogen && ./autogen && cd ../;
	gnat make -Padava.gpr;