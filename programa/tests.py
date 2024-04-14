import unittest
import hashlib
import time
from programa.connector import callFunc

class myTestCase(unittest.TestCase):
    #Crud usuario
    def __init__(self, methodName: str = "runTest") -> None:
        super().__init__(methodName)
        self.username = "test"
        self.password = "<PASSWORD>"
        self.hash = hashlib.sha256(self.password.encode()).hexdigest()
        self.rol = "mesero"

"""    def test_userOperations(self):
        #DELETE
        username = "test"
        user = callFunc('fn_eliminar_usuario', username)
        self.assertEqual(user, [('test', self.hash,'administrador')])

        #CREATE
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
        self.assertEqual(user, [('test', self.hash, 'administrador')])"""

"""    def test_areaOperations(self):
        #CREATE
        area = callFunc('fn_insertar_area', 'Patio', True)
        self.assertEqual(area, [(1, 'Patio', True)])

        #READ
        area = callFunc("fn_leer_areas")
        self.assertEqual(area, [(1, 'Patio', True)])

        area = callFunc("fn_leer_area_especifica", 1)
        self.assertEqual(area, [(1, 'Patio', True)])

        #UPDATE
        area = callFunc('fn_actualizar_area', 1, 'Patio', False)
        self.assertEqual(area, [(1, 'Patio', False)])

        #DELETE
        area = callFunc('fn_eliminar_area', 1)
        self.assertEqual(area, [(1, 'Patio', False)])"""



        
    

