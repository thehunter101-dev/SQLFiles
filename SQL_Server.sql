DROP DATABASE NOVICOMPUT;
--- Creacion de base de datos
CREATE DATABASE NOVICOMPUT
ON (NAME='NOVICOMPUT',FILENAME='/var/opt/mssql/data/NOVICOMPUT.mdf', SIZE=10MB, MAXSIZE=20MB,FILEGROWTH=1MB)
LOG ON (NAME='NOVICOMPUT_LOG', FILENAME='/var/opt/mssql/data/NOVICOMPUT.ldf');

USE NOVICOMPUT;
---Creacion de Tablas---
CREATE TABLE PRODUCTO
(
    IDPRODUCTO INT PRIMARY KEY IDENTITY,
    IDCATEGORIA INT NOT NULL,
    NOMBRE VARCHAR(20) NOT NULL,
    STOCK INT NOT NULL,
    ACTIVO BIT NOT NULL
)

CREATE TABLE PRODUCTODETALLE
(
    IDPRODUCTODETALLE INT PRIMARY KEY IDENTITY,
    IDPRODUCTO INT NOT NULL,
    DESCRIPCION VARCHAR(200) NOT NULL
)

CREATE TABLE  PROVEEDOR
(
    IDPROVEEDOR INT PRIMARY KEY IDENTITY,
    NOMBRES VARCHAR(100) NOT NULL,
    RUC VARCHAR(13) NOT NULL,
    TELEFONO VARCHAR(10) NOT NULL,
    EMAIL VARCHAR(50) NOT NULL,
    FECHA_CREACION DATE DEFAULT CONVERT(DATE, GETDATE())
)

-- CREAR TABLA COMPRA 
GO
CREATE TABLE COMPRA
(
    IDCOMPRA INT PRIMARY KEY IDENTITY,
    IDPROVEEDOR INT NOT NULL,
    FECHA_REGISTRO DATE NOT NULL,
    SUBTOTAL REAL NOT NULL,
    IVA REAL,
    DSCTO REAL,
    TOTAL REAL,
    PAGADO BIT
);


GO

--CREAR TABLA COMPRADETALLE

CREATE TABLE COMPRADETALLE
(
    IDCOMPRADETALLE INT PRIMARY KEY IDENTITY,
    IDCOMPRA INT,
    IDPRODUCTO INT,
    CANT INT,
    PRECIO REAL,
    SUBTOTAL REAL
);

GO
--CREAR TABLA CATEGORIA 

CREATE TABLE CATEGORIA
(
    IDCATEGORIA INT PRIMARY KEY IDENTITY,
    NOMBRE VARCHAR(100)
);

---Relaciones de tablas
ALTER TABLE PRODUCTODETALLE ADD CONSTRAINT FK_PD_P FOREIGN KEY (IDPRODUCTO) REFERENCES PRODUCTO (IDPRODUCTO)
ALTER TABLE PRODUCTO ADD CONSTRAINT FK_P_C FOREIGN KEY (IDCATEGORIA) REFERENCES CATEGORIA (IDCATEGORIA)
ALTER TABLE COMPRADETALLE ADD CONSTRAINT FK_CD_P FOREIGN KEY (IDPRODUCTO) REFERENCES PRODUCTO(IDPRODUCTO)
ALTER TABLE COMPRADETALLE ADD CONSTRAINT FK_CD_C FOREIGN KEY (IDCOMPRA) REFERENCES COMPRA (IDCOMPRA)
ALTER TABLE COMPRA ADD CONSTRAINT FK_C_P FOREIGN KEY (IDPROVEEDOR) REFERENCES PROVEEDOR (IDPROVEEDOR)

---Restricciones
ALTER TABLE PRODUCTO ADD CONSTRAINT CK_STOCK CHECK (STOCK > 0)
ALTER TABLE COMPRADETALLE ADD CONSTRAINT CK_CANT CHECK (CANT > 0 AND PRECIO > 0 AND SUBTOTAL > 0)
ALTER TABLE COMPRA ADD CONSTRAINT CK_COMPRA CHECK (SUBTOTAL > 0 AND IVA > 0 AND DSCTO > 0 AND TOTAL > 0)


