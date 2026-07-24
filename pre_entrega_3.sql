CREATE DATABASE Ventas_Tech_DB;
GO
USE Ventas_Tech_DB;
GO

-- ── DROP TABLES ──
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS vendedores;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS territorios;

-- ── SECCIÓN DDL ──────────────────────────

-- Territorios
CREATE TABLE territorios(
    id_territorio  VARCHAR(10) PRIMARY KEY,
    region         VARCHAR(50) NOT NULL,
    pais           VARCHAR(100) NOT NULL,
    zona           VARCHAR(50),
    estrato        INT NOT NULL,
    antiguedad     DATE NOT NULL,
    area_local     DECIMAL(10,2) NOT NULL,
    zona_climatica VARCHAR(100)
);

-- Categorías
CREATE TABLE categorias(
    id_categoria     VARCHAR(10) PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL,
    descripcion      VARCHAR(200)
);

-- Clientes
CREATE TABLE clientes(
    id_cliente         VARCHAR(10) PRIMARY KEY,
    nombre             VARCHAR(250) NOT NULL,
    email              VARCHAR(250) NOT NULL UNIQUE,
    ciudad             VARCHAR(100) NOT NULL,
    segmento           VARCHAR(100),
    fecha_registro     DATE NOT NULL,
    edad               INT NOT NULL,
    genero             VARCHAR(20) NOT NULL,
    telefono           VARCHAR(25) NOT NULL,
    canal_conocimiento VARCHAR(50) NOT NULL
);

-- Productos
CREATE TABLE productos(
    id_producto     VARCHAR(10) PRIMARY KEY,
    nombre_producto VARCHAR(250) NOT NULL,
    id_categoria    VARCHAR(10) FOREIGN KEY REFERENCES categorias(id_categoria),
    subcategoria    VARCHAR(100) NOT NULL,
    precio          DECIMAL(10,2) NOT NULL,
    costo           DECIMAL(10,2) NOT NULL,
    stock           INT DEFAULT 0,
    activo          BIT DEFAULT 1
);

-- Vendedores
CREATE TABLE vendedores(
    id_vendedor     VARCHAR(10) PRIMARY KEY,
    nombre_vendedor VARCHAR(250) NOT NULL,
    edad            INT NOT NULL,
    experiencia     INT NOT NULL,
    genero          VARCHAR(20) NOT NULL,
    email           VARCHAR(250) NOT NULL,
    telefono        VARCHAR(25) NOT NULL,
    id_territorio   VARCHAR(10) FOREIGN KEY REFERENCES territorios(id_territorio)
);

-- Ventas
CREATE TABLE ventas(
    id_venta        VARCHAR(10) PRIMARY KEY,
    fecha_venta     DATETIME2 NOT NULL,
    cantidad        INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    total_venta     DECIMAL(10,2) NOT NULL,
    canal           VARCHAR(100) NOT NULL,
    id_cliente      VARCHAR(10) FOREIGN KEY REFERENCES clientes(id_cliente),
    id_producto     VARCHAR(10) FOREIGN KEY REFERENCES productos(id_producto),
    id_territorio   VARCHAR(10) FOREIGN KEY REFERENCES territorios(id_territorio),
    id_vendedor     VARCHAR(10) FOREIGN KEY REFERENCES vendedores(id_vendedor)
);

-- ── SECCIÓN DML ──────────────────────────

-- Territorios
INSERT INTO territorios VALUES ('T001','Pampeana','Argentina','Centro',4,'2020-01-01',500.50,'Templada');
INSERT INTO territorios VALUES ('T002','Cuyo','Argentina','Oeste',3,'2019-06-15',320.00,'Árida');
INSERT INTO territorios VALUES ('T003','NEA','Argentina','Norte',3,'2021-03-10',450.75,'Subtropical');

-- Categorías
INSERT INTO categorias VALUES ('C1','Computación','Laptops, PCs y monitores');
INSERT INTO categorias VALUES ('C2','Accesorios','Periféricos y complementos');
INSERT INTO categorias VALUES ('C3','Audio','Auriculares y parlantes');
INSERT INTO categorias VALUES ('C4','Almacenamiento','Discos y memorias');

