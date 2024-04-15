-- CRUD DETALLE PEDIDO
-- fn_insertar_detalle_pedido: Función para insertar un nuevo detalle de pedido y retornar el detalle insertado.
CREATE OR REPLACE FUNCTION fn_insertar_detalle_pedido(pedido_id INTEGER, item_id INTEGER, cantidad_detalle INTEGER, estado_detalle VARCHAR)
RETURNS SETOF Detalle_Pedido AS $$
BEGIN
    RETURN QUERY INSERT INTO Detalle_Pedido (ID_Pedido, ID_Item, Cantidad, Estado)
    VALUES (pedido_id, item_id, cantidad_detalle, estado_detalle)
    RETURNING *;
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
CREATE OR REPLACE FUNCTION fn_actualizar_detalle_pedido(pedido_id INTEGER, item_id INTEGER, cantidad_detalle INTEGER, estado_detalle VARCHAR)
RETURNS SETOF Detalle_Pedido AS $$
BEGIN
    RETURN QUERY UPDATE Detalle_Pedido
    SET Cantidad = cantidad_detalle, Estado = estado_detalle
    WHERE ID_Pedido = pedido_id AND ID_Item = item_id
    RETURNING *;
END;
$$ LANGUAGE plpgsql;

-- fn_eliminar_detalle_pedido: Función para eliminar un detalle de pedido y retornar los detalles del detalle eliminado.
CREATE OR REPLACE FUNCTION fn_eliminar_detalle_pedido(pedido_id INTEGER, item_id INTEGER)
RETURNS SETOF Detalle_Pedido AS $$
BEGIN
    RETURN QUERY DELETE FROM Detalle_Pedido WHERE ID_Pedido = pedido_id AND ID_Item = item_id
    RETURNING *;
END;
$$ LANGUAGE plpgsql;
