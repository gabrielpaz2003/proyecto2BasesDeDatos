from connector import callFunc, connect
from entities import *
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


        if choice == "Agregar Producto":
            productos = callFunc("sp_leer_items_menu")

            print(productos)

            productos = [Product(p[0], p[1], p[2], p[3]).__str__ for p in productos]
            producto = enquiries.choose("Seleccione un producto: ", productos)

            print("\033c")
            cantidad = int(input("Cantidad: "))

            insercion = callFunc("sp_insertar_pedido_item", idPedido, producto.id, cantidad)
            print(insercion)
            if insercion:
                print("Producto agregado")
            else:
                print("No se pudo agregar el producto")


        elif choice == "Consultar Pedido":
            pass
            #Mostrar Pedido

        elif choice == "Cerrar Pedido":
            break


def __tomarPedido(cuenta: int):
    pedido = callFunc("sp_insertar_pedido", cuenta)
    __detallarPedido(pedido)


def __abrirCuenta(mesa: int):
    cuenta = callFunc("sp_insertar_cuenta", mesa)

    if cuenta:
        print("Cuenta abierta")
    else:
        print("No se pudo abrir la cuenta")

def __cerrarCuenta():
    #Establecer la conexión
    pass
    #Capturar los datos

    # TODO: Registrar el cierre de la cuenta en la base de datos

def __consultarPedidos():
    #Establecer la conexión
    pass
    #Capturar los datos



def mainMenu(userInstance: User) -> None:
    if userInstance.role == "mesero":
        opciones = ["Abrir Cuenta", "Tomar Pedido", "Consultar pedidos", "Cerrar Cuenta", "Salir"]
        print(f"Bienvenido {userInstance.username}")
        while True:
            choice = enquiries.choose('Choose one of these options: ', opciones)
            if choice == "Abrir Cuenta":
                mesa: int = int(input("Mesa: "))
                __abrirCuenta(mesa)
                print("Cuenta abierta")
            elif choice == "Tomar Pedido":
                cuenta: int = int(input("Cuenta: "))
                __tomarPedido(cuenta)
                print("Pedido tomado")
            elif choice == "Consultar pedidos":
                opcionesConsulta = ["Por mesa", "Por cuenta"]
                consulta = enquiries.choose('Consultar por: ', opcionesConsulta)
                if consulta == "Por mesa":
                    mesa: int = int(input("Mesa: "))
                    __consultarPedidos(consulta, mesa)
                elif consulta == "Por cuenta":
                    cuenta: int = int(input("Cuenta: "))
                    __consultarPedidos(consulta, cuenta)

            elif choice == "Cerrar Cuenta":
                cuenta: int = int(input("Cuenta: "))
                __cerrarCuenta(cuenta)
                print("Cuenta cerrada")
            elif choice == "Salir":
                return
            
    elif userInstance.role == "administrador":
        print(f"Bienvenido {userInstance.username}")

    elif userInstance.role == "chef":
        print(f"Bienvenido {userInstance.username}")

    elif userInstance.role == "barista":
        print(f"Bienvenido {userInstance.username}")