-- Clientes
INSERT INTO clientes VALUES ('CLI001','María López','maria@mail.com','Buenos Aires','Premium','2024-01-05',34,'F','1141234567','Redes sociales');
INSERT INTO clientes VALUES ('CLI002','Carlos Ruiz','carlos@mail.com','Córdoba','Standard','2024-01-10',45,'M','3517654321','Recomendación');
INSERT INTO clientes VALUES ('CLI003','Ana Gómez','ana@mail.com','Rosario','Premium','2024-02-01',29,'F','3411122334','Publicidad web');
INSERT INTO clientes VALUES ('CLI004','Pedro Sanz','pedro@mail.com','Mendoza','Standard','2024-02-15',52,'M','2615566778','Google');
INSERT INTO clientes VALUES ('CLI005','Laura Torres','laura@mail.com','Tucumán','Premium','2024-03-01',38,'F','3814433221','Redes sociales');

-- Vendedores
INSERT INTO vendedores VALUES ('V001','Juan Pérez',30,5,'M','juan@techstore.com','1145678901','T001');
INSERT INTO vendedores VALUES ('V002','Sofía Díaz',28,3,'F','sofia@techstore.com','3512345678','T002');
INSERT INTO vendedores VALUES ('V003','Martín Soto',41,12,'M','martin@techstore.com','3416789012','T003');

-- Productos
INSERT INTO productos VALUES ('P001','Laptop Pro 15','C1','Notebooks',1200.00,900.00,15,1);
INSERT INTO productos VALUES ('P002','Mouse Inalámbrico','C2','Periféricos',28.00,15.00,80,1);
INSERT INTO productos VALUES ('P003','Monitor 4K 27"','C1','Monitores',450.00,320.00,12,1);
INSERT INTO productos VALUES ('P004','Auriculares BT Pro','C3','Auriculares',120.00,70.00,35,1);
INSERT INTO productos VALUES ('P005','SSD Externo 1TB','C4','Discos',130.00,85.00,18,1);
INSERT INTO productos VALUES ('P006','Teclado Mecánico','C2','Periféricos',95.00,55.00,40,1);

-- Ventas
INSERT INTO ventas VALUES ('VT001','2024-03-05 10:15:00',2,1200.00,2400.00,'Online',   'CLI001','P001','T001','V001');
INSERT INTO ventas VALUES ('VT002','2024-03-06 11:30:00',5,  28.00, 140.00,'Tienda',   'CLI002','P002','T002','V002');
INSERT INTO ventas VALUES ('VT003','2024-03-07 09:45:00',1, 450.00, 450.00,'Online',   'CLI003','P003','T003','V003');
INSERT INTO ventas VALUES ('VT004','2024-03-08 14:20:00',2, 120.00, 240.00,'Tienda',   'CLI001','P004','T001','V001');
INSERT INTO ventas VALUES ('VT005','2024-03-10 16:05:00',3, 130.00, 390.00,'Online',   'CLI004','P005','T002','V002');
INSERT INTO ventas VALUES ('VT006','2024-03-11 12:00:00',4,  95.00, 380.00,'Tienda',   'CLI002','P006','T003','V003');
INSERT INTO ventas VALUES ('VT007','2024-03-12 18:30:00',1,1200.00,1200.00,'Online',   'CLI005','P001','T001','V001');
INSERT INTO ventas VALUES ('VT008','2024-03-13 10:10:00',8,  28.00, 224.00,'Mayorista','CLI003','P002','T002','V002');
INSERT INTO ventas VALUES ('VT009','2024-03-14 15:25:00',1, 120.00, 120.00,'Online',   'CLI004','P004','T003','V003');
INSERT INTO ventas VALUES ('VT010','2024-03-15 17:40:00',2, 450.00, 900.00,'Tienda',   'CLI005','P003','T001','V001');

-- ── VERIFICACIÓN ──
SELECT * FROM territorios;
SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM vendedores;
SELECT * FROM productos;
SELECT * FROM ventas;