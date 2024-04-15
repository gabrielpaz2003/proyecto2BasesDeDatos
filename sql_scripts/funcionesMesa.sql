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