#!/usr/bin/python3
import os
import os.path as path
import sys
def usage():
	print("%s: [input ROM file with $0000-$FFFF] [output ROM file which will have only $C000-$FFFF]" % sys.argv[0])
if len(sys.argv) != 3:
	print("Invalid argument count.")
def fix(inpath: str, outpath: str):
	print("Fixing %s and putting the output at %s" % (inpath, outpath))
	with open(inpath, 'rb') as infile:
		with open(outpath, 'wb+') as outfile:
			infile.seek(0xC000, os.SEEK_SET)
			outfile.write(infile.read(0x4000))
fix(sys.argv[1], sys.argv[2])