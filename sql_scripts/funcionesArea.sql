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
