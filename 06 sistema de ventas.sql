CREATE DATABASE sistema_ventas_4E;
USE sistema_ventas_4E;

-- Creamos la tabla tipo_usuario
CREATE TABLE tipo_usuarios (
id_tipo_usuario INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único
nombre_tipo VARCHAR(50) NOT NULL,
-- Tipo de usuario (Admin, Cliente)
-- Campos de auditoría
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
-- Fecha creación
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP, -- Fecha modificación
created_by INT, -- Usuario que crea
updated_by INT, -- Usuario que modifica
deleted BOOLEAN DEFAULT FALSE -- Borrado lógico
);

-- Tabla para usuarios
CREATE TABLE usuarios (
id_usuario INT AUTO_INCREMENT PRIMARY KEY, -- Id único
nombre_usuario VARCHAR(100) NOT NULL, -- Nombre de usuario
correo VARCHAR(100) UNIQUE, -- Correo electrónico único
tipo_usuario_id INT, -- Relación a tipo_usuario
-- Campos de auditoría
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
-- Fecha creación
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP, -- Fecha modificación
created_by INT, -- Usuario que crea
updated_by INT, -- Usuario que modifica
deleted BOOLEAN DEFAULT FALSE -- Borrado lógico
);

ALTER TABLE usuarios  -- Modificar tabla
-- Agregar una restricción (FK)
ADD CONSTRAINT fk_usuario_tipo_usuario
-- Añade referencia(FK)
FOREIGN KEY (tipo_usuario_id) REFERENCES
tipo_usuarios(id_tipo_usuario);

CREATE TABLE productos (
id_producto INT AUTO_INCREMENT PRIMARY KEY, -- Id único
nombre_producto VARCHAR(100) NOT NULL, -- Nombre del producto
precio FLOAT NOT NULL, -- precio de los productos
stock INT, -- stock de cuantos productos hay
-- Campos de auditoría
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
-- Fecha creación
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP, -- Fecha modificación
created_by INT, -- Usuario que crea
updated_by INT, -- Usuario que modifica
deleted BOOLEAN DEFAULT FALSE -- Borrado lógico
);

CREATE TABLE ventas (
id_ventas INT AUTO_INCREMENT PRIMARY KEY, -- Id único
usuario_id INT, -- Usuario que realizó la venta
Fecha DATE NOT NULL, -- Fecha automática de venta
-- Campos de auditoría
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
-- Fecha creación
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP, -- Fecha modificación
created_by INT, -- Usuario que crea
updated_by INT, -- Usuario que modifica
deleted BOOLEAN DEFAULT FALSE -- Borrado lógico
);

ALTER TABLE ventas  -- Modificar tabla
-- Agregar una restricción (FK)
ADD CONSTRAINT fk_ventas_usuarios
-- Añade referencia(FK)
FOREIGN KEY (usuario_id) REFERENCES
usuarios(id_usuario);

CREATE TABLE detalle_ventas (
id_detalle_ventas INT AUTO_INCREMENT PRIMARY KEY, -- Id único
venta_id INT NOT NULL, -- Relación a la venta
producto_id INT NOT NULL, -- Relación al producto
cantidad INT NOT NULL, -- Cantidad vendida
precio_unitario FLOAT NOT NULL,
-- Campos de auditoría
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
-- Fecha creación
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP, -- Fecha modificación
created_by INT, -- Usuario que crea
updated_by INT, -- Usuario que modifica
deleted BOOLEAN DEFAULT FALSE -- Borrado lógico
);

ALTER TABLE detalle_ventas  -- Modificar tabla
-- Agregar una restricción (FK)
ADD CONSTRAINT fk_detalle_ventas_ventas
-- Añade referencia(FK)
FOREIGN KEY (venta_id) REFERENCES
ventas(id_venta);

ALTER TABLE detalle_ventas  -- Modificar tabla
-- Agregar una restricción (FK)
ADD CONSTRAINT fk_detalle_ventas_productos
-- Añade referencia(FK)
FOREIGN KEY (producto_id) REFERENCES
productos(id_producto);

-- 1. Eliminar la FK en detalle ventas
ALTER TABLE detalle_ventas
DROP FOREIGN KEY fk_detalle_ventas_ventas;

-- 1. Eliminar la FK en ventas
ALTER TABLE ventas
DROP FOREIGN KEY fk_ventas_usuarios;

-- Paso 1: Cambiar la columna auto_increment para que ya no lo sea
ALTER TABLE ventas MODIFY id_ventas INT;

-- Paso 2: Ahora sí puedes eliminar la clave primaria
ALTER TABLE ventas DROP PRIMARY KEY;

