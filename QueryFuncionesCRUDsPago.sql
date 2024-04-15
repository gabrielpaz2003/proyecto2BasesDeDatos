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

