-- CRUD PAGO
-- fn_insertar_mesero: Función para insertar un nuevo mesero y retornar el mesero insertado
CREATE OR REPLACE FUNCTION fn_insertar_mesero(nombre_mesero VARCHAR, area_id_mesero INTEGER)
RETURNS SETOF Mesero AS $$
BEGIN
    RETURN QUERY INSERT INTO Mesero (Nombre, ID_Area)
    VALUES (nombre_mesero, area_id_mesero)
    RETURNING *;
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
BEGIN
    RETURN QUERY UPDATE Mesero
    SET Nombre = nombre_mesero, ID_Area = area_id_mesero
    WHERE ID_Mesero = mesero_id
    RETURNING *;
END;
$$ LANGUAGE plpgsql;

-- fn_eliminar_mesero: Función para eliminar un mesero y retornar los detalles del mesero eliminado
CREATE OR REPLACE FUNCTION fn_eliminar_mesero(mesero_id INTEGER)
RETURNS SETOF Mesero AS $$
BEGIN
    RETURN QUERY DELETE FROM Mesero WHERE ID_Mesero = mesero_id
    RETURNING *;
END;
$$ LANGUAGE plpgsql;
