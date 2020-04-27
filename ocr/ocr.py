#MASKRCNN
#CRNN


from PIL import Image
import pytesseract
#img= Image.open("1.jpeg").convert('1')
#img = img.convert('L')
#img.save('black_white_noise.jpg')
#img.show()

#text = pytesseract.image_to_string(img)

#print(text)
#save=open("example.txt",'w')
#save.write(text)
def binarize(image_to_transform, threshold):
	output_image=image_to_transform.convert("L")
	for x in range(output_image.width):
		for y in range(output_image.height):
			if output_image.getpixel((x,y))< threshold:
				output_image.putpixel( (x,y), 0 )
			else:
				output_image.putpixel( (x,y), 255 )
	return output_image

#config = ("-l eng --oem 2S --psm 6")

print("Trying with threshold " + str(128))
d=binarize(Image.open('12.jpg'), 128)
d.show()
save=open("example.txt",'w')
save.write(pytesseract.image_to_string(binarize(Image.open('12.jpg'), 128),config="--psm 6"))
#save.write(pytesseract.image_to_data(binarize(Image.open('12.jpg'),128)))

#save.write(pytesseract.image_to_pdf_or_hocr(binarize(Image.open('12.jpg'),128),extension='hocr').decode("utf-8") )

# Python program to convert 
# text file to pdf file 




print("endddddddddddddddddddddddddddddddddd")


