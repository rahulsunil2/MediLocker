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



print("Trying with threshold " + str(128))
d=binarize(Image.open('12.jpg'), 128)
d.show()
save=open("example.txt",'w')
save.write(pytesseract.image_to_string(binarize(Image.open('12.jpg'), 128)))

import requests
import pandas as pd

txt_data = open("example.txt",'r').text
splited_data = txt_data.split('\n')

table_title = 'Prices Received for Field Crops and Fruits - United States: February 2017 with Comparisons'
END_TABLE_LINE = '-------------------------------------------'


def find_no_line_start_table(table_title,splited_data):
    found_no_lines = []
    for index, line in enumerate(splited_data):
        if table_title in line:
            found_no_lines.append(index)

    return found_no_lines

_, table_start = find_no_line_start_table(table_title,splited_data)


def get_start_data_table(table_start, splited_data):
    for index, row in enumerate(splited_data[table_start:]):
        if '(D)' in row:
            return table_start + index

def get_end_table(start_table_data, splited_data ):
    for index, row in enumerate(splited_data[start_table_data:]):
            if END_TABLE_LINE in row:
                return start_table_data + index

def row(l):
    l = l.split()
    number_columns = 5
    if len(l) >= number_columns: 
        data_row = [''] * number_columns
        first_column_done = False

        index = 0
        for w in l:
            if not first_column_done:
                data_row[0] = ' '.join([data_row[0], w])
                if ':' in w:
                        first_column_done = True
            else:
                index += 1
                data_row[index] = w

        return data_row

start_line = get_start_data_table(table_start, splited_data)
end_line = get_end_table(start_line, splited_data)

table = splited_data[start_line : end_line]

def take_table(txt_data):
    comodity = []
    price_2011 = []
    feb_2016 = []
    jan_2017 = []
    feb_2017 = []

    for r in table:
        data_row = row(r)
        if data_row:
            col_1, col_2, col_3, col_4, col_5 = data_row
            comodity.append(col_1)
            price_2011.append(col_2)
            feb_2016.append(col_3)
            jan_2017.append(col_4)
            feb_2017.append(col_5)

    table_data = {'comodity': comodity, 'price_2011': price_2011,
                  'feb_2016': feb_2016, 'jan_2017': jan_2017, 'feb_2017': feb_2017}
    return table_data

dict_table = take_table(txt_data)
pd.DataFrame(dict_table)
