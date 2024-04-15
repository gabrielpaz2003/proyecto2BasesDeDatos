import unittest
import hashlib
from datetime import datetime, timezone
from programa.connector import callFunc

class myTestCase(unittest.TestCase):
    #Crud usuario
    def __init__(self, methodName: str = "runTest") -> None:
        super().__init__(methodName)
        self.username = "test"
        self.password = "<PASSWORD>"
        self.hash = hashlib.sha256(self.password.encode()).hexdigest()
        self.rol = "mesero"

    def test_userOperations(self):
        #CREATE
        username = "test"
        usuario = callFunc("fn_insertar_usuario", username, self.password, self.rol)
        self.assertEqual(usuario, [('test', "<PASSWORD>",'mesero')])

        #READ
        users = callFunc("fn_leer_usuarios")
        self.assertEqual(users, [('test', "<PASSWORD>", 'mesero')])

        username = "test"
        user = callFunc('fn_leer_usuario_especifico', username)
        self.assertEqual(user, [('test', "<PASSWORD>", 'mesero')])

        #UPDATE
        username = "test"
        user = callFunc('fn_actualizar_usuario', username, self.hash, 'administrador')
        self.assertEqual(user, [('test', self.hash, 'administrador')])

        #DELETE
        username = "test"
        user = callFunc('fn_eliminar_usuario', username)
        self.assertEqual(user, [('test', self.hash,'administrador')])

    def test_areaOperations(self):
        #CREATE
        area = callFunc('fn_insertar_area', 'Patio', True)
        numero = area[0][0]
        self.assertEqual(area, [(numero, 'Patio', True)])

        #READ
        area = callFunc("fn_leer_areas")
        self.assertEqual(area, [(1, 'Area 1', False),(numero, 'Patio', True)])

        area = callFunc("fn_leer_area_especifica", numero)
        self.assertEqual(area, [(numero, 'Patio', True)])

        #UPDATE
        area = callFunc('fn_actualizar_area', numero, 'Patio', False)
        self.assertEqual(area, [(numero, 'Patio', False)])

        #DELETE
        area = callFunc('fn_eliminar_area', numero)
        self.assertEqual(area, [(numero, 'Patio', False)])

    def test_mesaOperations(self):
        #CREATE
        mesa = callFunc('fn_insertar_mesa', 1, 4, False, True)
        numero = mesa[0][0]
        self.assertEqual(mesa, [(numero, 1, 4, False, True)])

        #READ
        mesa = callFunc("fn_leer_mesas")
        self.assertEqual(mesa, [(11,1,4,False,True),(numero, 1, 4, False, True)])

        mesa = callFunc("fn_leer_mesa_especifica", numero)
        self.assertEqual(mesa, [(numero, 1, 4, False, True)])

        #UPDATE
        mesa = callFunc('fn_actualizar_mesa',numero, 1, 4, False, False)
        self.assertEqual(mesa, [(numero, 1, 4, False, False)])

        #DELETE
        mesa = callFunc('fn_eliminar_mesa', numero)
        self.assertEqual(mesa, [(numero, 1, 4, False, False)])

    def test_cuentaOperations(self):
        #CREATE
        cuenta1 = callFunc('fn_insertar_cuenta', 11, 'abierta')
        numero = cuenta1[0][0]

        #READ
        cuenta = callFunc("fn_leer_cuentas")
        
        cuenta = callFunc("fn_leer_cuenta_especifica", numero)
        self.assertEqual(cuenta, cuenta1)

        #UPDATE
        now = datetime.now()
        cuenta = callFunc('fn_actualizar_cuenta', numero, 11, cuenta[0][2], now, 'cerrada')
        print(cuenta)

        #DELETE
        cuenta = callFunc('fn_eliminar_cuenta', numero)
        self.assertEqual(cuenta, [(numero, 11, cuenta[0][2], now, 'cerrada')])

    def test_pedidoOperations(self):
        #CREATE
        now = datetime.now()
        pedido1 = callFunc('fn_insertar_pedido', 11, now)
        numero = pedido1[0][0]
        self.assertEqual(pedido1, [(numero, 11, now)])

        #READ
        pedido = callFunc("fn_leer_pedidos")
        self.assertEqual(pedido, [(numero, 11, now)])

        pedido = callFunc("fn_leer_pedido_especifica", numero)
        self.assertEqual(pedido, [(numero, 11, now)])

        #UPDATE
        now = datetime.now()
        pedido = callFunc('fn_actualizar_pedido', numero, 11, now)
        self.assertEqual(pedido, [(numero, 11, now)])

        #DELETE
        pedido = callFunc('fn_eliminar_pedido', numero)
        self.assertEqual(pedido, [(numero, 11, now)])
        



        











        
    

