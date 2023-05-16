import psycopg2 as pg
from config import config

def connect(SQLsentences,insert_sentence=None,values_to_insert = None,action=False):
    conn = None
    
    try:
        # Leemos los parámetros de conexión
        params = config()
        conn = pg.connect(**params)

        # Creamos un cursor
        cur = conn.cursor()
        print('Connect to Postgres')

        # Ejecutamos la sentencia SQL
        for q in SQLsentences:
            cur.execute(q)
            conn.commit()
        
        print("tabla creada")

        if values_to_insert:
            for value in values_to_insert:
                insert_sentence = insert_sentence % value
                cur.execute(insert_sentence)
                conn.commit()
        
        #rows_number = cur.rowcount
        if action:
            result = cur.fetchall()

        # Cerramos la comunicación con PostgreSQL
        cur.close()
        if action:
            return result
    except (Exception, pg.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            print('Connection closed')
    