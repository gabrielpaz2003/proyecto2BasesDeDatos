--proyecto 2 bases de datos 1--

-- Universidad del Valle de Guatemala
-- Proyecto 2 (Gestion de Restaurante)
-- Gabriel Paz 221087
-- Joaquin Puente 22296
-- Nelson Garcia 22434

--reportes--


-- 1. Reporte de los platos más pedidos por los clientes en un rango de fechas solicitadas al usuario.

CREATE OR REPLACE FUNCTION obtener_items_menu_mas_pedidos(
    fecha_inicio TIMESTAMP,
    fecha_fin TIMESTAMP
)
RETURNS TABLE (
    ID_Item INTEGER,
    Nombre VARCHAR(255),
    Total_Pedidos INTEGER
) AS $$
BEGIN
    RETURN QUERY
    SELECT IM.ID_Item, IM.Nombre, SUM(DP.Cantidad)::INTEGER AS Total_Pedidos
    FROM Detalle_Pedido AS DP
    JOIN Pedido AS P ON DP.ID_Pedido = P.ID_Pedido
    JOIN Item_Menu AS IM ON DP.ID_Item = IM.ID_Item
    WHERE P.FechaHora BETWEEN fecha_inicio AND fecha_fin
    GROUP BY IM.ID_Item, IM.Nombre
    ORDER BY Total_Pedidos DESC
  	LIMIT 10;
END;
$$ LANGUAGE plpgsql;

-- 2. Horario en el que se ingresan más pedidos entre un rango de fechas solicitadas al usuario.

CREATE OR REPLACE FUNCTION obtener_horario_mas_concurrido(
    fecha_inicio TIMESTAMP,
    fecha_fin TIMESTAMP
)
RETURNS TABLE (
    Horario TIMESTAMP,
    Total_Pedidos INTEGER
) AS $$
BEGIN
    RETURN QUERY
    WITH Intervalos AS (
        SELECT generate_series(
            '2000-01-01'::TIMESTAMP, -- Fecha de inicio fija (podría ser cualquier fecha)
            '2000-01-02'::TIMESTAMP, -- Fecha de fin fija (podría ser cualquier fecha)
            interval '2 hour'
        ) AS Horario_Inicio
    )
    SELECT
        i.Horario_Inicio,
        COUNT(P.ID_Pedido)::INTEGER AS Total_Pedidos
    FROM
        Intervalos i
    LEFT JOIN Pedido P ON
        EXTRACT(HOUR FROM P.FechaHora) >= EXTRACT(HOUR FROM i.Horario_Inicio) AND
        EXTRACT(HOUR FROM P.FechaHora) < EXTRACT(HOUR FROM i.Horario_Inicio) + 2
    GROUP BY
        i.Horario_Inicio
    ORDER BY
        COUNT(P.ID_Pedido) DESC
    LIMIT 1;
END;
$$ LANGUAGE plpgsql;


--3. Promedio de tiempo en que se tardan los clientes en comer, agrupando la cantidad de
--personas comiendo, por ejemplo: 2 personas: 1 hora 10 minutos, 3 personas: 1 hora 15
--minutos, etc. entre un rango de fechas solicitadas al usuario.

CREATE OR REPLACE FUNCTION calcular_promedio_tiempo_comida(
    fecha_inicio TIMESTAMP,
    fecha_fin TIMESTAMP
)
RETURNS TABLE(cantidad_personas INTEGER, promedio_tiempo INTERVAL) AS
$$
BEGIN
    RETURN QUERY 
    SELECT mesa.Capacidad AS cantidad_personas,
           AVG(Cuenta.FechaHoraCierre - Cuenta.FechaHoraApertura) AS promedio_tiempo
    FROM Cuenta
    INNER JOIN Mesa ON Cuenta.ID_Mesa = Mesa.ID_Mesa
    WHERE Cuenta.FechaHoraCierre BETWEEN fecha_inicio AND fecha_fin
    GROUP BY mesa.Capacidad;
END;
$$
LANGUAGE plpgsql;

--4. Reporte de las quejas agrupadas por persona para un rango de fechas solicitadas al usuario.

CREATE OR REPLACE FUNCTION obtener_quejas_por_mesero(
    fecha_inicio TIMESTAMP,
    fecha_fin TIMESTAMP
)
RETURNS TABLE (
    ID_Queja INTEGER,
    FechaHora TIMESTAMP,
    Motivo TEXT,
    Severidad INTEGER,
    Nombre_Mesero VARCHAR(255)
) AS $$
BEGIN
    RETURN QUERY
    SELECT Q.ID_Queja, Q.FechaHora, Q.Motivo, Q.Severidad, M.Nombre AS Nombre_Mesero
    FROM Queja AS Q
    JOIN Mesero AS M ON Q.ID_Mesero = M.ID_Mesero
    WHERE Q.FechaHora BETWEEN fecha_inicio AND fecha_fin
    ORDER BY Nombre_Mesero;
END;
$$ LANGUAGE plpgsql;


-- 5. Reporte de las quejas agrupadas por plato para un rango de fechas solicitadas al usuario.

CREATE OR REPLACE FUNCTION obtener_quejas_por_item_menu(
    fecha_inicio TIMESTAMP,
    fecha_fin TIMESTAMP
)
RETURNS TABLE (
    ID_Queja INTEGER,
    FechaHora TIMESTAMP,
    Motivo TEXT,
    Severidad INTEGER,
    Nombre_Item_Menu VARCHAR(255)
) AS $$
BEGIN
    RETURN QUERY
    SELECT Q.ID_Queja, Q.FechaHora, Q.Motivo, Q.Severidad, IM.Nombre AS Nombre_Item_Menu
    FROM Queja AS Q
    JOIN Item_Menu AS IM ON Q.ID_Item = IM.ID_Item
    WHERE Q.FechaHora BETWEEN fecha_inicio AND fecha_fin
    ORDER BY Nombre_Item_Menu;
END;
$$ LANGUAGE plpgsql;


--6. Reporte de eficiencia de meseros mostrando los resultados de las encuestas, agrupado
--por personas y por mes para los últimos 6 meses.

CREATE OR REPLACE FUNCTION obtener_promedio_encuestas_por_mes()
RETURNS TABLE (
    Mes TIMESTAMP,
    Promedio_Amabilidad NUMERIC,
    Promedio_Exactitud NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        date_trunc('month', current_date - interval '1 month' * s.i) AS Mes,
        AVG(E.Amabilidad) AS Promedio_Amabilidad,
        AVG(E.Exactitud) AS Promedio_Exactitud
    FROM 
        generate_series(0, 5) AS s(i) -- 6 meses atrás
    LEFT JOIN 
        Cuenta AS C ON date_trunc('month', C.FechaHoraApertura) = date_trunc('month', current_date - interval '1 month' * s.i)
    LEFT JOIN 
        Encuesta AS E ON C.ID_Cuenta = E.ID_Cuenta
    GROUP BY 
        date_trunc('month', current_date - interval '1 month' * s.i)
    ORDER BY 
        Mes DESC;
END;
$$ LANGUAGE plpgsql;

