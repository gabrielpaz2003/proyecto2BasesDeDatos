-- TABLA USUARIO
-- fn_insertar_usuario: Función para insertar un nuevo usuario.
CREATE OR REPLACE FUNCTION fn_insertar_usuario(nombre_usuario VARCHAR, hash_contrasena TEXT, rol_usuario VARCHAR)
RETURNS SETOF Usuario
AS $$
DECLARE
    inserted_user Usuario%ROWTYPE;
BEGIN
    INSERT INTO Usuario (NombreUsuario, HashContraseña, Rol)
    VALUES (nombre_usuario, hash_contrasena, rol_usuario)
    RETURNING * INTO inserted_user;

    RETURN NEXT inserted_user;
END;
$$
LANGUAGE plpgsql;

-- fn_leer_usuarios: Función para obtener todos los usuarios.
CREATE OR REPLACE FUNCTION fn_leer_usuarios()
RETURNS SETOF usuario
AS $$
BEGIN
    RETURN QUERY SELECT * FROM Usuario;
END;
$$ LANGUAGE plpgsql;

-- fn_leer_usuario_especifico: Función para obtener un usuario específico por ID.
CREATE OR REPLACE FUNCTION fn_leer_usuario_especifico(nombre_usuario VARCHAR)
RETURNS SETOF usuario as $$
BEGIN
    RETURN QUERY SELECT * FROM Usuario u WHERE u.nombreusuario = nombre_usuario;
END;
$$ LANGUAGE plpgsql;

-- fn_actualizar_usuario: Función para actualizar un usuario existente.
CREATE OR REPLACE FUNCTION fn_actualizar_usuario(nombre_usuario VARCHAR, hash_contrasena TEXT, rol_usuario VARCHAR)
RETURNS SETOF Usuario
AS $$
DECLARE
    updated_user Usuario%ROWTYPE;
BEGIN
    UPDATE Usuario
    SET HashContraseña = hash_contrasena, Rol = rol_usuario
    WHERE NombreUsuario = nombre_usuario
    RETURNING * INTO updated_user;

    RETURN NEXT updated_user;
END;
$$ LANGUAGE plpgsql;

-- fn_eliminar_usuario: Función para eliminar un usuario.
CREATE OR REPLACE FUNCTION fn_eliminar_usuario(nombre_usuario VARCHAR)
RETURNS SETOF Usuario
AS $$
DECLARE
    deleted_user Usuario%ROWTYPE;
BEGIN
    DELETE FROM Usuario WHERE NombreUsuario = nombre_usuario
    RETURNING * INTO deleted_user;

    RETURN NEXT deleted_user;
END;
$$ LANGUAGE plpgsql;



-- CRUD QUEJA
-- fn_insertar_queja: Función para insertar una nueva queja y retornar la queja insertada
CREATE OR REPLACE FUNCTION fn_insertar_queja(cliente_id_queja VARCHAR, fecha_hora_queja TIMESTAMP, motivo_queja TEXT, severidad_queja INTEGER, mesero_id_queja INTEGER, item_id_queja INTEGER)
RETURNS SETOF Queja AS $$
DECLARE
    v_record Queja;
BEGIN
    INSERT INTO Queja (ID_Cliente, FechaHora, Motivo, Severidad, ID_Mesero, ID_Item)
    VALUES (cliente_id_queja, fecha_hora_queja, motivo_queja, severidad_queja, mesero_id_queja, item_id_queja)
    RETURNING * INTO v_record;
    RETURN NEXT v_record;
END;
$$ LANGUAGE plpgsql;


-- fn_leer_quejas: Función para obtener todas las quejas
CREATE OR REPLACE FUNCTION fn_leer_quejas()
RETURNS SETOF Queja AS $$
BEGIN
    RETURN QUERY SELECT * FROM Queja;
END;
$$ LANGUAGE plpgsql;


-- fn_leer_queja_especifica: Función para obtener una queja específica por ID de queja
CREATE OR REPLACE FUNCTION fn_leer_queja_especifica(queja_id INTEGER)
RETURNS SETOF Queja AS $$
BEGIN
    RETURN QUERY SELECT * FROM Queja WHERE ID_Queja = queja_id;
END;
$$ LANGUAGE plpgsql;

