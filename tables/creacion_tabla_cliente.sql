CREATE TABLE cliente(  
    numrun int NOT NULL PRIMARY KEY,
    dv_run VARCHAR(1) NOT NULL, 
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