GO
-- INSERCIONES DE CATEGORIA 
INSERT INTO CATEGORIA (NOMBRE) VALUES
('Laptops'),            
('Mouses'),             
('Teclados'),           
('Monitores'),          
('Almacenamiento'),     
('Impresoras'),         
('Auriculares'),        
('Parlantes'),          
('Tablets'),            
('Celulares'),           
('Televisores'),         
('Accesorios de PC'),    
('Redes y Conectividad'),
('Componentes PC'),      
('Consolas de Videojuegos'), 
('Video Proyectores'),   
('Cámaras y Fotografía'),
('Smartwatch y Wearables'),
('Electrodomésticos'),  
('Software');           


---Inserciones de Producto
INSERT INTO PRODUCTO (IDCATEGORIA, NOMBRE, STOCK, ACTIVO) VALUES
(1, 'Lenovo ThinkPad', 15, 1),
(1, 'Dell Inspiron', 10, 1),
(1, 'HP Pavilion', 20, 1),
(2, 'Logitech M185', 50, 1),
(2, 'Razer DeathAdder', 12, 1),
(2, 'Microsoft Basic', 30, 1),
(3, 'Mecánico Redragon', 25, 1),
(3, 'Logitech K120', 40, 1),
(3, 'Corsair K95', 8, 1),
(4, 'Samsung 24"', 18, 1),
(4, 'LG UltraWide 29"', 5, 1),
(4, 'Dell 27"', 10, 1),
(5, '1TB Seagate', 22, 1),
(5, 'SSD Kingston 480GB', 17, 1),
(5, 'SSD Samsung EVO 1TB', 6, 1),
(6, 'HP DeskJet', 7, 1),
(6, 'Epson EcoTank', 9, 1),
(7, 'HyperX Cloud II', 13, 1),
(7, 'Logitech G733', 11, 1),
(7, 'Sony WH-1000XM4', 4, 1);

---Inserciones Producto detalle
INSERT INTO PRODUCTODETALLE (IDPRODUCTO, DESCRIPCION) VALUES
(1, 'Laptop Lenovo ThinkPad con procesador Intel i5, 8GB RAM y SSD de 256GB'),
(2, 'Laptop Dell Inspiron con procesador AMD Ryzen 5, 8GB RAM y disco duro de 1TB'),
(3, 'Laptop HP Pavilion con procesador Intel i7, 16GB RAM y SSD de 512GB'),
(4, 'Mouse inalámbrico Logitech M185 con sensor óptico y receptor USB Nano'),
(5, 'Mouse gamer Razer DeathAdder con sensor óptico de 20,000 DPI y luces RGB'),
(6, 'Mouse Microsoft Basic con conexión USB y diseño ergonómico'),
(7, 'Teclado mecánico Redragon con switches azules y retroiluminación LED'),
(8, 'Teclado Logitech K120 con teclas resistentes y conexión USB'),
(9, 'Teclado mecánico Corsair K95 RGB con macros programables y switches Cherry MX'),
(10, 'Monitor Samsung 24 pulgadas Full HD con tecnología LED'),
(11, 'Monitor LG UltraWide 29 pulgadas con resolución 2560x1080 y panel IPS'),
(12, 'Monitor Dell 27 pulgadas con resolución QHD y soporte ajustable'),
(13, 'Disco duro interno Seagate de 1TB SATA III, 7200 RPM'),
(14, 'Unidad de estado sólido Kingston SSD 480GB SATA III, lectura rápida'),
(15, 'Unidad SSD Samsung EVO 1TB con interfaz NVMe y alta velocidad'),
(16, 'Impresora multifuncional HP DeskJet con escáner y conexión USB'),
(17, 'Impresora Epson EcoTank con sistema de tanques recargables y conexión Wi-Fi'),
(18, 'Auriculares HyperX Cloud II con sonido envolvente 7.1 y micrófono desmontable'),
(19, 'Auriculares Logitech G733 inalámbricos con luces RGB y micrófono con cancelación de ruido'),
(20, 'Auriculares Sony WH-1000XM4 con cancelación activa de ruido y conectividad Bluetooth');