-- fn_actualizar_queja: Función para actualizar una queja existente y retornar la queja actualizada
CREATE OR REPLACE FUNCTION fn_actualizar_queja(queja_id INTEGER, cliente_id_queja VARCHAR, fecha_hora_queja TIMESTAMP, motivo_queja TEXT, severidad_queja INTEGER, mesero_id_queja INTEGER, item_id_queja INTEGER)
RETURNS SETOF Queja AS $$
DECLARE
    v_record Queja;
BEGIN
    UPDATE Queja
    SET ID_Cliente = cliente_id_queja, FechaHora = fecha_hora_queja, Motivo = motivo_queja, Severidad = severidad_queja, ID_Mesero = mesero_id_queja, ID_Item = item_id_queja
    WHERE ID_Queja = queja_id
    RETURNING * INTO v_record;
    RETURN NEXT v_record;
END;
$$ LANGUAGE plpgsql;


-- fn_eliminar_queja: Función para eliminar una queja y retornar los detalles de la queja eliminada
CREATE OR REPLACE FUNCTION fn_eliminar_queja(queja_id INTEGER)
RETURNS SETOF Queja AS $$
DECLARE
    v_record Queja;
BEGIN
    DELETE FROM Queja WHERE ID_Queja = queja_id
    RETURNING * INTO v_record;
    RETURN NEXT v_record;
END;
$$ LANGUAGE plpgsql;



-- fn_insertar_pedido: Función para insertar un nuevo pedido.
CREATE OR REPLACE FUNCTION fn_insertar_pedido(cuenta_id INTEGER, fecha_hora TIMESTAMP, _estado VARCHAR)
RETURNS SETOF pedido AS $$
DECLARE
    pedido_insertado pedido%ROWTYPE;
BEGIN
    INSERT INTO Pedido (ID_Cuenta, FechaHora, Estado)
    VALUES (cuenta_id, fecha_hora, _estado)
    RETURNING * INTO pedido_insertado;

    RETURN NEXT pedido_insertado;
END;
$$ LANGUAGE plpgsql;

-- fn_leer_pedidos: Función para obtener todos los pedidos.
CREATE OR REPLACE FUNCTION fn_leer_pedidos()
RETURNS SETOF pedido AS $$
BEGIN
    RETURN QUERY SELECT * FROM Pedido;
END;
$$ LANGUAGE plpgsql;

-- fn_leer_pedido_especifico: Función para obtener un pedido específico por ID.
CREATE OR REPLACE FUNCTION fn_leer_pedido_especifico(pedido_id INTEGER)
RETURNS SETOF pedido AS $$
BEGIN
    RETURN QUERY SELECT * FROM Pedido WHERE ID_Pedido = pedido_id;
END;
$$ LANGUAGE plpgsql;

-- fn_actualizar_pedido: Función para actualizar un pedido existente.
CREATE OR REPLACE FUNCTION fn_actualizar_pedido(pedido_id INTEGER, cuenta_id INTEGER, fecha_hora TIMESTAMP, _estado VARCHAR)
RETURNS SETOF pedido AS $$
DECLARE
    pedido_actualizado pedido%ROWTYPE;
BEGIN
    UPDATE Pedido
    SET ID_Cuenta = cuenta_id, FechaHora = fecha_hora, Estado = _estado
    WHERE ID_Pedido = pedido_id
    RETURNING * INTO pedido_actualizado;

    RETURN NEXT pedido_actualizado;
END;
$$ LANGUAGE plpgsql;

--fn_eliminar_pedido: Función para eliminar un pedido.
CREATE OR REPLACE FUNCTION fn_eliminar_pedido(pedido_id INTEGER)
RETURNS SETOF pedido
AS $$
DECLARE
    pedido_eliminado pedido%ROWTYPE;
BEGIN
    DELETE FROM Pedido WHERE ID_Pedido = pedido_id
    RETURNING * INTO pedido_eliminado;

    RETURN NEXT pedido_eliminado;
END;
$$ LANGUAGE plpgsql;



-- CRUD PAGO
-- fn_insertar_pago: Función para insertar un nuevo pago y retornar el pago insertado
CREATE OR REPLACE FUNCTION fn_insertar_pago(cuenta_id_pago INTEGER, monto_pago NUMERIC, forma_pago_pago VARCHAR)
RETURNS SETOF Pago AS $$
DECLARE
    v_record Pago;
