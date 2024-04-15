from connector import callFunc, runQuery
from entities import *
from funcionesAuxiliares import *
import tabulate
import enquiries
import hashlib


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

def mainMenu(userInstance: User) -> None:
    if userInstance.role == "mesero":
        opciones = ["Abrir Cuenta", "Tomar Pedido", "Consultar pedidos", "Cerrar Cuenta", "Cerrar sesión"]
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
            elif choice == "Cerrar sesión":
                return
            
    elif userInstance.role == "administrador":
        print(f"Bienvenido {userInstance.username}")

    elif userInstance.role == "chef":
        print(f"Bienvenido {userInstance.username}")

    elif userInstance.role == "barista":
        print(f"Bienvenido {userInstance.username}")