ALTER TABLE ventas
CHANGE COLUMN id_ventas id_venta INT PRIMARY KEY AUTO_INCREMENT;


ALTER TABLE usuarios ADD Password VARCHAR(15) AFTER correo;

ALTER TABLE tipo_usuarios ADD descripcion_tipo VARCHAR(200) AFTER nombre_tipo;

ALTER TABLE productos
ADD descripcion_producto VARCHAR(100) AFTER id_producto;

ALTER TABLE detalle_ventas  -- Modificar tabla
-- Agregar una restricción (FK)
ADD CONSTRAINT fk_detalle_ventas_productos
-- Añade referencia(FK)
FOREIGN KEY (producto_id) REFERENCES
productos(id_producto);





INSERT INTO usuarios (
    nombre_usuario, password, correo, tipo_usuario_id, created_by, updated_by
)
VALUES(
    'sistema',
    '$2y$10$2pE', -- Contraseña encriptada (ejemplo realista con bcrypt)
    'sistema@plataforma.cl',
    NULL,
    NULL,
    NULL
);

INSERT INTO tipo_usuarios (
    nombre_tipo,
    descripcion_tipo,
    created_by,
    updated_by
)

VALUES (
    'administrador',
    'Accede a todas las funciones del sistema, incluida la administración de usuarios.',
    1, -- creado por el usuario inicial
    1  -- actualizado por el mismo
),
(
    'vendedor',
    'Gestiona las ventas y la atención al cliente, con acceso limitado a funciones administrativas.',
    1, -- creado por el usuario inicial
    1  -- actualizado por el mismo
),
(
    'gerente',
    'Supervisa la operación del sistema de ventas y analiza el rendimiento del equipo.',
    1, -- creado por el usuario inicial
    1  -- actualizado por el mismo
),
(
    'cliente',
    'Accede a su perfil personal, historial de compras y estado de sus pedidos.',
    1, -- creado por el usuario inicial
    1  -- actualizado por el mismo
);

INSERT INTO usuarios (
    nombre_usuario, Password, correo, tipo_usuario_id, created_by, updated_by
)
VALUES (
    'Mariangel pirona',
    'lalala1234', -- bcrypt hasheado
    'mariangelpirona@gmail.com',
    1,  -- tipo: Administrador
    1,   1  -- creado por el usuario "sistema"

),
(
    'yetzibel.gonzales',
    'lalu4321', -- bcrypt hasheado
    'yetzibelgonzales@gmail.com',
    2,  -- tipo: Administrador
    1,   1  -- creado por el usuario "sistema"

),
(
    'Abigail Caniucura',
    'jijijaja654', -- bcrypt hasheado
    'abigailcaniucura@gmail.com',
    4,  -- tipo: Administrador
    1,   1  -- creado por el usuario "sistema"

),
(
    'ignacio.garrido',
    'tukituki', -- bcrypt hasheado
    'ignaciogarrido@gmail.com',
    3,  -- tipo: Administrador
    1,   1  -- creado por el usuario "sistema"

),
(
    'benjaminrios',
    'weko', -- bcrypt hasheado
    'benjaminrios@gmail.com',
    4,  -- tipo: Administrador
    1,   1  -- creado por el usuario "sistema"

);


INSERT productos (
nombre_producto, precio, stock)

VALUES ( 'Gabinete mATX 230W G08', -- NOMBRE
    20.590, -- PRECIO
    100, -- STOCK
    1,  -- tipo: Administrador
    1  -- creado por el usuario "sistema"

),
(
    'Memoria 128GB microSDXC (100MB/s) UHS-1 U1 Ultra', -- NOMBRE
     15.190, -- PRECIO
     200, -- STOCK
    1,  -- tipo: Administrador
    1  -- creado por el usuario "sistema"

),
(
    'Disco Externo 2TB 2.5" USB 3.0 Canvio Basics Black A5', -- NOMBRE
     82.490, -- PRECIO
     160, -- STOCK
    1,  -- tipo: Administrador
    1 -- creado por el usuario "sistema"

),
(
    'Placa Madre Intel H610M-K D4 Prime', -- NOMBRE
	100.790, -- PRECIO
    50, -- STOCK
    1,  -- tipo: Administrador
    1  -- creado por el usuario "sistema"

),
(
    'CPU Ryzen 5 5500 (AM4)',
     109.990, -- PRECIO
     500, -- STOCK
    1,  -- tipo: Administrador
    1  -- creado por el usuario "sistema"

);


select*from tipo_usuarios;
select*from usuarios;
select*from productos;
