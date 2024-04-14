-- TABLA USUARIO
-- fn_insertar_usuario: Función para insertar un nuevo usuario.
CREATE OR REPLACE FUNCTION fn_insertar_usuario(nombre_usuario VARCHAR, hash_contrasena TEXT, rol_usuario VARCHAR)
RETURNS SETOF Usuario
AS $$
DECLARE
    inserted_user Usuario%ROWTYPE;
BEGIN
    INSERT INTO Usuario (NombreUsuario, HashContraseña, Rol)
    VALUES (nombre_usuario, hash_contrasena, rol_usuario)
    RETURNING * INTO inserted_user;

    RETURN NEXT inserted_user;
END;
$$
LANGUAGE plpgsql;

-- fn_leer_usuarios: Función para obtener todos los usuarios.
CREATE OR REPLACE FUNCTION fn_leer_usuarios()
RETURNS SETOF usuario
AS $$
BEGIN
    RETURN QUERY SELECT * FROM Usuario;
END;
$$ LANGUAGE plpgsql;

-- fn_leer_usuario_especifico: Función para obtener un usuario específico por ID.
CREATE OR REPLACE FUNCTION fn_leer_usuario_especifico(nombre_usuario VARCHAR)
RETURNS SETOF usuario as $$
BEGIN
    RETURN QUERY SELECT * FROM Usuario u WHERE u.nombreusuario = nombre_usuario;
END;
$$ LANGUAGE plpgsql;

-- fn_actualizar_usuario: Función para actualizar un usuario existente.
CREATE OR REPLACE FUNCTION fn_actualizar_usuario(nombre_usuario VARCHAR, hash_contrasena TEXT, rol_usuario VARCHAR)
RETURNS SETOF Usuario
AS $$
DECLARE
    updated_user Usuario%ROWTYPE;
BEGIN
    UPDATE Usuario
    SET HashContraseña = hash_contrasena, Rol = rol_usuario
    WHERE NombreUsuario = nombre_usuario
    RETURNING * INTO updated_user;

    RETURN NEXT updated_user;
END;
$$ LANGUAGE plpgsql;

-- fn_eliminar_usuario: Función para eliminar un usuario.
CREATE OR REPLACE FUNCTION fn_eliminar_usuario(nombre_usuario VARCHAR)
RETURNS SETOF Usuario
AS $$
DECLARE
    deleted_user Usuario%ROWTYPE;
BEGIN
    DELETE FROM Usuario WHERE NombreUsuario = nombre_usuario
    RETURNING * INTO deleted_user;

    RETURN NEXT deleted_user;
END;
$$ LANGUAGE plpgsql;

