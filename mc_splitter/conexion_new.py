import psycopg2 as pg
from config import config

def connect(e_, verbose=False):
    print(len(e_))
    conn = None
    try:
        # Leemos los parámetros de conexión
        params = config()

        # Conectamos con el servidor PostgreSQL
        conn = pg.connect(**params)
        
        # creamos un cursor
        cur = conn.cursor()

        for sentence in e_:
            # Ejecutamos una sentencia en SQL
            cur.execute(sentence)
            # guarda la ejecucion en la tabla
            conn.commit()            

        # Cerramos la comunicación con PostgreSQL
        cur.close()

    
    except (Exception, pg.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            print('Database connection closed.')

