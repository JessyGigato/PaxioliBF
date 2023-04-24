# Updated by Yasmin 23-04-10

from codecs_ import codecs, cod_raras
from conexion import connect
import sys
import os

def transformar_texto(text):
    new_text = []
    
    for pos, ch in enumerate(text):
        if pos % 1012 == 0 or pos % 1013 == 0: continue
        new_text.append(ch)
    
    return ''.join(new_text)

def obtener_mc_trans(path, verbose=False, encoding='cp500'):
    # para la lectura en hex
    text = open(path, 'r', encoding='latin1').read()
    '''
    count = 0
    for ch in text:
        if ch== '\n':
            print('encontre un salto de linea')
            count+=1
    print(f'encontre {count} saltos de linea')
    '''
    textord = ''.join([i for i in text])
    text = [hex(ord(i))[2:] for i in text]
    print(len(text))

    # se eliminan los terminos en las posiciones divisibles por 1012 y 1013  
    # ya que TAS pone 2 ceros cada 1012 caracteres
    #textord = ''.join([i for pos, i in enumerate(text) if pos == 0 or not (pos % 1012 == 0 or pos % 1013 == 0)])
    #text = [hex(ord(i))[2:] for pos, i in enumerate(text) if pos == 0 or not (pos % 1012 == 0 or pos % 1013 == 0)]
    
    #print('textord\n',textord[:1000])
    #file = open('ISO-MC20230325054638_01','w')
    #file.write(textord)
    #file.close()

    datoslen = []
    datoshex = []
    text_codif_list = []
    identifiers = []
    i = 0
    cadena = []
    cadena_ord = []
    count = 0

    while i < len(text):
        tamano = ''.join(text[i : i + 4])
        count+=1
        if verbose:
            print('tamano en hex de la primera trans -->', tamano, int(tamano, 16))
        
        
        tamano = int(tamano, 16)
        if tamano > 0:
            # listado con los tamanos en hex de las transacciones
            datoslen.append(tamano + 4)
            try:
                #print('TAMANO----->['+textord[i + 4 : i + 8]+']')
                identifiers.append(int(textord[i + 4 : i + 8]))
            except Exception as e:
                # imprime la excepcion
                print(e)
                print('CADENA ['+cadena[-1]+ ']'+'LEN ['+str(len(cadena[-1]))+']')
                print('CADENA ['+cadena_ord[-1]+ ']'+'LEN ['+str(len(cadena_ord[-1])/2)+']')
                #print(f'CADENA BIT: ['+str(bin(int(cadena_ord[-1][8*2:24*2],16)))+']')
                r = []
                for pos, item in enumerate(reversed(bin(int(cadena_ord[-1][8*2:24*2],16)))):
                    if item == '1':
                        r.append(pos + 1)
                #print("BITS ACTIVOS", r, '\n\n\n\n')
                # imprime los tamanos de las transacciones y la cantidad de transacciones leidas
                print(datoslen, len(datoslen))
                total = 0
                for i in range(0,len(datoslen)-1):
                    total+= datoslen[i]
                print(total,textord[total])
                # imprime el identificador que es donde sucede el error
                print('[' + textord[i + 4 : i + 8] + ']')
                exit(1)
            # listado de las transacciones en hexadecimal
            datoshex.append([_ for _ in text[i : i + 4 + tamano]])
            text_codif_list.append(text[i : i + 4 + tamano])
        
        cadena.append(textord[i:i + 4 + tamano])
        t = []
        for item in text[i : i + 4 + tamano]:
            t.append( f'0{item}' if len(item) == 1 else str(item))

        cadena_ord.append('-'.join(t))
        i = i + 4 + tamano
    
    print(count)
    datoshexfinal = []
    for hexlist in datoshex:
        value = []
        for hexval in hexlist:
            value.append(f'0{hexval}' if len(hexval) == 1 else hexval)
        datoshexfinal.append([_ for _ in value])
   
    file = open('ISO-MC20230325054638_00','w')
    for hexval in datoshexfinal:
        for s in hexval:
            file.write(s)
    file.close()

    if verbose :
        print('\n'.join([i for i in datoshexfinal]))

    # variable para almacenar las transacciones divididas en la forma de prueba
    result = []
    for pos, trans in enumerate(datoshexfinal):
        ident = identifiers[pos] 
        cadena = ''.join([i for i in trans[8:24]])
        cuerpo = ''.join(datoshexfinal[pos][24:])
        result.append((ident, cadena, cuerpo))
        
    return datoslen, datoshexfinal, text_codif_list, result

def agregar_a_tabla(path, codificacion='cp500'):
    _, _, _, result = obtener_mc_trans(path, encoding=codificacion)
    print(len(result))
    exec_list = [
        'DROP TABLE if exists prueba;',
        'create table prueba(ident varchar(4), cadena bit(128), cuerpo text, secuencia serial);',
        'truncate table prueba;'] + \
        [f'INSERT INTO prueba(ident, cadena, cuerpo) values(\'{ident}\', x\'{cadena}\', \'{cuerpo}\');' for ident, cadena, cuerpo in result]

    for item in exec_list:
        # print('\n', item)
        connect(item)
    return result

if __name__ == '__main__':
    path = 'MC.INC'

    if len(sys.argv) > 1:
        path = sys.argv[1]

        # try:
        result = agregar_a_tabla(path)
        # except Exception as e:
        #     print(e)

    