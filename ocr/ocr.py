

# Python program to extract text from all the images in a folder 
# storing the text in corresponding files in a different folder 
from PIL import Image 
import pytesseract as pt 
import os 
# So, that was a bit magical, and really required a fine reading of the docs to figure out
# that the number "1" is a string parameter to the convert function actually does the binarization.
# But you actually have all of the skills you need to write this functionality yourself.
# Lets walk through an example. First, lets define a function called binarize, which takes in
# an image and a threshold value:
def binarize(image_to_transform, threshold):
	output_image=image_to_transform.convert("L")
	# the threshold value is usually provided as a number between 0 and 255, which
    # is the number of bits in a byte.
    # the algorithm for the binarization is pretty simple, go through every pixel in the
    # image and, if it's greater than the threshold, turn it all the way up (255), and
    # if it's lower than the threshold, turn it all the way down (0).
    # so lets write this in code. First, we need to iterate over all of the pixels in the
    # image we want to work with
	for x in range(output_image.width):
		for y in range(output_image.height):
			if output_image.getpixel((x,y))< threshold:
				output_image.putpixel( (x,y), 0 )
			else:
				output_image.putpixel( (x,y), 255 )
	return output_image
	
def main(): 
	# path for the folder for getting the raw images (change path accordingly )
	path ="images"
	imagePath=" "

	# path for the folder for getting the output 
	tempPath ="text"

	# iterating the images inside the folder 
	for imageName in os.listdir(path): 
			
		inputPath = os.path.join(path, imageName) 
		img = Image.open(inputPath) 

		# applying ocr using pytesseract for python 
		text = pt.image_to_string(binarize(img, 176),config="-oem 3 --psm 6") 

		# for removing the .jpg from the imagePath 
		imagePath = imagePath[0:-4] 
		#print(imagePath)

		fullTempPath = os.path.join(tempPath, imageName+".txt") 
		#print(text) 

		# saving the text for every image in a separate .txt file 
		file1 = open(fullTempPath, "w") 
		file1.write(text) 
		file1.close() 

if __name__ == '__main__': 
	main() 


print("endddddddddddddddddddddddddddddddddd")


