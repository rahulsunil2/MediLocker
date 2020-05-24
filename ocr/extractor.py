


from PIL import Image
import pytesseract
import cv2
import numpy as np
from pytesseract import Output

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







circles = np.zeros((4,2),np.int)
counter = 0

#mousePoint detects point clicked in image and return its x,y and increase the count
def mousePoint(event,x,y,flag,params):
	if event == cv2.EVENT_LBUTTONDOWN:
		global counter
		circles[counter] = x,y
		counter = counter + 1
		#print(counter)
		print(circles)



# image is open
img =binarize(Image.open('images/12.jpg'), 196) 
im=np.array(img)

#loop till counter becomes 4( as 4 points of a box ) and convert that image into text using ocr

while True:

	if counter == 4:
		width, height = abs(circles[0][0]-circles[1][0]),abs(circles[1][1]-circles[2][1])
		pts1 = np.float32([circles[0],circles[1],circles[2],circles[3]])
		pts2 = np.float32([[0,0],[width,0],[0,height],[width,height]])
		matrix = cv2.getPerspectiveTransform(pts1,pts2)
		imgOutput = cv2.warpPerspective(im,matrix,(width,height))
		cv2.imwrite('images/image.png',imgOutput)
		im_pil = Image.open('images/image.png')
		text = pytesseract.image_to_string(im_pil,config="-oem 3 --psm 6")
		print(text)

		
		im_pil.show()
		break

	for x in range (0,4):
		cv2.circle(im,(circles[x][0],circles[x][1]),3,(0,255,0),cv2.FILLED)
	cv2.imshow('img', im)
	cv2.setMouseCallback("img", mousePoint)
	cv2.waitKey(1)
	#print(counter)
	




# #cv2.waitKey(0)
print("endddddddddddddddddddddddddddddddddd")


