-- Universidad del Valle de Guatemala
-- Proyecto 2 (Gestion de Restaurante)
-- Gabriel Paz 221087
-- Joaquin Puente 22296
-- Nelson Garcia 22434

-- TABLAS
-- Creación de las tablas
CREATE TABLE Usuario (
    NombreUsuario VARCHAR(255) UNIQUE PRIMARY KEY NOT NULL,
    HashContraseña TEXT NOT NULL,
    Rol VARCHAR(50) NOT NULL CHECK (Rol IN ('mesero', 'administrador', 'chef', 'barista'))
);

-- Área
CREATE TABLE Area (
    ID_Area SERIAL PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    EsParaFumadores BOOLEAN NOT NULL
);

-- Mesa
CREATE TABLE Mesa (
    ID_Mesa SERIAL PRIMARY KEY,
    ID_Area INTEGER NOT NULL,
    Capacidad INTEGER NOT NULL,
    EsMóvil BOOLEAN NOT NULL,
    Disponible BOOLEAN NOT NULL,
    FOREIGN KEY (ID_Area) REFERENCES Area(ID_Area)
);

-- Agrupación de Mesas
CREATE TABLE Agrupacion_Mesas (
    ID_Agrupacion SERIAL PRIMARY KEY,
    ID_Mesa INTEGER NOT NULL,
    FOREIGN KEY (ID_Mesa) REFERENCES Mesa(ID_Mesa)
);

-- Cuenta
CREATE TABLE Cuenta (
    ID_Cuenta SERIAL PRIMARY KEY,
    ID_Mesa INTEGER NOT NULL,
    FechaHoraApertura TIMESTAMP NOT NULL DEFAULT NOW(),
    FechaHoraCierre TIMESTAMP,
    Estado VARCHAR(50) NOT NULL CHECK (Estado IN ('abierta', 'cerrada')),
    FOREIGN KEY (ID_Mesa) REFERENCES Mesa(ID_Mesa)
);

-- Pedido
CREATE TABLE Pedido (
    ID_Pedido SERIAL PRIMARY KEY,
    ID_Cuenta INTEGER NOT NULL,
    FechaHora TIMESTAMP NOT NULL,
    FOREIGN KEY (ID_Cuenta) REFERENCES Cuenta(ID_Cuenta),
    Estado VARCHAR(50) NOT NULL CHECK (Estado IN ('pendiente','preparando', 'entregado'))
);

-- Ítem_Menu
CREATE TABLE Item_Menu (
    ID_Item SERIAL PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Descripcion TEXT,
    Precio NUMERIC(10,2) NOT NULL,
    Tipo VARCHAR(50) NOT NULL CHECK (Tipo IN ('comida', 'bebida'))
);

-- Detalle_Pedido
CREATE TABLE Detalle_Pedido (
    ID_Pedido INTEGER NOT NULL,
    ID_Item INTEGER NOT NULL,
    Cantidad INTEGER NOT NULL,
    FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido),
    FOREIGN KEY (ID_Item) REFERENCES Item_Menu(ID_Item),
    PRIMARY KEY (ID_Pedido, ID_Item)
);

-- Cliente
CREATE TABLE Cliente (
    NIT VARCHAR(50) PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Direccion TEXT NOT NULL
);

-- Pago
CREATE TABLE Pago (
    ID_Pago SERIAL PRIMARY KEY,
    ID_Cuenta INTEGER NOT NULL,
    Monto NUMERIC(10,2) NOT NULL,
    FormaPago VARCHAR(255) NOT NULL CHECK (FormaPago IN ('efectivo', 'tarjeta')),
    FOREIGN KEY (ID_Cuenta) REFERENCES Cuenta(ID_Cuenta)
);

-- Mesero
CREATE TABLE Mesero (
    ID_Mesero SERIAL PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    ID_Area INTEGER NOT NULL,
    FOREIGN KEY (ID_Area) REFERENCES Area(ID_Area)
);

-- Encuesta
CREATE TABLE Encuesta (
    ID_Encuesta SERIAL PRIMARY KEY,
    ID_Cuenta INTEGER UNIQUE NOT NULL,
    Amabilidad INTEGER CHECK (Amabilidad >= 1 AND Amabilidad <= 5),
    Exactitud INTEGER CHECK (Exactitud >= 1 AND Exactitud <= 5),
    FOREIGN KEY (ID_Cuenta) REFERENCES Cuenta(ID_Cuenta)
);

