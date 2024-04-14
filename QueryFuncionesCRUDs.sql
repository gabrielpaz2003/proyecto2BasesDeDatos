-- TABLA USUARIO
-- fn_insertar_usuario: Función para insertar un nuevo usuario.
CREATE OR REPLACE FUNCTION fn_insertar_usuario(nombre_usuario VARCHAR, hash_contrasena TEXT, rol_usuario VARCHAR)
RETURNS TABLE(ID_Usuario INTEGER, NombreUsuario VARCHAR, HashContraseña TEXT, Rol VARCHAR) AS $$
BEGIN
    RETURN QUERY INSERT INTO Usuario (NombreUsuario, HashContraseña, Rol) VALUES (nombre_usuario, hash_contrasena, rol_usuario)
    RETURNING ID_Usuario, NombreUsuario, HashContraseña, Rol;
END;
$$ LANGUAGE plpgsql;

-- fn_leer_usuarios: Función para obtener todos los usuarios.
CREATE OR REPLACE FUNCTION fn_leer_usuarios()
RETURNS TABLE(ID_Usuario INTEGER, NombreUsuario VARCHAR, HashContraseña TEXT, Rol VARCHAR) AS $$
BEGIN
    RETURN QUERY SELECT ID_Usuario, NombreUsuario, HashContraseña, Rol FROM Usuario;
END;
$$ LANGUAGE plpgsql;

-- fn_leer_usuario_especifico: Función para obtener un usuario específico por ID.
CREATE OR REPLACE FUNCTION fn_leer_usuario_especifico(id_usuario INT)
RETURNS TABLE(ID_Usuario INTEGER, NombreUsuario VARCHAR, HashContraseña TEXT, Rol VARCHAR) AS $$
BEGIN
    RETURN QUERY SELECT ID_Usuario, NombreUsuario, HashContraseña, Rol FROM Usuario WHERE ID_Usuario = id_usuario;
END;
$$ LANGUAGE plpgsql;

-- fn_actualizar_usuario: Función para actualizar un usuario existente.
CREATE OR REPLACE FUNCTION fn_actualizar_usuario(id_usuario INT, nombre_usuario VARCHAR, hash_contrasena TEXT, rol_usuario VARCHAR)
RETURNS TABLE(ID_Usuario INTEGER, NombreUsuario VARCHAR, HashContraseña TEXT, Rol VARCHAR) AS $$
BEGIN
    RETURN QUERY UPDATE Usuario
    SET NombreUsuario = nombre_usuario, HashContraseña = hash_contrasena, Rol = rol_usuario
    WHERE ID_Usuario = id_usuario
    RETURNING ID_Usuario, NombreUsuario, HashContraseña, Rol;
END;
$$ LANGUAGE plpgsql;

-- fn_eliminar_usuario: Función para eliminar un usuario.
CREATE OR REPLACE FUNCTION fn_eliminar_usuario(id_usuario INT)
RETURNS TABLE(ID_Usuario INTEGER, NombreUsuario VARCHAR, HashContraseña TEXT, Rol VARCHAR) AS $$
BEGIN
    RETURN QUERY DELETE FROM Usuario WHERE ID_Usuario = id_usuario
    RETURNING ID_Usuario, NombreUsuario, HashContraseña, Rol;
END;
$$ LANGUAGE plpgsql;


-- TABLA AREA
-- fn_insertar_area: Función para insertar un nuevo área.
CREATE OR REPLACE FUNCTION fn_insertar_area(nombre_area VARCHAR, es_para_fumadores BOOLEAN)
RETURNS TABLE(ID_Area INTEGER, Nombre VARCHAR, EsParaFumadores BOOLEAN) AS $$
BEGIN
    RETURN QUERY INSERT INTO Area (Nombre, EsParaFumadores) VALUES (nombre_area, es_para_fumadores)
    RETURNING ID_Area, Nombre, EsParaFumadores;
END;
$$ LANGUAGE plpgsql;


-- fn_leer_areas: Función para obtener todas las áreas.
CREATE OR REPLACE FUNCTION fn_leer_areas()
RETURNS TABLE(ID_Area INTEGER, Nombre VARCHAR, EsParaFumadores BOOLEAN) AS $$
BEGIN
    RETURN QUERY SELECT ID_Area, Nombre, EsParaFumadores FROM Area;
END;
$$ LANGUAGE plpgsql;

-- fn_leer_area_especifica: Función para obtener un área específica por ID.
CREATE OR REPLACE FUNCTION fn_leer_area_especifica(id_area INT)
RETURNS TABLE(ID_Area INTEGER, Nombre VARCHAR, EsParaFumadores BOOLEAN) AS $$
BEGIN
    RETURN QUERY SELECT ID_Area, Nombre, EsParaFumadores FROM Area WHERE ID_Area = id_area;
END;
$$ LANGUAGE plpgsql;

-- fn_actualizar_area: Función para actualizar una área existente.
CREATE OR REPLACE FUNCTION fn_actualizar_area(id_area INT, nombre_area VARCHAR, es_para_fumadores BOOLEAN)
RETURNS TABLE(ID_Area INTEGER, Nombre VARCHAR, EsParaFumadores BOOLEAN) AS $$
BEGIN
    RETURN QUERY UPDATE Area
    SET Nombre = nombre_area, EsParaFumadores = es_para_fumadores
    WHERE ID_Area = id_area
    RETURNING ID_Area, Nombre, EsParaFumadores;
END;
$$ LANGUAGE plpgsql;

-- fn_eliminar_area: Función para eliminar un área.
CREATE OR REPLACE FUNCTION fn_eliminar_area(id_area INT)
RETURNS TABLE(ID_Area INTEGER, Nombre VARCHAR, EsParaFumadores BOOLEAN) AS $$
BEGIN
    RETURN QUERY DELETE FROM Area WHERE ID_Area = id_area
    RETURNING ID_Area, Nombre, EsParaFumadores;
END;
$$ LANGUAGE plpgsql;

-- TABLA 