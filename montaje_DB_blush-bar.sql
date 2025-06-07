CREATE TABLE genero(
    id_genero int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(9) NOT NULL
);
CREATE TABLE comuna(
    id_comuna INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(25) NOT NULL
);
CREATE TABLE tipo_cliente(
    id_tipo_cliente int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(15) NOT NULL,
    porc_desc DECIMAL(5,2) NOT NULL DEFAULT 0.00
);
CREATE TABLE cliente(  
    numrun int NOT NULL PRIMARY KEY,
    dv_run INT NOT NULL, 
    pnombre VARCHAR(25) NOT NULL,
    snombre VARCHAR(25) NOT NULL,
    papellido VARCHAR(35) NOT NULL,
    mapellido VARCHAR(35) NOT NULL,
    edad INT(3) NOT NULL,
    id_genero INT NOT NULL,
    id_comuna INT NOT NULL,
    id_tipo_cliente INT NOT NULL,
    FOREIGN KEY (id_genero) REFERENCES genero(id_genero),
    FOREIGN KEY (id_comuna) REFERENCES comuna(id_comuna),
    FOREIGN KEY (id_tipo_cliente) REFERENCES tipo_cliente(id_tipo_cliente)
);
CREATE TABLE categoria(
    id_categoria int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(100) NOT NULL
);
CREATE TABLE marca(
    id_marca int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(100) NOT NULL
);
CREATE TABLE producto(
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    id_categoria INT NOT NULL,
    id_marca INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria), 
    FOREIGN KEY (id_marca) REFERENCES marca(id_marca) 
);
CREATE TABLE metodo_pago(
    id_metodo_pago int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(50) NOT NULL
);
CREATE TABLE promocion(
    id_promocion int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    porc_desc DECIMAL(5, 2) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    activa BOOLEAN DEFAULT TRUE
);
CREATE TABLE venta(
    id_venta int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    numrun int NOT NULL,
    id_metodo_pago int NOT NULL,
    fecha_venta DATETIME NOT NULL,
    monto_subtotal DECIMAL(10, 2) NOT NULL,
    monto_descuentos DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    monto_final DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (numrun) REFERENCES cliente(numrun),
    FOREIGN KEY (id_metodo_pago) REFERENCES metodo_pago(id_metodo_pago)
);
CREATE TABLE detalle_venta(
    id_detalle_venta int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES venta(id_venta),
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);
CREATE TABLE venta_promocion(
    id_venta INT NOT NULL,
    id_promocion INT NOT NULL,
    PRIMARY KEY (id_venta,id_promocion),
    FOREIGN KEY (id_venta) REFERENCES venta(id_venta),
    FOREIGN KEY (id_promocion) REFERENCES promocion(id_promocion)
);