BEGIN
    INSERT INTO Pago (ID_Cuenta, Monto, FormaPago)
    VALUES (cuenta_id_pago, monto_pago, forma_pago_pago)
    RETURNING * INTO v_record;
    RETURN NEXT v_record;
END;
$$ LANGUAGE plpgsql;


-- fn_leer_pagos: Función para obtener todos los pagos
CREATE OR REPLACE FUNCTION fn_leer_pagos()
RETURNS SETOF Pago AS $$
BEGIN
    RETURN QUERY SELECT * FROM Pago;
END;
$$ LANGUAGE plpgsql;


-- fn_leer_pago_especifico: Función para obtener un pago específico por ID
CREATE OR REPLACE FUNCTION fn_leer_pago_especifico(pago_id INTEGER)
RETURNS SETOF Pago AS $$
BEGIN
    RETURN QUERY SELECT * FROM Pago WHERE ID_Pago = pago_id;
END;
$$ LANGUAGE plpgsql;


-- fn_actualizar_pago: Función para actualizar un pago existente y retornar el pago actualizado
CREATE OR REPLACE FUNCTION fn_actualizar_pago(pago_id INTEGER, cuenta_id_pago INTEGER, monto_pago NUMERIC, forma_pago_pago VARCHAR)
RETURNS SETOF Pago AS $$
DECLARE
    v_record Pago;
BEGIN
    UPDATE Pago
    SET ID_Cuenta = cuenta_id_pago, Monto = monto_pago, FormaPago = forma_pago_pago
    WHERE ID_Pago = pago_id
    RETURNING * INTO v_record;
    RETURN NEXT v_record;
END;
$$ LANGUAGE plpgsql;


-- fn_eliminar_pago: Función para eliminar un pago y retornar los detalles del pago eliminado
CREATE OR REPLACE FUNCTION fn_eliminar_pago(pago_id INTEGER)
RETURNS SETOF Pago AS $$
DECLARE
    v_record Pago;
BEGIN
    DELETE FROM Pago WHERE ID_Pago = pago_id
    RETURNING * INTO v_record;
    RETURN NEXT v_record;
END;
$$ LANGUAGE plpgsql;

-- CRUD PAGO
-- fn_insertar_mesero: Función para insertar un nuevo mesero y retornar el mesero insertado
CREATE OR REPLACE FUNCTION fn_insertar_mesero(nombre_mesero VARCHAR, area_id_mesero INTEGER)
RETURNS SETOF Mesero AS $$
DECLARE
    v_record Mesero;
BEGIN
    INSERT INTO Mesero (Nombre, ID_Area)
    VALUES (nombre_mesero, area_id_mesero)
    RETURNING * INTO v_record;
    RETURN NEXT v_record;
END;
$$ LANGUAGE plpgsql;


-- fn_leer_meseros: Función para obtener todos los meseros
CREATE OR REPLACE FUNCTION fn_leer_meseros()
RETURNS SETOF Mesero AS $$
BEGIN
    RETURN QUERY SELECT * FROM Mesero;
END;
$$ LANGUAGE plpgsql;


-- fn_leer_mesero_especifico: Función para obtener un mesero específico por ID
CREATE OR REPLACE FUNCTION fn_leer_mesero_especifico(mesero_id INTEGER)
RETURNS SETOF Mesero AS $$
BEGIN
    RETURN QUERY SELECT * FROM Mesero WHERE ID_Mesero = mesero_id;
END;
$$ LANGUAGE plpgsql;


-- fn_actualizar_mesero: Función para actualizar un mesero existente y retornar el mesero actualizado
CREATE OR REPLACE FUNCTION fn_actualizar_mesero(mesero_id INTEGER, nombre_mesero VARCHAR, area_id_mesero INTEGER)
RETURNS SETOF Mesero AS $$
DECLARE
    v_record Mesero;
BEGIN
    UPDATE Mesero
    SET Nombre = nombre_mesero, ID_Area = area_id_mesero
    WHERE ID_Mesero = mesero_id
    RETURNING * INTO v_record;
    RETURN NEXT v_record;
END;
$$ LANGUAGE plpgsql;


-- fn_eliminar_mesero: Función para eliminar un mesero y retornar los detalles del mesero eliminado
CREATE OR REPLACE FUNCTION fn_eliminar_mesero(mesero_id INTEGER)
RETURNS SETOF Mesero AS $$
DECLARE
    v_record Mesero;
