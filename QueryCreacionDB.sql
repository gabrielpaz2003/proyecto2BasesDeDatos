-- Universidad del Valle de Guatemala
-- Proyecto 2 (Gestion de Restaurante)
-- Gabriel Paz 221087
-- Joaquin Puente 22296
-- Nelson Garcia 22434

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

-- Cuenta
CREATE TABLE Cuenta (
    ID_Cuenta SERIAL PRIMARY KEY,
    ID_Mesa INTEGER NOT NULL,
    FechaHoraApertura TIMESTAMP NOT NULL DEFAULT NOW(),
    FechaHoraCierre TIMESTAMP,
    Estado VARCHAR(50) CHECK (Estado IN ('abierta', 'cerrada')),
    FOREIGN KEY (ID_Mesa) REFERENCES Mesa(ID_Mesa)
);

-- Pedido
CREATE TABLE Pedido (
    ID_Pedido SERIAL PRIMARY KEY,
    ID_Cuenta INTEGER NOT NULL,
    FechaHora TIMESTAMP NOT NULL,
    FOREIGN KEY (ID_Cuenta) REFERENCES Cuenta(ID_Cuenta)
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
    Estado VARCHAR(50) NOT NULL CHECK (Estado IN ('pendiente','preparando', 'entregado')),
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
