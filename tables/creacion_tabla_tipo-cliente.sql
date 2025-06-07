CREATE TABLE tipo_cliente(
    id_tipo_cliente int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(15) NOT NULL,
    porc_desc DECIMAL(5,2) NOT NULL DEFAULT 0.00
);