# Updated by Jessy 23-05-02


import sys
from binascii import unhexlify
from conexion_new import connect

def obtener_mc_trans(path, verbose=False, encoding='cp500'):
    text_hex = open(path,'rb').read().hex()

    i = 0
    identifiers = []
    identifiers_hex = []
    cuerpo = []
    count = 0
    result = []

    while i < len(text_hex):
        tamano = ''.join(text_hex[i : i + 8])
        count+=1
        tamano = int(tamano,16)

        if tamano > 0:
            try:
                ident_hex = text_hex[i + 8 : i + 16]
                identifiers_hex.append(ident_hex)
                ident = unhexlify(ident_hex).decode('ascii')
                identifiers.append(ident)

            except Exception as e:
                print(e)
            
        cuerpo.append(text_hex[i + 16 : i + 8 + (tamano * 2)])
        i = i + 8 + (tamano*2)#ultima_pos + tamano + cuerpo
        
    for pos, ident in enumerate(identifiers):
        c = cuerpo[pos]
        result.append((ident,c[:32],c[32:]))
    
    return result

def agregar_a_tabla(path, codificacion='cp500'):
    result = obtener_mc_trans(path, encoding=codificacion)
    exec_list = [
        'DROP TABLE if exists prueba;',
        'create table prueba(ident varchar(4), cadena bit(128), cuerpo text, secuencia serial);',
        'truncate table prueba;'] + \
        [f'INSERT INTO prueba(ident, cadena, cuerpo) values(\'{ident}\', x\'{cadena_bit}\', \'{cuerpo}\');' for ident, cadena_bit, cuerpo in result]
    #for item in exec_list:
    print(len(exec_list))
    connect(exec_list)
    return result

if __name__ == '__main__':
    path = 'MC.INC'

    if len(sys.argv) > 1:
        path = sys.argv[1]

    result = agregar_a_tabla(path)
    
    #for i in result:
    #    print(result[0],result[1],result[2])