BEGIN
    DELETE FROM Mesero WHERE ID_Mesero = mesero_id
    RETURNING * INTO v_record;
    RETURN NEXT v_record;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION fn_insertar_mesa(idarea INT, capacidadN INT, es_movil BOOLEAN, disponibleN BOOLEAN)
RETURNS SETOF mesa
AS $$
DECLARE
    new_mesa mesa%ROWTYPE;
BEGIN
    INSERT INTO Mesa (ID_Area, Capacidad, EsMóvil, Disponible)
    VALUES (idarea, capacidadN, es_movil, disponibleN)
    RETURNING * INTO new_mesa;

    RETURN NEXT new_mesa;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_leer_mesas()
RETURNS SETOF mesa
AS $$
BEGIN
    RETURN QUERY SELECT * FROM Mesa;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION fn_leer_mesa_especifica(idmesa INT)
RETURNS SETOF mesa
AS $$
BEGIN
    RETURN QUERY SELECT * FROM Mesa WHERE ID_Mesa = idmesa;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION fn_actualizar_mesa(_idmesa INT, _idarea INT, _capacidad INT, _esmovil BOOLEAN, _disponible BOOLEAN)
RETURNS SETOF mesa
AS $$
DECLARE
    updated_mesa mesa%ROWTYPE;
BEGIN
    UPDATE Mesa
    SET ID_Area = _idarea, Capacidad = _capacidad, EsMóvil = _esmovil, Disponible = _disponible
    WHERE ID_Mesa = _idmesa
    RETURNING * INTO updated_mesa;

    RETURN NEXT updated_mesa;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION fn_eliminar_mesa(_idmesa INT)
RETURNS SETOF mesa
AS $$
DECLARE
    deleted_mesa mesa%ROWTYPE;
BEGIN
    DELETE FROM Mesa WHERE ID_Mesa = _idmesa
    RETURNING * INTO deleted_mesa;

    RETURN NEXT deleted_mesa;
END;
$$ LANGUAGE plpgsql;

-- CRUD ITEM MENU
-- fn_insertar_item_menu: Función para insertar un nuevo ítem en el menú y retornar el ítem insertado.
CREATE OR REPLACE FUNCTION fn_insertar_item_menu(nombre_item VARCHAR, descripcion_item TEXT, precio_item NUMERIC, tipo_item VARCHAR)
RETURNS SETOF Item_Menu AS $$
DECLARE
    v_record Item_Menu;
BEGIN
    INSERT INTO Item_Menu (Nombre, Descripcion, Precio, Tipo)
    VALUES (nombre_item, descripcion_item, precio_item, tipo_item)
    RETURNING * INTO v_record;
    RETURN NEXT v_record;
END;
$$ LANGUAGE plpgsql;


-- fn_leer_items_menu: Función para obtener todos los ítems del menú.
CREATE OR REPLACE FUNCTION fn_leer_items_menu()
RETURNS SETOF Item_Menu AS $$
BEGIN
    RETURN QUERY SELECT * FROM Item_Menu;
END;
$$ LANGUAGE plpgsql;



-- fn_leer_item_menu_especifico: Función para obtener un ítem específico del menú por ID.
CREATE OR REPLACE FUNCTION fn_leer_item_menu_especifico(item_id INTEGER)
RETURNS SETOF Item_Menu AS $$
BEGIN
    RETURN QUERY SELECT * FROM Item_Menu WHERE ID_Item = item_id;
END;
$$ LANGUAGE plpgsql;


-- fn_actualizar_item_menu: Función para actualizar un ítem del menú y retornar el ítem actualizado.
CREATE OR REPLACE FUNCTION fn_actualizar_item_menu(item_id INTEGER, nombre_item VARCHAR, descripcion_item TEXT, precio_item NUMERIC, tipo_item VARCHAR)
RETURNS SETOF Item_Menu AS $$
DECLARE
    v_record Item_Menu;
BEGIN
    UPDATE Item_Menu
    SET Nombre = nombre_item, Descripcion = descripcion_item, Precio = precio_item, Tipo = tipo_item
    WHERE ID_Item = item_id
    RETURNING * INTO v_record;
    RETURN NEXT v_record;
