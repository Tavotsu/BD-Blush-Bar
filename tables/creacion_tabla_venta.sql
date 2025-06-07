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