import psycopg2 as pg
from config import config

def connect(e_, verbose=False):
    conn = None
    try:
        # Leemos los parámetros de conexión
        params = config()

        # Conectamos con el servidor PostgreSQL
        if verbose:
            print('Conectando con PostgreSQL...')
        conn = pg.connect(**params)

        # creamos un cursor
        cur = conn.cursor()

        # Ejecutamos una sentencia en SQL
        cur.execute(e_)
        # guarda la ejecucion en la tabla

        conn.commit()
        # Mostramos el valor de la consulta que hemos solicitado con la sentencia anterior
        c = cur.fetchone()
        if verbose:
            print(c)

        # Cerramos la comunicación con PostgreSQL
        cur.close()
    
    except (Exception, pg.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            print('Database connection closed.')

