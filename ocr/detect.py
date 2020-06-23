

import re
import cv2
import pytesseract
from PIL import Image
import numpy as np
import json


def binarize(image_to_transform, threshold):
	output_image=image_to_transform.convert("L")
	for x in range(output_image.width):
		for y in range(output_image.height):
			if output_image.getpixel((x,y))< threshold:
				output_image.putpixel( (x,y), 0 )
			else:
				output_image.putpixel( (x,y), 255 )
	return output_image


im =binarize(Image.open('images/di.jpg'), 196) 
#im.show()
img = np.array(im)
d = pytesseract.image_to_data(img, output_type=pytesseract.Output.DICT)
keys = list(d.keys())

a_file = open("list", "r")


myNames = []

myNames = [line.strip() for line in a_file]

a_file.close()


#print(myNames)
Medicallist=myNames
#Medicallist = ["BLOOD", "HEMOGLOBIN","HEMATOCRIT","MC","CV","RDW","ABSOLUTE","PLATELET","MPV","NEUTROPHILS","BAND","METAMYELOCYTES","MYELOCYTES","PROMYELOCYTES","LYMPHOCYTES","REACTIVE","MONOCYTES","EOSINOPHILS","BASOPHILS","BLASTS","NUCLEATED"]
result_dict={}
n_boxes = len(d['text'])
for i in range(n_boxes):
	if int(d['conf'][i]) > 40:
		for pattern in Medicallist:
			if re.match(pattern, d['text'][i]):
				(x, y, w, h) = (d['left'][i], d['top'][i], d['width'][i], d['height'][i])
				pil_crop=Image.fromarray(img[y-4:y+h+4,:])
				text = re.split(' |\n',pytesseract.image_to_string(pil_crop))
				#print(text)
				for j in range(len(text)):
					if(any(map(str.isdigit, text[j]))):
						#print(text[j])
						result_dict.update({" ".join(text[:j]):float(text[j])})
						break
					elif(text[j]=="o1" or text[j]=="OL" ):
						pass

					elif(text[j]=="DNR"):
						result_dict.update({" ".join(text[:j]):text[j]})
						break
				
print(json.dumps(result_dict, indent = 4))
file=open("text/Json.txt","w",encoding="utf-8")
json.dump(result_dict,file,indent = 4,ensure_ascii=False)
cv2.imshow('img', img)
cv2.waitKey(0)
cv2.destroyAllWindows()
