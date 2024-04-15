-- CRUD ITEM MENU
-- fn_insertar_item_menu: Función para insertar un nuevo ítem en el menú y retornar el ítem insertado.
CREATE OR REPLACE FUNCTION fn_insertar_item_menu(nombre_item VARCHAR, descripcion_item TEXT, precio_item NUMERIC, tipo_item VARCHAR)
RETURNS SETOF Item_Menu AS $$
DECLARE
    v_record Item_Menu;
BEGIN
    INSERT INTO Item_Menu (Nombre, Descripcion, Precio, Tipo)
    VALUES (nombre_item, descripcion_item, precio_item, tipo_item)
    RETURNING * INTO v_record;
    RETURN NEXT v_record;
END;
$$ LANGUAGE plpgsql;


-- fn_leer_items_menu: Función para obtener todos los ítems del menú.
CREATE OR REPLACE FUNCTION fn_leer_items_menu()
RETURNS SETOF Item_Menu AS $$
BEGIN
    RETURN QUERY SELECT * FROM Item_Menu;
END;
$$ LANGUAGE plpgsql;



-- fn_leer_item_menu_especifico: Función para obtener un ítem específico del menú por ID.
CREATE OR REPLACE FUNCTION fn_leer_item_menu_especifico(item_id INTEGER)
RETURNS SETOF Item_Menu AS $$
BEGIN
    RETURN QUERY SELECT * FROM Item_Menu WHERE ID_Item = item_id;
END;
$$ LANGUAGE plpgsql;


-- fn_actualizar_item_menu: Función para actualizar un ítem del menú y retornar el ítem actualizado.
CREATE OR REPLACE FUNCTION fn_actualizar_item_menu(item_id INTEGER, nombre_item VARCHAR, descripcion_item TEXT, precio_item NUMERIC, tipo_item VARCHAR)
RETURNS SETOF Item_Menu AS $$
DECLARE
    v_record Item_Menu;
BEGIN
    UPDATE Item_Menu
    SET Nombre = nombre_item, Descripcion = descripcion_item, Precio = precio_item, Tipo = tipo_item
    WHERE ID_Item = item_id
    RETURNING * INTO v_record;
    RETURN NEXT v_record;
END;
$$ LANGUAGE plpgsql;


-- fn_eliminar_item_menu: Función para eliminar un ítem del menú y retornar los detalles del ítem eliminado.
CREATE OR REPLACE FUNCTION fn_eliminar_item_menu(item_id INTEGER)
RETURNS SETOF Item_Menu AS $$
DECLARE
    v_record Item_Menu;
BEGIN
    DELETE FROM Item_Menu WHERE ID_Item = item_id
    RETURNING * INTO v_record;
    RETURN NEXT v_record;
END;
$$ LANGUAGE plpgsql;

