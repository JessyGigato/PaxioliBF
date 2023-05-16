from conexion import connect
from binascii import unhexlify

def create_ebcdic_file():
    select_sentence = ['SELECT * FROM t_ebcdic as t ORDER BY t.id'  ]
    result = connect(select_sentence,action=True)
    '''
    #print(result[0:10])
    print(result[1])
    print(type(result[1]))
    print(result[1][0])
    print(type(result[1][0]))
    c = 0
    for i in result[:100]:
        print(f'transaccion {i[1]}',)
        print(i[0]+'\n\n')
    '''

    with open('ISO-MC20230325054638-ebcdic_3.BLK','wb') as fout:
        for transaction in result:
            transaction = transaction[0]
            w = fout.write(unhexlify(transaction + '0D0A'))
    
    fout.close()

if __name__ == '__main__':
    create_ebcdic_file()



    