END;
$$ LANGUAGE plpgsql;


-- fn_eliminar_item_menu: Función para eliminar un ítem del menú y retornar los detalles del ítem eliminado.
CREATE OR REPLACE FUNCTION fn_eliminar_item_menu(item_id INTEGER)
RETURNS SETOF Item_Menu AS $$
DECLARE
    v_record Item_Menu;
BEGIN
    DELETE FROM Item_Menu WHERE ID_Item = item_id
    RETURNING * INTO v_record;
    RETURN NEXT v_record;
END;
$$ LANGUAGE plpgsql;

-- CRUD ENCUESTA
-- fn_insertar_encuesta: Función para insertar una nueva encuesta y retornar la encuesta insertada
CREATE OR REPLACE FUNCTION fn_insertar_encuesta(cuenta_id_encuesta INTEGER, amabilidad_encuesta INTEGER, exactitud_encuesta INTEGER)
RETURNS SETOF Encuesta AS $$
DECLARE
    v_record Encuesta;
BEGIN
    INSERT INTO Encuesta (ID_Cuenta, Amabilidad, Exactitud)
    VALUES (cuenta_id_encuesta, amabilidad_encuesta, exactitud_encuesta)
    RETURNING * INTO v_record;
    RETURN NEXT v_record;
END;
$$ LANGUAGE plpgsql;


-- fn_leer_encuestas: Función para obtener todas las encuestas
CREATE OR REPLACE FUNCTION fn_leer_encuestas()
RETURNS SETOF Encuesta AS $$
BEGIN
    RETURN QUERY SELECT * FROM Encuesta;
END;
$$ LANGUAGE plpgsql;

-- fn_leer_encuesta_especifica: Función para obtener una encuesta específica por ID de encuesta
CREATE OR REPLACE FUNCTION fn_leer_encuesta_especifica(encuesta_id INTEGER)
RETURNS SETOF Encuesta AS $$
BEGIN
    RETURN QUERY SELECT * FROM Encuesta WHERE ID_Encuesta = encuesta_id;
END;
$$ LANGUAGE plpgsql;

-- fn_actualizar_encuesta: Función para actualizar una encuesta existente y retornar la encuesta actualizada
CREATE OR REPLACE FUNCTION fn_actualizar_encuesta(encuesta_id INTEGER, cuenta_id_encuesta INTEGER, amabilidad_encuesta INTEGER, exactitud_encuesta INTEGER)
RETURNS SETOF Encuesta AS $$
DECLARE
    v_record Encuesta;
BEGIN
    UPDATE Encuesta
    SET ID_Cuenta = cuenta_id_encuesta, Amabilidad = amabilidad_encuesta, Exactitud = exactitud_encuesta
    WHERE ID_Encuesta = encuesta_id
    RETURNING * INTO v_record;
    RETURN NEXT v_record;
END;
$$ LANGUAGE plpgsql;


-- fn_eliminar_encuesta: Función para eliminar una encuesta y retornar los detalles de la encuesta eliminada
CREATE OR REPLACE FUNCTION fn_eliminar_encuesta(encuesta_id INTEGER)
RETURNS SETOF Encuesta AS $$
DECLARE
    v_record Encuesta;
BEGIN
    DELETE FROM Encuesta WHERE ID_Encuesta = encuesta_id
    RETURNING * INTO v_record;
    RETURN NEXT v_record;
END;
$$ LANGUAGE plpgsql;


-- CRUD DETALLE PEDIDO
-- fn_insertar_detalle_pedido: Función para insertar un nuevo detalle de pedido y retornar el detalle insertado.
CREATE OR REPLACE FUNCTION fn_insertar_detalle_pedido(pedido_id INTEGER, item_id INTEGER, cantidad INTEGER)
RETURNS SETOF Detalle_Pedido AS $$
DECLARE
    v_record Detalle_Pedido;
BEGIN
    INSERT INTO Detalle_Pedido (ID_Pedido, ID_Item, Cantidad)
    VALUES (pedido_id, item_id, cantidad)
    RETURNING * INTO v_record;
    RETURN NEXT v_record;
END;
$$ LANGUAGE plpgsql;


-- fn_leer_detalles_pedido: Función para obtener todos los detalles de pedidos.
CREATE OR REPLACE FUNCTION fn_leer_detalles_pedido()
RETURNS SETOF Detalle_Pedido AS $$
BEGIN
    RETURN QUERY SELECT * FROM Detalle_Pedido;
