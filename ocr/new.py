# Python program to extract text from all the images in a folder 
# storing the text in corresponding files in a different folder 

import pytesseract as pt 
import os


import re
import cv2

from PIL import Image
import numpy as np
import json

# So, that was a bit magical, and really required a fine reading of the docs to figure out
# that the number "1" is a string parameter to the convert function actually does the binarization.
# But you actually have all of the skills you need to write this functionality yourself.
# Lets walk through an example. First, lets define a function called binarize, which takes in
# an image and a threshold value:
def binarize(image_to_transform, threshold):
	output_image=image_to_transform.convert("L")
	for x in range(output_image.width):
		for y in range(output_image.height):
			if output_image.getpixel((x,y))< threshold:
				output_image.putpixel( (x,y), 0 )
			else:
				output_image.putpixel( (x,y), 255 )
	return output_image
	

	# path for the folder for getting the raw images (change path accordingly )
path ="images"
imagePath=" "

	# path for the folder for getting the output 
tempPath ="text"
a_file = open("list", "r")


myNames = []

myNames = [line.strip() for line in a_file]
Medicallist=myNames

a_file.close()
result_dict={}
p=r'^[-+]?[0-9]*\.[0-9]+-[-+]?[0-9]*\.[0-9]+$'
for imageName in os.listdir(path):
        inputPath = os.path.join(path, imageName)
        img = Image.open(inputPath)
        d=binarize(img, 196)
        d.show()
        # applying ocr using pytesseract for python
        text = re.split(' |\n',pt.image_to_string(d))
        n_boxes = len(text)
        for i in range(n_boxes):
                for pattern in Medicallist:
                        if re.match(pattern, text[i]):
                                if re.match(p, text[i]):
                                        pass
                                elif(any(map(str.isdigit, text[i]))):
                                        print(float(text[i]))
                                        result_dict.update({" ".join(text[:i]):text[i]})
                                elif(text[i]=="DNR"):
                                        pass
                                        #print("DNR")
                                
                       
                                                
                                
                
        # for removing the .jpg from the imagePath
        imagePath = imagePath[0:-4]
        #print(json.dumps(result_dict, indent = 4))
        #print(imagePath)
        fullTempPath = os.path.join(tempPath, imageName+".txt")
        file1 = open(fullTempPath, "w")
        file1.write(text)
        file1.close() 




print("endddddddddddddddddddddddddddddddddd")
