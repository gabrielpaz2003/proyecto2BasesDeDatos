import unittest
import hashlib
from datetime import datetime
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
        nowA = datetime.now()
        cuenta = callFunc('fn_insertar_cuenta', 11, 'abierta', nowA)
        numero = cuenta[0][0]
        self.assertEqual(cuenta, [(numero, 11, nowA, None, 'abierta')])

        #READ
        cuenta = callFunc("fn_leer_cuentas")
        timeA = datetime(2021, 1, 1, 12, 0, 0, 0)
        timeB = datetime(2021, 1, 1, 12, 30, 0, 0)
        self.assertEqual(cuenta, [(1,11,timeA, timeB, 'cerrada'),(numero, 11, nowA, None, 'abierta')])
        
        cuenta = callFunc("fn_leer_cuenta_especifica", numero)
        self.assertEqual(cuenta, [(numero, 11, nowA, None, 'abierta')])

        #UPDATE
        now = datetime.now()
        cuenta = callFunc('fn_actualizar_cuenta', numero, 11, nowA, now, 'cerrada')
        self.assertEqual(cuenta, [(numero, 11, nowA, now, 'cerrada')])

        #DELETE
        cuenta = callFunc('fn_eliminar_cuenta', numero)
        self.assertEqual(cuenta, [(numero, 11, nowA, now, 'cerrada')])

    def test_pedidoOperations(self):
        #CREATE
        now = datetime.now()
        pedido1 = callFunc('fn_insertar_pedido', 1, now)
        numero = pedido1[0][0]
        self.assertEqual(pedido1, [(numero, 1, now)])

        #READ
        pedido = callFunc("fn_leer_pedidos")
        self.assertEqual(pedido, [(numero, 1, now),(1,1,datetime(2024,4,15,4,41,0,0))])

        pedido = callFunc("fn_leer_pedido_especifico", numero)
        self.assertEqual(pedido, [(numero, 1, now)])

        #UPDATE
        now = datetime.now()
        pedido = callFunc('fn_actualizar_pedido', numero, 1, now)
        self.assertEqual(pedido, [(numero, 1, now)])

        #DELETE
        pedido = callFunc('fn_eliminar_pedido', numero)
        self.assertEqual(pedido, [(numero, 1, now)])

    def test_clienteOperations(self):
        #CREATE 
        cliente = callFunc('fn_insertar_cliente', "10954245", "Joaquín Puente", "Mi casa")
        numero = cliente[0][0]
        self.assertEqual(cliente, [("10954245", "Joaquín Puente", "Mi casa")])

        #READ
        cliente = callFunc("fn_leer_clientes")
        self.assertEqual(cliente, [('123456-7', 'Juan Perez', 'Ciudad'),("10954245", "Joaquín Puente", "Mi casa")])

        cliente = callFunc("fn_leer_cliente_especifico", "10954245")
        self.assertEqual(cliente, [("10954245", "Joaquín Puente", "Mi casa")])

        #UPDATE
        cliente = callFunc('fn_actualizar_cliente', "10954245", "Joaquín Puente", "Mi casa 2")
        self.assertEqual(cliente, [("10954245", "Joaquín Puente", "Mi casa 2")])

        #DELETE
        cliente = callFunc('fn_eliminar_cliente', "10954245")
        self.assertEqual(cliente, [("10954245", "Joaquín Puente", "Mi casa 2")])

    def test_encuentaOperations(self):
        #CREATE
        encuesta = callFunc('fn_insertar_encuesta', 1, 5, 5)
        numero = encuesta[0][0]
        self.assertEqual(encuesta, [(numero, 1, 5, 5)])

        #READ
        encuesta = callFunc("fn_leer_encuestas")
        self.assertEqual(encuesta, [(numero, 1, 5, 5)])

        encuesta = callFunc("fn_leer_encuesta_especifica", numero)
        self.assertEqual(encuesta, [(numero, 1, 5, 5)])

        #UPDATE
        encuesta = callFunc('fn_actualizar_encuesta', numero, 1, 3, 5)
        self.assertEqual(encuesta, [(numero, 1, 3, 5)])

        #DELETE
        encuesta = callFunc('fn_eliminar_encuesta', numero)
        self.assertEqual(encuesta, [(numero, 1, 3, 5)])
        
    def test_itemMenuOperations(self):
        #CREATE
        item = callFunc('fn_insertar_item_menu', "Papas fritas", "Papas fritas, elección del chef", 10, "comida")
        numero = item[0][0]
        self.assertEqual(item, [(numero, "Papas fritas", "Papas fritas, elección del chef", 10, "comida")])

        #READ
        item = callFunc("fn_leer_items_menu")
        self.assertEqual(item, [
            (numero, "Papas fritas", "Papas fritas, elección del chef", 10, "comida"),
            (4,"Hamburguesa","Hamburguesa de carne con queso y lechuga",5.00,"comida"),
            (5,"Refresco","Refresco de cola",1.50,"bebida"),
            (6,"Ensalada","Ensalada de lechuga, tomate y pepino",3.00,"comida"),
            (7,"Agua","Agua embotellada",1.00,"bebida"),
            (8,"Helado","Helado de chocolate",2.50,"comida"),
            (9,"Pastel","Pastel de chocolate",3.50,"comida")
        ])

        item = callFunc("fn_leer_item_menu_especifico", numero)
        self.assertEqual(item, [(numero, "Papas fritas", "Papas fritas, elección del chef", 10, "comida")])

        #UPDATE
        item = callFunc('fn_actualizar_item_menu', numero, "Papas fritas", "Papas fritas, elección del chef", 15, "comida")
        self.assertEqual(item, [(numero, "Papas fritas", "Papas fritas, elección del chef", 15, "comida")])

        #DELETE
        item = callFunc('fn_eliminar_item_menu', numero)
        self.assertEqual(item, [(numero, "Papas fritas", "Papas fritas, elección del chef", 15, "comida")])

    def test_detallePedidoOperations(self):
        #CREATE
        detalle = callFunc('fn_insertar_detalle_pedido',1, 4, 1, 'pendiente')
        self.assertEqual(detalle, [(1, 4, 1, 'pendiente')])

        #READ
        detalle = callFunc("fn_leer_detalles_pedido")
        self.assertEqual(detalle, [(1, 4, 1, 'pendiente')])

        detalle = callFunc("fn_leer_detalle_pedido_especifico", 1, 4)
        self.assertEqual(detalle, [(1, 4, 1, 'pendiente')])

        #UPDATE
        detalle = callFunc('fn_actualizar_detalle_pedido', 1, 4, 1, 'entregado')
        self.assertEqual(detalle, [(1, 4, 1, 'entregado')])

        #DELETE
        detalle = callFunc('fn_eliminar_detalle_pedido', 1, 4)
        self.assertEqual(detalle, [(1, 4, 1, 'entregado')])

    def test_meseroOperations(self):
        #CREATE
        mesero = callFunc('fn_insertar_mesero', "Joaquín", 1)
        numero = mesero[0][0]
        self.assertEqual(mesero, [(numero, "Joaquín", 1)])

        #READ
        mesero = callFunc("fn_leer_meseros")
        self.assertEqual(mesero, [(1, "Juan", 1),(numero, "Joaquín", 1)])

        mesero = callFunc("fn_leer_mesero_especifico", numero)
        self.assertEqual(mesero, [(numero, "Joaquín", 1)])

        #UPDATE
        mesero = callFunc('fn_actualizar_mesero', numero, "Joaquín Puente", 1)
        self.assertEqual(mesero, [(numero, "Joaquín Puente", 1)])

        #DELETE
        mesero = callFunc('fn_eliminar_mesero', numero)
        self.assertEqual(mesero, [(numero, "Joaquín Puente", 1)])
        
    def test_pagoOperations(self):
        #CREATE
        pago = callFunc('fn_insertar_pago', 1, 500, 'efectivo')
        numero = pago[0][0]
        self.assertEqual(pago, [(numero, 1, 500, 'efectivo')])

        #READ
        pago = callFunc("fn_leer_pagos")
        self.assertEqual(pago, [(numero, 1, 500, 'efectivo')])

        pago = callFunc("fn_leer_pago_especifico", numero)
        self.assertEqual(pago, [(numero, 1, 500, 'efectivo')])

        #UPDATE
        pago = callFunc('fn_actualizar_pago', numero, 1, 1000, 'efectivo')
        self.assertEqual(pago, [(numero, 1, 1000, 'efectivo')])

        #DELETE
        pago = callFunc('fn_eliminar_pago', numero)
        self.assertEqual(pago, [(numero, 1, 1000, 'efectivo')])

    def test_quejaOperations(self):
        #CREATE
        now = datetime.now()
        queja = callFunc('fn_insertar_queja', "123456-7", now, "Mesero Grosero", 5, 1, None)
        numero = queja[0][0]
        self.assertEqual(queja, [(numero, "123456-7", now, "Mesero Grosero", 5, 1, None)])

        #READ
        queja = callFunc("fn_leer_quejas")
        self.assertEqual(queja, [(numero, "123456-7", now, "Mesero Grosero", 5, 1, None)])

        queja = callFunc("fn_leer_queja_especifica", numero)
        self.assertEqual(queja, [(numero, "123456-7", now, "Mesero Grosero", 5, 1, None)])

        #UPDATE
        queja = callFunc('fn_actualizar_queja', numero, "123456-7", now, "Mesero Grosero", 3, 1, None)
        self.assertEqual(queja, [(numero, "123456-7", now, "Mesero Grosero", 3, 1, None)])

        #DELETE
        queja = callFunc('fn_eliminar_queja', numero)
        self.assertEqual(queja, [(numero, "123456-7", now, "Mesero Grosero", 3, 1, None)])





        

        



        











        
    

