from connector import callFunc, runQuery
from entities import *
from funcionesAuxiliares import *
#from cruds import *
import tabulate
import enquiries
import hashlib
from datetime import datetime

def convertir_a_datetime(año, mes, dia):
    fecha = datetime(int(año), int(mes), int(dia),0,0,0,0)
    return fecha

def registerUser(username: str, password: str, rol: str) -> None:
    passwordHash = hashlib.sha256(password.encode()).hexdigest()
    callFunc("fn_insertar_usuario", username, passwordHash, rol)

def loginUser(username: str, password: str) -> User:
    passwordHash = hashlib.sha256(password.encode()).hexdigest()

    user = callFunc('fn_leer_usuario_especifico', username)
    print("User: ", user)
    if user:
        if user[0][1] == passwordHash:
            return User(user[0][0], user[0][1], user[0][2])
        else:
            return None
    else:
        return None

def __detallarPedido(idPedido: int):
    options = ["Agregar Producto", "Consultar Pedido", "Cerrar Pedido"]
    
    while True:
        choice = enquiries.choose("Seleccione una opción: ", options)

        productos = callFunc("fn_leer_items_menu")
        productos = [Product(p[0], p[1], p[2], p[3]) for p in productos]

        if choice == "Agregar Producto":
            print("\033c")
            if len(productos) == 0:
                print("No hay productos en el menu")
                return
            producto = enquiries.choose("Seleccione un producto: ", productos)
            cantidad = int(input("Cantidad: "))
            insercion = callFunc("fn_insertar_detalle_pedido", idPedido, producto.id, cantidad)

            if insercion:
                print("Producto agregado")
            else:
                print("No se pudo agregar el producto")

        elif choice == "Consultar Pedido":
            result = runQuery(f"SELECT * FROM detalle_pedido WHERE id_pedido = {idPedido}")

            pedidos = [Detalle(p[0], p[1], p[2]) for p in result]
            print("\033c")

            if len(pedidos) == 0:
                print("No hay pedidos")
                return
            
            table = [["Producto", "Cantidad"]]

            for p in pedidos:
                for r in productos:
                    if p.product_id == r.id:
                        table.append([r.name, p.quantity])
                        break
            
            print(tabulate.tabulate(table, headers="firstrow"))
            print("\n")



        elif choice == "Cerrar Pedido":
            break

def __tomarPedido(cuenta: int):
    pedido = callFunc("fn_insertar_pedido", cuenta, get_now(), 'pendiente')

    __detallarPedido(pedido[0][0])

def __abrirCuenta(mesa: int):
    cuenta = callFunc("fn_insertar_cuenta", mesa, 'abierta', get_now())
    cuenta = Account(cuenta[0][0], cuenta[0][1], cuenta[0][2], cuenta[0][3], cuenta[0][4])
    print("\033c")

    if cuenta:
        print(f"Cuenta abierta {cuenta.id}")
    else:
        print("No se pudo abrir la cuenta")

def __cerrarCuenta(cuentaId: int):
    cuenta = callFunc("fn_leer_cuenta_especifica", cuentaId)
    cuenta: Account = Account(cuenta[0][0], cuenta[0][1], cuenta[0][2], cuenta[0][3], cuenta[0][4])
    cuenta = callFunc("fn_actualizar_cuenta", cuentaId, cuenta.table_id, cuenta.open_datetime, get_now(), 'cerrada')
    cuenta = Account(cuenta[0][0], cuenta[0][1], cuenta[0][2], cuenta[0][3], cuenta[0][4])
    if cuenta:
        print(f"Cuenta cerrada {cuenta.id}")
    else:
        print("No se pudo cerrar la cuenta")

    __facturarCuenta(cuentaId)

def __consultarPedidosCuenta(id_cuenta):
    result = runQuery(f"""select dp.id_item, im.nombre, dp.cantidad from detalle_pedido dp
        join pedido p on dp.id_pedido = p.id_pedido
        join cuenta c on p.id_cuenta = c.id_cuenta
        join item_menu im on dp.id_item = im.id_item
        where c.id_cuenta = {id_cuenta};
    """)

    tabla = [["Id", "Producto", "Cantidad"]]
    for r in result:
        tabla.append([r[0], r[1], r[2]])

    print(tabulate.tabulate(tabla, headers="firstrow"))

