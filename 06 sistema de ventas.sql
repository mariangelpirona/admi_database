-- Crear la base de datos
CREATE DATABASE sistema_ventas_4E;
-- Seleccionar la base de datos para trabajar
USE sistema_ventas_4E;
-- Creamos la tabla tipo_usuario
CREATE TABLE tipo_usuarios (
id INT AUTO_INCREMENT PRIMARY KEY,
-- Identificador único
nombre_tipo VARCHAR(50) NOT NULL,
-- Tipo de usuario (Admin, Cliente)
-- Creamos la tabla tipo_usuario
-- Campos de auditoría
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
-- Fecha creación
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP, -- Fecha modificación
created_by INT,-- Usuario que crea
updated_by INT,-- Usuario que modifica
deleted BOOLEAN DEFAULT FALSE -- Borrado lógico
);
-- Tabla para usuarios

CREATE TABLE usuarios (
id_tipo_usuario INT AUTO_INCREMENT PRIMARY KEY, -- Id único
nombre_tipo VARCHAR(100) NOT NULL, -- Nombre de usuario
correo VARCHAR(100) UNIQUE, -- Correo electrónico único
tipo_usuario_id INT, -- Relación a tipo_usuario
-- Campos de auditoría
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
-- Fecha creación
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP, -- Fecha modificación
created_by INT,-- Usuario que crea
updated_by INT,-- Usuario que modifica
deleted BOOLEAN DEFAULT FALSE -- Borrado lógico
);
-- ------------------------------------------------------------
ALTER TABLE usuarios -- Modificar tabla
-- Agregar una restricción (FK)
ADD CONSTRAINT fk_usuario_tipo_usuario
-- Añade referencia(FK)
FOREIGN KEY (tipo_usuario_id) REFERENCES
tipo_usuarios(id);
-- ------------------------------------------------------------
create table productos (
id_productos int auto_increment primary key,
nombre_producto varchar(100) not null,
precio_producto float not null,
stock_producto int not null,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT false
);
create table ventas (
id_ventas int auto_increment primary key,
tipo_usuario_id int not null,
fechas_venta datetime,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT false
);
-- -------------------------------------------------------
ALTER TABLE ventas
ADD CONSTRAINT fk_ventas_tipo_usuario
FOREIGN KEY (tipo_usuario_id) REFERENCES
tipo_usuarios(id);
-- ----------------------------------------------------------
create table detalle_ventas (
id_detalle_venta int auto_increment primary key,
id_ventas int not null,
id_producto int not null,
cantidad int not null,
precio_unitario int not null,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
created_by INT,
updated_by INT,
deleted BOOLEAN DEFAULT false
);
-- ---------------------------------------------
alter table detalle_ventas
add constraint fk_detalle_ventas_ventas
foreign key (id_ventas) references
ventas(id_ventas);
-- ----------------------------------------------
alter table detalle_ventas
add constraint fk_detalle_ventas_producto
foreign key (id_producto) references
productos(id_productos);
-- -----------------------------------------------