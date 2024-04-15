#Importar la librería del conector
import psycopg2 as pg

#Establecer la conexión
def __connect() -> pg.extensions.connection:
    try:
        conexion = pg.connect(user = "postgres",
                                    password = "postgres",
                                    host = "localhost",
                                    port = "5432",
                                    database = "proyecto2")

        return conexion
    except (Exception, pg.DatabaseError) as error:
        print(error)

def callFunc(funcName: str, *args) -> list[tuple]:
    try:
        connector = __connect()
        engine = connector.cursor()

        params = list(args)

        engine.callproc(f"{funcName}", params)

        connector.commit()

        return engine.fetchall()

    except (Exception, pg.DatabaseError) as error:
        print("Error: ", error)

    finally:
        if (connector):
            connector.close()

def runQuery(query: str) -> list[tuple]:
    try:
        connector = __connect()
        engine = connector.cursor()

        engine.execute(query)

        connector.commit()

        return engine.fetchall()
    except (Exception, pg.DatabaseError) as error:
        print("Error: ", error)
    finally:
        if (connector):
            connector.close()