from binascii  import unhexlify

with open('ISO-MC20230325054638.BLK','rb') as f, open('ISO-MC20230325054638-03.BLK','wb') as fout:
    i = 0
    count =0
    content = f.read().hex()
    len_content = len(content)
    content = content.replace('0d0a','0d1a')

    while i + 2024 < len_content:
        w = fout.write(unhexlify(content[i:i+2024]))
        #print(i,content[i+2024:i+2028])
        i+= 2024 + 4
        #print('i despues de leer------> ',i, 'escrito--->',w)

f.close()
fout.close()