

import re
import pytesseract 
from PIL import Image
import numpy as np
import json
import time
import os
from os import path



def binarize(image_to_transform, threshold):
	output_image=image_to_transform.convert("L")
	for x in range(output_image.width):
		for y in range(output_image.height):
			if output_image.getpixel((x,y))< threshold:
				output_image.putpixel( (x,y), 0 )
			else:
				output_image.putpixel( (x,y), 255 )
	return output_image
def OCRextract(inputPath):
	start1 = time.process_time()
	start = time.process_time()
	basepath = path.dirname(__file__)
	inputPath = path.abspath(path.join(basepath, "..", "media", inputPath))
	# a_file = open("MediCareApp/list", "r")
	# myNames = []
	# myNames = ["BLOOD", "HEMOGLOBIN","HEMATOCRIT","MC","CV","RDW","ABSOLUTE","PLATELET","MPV","NEUTROPHILS","BAND","METAMYELOCYTES","MYELOCYTES","PROMYELOCYTES","LYMPHOCYTES","REACTIVE","MONOCYTES","EOSINOPHILS","BASOPHILS","BLASTS","NUCLEATED"]
	myNames = ["GLUCOSE"]
	# a_file.close()
	Medicallist=myNames
	print(inputPath)
	im = binarize(Image.open(inputPath), 196) 
	lines = re.split('\n',pytesseract.image_to_string(im))
	print(time.process_time() - start)
	text=[]
	for i in range(len(lines)):
		temp=[[j,i] for j in lines[i].split(" ")]
		text.extend(temp)
	result_dict={}
	n_boxes = len(text)
	for i in range(n_boxes):
		for pattern in Medicallist:
			if re.match(pattern, text[i][0]):
				line = lines[text[i][1]].split(" ")
				#print(text)
				for j in range(len(line)):
					if(any(map(str.isdigit, line[j]))):
						#print(text[j])
						result_dict.update({" ".join(line[:j]):line[j]})
						break
					elif(line[j]=="o1" or line[j]=="OL" ):
						pass
					elif(line[j]=="DNR"):
						result_dict.update({" ".join(line[:j]):line[j]})
						break
						
	print(time.process_time() - start1)
	return result_dict