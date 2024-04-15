-- CRUD CLIENTE
-- fn_insertar_cliente: Función para insertar un nuevo cliente y retornar el cliente insertado
CREATE OR REPLACE FUNCTION fn_insertar_cliente(nit_cliente VARCHAR, nombre_cliente VARCHAR, direccion_cliente TEXT)
RETURNS SETOF Cliente AS $$
BEGIN
    RETURN QUERY INSERT INTO Cliente (NIT, Nombre, Direccion)
    VALUES (nit_cliente, nombre_cliente, direccion_cliente)
    RETURNING *;
END;
$$ LANGUAGE plpgsql;

-- fn_leer_clientes: Función para obtener todos los clientes
CREATE OR REPLACE FUNCTION fn_leer_clientes()
RETURNS SETOF Cliente AS $$
BEGIN
    RETURN QUERY SELECT * FROM Cliente;
END;
$$ LANGUAGE plpgsql;

-- fn_leer_cliente_especifico: Función para obtener un cliente específico por NIT
CREATE OR REPLACE FUNCTION fn_leer_cliente_especifico(nit_cliente VARCHAR)
RETURNS SETOF Cliente AS $$
BEGIN
    RETURN QUERY SELECT * FROM Cliente WHERE NIT = nit_cliente;
END;
$$ LANGUAGE plpgsql;

-- fn_actualizar_cliente: Función para actualizar un cliente existente y retornar el cliente actualizado
CREATE OR REPLACE FUNCTION fn_actualizar_cliente(nit_cliente VARCHAR, nombre_cliente VARCHAR, direccion_cliente TEXT)
RETURNS SETOF Cliente AS $$
BEGIN
    RETURN QUERY UPDATE Cliente
    SET Nombre = nombre_cliente, Direccion = direccion_cliente
    WHERE NIT = nit_cliente
    RETURNING *;
END;
$$ LANGUAGE plpgsql;

-- fn_eliminar_cliente: Función para eliminar un cliente y retornar los detalles del cliente eliminado
CREATE OR REPLACE FUNCTION fn_eliminar_cliente(nit_cliente VARCHAR)
RETURNS SETOF Cliente AS $$
BEGIN
    RETURN QUERY DELETE FROM Cliente WHERE NIT = nit_cliente
    RETURNING *;
END;
$$ LANGUAGE plpgsql;
