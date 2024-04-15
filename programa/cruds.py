from connector import callFunc
from functions import *
import enquiries

def modificarUsuario():
    opciones = ["INSERTAR","LEER", "LEER ESPECIFICO","ACTUALIZAR","ELIMINAR"]
    selección = enquiries.choose("Seleccione una acción: ", opciones)
    if selección == "INSERTAR":
        username: str = input("Usuario: ")
        password: str = input("Contraseña: ")

        rol: str = enquiries.choose('Seleccione un rol: ', roles)

        registerUser(username=username, password=password, rol=rol)
    elif selección == "LEER":
        resultado = callFunc('fn_')
    elif selección == "LEER ESPECIFICO":
        resultado = callFunc('fn_')
    elif selección == "ACTUALIZAR":
        resultado = callFunc('fn_')
    elif selección == "ELIMINAR":
        resultado = callFunc('fn_')

def modificarCuenta():
    opciones = ["INSERTAR","LEER", "LEER ESPECIFICO","ACTUALIZAR","ELIMINAR"]
    selección = enquiries.choose("Seleccione una acción: ", opciones)
    if selección == "INSERTAR":
        resultado = callFunc('fn_')
    elif selección == "LEER":
        resultado = callFunc('fn_')
    elif selección == "LEER ESPECIFICO":
        resultado = callFunc('fn_')
    elif selección == "ACTUALIZAR":
        resultado = callFunc('fn_')
    elif selección == "ELIMINAR":
        resultado = callFunc('fn_')

def modificarPedido():
    opciones = ["INSERTAR","LEER", "LEER ESPECIFICO","ACTUALIZAR","ELIMINAR"]
    selección = enquiries.choose("Seleccione una acción: ", opciones)
    if selección == "INSERTAR":
        resultado = callFunc('fn_')
    elif selección == "LEER":
        resultado = callFunc('fn_')
    elif selección == "LEER ESPECIFICO":
        resultado = callFunc('fn_')
    elif selección == "ACTUALIZAR":
        resultado = callFunc('fn_')
    elif selección == "ELIMINAR":
        resultado = callFunc('fn_')

def modificarDetallePedido():
    opciones = ["INSERTAR","LEER", "LEER ESPECIFICO","ACTUALIZAR","ELIMINAR"]
    selección = enquiries.choose("Seleccione una acción: ", opciones)
    if selección == "INSERTAR":
        resultado = callFunc('fn_')
    elif selección == "LEER":
        resultado = callFunc('fn_')
    elif selección == "LEER ESPECIFICO":
        resultado = callFunc('fn_')
    elif selección == "ACTUALIZAR":
        resultado = callFunc('fn_')
    elif selección == "ELIMINAR":
        resultado = callFunc('fn_')

def modificarItemMenu():
    opciones = ["INSERTAR","LEER", "LEER ESPECIFICO","ACTUALIZAR","ELIMINAR"]
    selección = enquiries.choose("Seleccione una acción: ", opciones)
    if selección == "INSERTAR":
        resultado = callFunc('fn_')
    elif selección == "LEER":
        resultado = callFunc('fn_')
    elif selección == "LEER ESPECIFICO":
        resultado = callFunc('fn_')
    elif selección == "ACTUALIZAR":
        resultado = callFunc('fn_')
    elif selección == "ELIMINAR":
        resultado = callFunc('fn_')

def modificarMesa():
    opciones = ["INSERTAR","LEER", "LEER ESPECIFICO","ACTUALIZAR","ELIMINAR"]
    selección = enquiries.choose("Seleccione una acción: ", opciones)
    if selección == "INSERTAR":
        resultado = callFunc('fn_')
    elif selección == "LEER":
        resultado = callFunc('fn_')
    elif selección == "LEER ESPECIFICO":
        resultado = callFunc('fn_')
    elif selección == "ACTUALIZAR":
        resultado = callFunc('fn_')
    elif selección == "ELIMINAR":
        resultado = callFunc('fn_')

def modificarMesero():
    opciones = ["INSERTAR","LEER", "LEER ESPECIFICO","ACTUALIZAR","ELIMINAR"]
    selección = enquiries.choose("Seleccione una acción: ", opciones)
    if selección == "INSERTAR":
        resultado = callFunc('fn_')
    elif selección == "LEER":
        resultado = callFunc('fn_')
    elif selección == "LEER ESPECIFICO":
        resultado = callFunc('fn_')
    elif selección == "ACTUALIZAR":
        resultado = callFunc('fn_')
    elif selección == "ELIMINAR":
        resultado = callFunc('fn_')

def modificarArea():
    opciones = ["INSERTAR","LEER", "LEER ESPECIFICO","ACTUALIZAR","ELIMINAR"]
    selección = enquiries.choose("Seleccione una acción: ", opciones)
    if selección == "INSERTAR":
        resultado = callFunc('fn_')
    elif selección == "LEER":
        resultado = callFunc('fn_')
    elif selección == "LEER ESPECIFICO":
        resultado = callFunc('fn_')
    elif selección == "ACTUALIZAR":
        resultado = callFunc('fn_')
    elif selección == "ELIMINAR":
        resultado = callFunc('fn_')

def modificarCliente():
    opciones = ["INSERTAR","LEER", "LEER ESPECIFICO","ACTUALIZAR","ELIMINAR"]
    selección = enquiries.choose("Seleccione una acción: ", opciones)
    if selección == "INSERTAR":
        resultado = callFunc('fn_')
    elif selección == "LEER":
        resultado = callFunc('fn_')
    elif selección == "LEER ESPECIFICO":
        resultado = callFunc('fn_')
    elif selección == "ACTUALIZAR":
        resultado = callFunc('fn_')
    elif selección == "ELIMINAR":
        resultado = callFunc('fn_')

def modificarEncuesta():
    opciones = ["INSERTAR","LEER", "LEER ESPECIFICO","ACTUALIZAR","ELIMINAR"]
    selección = enquiries.choose("Seleccione una acción: ", opciones)
    if selección == "INSERTAR":
        resultado = callFunc('fn_')
    elif selección == "LEER":
        resultado = callFunc('fn_')
    elif selección == "LEER ESPECIFICO":
        resultado = callFunc('fn_')
    elif selección == "ACTUALIZAR":
        resultado = callFunc('fn_')
    elif selección == "ELIMINAR":
        resultado = callFunc('fn_')

def modificarQueja():
    opciones = ["INSERTAR","LEER", "LEER ESPECIFICO","ACTUALIZAR","ELIMINAR"]
    selección = enquiries.choose("Seleccione una acción: ", opciones)
    if selección == "INSERTAR":
        resultado = callFunc('fn_')
    elif selección == "LEER":
        resultado = callFunc('fn_')
    elif selección == "LEER ESPECIFICO":
        resultado = callFunc('fn_')
    elif selección == "ACTUALIZAR":
        resultado = callFunc('fn_')
    elif selección == "ELIMINAR":
        resultado = callFunc('fn_')

def modificarPago():
    opciones = ["INSERTAR","LEER", "LEER ESPECIFICO","ACTUALIZAR","ELIMINAR"]
    selección = enquiries.choose("Seleccione una acción: ", opciones)
    if selección == "INSERTAR":
        resultado = callFunc('fn_')
    elif selección == "LEER":
        resultado = callFunc('fn_')
    elif selección == "LEER ESPECIFICO":
        resultado = callFunc('fn_')
    elif selección == "ACTUALIZAR":
        resultado = callFunc('fn_')
    elif selección == "ELIMINAR":
        resultado = callFunc('fn_')