END;
$$ LANGUAGE plpgsql;


-- fn_leer_detalle_pedido_especifico: Función para obtener un detalle específico de pedido por ID de pedido y ID de ítem.
CREATE OR REPLACE FUNCTION fn_leer_detalle_pedido_especifico(pedido_id INTEGER, item_id INTEGER)
RETURNS SETOF Detalle_Pedido AS $$
BEGIN
    RETURN QUERY SELECT * FROM Detalle_Pedido WHERE ID_Pedido = pedido_id AND ID_Item = item_id;
END;
$$ LANGUAGE plpgsql;

-- fn_actualizar_detalle_pedido: Función para actualizar un detalle de pedido y retornar el detalle actualizado.
CREATE OR REPLACE FUNCTION fn_actualizar_detalle_pedido(pedido_id INTEGER, item_id INTEGER, _cantidad INTEGER)
RETURNS SETOF Detalle_Pedido AS $$
DECLARE
    v_record Detalle_Pedido;
BEGIN
    UPDATE Detalle_Pedido
    SET Cantidad = _cantidad
    WHERE ID_Pedido = pedido_id AND ID_Item = item_id
    RETURNING * INTO v_record;
    RETURN NEXT v_record;
END;
$$ LANGUAGE plpgsql;


-- fn_eliminar_detalle_pedido: Función para eliminar un detalle de pedido y retornar los detalles del detalle eliminado.
CREATE OR REPLACE FUNCTION fn_eliminar_detalle_pedido(pedido_id INTEGER, item_id INTEGER)
RETURNS SETOF Detalle_Pedido AS $$
DECLARE
    v_record Detalle_Pedido;
BEGIN
    DELETE FROM Detalle_Pedido WHERE ID_Pedido = pedido_id AND ID_Item = item_id
    RETURNING * INTO v_record;
    RETURN NEXT v_record;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION fn_insertar_cuenta(idmesa INT, estadoA varchar, _fecha_hora_apertura TIMESTAMP)
RETURNS SETOF cuenta
AS $$
DECLARE
    new_cuenta cuenta%ROWTYPE;
BEGIN
    INSERT INTO Cuenta (ID_Mesa, estado, fechahoraapertura) VALUES (idmesa, estadoA, _fecha_hora_apertura)
    RETURNING * INTO new_cuenta;

    RETURN NEXT new_cuenta;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION fn_leer_cuentas()
RETURNS SETOF cuenta
AS $$
BEGIN
    RETURN QUERY SELECT * FROM Cuenta;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION fn_leer_cuenta_especifica(idcuenta INT)
RETURNS SETOF cuenta
AS $$
BEGIN
    RETURN QUERY SELECT * FROM Cuenta WHERE ID_Cuenta = idcuenta;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION fn_actualizar_cuenta(idcuenta INT, idmesa INT, fecha_hora_apertura TIMESTAMP, fecha_hora_cierre TIMESTAMP, estadoA VARCHAR)
RETURNS SETOF cuenta
AS $$
DECLARE
    updated_cuenta cuenta%ROWTYPE;
BEGIN
    UPDATE Cuenta
    SET ID_Mesa = idmesa, FechaHoraApertura = fecha_hora_apertura, FechaHoraCierre = fecha_hora_cierre, Estado = estadoA
    WHERE ID_Cuenta = idcuenta
    RETURNING * INTO updated_cuenta;

    RETURN NEXT updated_cuenta;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION fn_eliminar_cuenta(idcuenta INT)
RETURNS SETOF cuenta
AS $$
DECLARE
    deleted_cuenta cuenta%ROWTYPE;
BEGIN
    DELETE FROM Cuenta WHERE ID_Cuenta = idcuenta
    RETURNING * INTO deleted_cuenta;

    RETURN NEXT deleted_cuenta;
END;
$$ LANGUAGE plpgsql;


-- CRUD CLIENTE
-- fn_insertar_cliente: Función para insertar un nuevo cliente y retornar el cliente insertado
CREATE OR REPLACE FUNCTION fn_insertar_cliente(nit_cliente VARCHAR, nombre_cliente VARCHAR, direccion_cliente TEXT)
RETURNS SETOF Cliente AS $$
DECLARE
    v_record Cliente;
