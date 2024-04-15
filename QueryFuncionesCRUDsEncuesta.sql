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

