with open('ISO-MC20230325054638-ebcdic_3.BLK','rb') as f_new, open('R1110VE21104.OUT','rb') as f_ok:
    content_new = f_new.read().hex()
    content_ok = f_ok.read().hex()
    len_content_new = len(content_new)
    len_content_ok = len(content_ok)
    print(content_new==content_ok)
    print(len_content_new)
    print(len_content_ok)
    for i,b in enumerate(content_ok):
        if b != content_new[i]:
            print('pos' + str(i))
            print('fincimex ' + str(content_ok[i-10:i+100])) 
            print('ebcdic   '+ str(content_new[i-10:i+100]))

f_new.close()
f_ok.close()