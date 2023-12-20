#!/usr/bin/python3
from PIL import Image
import sys
import os
import os.path as path
import json
scriptdir = path.realpath(path.dirname(__file__))
resdir = path.realpath(path.join(scriptdir, "..", "res"))
resfiles = os.listdir(resdir)
for file in resfiles:
	if file.lower().endswith(".png"):
		dot = file.rfind(".")
		filestem = file[dot - 1:]
		imgbytes = bytearray()
		with Image.open(path.join(resdir, file)) as img:
			width = img.width
			height = img.height
			countw: int = int(width / 8)
			counth: int = int(height / 8)
			px = img.load()
			for tile_y in range(counth):
				for tile_x in range(countw):
					for inner_y in range(8):
						byte: int = 0
						imgy = (tile_y * 8) + inner_y
						for inner_x in range(8):
							imgx = (tile_x * 8) + inner_x
							pixel = px[imgx, imgy]
							if img.has_transparency_data:
								if pixel[3] != 0:
									byte |= 1 << (7 - inner_x)
						imgbytes.append(byte)
		with open(path.join(resdir, filestem + ".bin"), "wb+") as f:
			f.write(imgbytes)