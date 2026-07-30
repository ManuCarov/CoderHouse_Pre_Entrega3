-- ============================================================
--  Proyecto: Ventas_Tech_DB
--  Practica: Creando la base de datos Ventas_Tech_DB
--            DDL, Constraints e INSERT
--  Contexto: DBA de TechStore (cadena de tiendas de tecnologia)
--
--  Modelo:
--    categorias (1) --- (N) productos (1) --- (N) ventas (N) --- (1) clientes
--
--  Compatibilidad: PostgreSQL / SQL Server
-- ============================================================


-- ============================================================
--  PASO 1: CREAR LA BASE DE DATOS
--  (Ejecutar por separado antes del resto del script)
-- ============================================================
-- CREATE DATABASE Ventas_Tech_DB;
-- USE Ventas_Tech_DB;


-- ============================================================
--  PASO 2: DROP TABLES
--  Orden inverso a las dependencias para no violar las FKs.
-- ============================================================
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;


-- ============================================================
--  PASO 3: CREATE TABLES
--  Orden: dimensiones primero, tabla de hechos al final.
-- ============================================================

-- Tabla categorias
CREATE TABLE categorias (
    id_categoria     INT           PRIMARY KEY,
    nombre_categoria VARCHAR(50)   NOT NULL,
    descripcion      VARCHAR(200)
);

-- Tabla clientes
CREATE TABLE clientes (
    id_cliente     INT          PRIMARY KEY,
    nombre         VARCHAR(100) NOT NULL,
    email          VARCHAR(100) UNIQUE,
    ciudad         VARCHAR(50),
    fecha_registro DATE         NOT NULL
);

-- Tabla productos
CREATE TABLE productos (
    id_producto     INT           PRIMARY KEY,
    nombre_producto VARCHAR(100)  NOT NULL,
    id_categoria    INT           FOREIGN KEY REFERENCES categorias(id_categoria),
    precio          DECIMAL(10,2) NOT NULL,
    stock           INT           DEFAULT 0,
    activo          TINYINT       DEFAULT 1
);

-- Tabla ventas (HECHOS)
CREATE TABLE ventas (
    id_venta        INT           PRIMARY KEY,
    id_cliente      INT           FOREIGN KEY REFERENCES clientes(id_cliente),
    id_producto     INT           FOREIGN KEY REFERENCES productos(id_producto),
    cantidad        INT           NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    fecha_venta     DATE          NOT NULL
);


-- ============================================================
--  PASO 4: INSERT DATA
--  Orden: primero tablas sin dependencias.
-- ============================================================

-- categorias (4 registros)
INSERT INTO categorias VALUES (1, N'Computación',    N'Laptops, PCs y monitores');
INSERT INTO categorias VALUES (2, N'Accesorios',     N'Periféricos y complementos');
INSERT INTO categorias VALUES (3, N'Audio',          N'Auriculares y parlantes');
INSERT INTO categorias VALUES (4, N'Almacenamiento', N'Discos y memorias');

-- clientes (5 registros)
INSERT INTO clientes VALUES (1, N'María López',  N'maria@mail.com',  N'Buenos Aires', '2024-01-05');
INSERT INTO clientes VALUES (2, N'Carlos Ruiz',  N'carlos@mail.com', N'Córdoba',      '2024-01-10');
INSERT INTO clientes VALUES (3, N'Ana Gómez',    N'ana@mail.com',    N'Rosario',      '2024-02-01');
INSERT INTO clientes VALUES (4, N'Pedro Sanz',   N'pedro@mail.com',  N'Mendoza',      '2024-02-15');
INSERT INTO clientes VALUES (5, N'Laura Torres', N'laura@mail.com',  N'Tucumán',      '2024-03-01');

-- productos (6 registros)
INSERT INTO productos VALUES (1, N'Laptop Pro 15',      1, 1200.00, 15, 1);
INSERT INTO productos VALUES (2, N'Mouse Inalámbrico',  2,   28.00, 80, 1);
INSERT INTO productos VALUES (3, N'Monitor 4K 27"',     1,  450.00, 12, 1);
INSERT INTO productos VALUES (4, N'Auriculares BT Pro', 3,  120.00, 35, 1);
INSERT INTO productos VALUES (5, N'SSD Externo 1TB',    4,  130.00, 18, 1);
INSERT INTO productos VALUES (6, N'Teclado Mecánico',   2,   95.00, 40, 1);

-- ventas (10 registros)
INSERT INTO ventas VALUES (1,  1, 1, 2, 1200.00, '2024-03-05');
INSERT INTO ventas VALUES (2,  2, 2, 5,   28.00, '2024-03-06');
INSERT INTO ventas VALUES (3,  3, 3, 1,  450.00, '2024-03-07');
INSERT INTO ventas VALUES (4,  1, 4, 2,  120.00, '2024-03-08');
INSERT INTO ventas VALUES (5,  4, 5, 3,  130.00, '2024-03-10');
INSERT INTO ventas VALUES (6,  2, 6, 4,   95.00, '2024-03-11');
INSERT INTO ventas VALUES (7,  5, 1, 1, 1200.00, '2024-03-12');
INSERT INTO ventas VALUES (8,  3, 2, 8,   28.00, '2024-03-13');
INSERT INTO ventas VALUES (9,  4, 4, 1,  120.00, '2024-03-14');
INSERT INTO ventas VALUES (10, 5, 3, 2,  450.00, '2024-03-15');


-- ============================================================
--  PASO 5: VERIFICACION DE INTEGRIDAD
-- ============================================================
SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;