---Provedor
INSERT INTO PROVEEDOR (NOMBRES, RUC, TELEFONO, EMAIL) VALUES
('Lenovo Ecuador S.A.', '1790012345001', '0991234567', 'ventas@lenovo.com.ec'),
('Dell Ecuador S.A.', '1790012345002', '0992345678', 'contacto@dell.com.ec'),
('HP Ecuador S.A.', '1790012345003', '0993456789', 'soporte@hp.com.ec'),
('Logitech S.A.', '1790012345004', '0994567890', 'ventas@logitech.com.ec'),
('Razer S.A.', '1790012345005', '0995678901', 'info@razer.com.ec'),
('Microsoft Ecuador S.A.', '1790012345006', '0996789012', 'contacto@microsoft.com.ec'),
('Redragon S.A.', '1790012345007', '0997890123', 'ventas@redragon.com.ec'),
('Corsair S.A.', '1790012345008', '0998901234', 'soporte@corsair.com.ec'),
('Samsung Ecuador S.A.', '1790012345009', '0999012345', 'contacto@samsung.com.ec'),
('LG Electronics S.A.', '1790012345010', '0990123456', 'ventas@lg.com.ec'),
('Seagate Technology S.A.', '1790012345011', '0991234568', 'info@seagate.com.ec'),
('Kingston Technology S.A.', '1790012345012', '0992345679', 'ventas@kingston.com.ec'),
('Epson Ecuador S.A.', '1790012345013', '0993456780', 'contacto@epson.com.ec'),
('HyperX S.A.', '1790012345014', '0994567891', 'ventas@hyperx.com.ec'),
('Sony Ecuador S.A.', '1790012345015', '0995678902', 'info@sony.com.ec'),
('Asus Ecuador S.A.', '1790012345016', '0996789013', 'contacto@asus.com.ec'),
('Acer Ecuador S.A.', '1790012345017', '0997890124', 'ventas@acer.com.ec'),
('TP-Link Ecuador S.A.', '1790012345018', '0998901235', 'soporte@tplink.com.ec'),
('Microsoft Surface S.A.', '1790012345019', '0999012346', 'ventas@surface.com.ec'),
('Canon Ecuador S.A.', '1790012345020', '0990123457', 'contacto@canon.com.ec');


GO

--INSERCIONES DE COMPRA
INSERT INTO COMPRA (IDPROVEEDOR, FECHA_REGISTRO, SUBTOTAL, IVA, DSCTO, TOTAL, PAGADO) VALUES
(1, '2025-08-01', 2555.00, 306.60, 10.00, 2861.60, 1),
(2, '2025-08-02', 1090.00, 130.80, 50.00, 1170.80, 1),
(3, '2025-08-03', 698.00, 83.76, 5.00, 781.76, 1),
(4, '2025-08-04', 840.00, 100.80, 5.00, 940.80, 1),
(5, '2025-08-05', 345.00, 41.40, 10.00, 376.40, 0),
(6, '2025-08-06', 960.00, 115.20, 10.00, 1075.20, 1),
(7, '2025-08-07', 445.00, 53.40, 20.00, 478.40, 1),
(8, '2025-08-08', 1220.00, 146.40, 10.00, 1366.40, 1),
(9, '2025-08-09', 670.00, 80.40, 30.00, 720.40, 0),
(10, '2025-08-10', 1500.00, 180.00, 50.00, 1630.00, 1),
(11, '2025-08-11', 2300.00, 276.00, 100.00, 2476.00, 1),
(12, '2025-08-12', 510.00, 61.20, 5.00, 571.20, 0),
(13, '2025-08-13', 925.00, 111.00, 25.00, 1011.00, 1),
(14, '2025-08-14', 1340.00, 160.80, 10.00, 1500.80, 1),
(15, '2025-08-15', 410.00, 49.20, 10.00, 449.20, 0),
(16, '2025-08-16', 2890.00, 346.80, 20.00, 3236.80, 1),
(17, '2025-08-17', 775.00, 93.00, 20.00, 848.00, 1),
(18, '2025-08-18', 640.00, 76.80, 5.00, 716.80, 0),
(19, '2025-08-19', 1980.00, 237.60, 80.00, 2137.60, 1),
(20, '2025-08-20', 860.00, 103.20, 10.00, 963.20, 1);

GO

