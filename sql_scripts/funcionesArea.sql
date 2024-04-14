-- fn_insertar_area: Function to insert a new area.
CREATE OR REPLACE FUNCTION fn_insertar_area(nombre_area VARCHAR, es_para_fumadores BOOLEAN)
RETURNS TABLE(ID_Area INTEGER, Nombre VARCHAR, EsParaFumadores BOOLEAN) AS $$
BEGIN
    INSERT INTO Area (Nombre, EsParaFumadores) VALUES (nombre_area, es_para_fumadores)
    RETURNING ID_Area, Nombre, EsParaFumadores INTO ID_Area, Nombre, EsParaFumadores;
    RETURN NEXT;
END;
$$ LANGUAGE plpgsql;

-- fn_leer_areas: Function to retrieve all areas.
CREATE OR REPLACE FUNCTION fn_leer_areas()
RETURNS TABLE(ID_Area INTEGER, Nombre VARCHAR, EsParaFumadores BOOLEAN) AS $$
BEGIN
    RETURN QUERY SELECT ID_Area, Nombre, EsParaFumadores FROM Area;
END;
$$ LANGUAGE plpgsql;

-- fn_leer_area_especifica: Function to retrieve a specific area by ID.
CREATE OR REPLACE FUNCTION fn_leer_area_especifica(id_area INT)
RETURNS TABLE(ID_Area INTEGER, Nombre VARCHAR, EsParaFumadores BOOLEAN) AS $$
BEGIN
    RETURN QUERY SELECT ID_Area, Nombre, EsParaFumadores FROM Area WHERE ID_Area = id_area;
END;
$$ LANGUAGE plpgsql;

-- fn_actualizar_area: Function to update an existing area.
CREATE OR REPLACE FUNCTION fn_actualizar_area(id_area INT, nombre_area VARCHAR, es_para_fumadores BOOLEAN)
RETURNS TABLE(ID_Area INTEGER, Nombre VARCHAR, EsParaFumadores BOOLEAN) AS $$
BEGIN
    UPDATE Area
    SET Nombre = nombre_area, EsParaFumadores = es_para_fumadores
    WHERE ID_Area = id_area
    RETURNING ID_Area, Nombre, EsParaFumadores INTO ID_Area, Nombre, EsParaFumadores;
    RETURN NEXT;
END;
$$ LANGUAGE plpgsql;

-- fn_eliminar_area: Function to delete an area.
CREATE OR REPLACE FUNCTION fn_eliminar_area(id_area INT)
RETURNS TABLE(ID_Area INTEGER, Nombre VARCHAR, EsParaFumadores BOOLEAN) AS $$
BEGIN
    DELETE FROM Area WHERE ID_Area = id_area
    RETURNING ID_Area, Nombre, EsParaFumadores INTO ID_Area, Nombre, EsParaFumadores;
    RETURN NEXT;
END;
$$ LANGUAGE plpgsql;
