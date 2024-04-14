#Importar la librería del conector
import psycopg2 as pg

#Establecer la conexión
def connect() -> pg.extensions.connection:
    try:
        conexion = pg.connect(user = "postgres",
                                    password = "postgres",
                                    host = "localhost",
                                    port = "5432",
                                    database = "proyecto2")
        
        #print(f"Conectado a la base de datos {conexion.get_dsn_parameters()['dbname']}")

        return conexion
    except (Exception, pg.DatabaseError) as error:
        print(error)
"""
def callProc(procName: str, *args) -> None:
    try: 
        connector = connect()
        engine = connector.cursor()

        params = (f"""'{"', '".join(args)}'""")

        print("Procedimiento: ", procName)
        print("Parámetros: ", params)

        engine.execute(f"CALL {procName}({params})")

        connector.commit()

        print(f"Procedimiento {procName} ejecutado correctamente")


    except (Exception, pg.DatabaseError) as error:
        print("Error: ", error)

    finally:
        if (connector):
            connector.close()
            print("Conexión a la base de datos cerrada\n")"""

def callFunc(funcName: str, *args) -> list[tuple]:
    try:
        connector = connect()
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