--INSECIONES DE COMPRADETALLE
INSERT INTO COMPRADETALLE (IDCOMPRA, IDPRODUCTO, CANT, PRECIO, SUBTOTAL) VALUES
(1, 1, 2, 850.00, 1700.00),
(1, 2, 1, 780.00, 780.00),
(1, 4, 3, 25.00, 75.00),
(2, 3, 1, 950.00, 950.00),
(2, 5, 2, 60.00, 120.00),
(2, 6, 1, 20.00, 20.00),
(3, 7, 2, 120.00, 240.00),
(3, 8, 1, 18.00, 18.00),
(3, 10, 2, 220.00, 440.00),
(4, 11, 1, 330.00, 330.00),
(4, 12, 1, 400.00, 400.00),
(4, 13, 2, 55.00, 110.00),
(5, 14, 1, 75.00, 75.00),
(5, 15, 1, 150.00, 150.00),
(5, 16, 1, 120.00, 120.00),
(6, 17, 1, 250.00, 250.00),
(6, 18, 2, 300.00, 600.00),
(6, 19, 1, 110.00, 110.00),
(7, 20, 1, 350.00, 350.00),
(7, 9, 1, 95.00, 95.00);

--AUMENTAR LA CANTIDAD EN 2 UNIDADES A LOS PRODUCTOSCON PRECIO MAYOR A 40
UPDATE COMPRADETALLE
SET CANT = CANT + 2
WHERE PRECIO > 40;

-- UPDATES DE COMPRA 
USE NOVICOMPUT;
-- AUMENTA EL IVA EN  5% PARA COMPRAS ENTRE EL 5 Y 10 DE ENERO 2025
UPDATE COMPRA
SET IVA = IVA * 1.05
WHERE FECHA_REGISTRO BETWEEN '2025-01-05' AND '2025-01-10';

--MARCAR COMO PAGADO LAS COMPRAS CON MENOR A 100
UPDATE COMPRA
SET PAGADO = 1
WHERE TOTAL < 100;

--APLICAR DESCUNTO DE 10 A COMPRA CON MAYOR A 500
UPDATE COMPRA
SET DSCTO = DSCTO + 10
WHERE TOTAL > 500;

--CAMBIAR EL PRECIO A 5 EN LOSPRODUCTOS CON IDPRODUCTOS QUE ESTEN ENTRE 5 Y 10
UPDATE COMPRADETALLE
SET PRECIO = 5
WHERE IDPRODUCTO BETWEEN 5 AND 10;


-- ACTUALIZAR EL SUBTOTAL PARA EL IDCOMPRA EN ESPECIFICO 
UPDATE COMPRADETALLE
SET SUBTOTAL = CANT * PRECIO
WHERE IDCOMPRA = 15;


-- MULTIPLICAR EL PRECIO POR 1.1 PARA COMPRADETALLE CON EL IDPRODUCTO EN UNA LISTA 
UPDATE COMPRADETALLE
SET PRECIO = PRECIO * 1.1
WHERE IDPRODUCTO IN (2, 4, 6, 8, 10);


-- UPDATES DE CATEGORA DELETE FROM PRODUCTODETALLE WHERE IDPRODUCTODETALLE = 20
-- CAMBIAR LAS QUE TENGAN UNA "a" EN SU NOMBRE POR "Alimentos"
UPDATE CATEGORIA
SET NOMBRE = 'Alimentos'
WHERE NOMBRE LIKE '%a%';
-- CAMBIAR EL QUE TENGA EL ID DE "12" POR "Tecnologia"
UPDATE CATEGORIA
SET NOMBRE = 'Tecnología'
WHERE IDCATEGORIA = 12;
--CAMBIAR EL ID "1,2,3,4" POR "Productos Basicos"
UPDATE CATEGORIA
SET NOMBRE = 'Productos Básicos'
WHERE IDCATEGORIA IN (1, 2, 3, 4);

-- Borrar detalles del producto
DELETE FROM COMPRADETALLE WHERE IDPRODUCTO = 20;
DELETE FROM PRODUCTODETALLE WHERE IDPRODUCTO = 20;
-- Borrar compras del proveedor
DELETE FROM COMPRA WHERE IDPROVEEDOR IN (16, 17);
-- Ahora puedes borrar el producto y proveedor
DELETE FROM PRODUCTO WHERE IDPRODUCTO = 20;
DELETE FROM PROVEEDOR WHERE IDPROVEEDOR IN (16, 17);