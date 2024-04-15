-- fn_insertar_pedido: Función para insertar un nuevo pedido.
CREATE OR REPLACE FUNCTION fn_insertar_pedido(cuenta_id INTEGER, fecha_hora TIMESTAMP)
RETURNS SETOF pedido AS $$
DECLARE
    pedido_insertado pedido%ROWTYPE;
BEGIN
    INSERT INTO Pedido (ID_Cuenta, FechaHora)
    VALUES (cuenta_id, fecha_hora)
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
CREATE OR REPLACE FUNCTION fn_actualizar_pedido(pedido_id INTEGER, cuenta_id INTEGER, fecha_hora TIMESTAMP)
RETURNS SETOF pedido AS $$
DECLARE
    pedido_actualizado pedido%ROWTYPE;
BEGIN
    UPDATE Pedido
    SET ID_Cuenta = cuenta_id, FechaHora = fecha_hora
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

