#!/bin/bash

if [ ! -r $1 ]
then
	echo "Usage: $0 <dlx_assembly_file>.asm"
	exit 1
fi

asmfile=`echo $1 | sed s/[.].*//g`
perl ./assembler_source/dlxasm.pl -o $asmfile.bin -list $asmfile.list $1
rm $asmfile.bin.hdr
cat $asmfile.bin | hexdump -v -e '/1 "%02X" /1 "%02X" /1 "%02X" /1 "%02X\n"' > $asmfile\_dump.mem
cp $asmfile\_dump.mem ../src/DatapathCore/a.b.k-Memories/IRAM_init_file.mem