-- Queja
CREATE TABLE Queja (
    ID_Queja SERIAL PRIMARY KEY,
    ID_Cliente VARCHAR(50) NOT NULL,
    FechaHora TIMESTAMP NOT NULL,
    Motivo TEXT NOT NULL,
    Severidad INTEGER CHECK (Severidad >= 1 AND Severidad <= 5),
    ID_Mesero INTEGER,
    ID_Item INTEGER,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(NIT),
    FOREIGN KEY (ID_Mesero) REFERENCES Mesero(ID_Mesero),
    FOREIGN KEY (ID_Item) REFERENCES Item_Menu(ID_Item)
);

-- INDICES

-- Creación de índices
CREATE INDEX idx_area ON Mesa(ID_Area);
CREATE INDEX idx_cuenta ON Pedido(ID_Cuenta);
CREATE INDEX idx_mesa ON Cuenta(ID_Mesa);
CREATE INDEX idx_pedido ON Detalle_Pedido(ID_Pedido);
CREATE INDEX idx_item ON Detalle_Pedido(ID_Item);
CREATE INDEX idx_pago_cuenta ON Pago(ID_Cuenta);
CREATE INDEX idx_mesero_area ON Mesero(ID_Area);
CREATE INDEX idx_queja_cliente ON Queja(ID_Cliente);
CREATE INDEX idx_queja_mesero ON Queja(ID_Mesero);
CREATE INDEX idx_queja_item ON Queja(ID_Item);


-- TRIGGERS

-- Trigger para actualizar el estado de la mesa
-- Función para establecer la mesa(s) como no disponible
CREATE OR REPLACE FUNCTION fn_mesas_no_disponibles()
RETURNS TRIGGER AS $$
BEGIN
    -- Verificar si la mesa está agrupada y actualizar todas las mesas en la agrupación
    IF EXISTS (SELECT 1 FROM Agrupacion_Mesas WHERE ID_Mesa = NEW.ID_Mesa) THEN
        UPDATE Mesa
        SET Disponible = FALSE
        WHERE ID_Mesa IN (
            SELECT ID_Mesa FROM Agrupacion_Mesas WHERE ID_Agrupacion IN (
                SELECT ID_Agrupacion FROM Agrupacion_Mesas WHERE ID_Mesa = NEW.ID_Mesa
            )
        );
    ELSE
        -- Actualizar solo la mesa específica
        UPDATE Mesa SET Disponible = FALSE WHERE ID_Mesa = NEW.ID_Mesa;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para cambiar el estado al abrir una cuenta
CREATE TRIGGER trg_mesas_no_disponibles
AFTER INSERT ON Cuenta
FOR EACH ROW
EXECUTE FUNCTION fn_mesas_no_disponibles();

-- Función para establecer la mesa(s) como disponible
CREATE OR REPLACE FUNCTION fn_mesas_disponibles()
RETURNS TRIGGER AS $$
BEGIN
    -- Verificar si la mesa está agrupada y actualizar todas las mesas en la agrupación
    IF EXISTS (SELECT 1 FROM Agrupacion_Mesas WHERE ID_Mesa = NEW.ID_Mesa) THEN
        UPDATE Mesa
        SET Disponible = TRUE
        WHERE ID_Mesa IN (
            SELECT ID_Mesa FROM Agrupacion_Mesas WHERE ID_Agrupacion IN (
                SELECT ID_Agrupacion FROM Agrupacion_Mesas WHERE ID_Mesa = NEW.ID_Mesa
            )
        );
    ELSE
        -- Actualizar solo la mesa específica
        UPDATE Mesa SET Disponible = TRUE WHERE ID_Mesa = NEW.ID_Mesa;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para cambiar el estado al cerrar una cuenta
CREATE TRIGGER trg_mesas_disponibles
AFTER UPDATE OF FechaHoraCierre ON Cuenta
FOR EACH ROW
WHEN (NEW.FechaHoraCierre IS NOT NULL)
EXECUTE FUNCTION fn_mesas_disponibles();

-- Función para actualizar la calificación promedio del mesero
CREATE OR REPLACE FUNCTION fn_actualizar_calificacion_mesero()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Mesero SET CalificacionPromedio = (
        SELECT AVG(Amabilidad)
        FROM Encuesta
        WHERE ID_Cuenta IN (
            SELECT ID_Cuenta FROM Cuenta WHERE ID_Mesero = NEW.ID_Mesero
        )
    ) WHERE ID_Mesero = NEW.ID_Mesero;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para actualizar la calificación después de cada encuesta
CREATE TRIGGER trg_actualizar_calificacion_mesero
AFTER INSERT OR UPDATE ON Encuesta
FOR EACH ROW
EXECUTE FUNCTION fn_actualizar_calificacion_mesero();