def __facturarCuenta(id_cuenta):
    result = runQuery(f"""
    select dp.id_item, im.nombre, dp.cantidad, im.precio*dp.cantidad as subtotal from detalle_pedido dp
    join pedido p on dp.id_pedido = p.id_pedido
    join cuenta c on p.id_cuenta = c.id_cuenta
    join item_menu im on dp.id_item = im.id_item
    where c.id_cuenta = {id_cuenta};""")

    tabla = [["Id", "Producto", "Cantidad", "Subtotal"]]

    total = 0.00

    for r in result:
        total += float(r[3])
        tabla.append([r[0], r[1], r[2], r[3]])

    print(tabulate.tabulate(tabla, headers="firstrow"))

    propina = total*0.15

    print(f"Subtotal: Q{total:.2f}")
    print(f"Propina Q{propina:.2f}")
    print(f"Total Q{(total+propina):.2f}")

def __consultarPedido(id_pedido):
    result = runQuery(f"""
    select im.nombre, dp.cantidad from detalle_pedido dp
    join item_menu im on dp.id_item = im.id_item
    where dp.id_pedido = {id_pedido}
    """)
    print("\033c")

    tabla = [["Producto", "Cantidad"]]
    for r in result:
        tabla.append([r[0], r[1]])

    print(tabulate.tabulate(tabla, headers="firstrow"))

def __fetchPedidosCocina(tipo):
    result = runQuery(f"""
    SELECT p.id_pedido  from detalle_pedido dp
    join pedido p on dp.id_pedido = p.id_pedido
    join item_menu im on dp.id_item = im.id_item
    where p.estado = 'pendiente' and im.tipo = '{tipo}'
    order by p.fechahora asc;
    """)    
    print("\033c")

    pedidos = [r[0] for r in result]

    ver = enquiries.choose('Choose one of these options: ', pedidos)

    __consultarPedido(ver)

def __entregarPedido(tipo):
    result = runQuery(f"""
    SELECT p.id_pedido  from detalle_pedido dp
    join pedido p on dp.id_pedido = p.id_pedido
    join item_menu im on dp.id_item = im.id_item
    where p.estado = 'pendiente' and im.tipo = '{tipo}'
    order by p.fechahora asc;
    """)    
    pedidos = [r[0] for r in result]
    print("\033c")

    ver = enquiries.choose('Choose one of these options: ', pedidos)

    resultado = callFunc("fn_leer_pedido_especifico", ver)

    callFunc("fn_actualizar_pedido", ver, resultado[0][1], resultado[0][2], 'entregado')

def __crearAgrupacion(valores):
    string = ""
    for i in valores:
        string += f"({i}),"

    runQuery(f"INSERT INTO agrupacion_mesas(ID_Mesa) VALUES {string}")

def __eliminarAgrupacion(idAgrupacion):
    runQuery(f"DELETE FROM agrupacion_mesas WHERE ID_Agrupacion == {idAgrupacion}")

    print("Agrupación eliminada")

