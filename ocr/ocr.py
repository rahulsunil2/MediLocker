#ocr.py
#The Program converts  image into text 
#here 128 is given threshold value 


from PIL import Image
import pytesseract

def binarize(image_to_transform, threshold):
	output_image=image_to_transform.convert("L")
	for x in range(output_image.width):
		for y in range(output_image.height):
			if output_image.getpixel((x,y))< threshold:
				output_image.putpixel( (x,y), 0 )
			else:
				output_image.putpixel( (x,y), 255 )
	return output_image



print("Trying with threshold " + str(128))
d=binarize(Image.open('12.jpg'), 128)
d.show()
save=open("example.txt",'w')
save.write(pytesseract.image_to_string(binarize(Image.open('12.jpg'), 128)))

