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