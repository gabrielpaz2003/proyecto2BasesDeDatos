--CRUD USUARIO
--Crear Usuario
CREATE OR REPLACE PROCEDURE sp_insertar_usuario(nombre_usuario VARCHAR, hash_contrasena TEXT, rol_usuario VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Usuario (NombreUsuario, HashContraseña, Rol) VALUES (nombre_usuario, hash_contrasena, rol_usuario);
END;
$$;

-- Leer todos los Usuarios
CREATE OR REPLACE PROCEDURE sp_leer_usuarios()
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM Usuario;
END;
$$;

-- Leer usuario especifico
CREATE OR REPLACE PROCEDURE sp_leer_usuario_especifico(id_usuario INT)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM Usuario WHERE ID_Usuario = id_usuario;
END;
$$;

-- Actualizar Usuario
CREATE OR REPLACE PROCEDURE sp_actualizar_usuario(id_usuario INT, nombre_usuario VARCHAR, hash_contrasena TEXT, rol_usuario VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Usuario
    SET NombreUsuario = nombre_usuario, HashContraseña = hash_contrasena, Rol = rol_usuario
    WHERE ID_Usuario = id_usuario;
END;
$$;

-- Eliminar Usuario
CREATE OR REPLACE PROCEDURE sp_eliminar_usuario(id_usuario INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Usuario WHERE ID_Usuario = id_usuario;
END;
$$;

-- CRUD AREA
-- Insertar Area
CREATE OR REPLACE PROCEDURE sp_insertar_area(nombre_area VARCHAR, es_para_fumadores BOOLEAN)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Area (Nombre, EsParaFumadores) VALUES (nombre_area, es_para_fumadores);
END;
$$;

-- Leer todas las Areas
CREATE OR REPLACE PROCEDURE sp_leer_areas()
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM Area;
END;
$$;

-- Leer area especifica
CREATE OR REPLACE PROCEDURE sp_leer_area_especifica(id_area INT)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM Area WHERE ID_Area = id_area;
END;
$$;

-- Actualizar area
CREATE OR REPLACE PROCEDURE sp_actualizar_area(id_area INT, nombre_area VARCHAR, es_para_fumadores BOOLEAN)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Area
    SET Nombre = nombre_area, EsParaFumadores = es_para_fumadores
    WHERE ID_Area = id_area;
END;
$$;

-- Eliminar area
CREATE OR REPLACE PROCEDURE sp_eliminar_area(id_area INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Area WHERE ID_Area = id_area;
END;
$$;

-- CRUD Mesa
-- Crear Mesa
CREATE OR REPLACE PROCEDURE sp_insertar_mesa(id_area INT, capacidad INT, es_móvil BOOLEAN)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Mesa (ID_Area, Capacidad, EsMóvil) VALUES (id_area, capacidad, es_móvil);
END;
$$;

-- Leer Mesas
CREATE OR REPLACE PROCEDURE sp_leer_mesas()
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM Mesa;
END;
$$;

-- Leer una mesa especifica
CREATE OR REPLACE PROCEDURE sp_leer_mesa_especifica(id_mesa INT)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM Mesa WHERE ID_Mesa = id_mesa;
END;
$$;

-- Actualizar mesa
CREATE OR REPLACE PROCEDURE sp_actualizar_mesa(id_mesa INT, id_area INT, capacidad INT, es_móvil BOOLEAN)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Mesa
    SET ID_Area = id_area, Capacidad = capacidad, EsMóvil = es_móvil
    WHERE ID_Mesa = id_mesa;
END;
$$;

-- Eliminar mesa
CREATE OR REPLACE PROCEDURE sp_eliminar_mesa(id_mesa INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Mesa WHERE ID_Mesa = id_mesa;
END;
$$;

-- CRUD Cuenta
-- Crear Cuenta
CREATE OR REPLACE PROCEDURE sp_insertar_cuenta(id_mesa INT, fecha_hora_apertura TIMESTAMP, fecha_hora_cierre TIMESTAMP, estado VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Cuenta (ID_Mesa, FechaHoraApertura, FechaHoraCierre, Estado) VALUES (id_mesa, fecha_hora_apertura, fecha_hora_cierre, estado);
END;
$$;

-- Leer todas las Cuentas
CREATE OR REPLACE PROCEDURE sp_leer_cuentas()
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM Cuenta;
END;
$$;

-- Leer Cuenta especifica
CREATE OR REPLACE PROCEDURE sp_leer_cuenta_especifica(id_cuenta INT)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM Cuenta WHERE ID_Cuenta = id_cuenta;
END;
$$;

-- Actualizar Cuenta
CREATE OR REPLACE PROCEDURE sp_actualizar_cuenta(id_cuenta INT, id_mesa INT, fecha_hora_apertura TIMESTAMP, fecha_hora_cierre TIMESTAMP, estado VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Cuenta
    SET ID_Mesa = id_mesa, FechaHoraApertura = fecha_hora_apertura, FechaHoraCierre = fecha_hora_cierre, Estado = estado
    WHERE ID_Cuenta = id_cuenta;
END;
$$;

-- Eliminar Cuenta
CREATE OR REPLACE PROCEDURE sp_eliminar_cuenta(id_cuenta INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Cuenta WHERE ID_Cuenta = id_cuenta;
END;
$$;

-- CRUD Pedido
-- Crear Pedido
CREATE OR REPLACE PROCEDURE sp_insertar_pedido(id_cuenta INT, fecha_hora TIMESTAMP)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Pedido (ID_Cuenta, FechaHora) VALUES (id_cuenta, fecha_hora);
END;
$$;

-- Leer Pedidos
CREATE OR REPLACE PROCEDURE sp_leer_pedidos()
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM Pedido;
END;
$$;

-- Leer un pedido especifico
CREATE OR REPLACE PROCEDURE sp_leer_pedido_especifico(id_pedido INT)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM Pedido WHERE ID_Pedido = id_pedido;
END;
$$;

-- Actualizar Pedido
CREATE OR REPLACE PROCEDURE sp_actualizar_pedido(id_pedido INT, id_cuenta INT, fecha_hora TIMESTAMP)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Pedido
    SET ID_Cuenta = id_cuenta, FechaHora = fecha_hora
    WHERE ID_Pedido = id_pedido;
END;
$$;

-- Eliminar Pedido
CREATE OR REPLACE PROCEDURE sp_eliminar_pedido(id_pedido INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Pedido WHERE ID_Pedido = id_pedido;
END;
$$;

-- CRUD Item Menu
-- Crear Item
CREATE OR REPLACE PROCEDURE sp_insertar_item_menu(nombre VARCHAR, descripcion TEXT, precio NUMERIC)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Item_Menu (Nombre, Descripcion, Precio) VALUES (nombre, descripcion, precio);
END;
$$;

-- Leer Items
CREATE OR REPLACE PROCEDURE sp_leer_items_menu()
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM Item_Menu;
END;
$$;

-- Leer Item especifico
CREATE OR REPLACE PROCEDURE sp_leer_item_menu_especifico(id_item INT)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM Item_Menu WHERE ID_Item = id_item;
END;
$$;

-- Actualizar Item
CREATE OR REPLACE PROCEDURE sp_actualizar_item_menu(id_item INT, nombre VARCHAR, descripcion TEXT, precio NUMERIC)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Item_Menu
    SET Nombre = nombre, Descripcion = descripcion, Precio = precio
    WHERE ID_Item = id_item;
END;
$$;

-- Eliminar Item
CREATE OR REPLACE PROCEDURE sp_eliminar_item_menu(id_item INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Item_Menu WHERE ID_Item = id_item;
END;
$$;

-- CRUD Detalle Pedido
-- Crear Detalle Pedido
CREATE OR REPLACE PROCEDURE sp_insertar_detalle_pedido(id_pedido INT, id_item INT, cantidad INT)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Detalle_Pedido (ID_Pedido, ID_Item, Cantidad) VALUES (id_pedido, id_item, cantidad);
END;
$$;

-- Leer Detalles
CREATE OR REPLACE PROCEDURE sp_leer_detalles_pedido()
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM Detalle_Pedido;
END;
$$;

-- Leer Detalle especifico
CREATE OR REPLACE PROCEDURE sp_leer_detalle_pedido_especifico(id_pedido INT, id_item INT)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM Detalle_Pedido WHERE ID_Pedido = id_pedido AND ID_Item = id_item;
END;
$$;

-- Actualizar Detalle
CREATE OR REPLACE PROCEDURE sp_actualizar_detalle_pedido(id_pedido INT, id_item INT, cantidad INT)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Detalle_Pedido
    SET Cantidad = cantidad
    WHERE ID_Pedido = id_pedido AND ID_Item = id_item;
END;
$$;

-- Eliminar Detalle
CREATE OR REPLACE PROCEDURE sp_eliminar_detalle_pedido(id_pedido INT, id_item INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Detalle_Pedido WHERE ID_Pedido = id_pedido AND ID_Item = id_item;
END;
$$;

-- CRUD Cliente
-- Crear Cliente
CREATE OR REPLACE PROCEDURE sp_insertar_cliente(nit VARCHAR, nombre VARCHAR, direccion TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Cliente (NIT, Nombre, Direccion) VALUES (nit, nombre, direccion);
END;
$$;

-- Leer Clientes
CREATE OR REPLACE PROCEDURE sp_leer_clientes()
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM Cliente;
END;
$$;

-- Leer Cliente especifico
CREATE OR REPLACE PROCEDURE sp_leer_cliente_especifico(nit_cliente VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM Cliente WHERE NIT = nit_cliente;
END;
$$;

-- Actualizar Cliente
CREATE OR REPLACE PROCEDURE sp_actualizar_cliente(nit_cliente VARCHAR, nombre VARCHAR, direccion TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Cliente
    SET Nombre = nombre, Direccion = direccion
    WHERE NIT = nit_cliente;
END;
$$;

-- Eliminar Cliente
CREATE OR REPLACE PROCEDURE sp_eliminar_cliente(nit_cliente VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Cliente WHERE NIT = nit_cliente;
END;
$$;

-- CRUD Pago
-- Crear Pago
CREATE OR REPLACE PROCEDURE sp_insertar_pago(id_cuenta INT, monto NUMERIC, forma_pago VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Pago (ID_Cuenta, Monto, FormaPago) VALUES (id_cuenta, monto, forma_pago);
END;
$$;

-- Leer Pagos
CREATE OR REPLACE PROCEDURE sp_leer_pagos()
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM Pago;
END;
$$;

-- Leer pago especifico
CREATE OR REPLACE PROCEDURE sp_leer_pago_especifico(id_pago INT)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM Pago WHERE ID_Pago = id_pago;
END;
$$;

-- Actualizar pago
CREATE OR REPLACE PROCEDURE sp_actualizar_pago(id_pago INT, monto NUMERIC, forma_pago VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Pago
    SET Monto = monto, FormaPago = forma_pago
    WHERE ID_Pago = id_pago;
END;
$$;

-- Eliminar Pago
CREATE OR REPLACE PROCEDURE sp_eliminar_pago(id_pago INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Pago WHERE ID_Pago = id_pago;
END;
$$;

-- CRUD Mesero
-- Crear Mesero
CREATE OR REPLACE PROCEDURE sp_insertar_mesero(nombre VARCHAR, id_area INT)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Mesero (Nombre, ID_Area) VALUES (nombre, id_area);
END;
$$;

-- Leer Meseros
CREATE OR REPLACE PROCEDURE sp_leer_meseros()
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM Mesero;
END;
$$;

-- Leer mesero especifico
CREATE OR REPLACE PROCEDURE sp_leer_mesero_especifico(id_mesero INT)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM Mesero WHERE ID_Mesero = id_mesero;
END;
$$;

-- Actualizar Mesero
CREATE OR REPLACE PROCEDURE sp_actualizar_mesero(id_mesero INT, nombre VARCHAR, id_area INT)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Mesero
    SET Nombre = nombre, ID_Area = id_area
    WHERE ID_Mesero = id_mesero;
END;
$$;

-- Eliminar Mesero
CREATE OR REPLACE PROCEDURE sp_eliminar_mesero(id_mesero INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Mesero WHERE ID_Mesero = id_mesero;
END;
$$;

-- CRUD Encuesta
-- Crear Encuesta
CREATE OR REPLACE PROCEDURE sp_insertar_encuesta(id_cuenta INT, amabilidad INT, exactitud INT)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Encuesta (ID_Cuenta, Amabilidad, Exactitud) VALUES (id_cuenta, amabilidad, exactitud);
END;
$$;

-- Leer Encuestas
CREATE OR REPLACE PROCEDURE sp_leer_encuestas()
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM Encuesta;
END;
$$;

-- Leer Encuesta especifica
CREATE OR REPLACE PROCEDURE sp_leer_encuesta_especifica(id_encuesta INT)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM Encuesta WHERE ID_Encuesta = id_encuesta;
END;
$$;

-- Actualizar Encuesta
CREATE OR REPLACE PROCEDURE sp_actualizar_encuesta(id_encuesta INT, amabilidad INT, exactitud INT)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Encuesta
    SET Amabilidad = amabilidad, Exactitud = exactitud
    WHERE ID_Encuesta = id_encuesta;
END;
$$;

-- Eliminar Encuesta
CREATE OR REPLACE PROCEDURE sp_eliminar_encuesta(id_encuesta INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Encuesta WHERE ID_Encuesta = id_encuesta;
END;
$$;

-- CRUD Queja
-- Crear Queja
CREATE OR REPLACE PROCEDURE sp_insertar_queja(id_cliente VARCHAR, fecha_hora TIMESTAMP, motivo TEXT, severidad INT, id_mesero INT = NULL, id_item INT = NULL)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Queja (ID_Cliente, FechaHora, Motivo, Severidad, ID_Mesero, ID_Item)
    VALUES (id_cliente, fecha_hora, motivo, severidad, id_mesero, id_item);
END;
$$;

-- Leer Quejas
CREATE OR REPLACE PROCEDURE sp_leer_quejas()
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM Queja;
END;
$$;

-- Leer Queja especifica
CREATE OR REPLACE PROCEDURE sp_leer_queja_especifica(id_queja INT)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM Queja WHERE ID_Queja = id_queja;
END;
$$;

-- Actualizar Queja
CREATE OR REPLACE PROCEDURE sp_actualizar_queja(id_queja INT, motivo TEXT, severidad INT, id_mesero INT = NULL, id_item INT = NULL)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Queja
    SET Motivo = motivo, Severidad = severidad, ID_Mesero = id_mesero, ID_Item = id_item
    WHERE ID_Queja = id_queja;
END;
$$;

-- Eliminar Queja
CREATE OR REPLACE PROCEDURE sp_eliminar_queja(id_queja INT)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Queja WHERE ID_Queja = id_queja;
END;
$$;



