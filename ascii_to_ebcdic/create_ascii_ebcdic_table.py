from converter import *
from conexion import connect

ebcdic = ['00','01','02','03','1A','09','1A','7F','1A','1A','0A','0B','0C','0D','0E','0F','10','11','12',
          '13','3C','3D','32','26','18','19','3F','27','1C','1D','1E','1F','40','4F','7F','7B','5B','6C',
          '50','7D','4D','5D','5C','4E','6B','60','4B','61','F0','F1','F2','F3','F4','F5','F6','F7','F8',
          'F9','7A','5E','4C','7E','6E','6F','7C','C1','C2','C3','C4','C5','C6','C7','C8','C9','D1','D2',
          'D3','D4','D5','D6','D7','D8','D9','E2','E3','E4','E5','E6','E7','E8','E9','4A','E0','5A','5F',
          '6D','79','81','82','83','84','85','86','87','88','89','91','92','93','94','95','96','97','98',
          '99','A2','A3','A4','A5','A6','A7','A8','A9','C0','6A','D0','A1','07','3F', '3F', '3F', '3F', 
          '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F',
          '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F',
          '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', 
          '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', 
          '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', 
          '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', 
          '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', 
          '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F', '3F' ]

ascii =  ['00','01','02','03','04','05','06','07','08','09','0A','0B','0C','0D','0E','0F','10','11','12',
          '13','14','15','16','17','18','19','1A','1B','1C','1D','1E','1F','20','21','22','23','24','25',
          '26','27','28','29','2A','2B','2C','2D','2E','2F','30','31','32','33','34','35','36','37','38',
          '39','3A','3B','3C','3D','3E','3F','40','41','42','43','44','45','46','47','48','49','4A','4B',
          '4C','4D','4E','4F','50','51','52','53','54','55','56','57','58','59','5A','5B','5C','5D','5E',
          '5F','60','61','62','63','64','65','66','67','68','69','6A','6B','6C','6D','6E','6F','70','71',
          '72','73','74','75','76','77','78','79','7A','7B','7C','7D','7E','7F','80','81','82','83','84',
          '85','86','87','88','89','8A','8B','8C','8D','8E','8F','90','91','92','93','94','95','96','97',
          '98','99','9A','9B','9C','9D','9E','9F','A0','A1','A2','A3','A4','A5','A6','A7','A8','A9','AA',
          'AB','AC','AD','AE','AF','B0','B1','B2','B3','B4','B5','B6','B7','B8','B9','BA','BB','BC','BD',
          'BE','BF','C0','C1','C2','C3','C4','C5','C6','C7','C8','C9','CA','CB','CC','CD','CE','CF','D0',
          'D1','D2', 'D3', 'D4', 'D5', 'D6', 'D7', 'D8', 'D9', 'DA', 'DB', 'DC', 'DD', 'DE', 'DF', 'E0',
          'E1', 'E2', 'E3', 'E4', 'E5', 'E6', 'E7', 'E8', 'E9', 'EA', 'EB', 'EC', 'ED', 'EE', 'EF', 'F0', 
          'F1', 'F2', 'F3', 'F4', 'F5', 'F6', 'F7', 'F8', 'F9', 'FA', 'FB', 'FC', 'FD', 'FE', 'FF']


def build_sentences(SQLsentence,vars):
    result = []
    for t in vars:
        result.append(SQLsentence % t)
    return result

def crear_tabla_ascii_ebcdic():
    create_sentence = ["DROP TABLE IF EXISTS ascii_to_ebcdic", 
                       "CREATE  TABLE ascii_to_ebcdic(ascii text PRIMARY KEY, ebcdic text);"]
    insert_sentence = "INSERT INTO ascii_to_ebcdic(ascii, ebcdic) VALUES(%s);"
    values_to_insert = []

    for i in range(len(ascii)):
        values_to_insert.append('\''+(ascii[i]).lower()+'\''+ ','+'\'' + ebcdic[i]+'\'')
    insert_sentences = build_sentences(insert_sentence,values_to_insert)
    print(insert_sentences)
    connect(create_sentence + insert_sentences)#,insert_sentence,values_to_insert)

if __name__ == '__main__':
    print(len(ebcdic)==len(ascii))
    
    crear_tabla_ascii_ebcdic()

    #result = []
    #for item in ascii:
    #    print('hex[',item,'] ascii[',hex_to_ascii(item),']ebcdic[',ascii_to_ebcdic(hex_to_ascii(item)),']')
    #    result.append(ascii_to_ebcdic(hex_to_ascii(item)))
    #list = []
    #for i in ['C','D','E','F']:
    #    for j in ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'] :
    #        list.append(i+j)
    #print(list)
    
    #ascii_ = []
    #for item in ascii:
    #    ascii_.append(hex_to_ascii(item))
    #print(ascii)

    #f = ['3F' for i in range(128)]
    #print(f)
