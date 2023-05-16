from conexion import connect

bit = ['0000','0001','0010','0011','0100','0101','0110','0111','1000',
       '1001','1010','1011','1100','1101','1110','1111']
hex = ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F']

def build_sentences(SQLsentence,vars):
    result = []
    for t in vars:
        result.append(SQLsentence % t)
    return result

def crear_tabla_ascii_ebcdic():
    create_sentence = ["DROP TABLE IF EXISTS bit4_hex", 
                       "CREATE  TABLE bit4_hex(bit4 text PRIMARY KEY, hex text);"]
    insert_sentence = "INSERT INTO bit4_hex(bit4, hex) VALUES(%s);"
    values_to_insert = []

    for i,b in enumerate(bit):
        values_to_insert.append('\''+(bit[i])+'\',\'' + hex[i]+'\'')
    insert_sentences = build_sentences(insert_sentence,values_to_insert)
    print(insert_sentences)
    connect(create_sentence + insert_sentences)#,insert_sentence,values_to_insert)

crear_tabla_ascii_ebcdic()

