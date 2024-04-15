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