BEGIN
    INSERT INTO Cliente (NIT, Nombre, Direccion)
    VALUES (nit_cliente, nombre_cliente, direccion_cliente)
    RETURNING * INTO v_record;
    RETURN NEXT v_record;
END;
$$ LANGUAGE plpgsql;

-- fn_leer_clientes: Función para obtener todos los clientes
CREATE OR REPLACE FUNCTION fn_leer_clientes()
RETURNS SETOF Cliente AS $$
BEGIN
    RETURN QUERY SELECT * FROM Cliente;
END;
$$ LANGUAGE plpgsql;

-- fn_leer_cliente_especifico: Función para obtener un cliente específico por NIT
CREATE OR REPLACE FUNCTION fn_leer_cliente_especifico(nit_cliente VARCHAR)
RETURNS SETOF Cliente AS $$
BEGIN
    RETURN QUERY SELECT * FROM Cliente WHERE NIT = nit_cliente;
END;
$$ LANGUAGE plpgsql;

-- fn_actualizar_cliente: Función para actualizar un cliente existente y retornar el cliente actualizado
CREATE OR REPLACE FUNCTION fn_actualizar_cliente(nit_cliente VARCHAR, nombre_cliente VARCHAR, direccion_cliente TEXT)
RETURNS SETOF Cliente AS $$
DECLARE
    v_record Cliente;
BEGIN
    UPDATE Cliente
    SET Nombre = nombre_cliente, Direccion = direccion_cliente
    WHERE NIT = nit_cliente
    RETURNING * INTO v_record;
    RETURN NEXT v_record;
END;
$$ LANGUAGE plpgsql;

-- fn_eliminar_cliente: Función para eliminar un cliente y retornar los detalles del cliente eliminado
CREATE OR REPLACE FUNCTION fn_eliminar_cliente(nit_cliente VARCHAR)
RETURNS SETOF Cliente AS $$
DECLARE
    v_record Cliente;
BEGIN
    DELETE FROM Cliente WHERE NIT = nit_cliente
    RETURNING * INTO v_record;
    RETURN NEXT v_record;
END;
$$ LANGUAGE plpgsql;



-- fn_insertar_area: Function to insert a new area.
CREATE OR REPLACE FUNCTION fn_insertar_area(nombre_area VARCHAR, es_para_fumadores BOOLEAN)
RETURNS SETOF Area
AS $$
DECLARE
    new_area Area%ROWTYPE;
BEGIN
    INSERT INTO Area (Nombre, EsParaFumadores)
    VALUES (nombre_area, es_para_fumadores)
    RETURNING * INTO new_area;

    RETURN NEXT new_area;
END;
$$ LANGUAGE plpgsql;

-- fn_leer_areas: Function to retrieve all areas.
CREATE OR REPLACE FUNCTION fn_leer_areas()
RETURNS SETOF area AS $$
BEGIN
    RETURN QUERY SELECT * FROM Area;
END;
$$ LANGUAGE plpgsql;


-- fn_leer_area_especifica: Function to retrieve a specific area by ID.
CREATE OR REPLACE FUNCTION fn_leer_area_especifica(idArea INT)
RETURNS SETOF area AS $$
BEGIN
    RETURN QUERY SELECT * FROM Area WHERE ID_Area = idarea;
END;
$$ LANGUAGE plpgsql;

-- fn_actualizar_area: Function to update an existing area.
CREATE OR REPLACE FUNCTION fn_actualizar_area(idarea INT, nombre_area VARCHAR, es_para_fumadores BOOLEAN)
RETURNS SETOF Area
AS $$
BEGIN
    RETURN QUERY UPDATE Area
    SET Nombre = nombre_area, EsParaFumadores = es_para_fumadores
    WHERE ID_Area = idarea
    RETURNING *;
END;
$$ LANGUAGE plpgsql;


-- fn_eliminar_area: Function to delete an area.
CREATE OR REPLACE FUNCTION fn_eliminar_area(idarea INT)
RETURNS SETOF Area AS $$
DECLARE
    deleted_area Area%ROWTYPE;
BEGIN
    DELETE FROM Area WHERE ID_Area = idarea
    RETURNING * INTO deleted_area;

    RETURN NEXT deleted_area;
END;
$$ LANGUAGE plpgsql;


