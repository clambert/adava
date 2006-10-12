
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