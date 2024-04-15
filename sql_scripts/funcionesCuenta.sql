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


