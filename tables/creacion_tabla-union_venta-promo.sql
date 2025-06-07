CREATE TABLE venta_promocion(
    id_venta INT NOT NULL,
    id_promocion INT NOT NULL,
    PRIMARY KEY (id_venta,id_promocion),
    FOREIGN KEY (id_venta) REFERENCES venta(id_venta),
    FOREIGN KEY (id_promocion) REFERENCES promocion(id_promocion)
);