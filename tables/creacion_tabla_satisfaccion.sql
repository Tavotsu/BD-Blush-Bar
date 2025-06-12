CREATE TABLE satisfaccion_venta(
    id_satisfaccion INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_venta INT NOT NULL UNIQUE,
    puntuacion INT NOT NULL,
    comentario TEXT,
    fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_venta) REFERENCES venta(id_venta),
    CONSTRAINT chk_puntuacion CHECK (puntuacion BETWEEN 1 AND 10)
);