def mainMenu(userInstance: User) -> None:
    print("\033c")
    if userInstance.role == "mesero":
        opciones = ["Abrir Cuenta", "Tomar Pedido", "Consultar pedidos", "Cerrar Cuenta", "Agrupaciones", "Cerrar sesión"]
        print(f"Bienvenido {userInstance.username}")
        while True:
            choice = enquiries.choose('Choose one of these options: ', opciones)
            if choice == "Abrir Cuenta":
                mesa: int = int(input("Mesa: "))
                __abrirCuenta(mesa)
            elif choice == "Tomar Pedido":
                cuenta: int = int(input("Cuenta: "))
                __tomarPedido(cuenta)
            elif choice == "Consultar pedidos":
                cuenta: int = int(input("Cuenta: "))
                __consultarPedidosCuenta(cuenta)
            elif choice == "Cerrar Cuenta":
                cuenta: int = int(input("Cuenta: "))
                __cerrarCuenta(cuenta)
            elif choice == "Agrupaciones":
                options = ["Crear Agrupación", "Eliminar agrupación", "Salir"]
                choice = enquiries.choose('Elije una opción: ', options)
                if choice == "Crear Agrupación":
                    print("Ingrese los números de mesa que desea agregar (Salir = 0)")
                    valores = []
                    while True:
                        valor = input("Mesa: ")
                        if valor == "0":
                            break
                        else:
                            valores.append(int(valor))

                    __crearAgrupacion(valores)
                elif choice == "Eliminar agrupación":
                    __eliminarAgrupacion()
                elif choice == "Salir":
                    continue


            elif choice == "Cerrar sesión":
                return
            
    elif userInstance.role == "administrador":
        print(f"Bienvenido {userInstance.username}")
        while True:
            choice = enquiries.choose('Elije una opción: ', ["Ver reportes", "Ver Quejas", "Ver encuestas", "Modificar datos", "Cerrar sesión"])
            if choice == "Ver reportes":
                print("\033c")
                reportes = ["Plato más pedido", "Horario de más pedidos", "Promedio de tiempo para comer", "Quejas por fecha", "Quejas por fecha por persona", "Eficiencia Meseros"]
                choice = enquiries.choose('Elije una opción: ', reportes)

                if choice == "Plato más pedido":

                    año_inicio = input("Ingrese el año de inicio (YYYY): ")
                    mes_inicio = input("Ingrese el mes de inicio (MM): ")
                    dia_inicio = input("Ingrese el día de inicio (DD): ")

                    try:
                        fecha_inicio = convertir_a_datetime(año_inicio, mes_inicio, dia_inicio)
                        print("La fecha en formato datetime es:", fecha_inicio)
                        break  # Salir del bucle si la fecha es válida
                    except ValueError:
                        print("La fecha ingresada no es válida. Por favor, asegúrese de ingresar valores numéricos válidos para año, mes y día.")


                    año_fin = input("Ingrese el año de fin (YYYY): ")
                    mes_fin = input("Ingrese el mes de fin (MM): ")
                    dia_fin = input("Ingrese el día de fin (DD): ")

                    try:
                        fecha_fin = convertir_a_datetime(año_fin, mes_fin, dia_fin)
                        print("La fecha en formato datetime es:", fecha_inicio)
                        break  # Salir del bucle si la fecha es válida
                    except ValueError:
                        print("La fecha ingresada no es válida. Por favor, asegúrese de ingresar valores numéricos válidos para año, mes y día.")

                    
                    result = callFunc("obtener_items_menu_mas_pedidos", fecha_inicio, fecha_fin)
            
                    tabla = [["ID_Item", "Nombre", "Total de pedidos"]]

                    for r in result:
                        tabla.append([r[0], r[1], r[2]])
                    
                    print(tabulate.tabulate(tabla, headers="firstrow"))

                elif choice == "Horario de más pedidos":

                    año_inicio = input("Ingrese el año de inicio (YYYY): ")
                    mes_inicio = input("Ingrese el mes de inicio (MM): ")
                    dia_inicio = input("Ingrese el día de inicio (DD): ")

                    try:
                        fecha_inicio = convertir_a_datetime(año_inicio, mes_inicio, dia_inicio)
                        print("La fecha en formato datetime es:", fecha_inicio)
                        break  # Salir del bucle si la fecha es válida
                    except ValueError:
                        print("La fecha ingresada no es válida. Por favor, asegúrese de ingresar valores numéricos válidos para año, mes y día.")


                    año_fin = input("Ingrese el año de fin (YYYY): ")
                    mes_fin = input("Ingrese el mes de fin (MM): ")
                    dia_fin = input("Ingrese el día de fin (DD): ")

                    try:
                        fecha_fin = convertir_a_datetime(año_fin, mes_fin, dia_fin)
                        print("La fecha en formato datetime es:", fecha_inicio)
                        break  # Salir del bucle si la fecha es válida
                    except ValueError:
                        print("La fecha ingresada no es válida. Por favor, asegúrese de ingresar valores numéricos válidos para año, mes y día.")

                    result = callFunc("obtener_horario_mas_concurrido", fecha_inicio, fecha_fin)

                    tabla = [["Horario", "Total de pedidos"]]
                    for r in result:
                        tabla.append([r[0], r[1]])

                    print(tabulate.tabulate(tabla, headers="firstrow"))

                elif choice == "Promedio de tiempo para comer":
                    
                    año_inicio = input("Ingrese el año de inicio (YYYY): ")
                    mes_inicio = input("Ingrese el mes de inicio (MM): ")
                    dia_inicio = input("Ingrese el día de inicio (DD): ")

                    try:
                        fecha_inicio = convertir_a_datetime(año_inicio, mes_inicio, dia_inicio)
                        print("La fecha en formato datetime es:", fecha_inicio)
                        break  # Salir del bucle si la fecha es válida
                    except ValueError:
                        print("La fecha ingresada no es válida. Por favor, asegúrese de ingresar valores numéricos válidos para año, mes y día.")


                    año_fin = input("Ingrese el año de fin (YYYY): ")
                    mes_fin = input("Ingrese el mes de fin (MM): ")
                    dia_fin = input("Ingrese el día de fin (DD): ")

                    try:
                        fecha_fin = convertir_a_datetime(año_fin, mes_fin, dia_fin)
                        print("La fecha en formato datetime es:", fecha_inicio)
                        break  # Salir del bucle si la fecha es válida
                    except ValueError:
                        print("La fecha ingresada no es válida. Por favor, asegúrese de ingresar valores numéricos válidos para año, mes y día.")

                    result = callFunc("calcular_promedio_tiempo_comida", fecha_inicio, fecha_fin)

                    tabla = [["Cantidad de personas", "Promedio de tiempo"]]
                    for r in result:
                        tabla.append([r[0], r[1]])

                    print(tabulate.tabulate(tabla, headers="firstrow"))

                elif choice == "Quejas por fecha":

                    año_inicio = input("Ingrese el año de inicio (YYYY): ")
                    mes_inicio = input("Ingrese el mes de inicio (MM): ")
                    dia_inicio = input("Ingrese el día de inicio (DD): ")

                    try:
                        fecha_inicio = convertir_a_datetime(año_inicio, mes_inicio, dia_inicio)
                        print("La fecha en formato datetime es:", fecha_inicio)
                        break  # Salir del bucle si la fecha es válida
                    except ValueError:
                        print("La fecha ingresada no es válida. Por favor, asegúrese de ingresar valores numéricos válidos para año, mes y día.")


                    año_fin = input("Ingrese el año de fin (YYYY): ")
                    mes_fin = input("Ingrese el mes de fin (MM): ")
                    dia_fin = input("Ingrese el día de fin (DD): ")

                    try:
                        fecha_fin = convertir_a_datetime(año_fin, mes_fin, dia_fin)
                        print("La fecha en formato datetime es:", fecha_inicio)
                        break  # Salir del bucle si la fecha es válida
                    except ValueError:
                        print("La fecha ingresada no es válida. Por favor, asegúrese de ingresar valores numéricos válidos para año, mes y día.")

                    result = callFunc("obtener_quejas_por_item_menu", fecha_inicio, fecha_fin)

                    tabla = [["ID_Queja", "FechaHora", "Motivo", "Severidad", "Mesero"]]

                    for r in result:
                        tabla.append([r[0], r[1], r[2], r[3], r[4]])

                    print(tabulate.tabulate(tabla, headers="firstrow"))

                elif choice == "Quejas por fecha por persona":
                    
                    año_inicio = input("Ingrese el año de inicio (YYYY): ")
                    mes_inicio = input("Ingrese el mes de inicio (MM): ")
                    dia_inicio = input("Ingrese el día de inicio (DD): ")

                    try:
                        fecha_inicio = convertir_a_datetime(año_inicio, mes_inicio, dia_inicio)
                        print("La fecha en formato datetime es:", fecha_inicio)
                        break  # Salir del bucle si la fecha es válida
                    except ValueError:
                        print("La fecha ingresada no es válida. Por favor, asegúrese de ingresar valores numéricos válidos para año, mes y día.")


                    año_fin = input("Ingrese el año de fin (YYYY): ")
                    mes_fin = input("Ingrese el mes de fin (MM): ")
                    dia_fin = input("Ingrese el día de fin (DD): ")

                    try:
                        fecha_fin = convertir_a_datetime(año_fin, mes_fin, dia_fin)
                        print("La fecha en formato datetime es:", fecha_inicio)
                        break  # Salir del bucle si la fecha es válida
                    except ValueError:
                        print("La fecha ingresada no es válida. Por favor, asegúrese de ingresar valores numéricos válidos para año, mes y día.")

                    result = callFunc("obtener_quejas_por_mesero", fecha_inicio, fecha_fin)

                    tabla = [["ID_Queja", "FechaHora", "Motivo", "Severidad", "Item"]]
                    for r in result:
                        tabla.append([r[0], r[1], r[2], r[3], r[4]])

                    print(tabulate.tabulate(tabla, headers="firstrow"))

                elif choice == "Eficiencia Meseros":
            
                    result = callFunc("calcular_eficiencia_meseros")
                    tabla = [["Mes", "Amabilidad", "Exactitud"]]
                    for r in result:
                        tabla.append([r[0], r[1], r[2]])

                    print(tabulate.tabulate(tabla, headers="firstrow"))

            elif choice == "Cerrar sesión":
                return

    elif userInstance.role == "chef":
        opciones = ["Ver Pedidios", "Entregar Pedido", "Cerrar sesión"]
        print(f"Bienvenido {userInstance.username}")
        while True:
            choice = enquiries.choose('Elije una opción: ', opciones)
            if choice == "Ver Pedidios":
                __fetchPedidosCocina('comida')
            elif choice == "Entregar Pedido":
                __entregarPedido('comida')
            elif choice == "Cerrar sesión":
                return


    elif userInstance.role == "barista":
        opciones = ["Ver Pedidios", "Entregar Pedido", "Cerrar sesión"]
        print(f"Bienvenido {userInstance.username}")
        while True:
            choice = enquiries.choose('Elije una opción: ', opciones)
            if choice == "Ver Pedidios":
                __fetchPedidosCocina('bebida')
            elif choice == "Entregar Pedido":
                __entregarPedido('bebida')
            elif choice == "Cerrar sesión":
                return




