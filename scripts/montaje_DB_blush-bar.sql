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
    dv_run VARCHAR(1) NOT NULL, 
    pnombre VARCHAR(25) NOT NULL,
    snombre VARCHAR(25) NOT NULL,
    papellido VARCHAR(35) NOT NULL,
    mapellido VARCHAR(35) NOT NULL,
    fec_nac DATE NOT NULL,
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

CREATE TABLE satisfaccion_venta(
    id_satisfaccion INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_venta INT NOT NULL UNIQUE,
    puntuacion INT NOT NULL,
    comentario TEXT,
    fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_venta) REFERENCES venta(id_venta),
    CONSTRAINT chk_puntuacion CHECK (puntuacion BETWEEN 1 AND 10)
);

#Comienza el poblado de la base de datos

START TRANSACTION;

# genero
INSERT INTO `genero` (`id_genero`, `descripcion`) VALUES (1, 'Femenino');
INSERT INTO `genero` (`id_genero`, `descripcion`) VALUES (2, 'Masculino');
INSERT INTO `genero` (`id_genero`, `descripcion`) VALUES (3, 'Otro');

# comuna
INSERT INTO `comuna` (`id_comuna`, `descripcion`) VALUES (1, 'La paloma');
INSERT INTO `comuna` (`id_comuna`, `descripcion`) VALUES (2, 'Mirasol');
INSERT INTO `comuna` (`id_comuna`, `descripcion`) VALUES (3, 'Puerta sur');
INSERT INTO `comuna` (`id_comuna`, `descripcion`) VALUES (4, 'Jardin Austral');
INSERT INTO `comuna` (`id_comuna`, `descripcion`) VALUES (5, 'Barrio Puerto (Angelmo)');
INSERT INTO `comuna` (`id_comuna`, `descripcion`) VALUES (6, 'Parque Industrial');
INSERT INTO `comuna` (`id_comuna`, `descripcion`) VALUES (7, 'Chile Barrio');
INSERT INTO `comuna` (`id_comuna`, `descripcion`) VALUES (8, 'Antuhue');
INSERT INTO `comuna` (`id_comuna`, `descripcion`) VALUES (9, 'Alerce');
INSERT INTO `comuna` (`id_comuna`, `descripcion`) VALUES (6, 'Lagunitas');
INSERT INTO `comuna` (`id_comuna`, `descripcion`) VALUES (6, 'Pichi pelluco');

# tipo_cliente
INSERT INTO `tipo_cliente` (`id_tipo_cliente`, `descripcion`, `porc_desc`) VALUES (1, 'Regular', 0.0);
INSERT INTO `tipo_cliente` (`id_tipo_cliente`, `descripcion`, `porc_desc`) VALUES (2, 'Frecuente', 7.5);
INSERT INTO `tipo_cliente` (`id_tipo_cliente`, `descripcion`, `porc_desc`) VALUES (3, 'Suscrito', 5.0);

# metodo_pago
INSERT INTO `metodo_pago` (`id_metodo_pago`, `descripcion`) VALUES (1, 'Debito/Prepago');
INSERT INTO `metodo_pago` (`id_metodo_pago`, `descripcion`) VALUES (2, 'Credito');
INSERT INTO `metodo_pago` (`id_metodo_pago`, `descripcion`) VALUES (3, 'Efectivo');
INSERT INTO `metodo_pago` (`id_metodo_pago`, `descripcion`) VALUES (4, 'App');

# categoria
INSERT INTO `categoria` (`id_categoria`, `descripcion`) VALUES (1, 'Maquillaje');
INSERT INTO `categoria` (`id_categoria`, `descripcion`) VALUES (2, 'Cuidado de la piel');
INSERT INTO `categoria` (`id_categoria`, `descripcion`) VALUES (3, 'Accesorios');
INSERT INTO `categoria` (`id_categoria`, `descripcion`) VALUES (4, 'Kits y Sets');
INSERT INTO `categoria` (`id_categoria`, `descripcion`) VALUES (5, 'Maquillaje Ojos');
INSERT INTO `categoria` (`id_categoria`, `descripcion`) VALUES (6, 'Maquillaje Labios');

# marca
INSERT INTO `marca` (`id_marca`, `descripcion`) VALUES (1, 'Benefit Cosmetics');
INSERT INTO `marca` (`id_marca`, `descripcion`) VALUES (2, 'Charlotte Tilbury');
INSERT INTO `marca` (`id_marca`, `descripcion`) VALUES (3, 'Clinique');
INSERT INTO `marca` (`id_marca`, `descripcion`) VALUES (4, 'Dior Beauty');
INSERT INTO `marca` (`id_marca`, `descripcion`) VALUES (5, 'Drunk Elephant');
INSERT INTO `marca` (`id_marca`, `descripcion`) VALUES (6, 'Estée Lauder');
INSERT INTO `marca` (`id_marca`, `descripcion`) VALUES (7, 'Fenty Beauty');
INSERT INTO `marca` (`id_marca`, `descripcion`) VALUES (8, 'Glossier');
INSERT INTO `marca` (`id_marca`, `descripcion`) VALUES (9, 'Kiehls');
INSERT INTO `marca` (`id_marca`, `descripcion`) VALUES (10, 'La Roche-Posay');
INSERT INTO `marca` (`id_marca`, `descripcion`) VALUES (11, 'MAC Cosmetics');
INSERT INTO `marca` (`id_marca`, `descripcion`) VALUES (12, 'Morphe');
INSERT INTO `marca` (`id_marca`, `descripcion`) VALUES (13, 'NARS');
INSERT INTO `marca` (`id_marca`, `descripcion`) VALUES (14, 'Rare Beauty');
INSERT INTO `marca` (`id_marca`, `descripcion`) VALUES (15, 'Supergoop!');
INSERT INTO `marca` (`id_marca`, `descripcion`) VALUES (16, 'Tarte');
INSERT INTO `marca` (`id_marca`, `descripcion`) VALUES (17, 'The Ordinary');
INSERT INTO `marca` (`id_marca`, `descripcion`) VALUES (18, 'Urban Decay');

# promocion
INSERT INTO `promocion` (`id_promocion`, `nombre`, `porc_desc`, `fecha_inicio`, `fecha_fin`, `activa`) VALUES (1, 'Cyber Day 2024', 20.0, '2024-10-21', '2024-10-23', TRUE);
INSERT INTO `promocion` (`id_promocion`, `nombre`, `porc_desc`, `fecha_inicio`, `fecha_fin`, `activa`) VALUES (2, 'Promo Aniversario Blush Bar', 15.0, '2025-03-01', '2025-03-15', TRUE);
INSERT INTO `promocion` (`id_promocion`, `nombre`, `porc_desc`, `fecha_inicio`, `fecha_fin`, `activa`) VALUES (3, 'Black Friday 2024', 25.0, '2024-11-29', '2024-12-01', TRUE);
INSERT INTO `promocion` (`id_promocion`, `nombre`, `porc_desc`, `fecha_inicio`, `fecha_fin`, `activa`) VALUES (4, 'Especial Día de la Madre 2025', 10.0, '2025-05-01', '2025-05-11', TRUE);
INSERT INTO `promocion` (`id_promocion`, `nombre`, `porc_desc`, `fecha_inicio`, `fecha_fin`, `activa`) VALUES (5, 'Liquidación de Invierno 2025', 30.0, '2025-07-20', '2025-07-31', TRUE);

# producto
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (101, 'Crema Lala Retro Whipped Drunk Elephant', 'Descripción de Crema Lala Retro Whipped Drunk Elephant', 60625, 140, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (102, 'Paleta de Sombras Tartelette Tarte', 'Descripción de Paleta de Sombras Tartelette Tarte', 41836, 119, 5, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (103, 'Base Forever Skin Glow Dior Beauty', 'Descripción de Base Forever Skin Glow Dior Beauty', 50472, 176, 1, 4);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (104, 'Base Even Better Clinique', 'Descripción de Base Even Better Clinique', 31730, 78, 1, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (105, 'Rubor Líquido Soft Pinch Rare Beauty', 'Descripción de Rubor Líquido Soft Pinch Rare Beauty', 24467, 184, 1, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (106, 'Sistema de 3 Pasos Clinique', 'Descripción de Sistema de 3 Pasos Clinique', 24517, 69, 4, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (107, 'Bálsamo Labial Addict Dior Beauty', 'Descripción de Bálsamo Labial Addict Dior Beauty', 34618, 64, 6, 4);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (108, 'Sérum de Día C-Firma Drunk Elephant', 'Descripción de Sérum de Día C-Firma Drunk Elephant', 75323, 164, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (109, 'Crema Lala Retro Whipped Drunk Elephant', 'Descripción de Crema Lala Retro Whipped Drunk Elephant', 58548, 137, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (110, 'Brillo Gloss Bomb Fenty Beauty', 'Descripción de Brillo Gloss Bomb Fenty Beauty', 20721, 137, 6, 7);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (111, 'Corrector Shape Tape Tarte', 'Descripción de Corrector Shape Tape Tarte', 25325, 177, 1, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (112, 'Sérum Advanced Night Repair Estée Lauder', 'Descripción de Sérum Advanced Night Repair Estée Lauder', 86002, 117, 2, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (113, 'Paleta de Sombras Naked Urban Decay', 'Descripción de Paleta de Sombras Naked Urban Decay', 44620, 79, 5, 18);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (114, 'Peeling Solution AHA 30% The Ordinary', 'Descripción de Peeling Solution AHA 30% The Ordinary', 10540, 47, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (115, 'Contorno de Ojos de Aguacate Kiehl''s', 'Descripción de Contorno de Ojos de Aguacate Kiehl''s', 31956, 69, 2, 9);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (116, 'Gel de Cejas Boy Brow Glossier', 'Descripción de Gel de Cejas Boy Brow Glossier', 17614, 25, 5, 8);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (117, 'Bálsamo Labial Addict Dior Beauty', 'Descripción de Bálsamo Labial Addict Dior Beauty', 37958, 88, 6, 4);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (118, 'Esponja de Maquillaje Rare Beauty', 'Descripción de Esponja de Maquillaje Rare Beauty', 8451, 109, 3, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (119, 'Sistema de 3 Pasos Clinique', 'Descripción de Sistema de 3 Pasos Clinique', 24742, 141, 4, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (120, 'Fijador Fix+ MAC Cosmetics', 'Descripción de Fijador Fix+ MAC Cosmetics', 21807, 77, 3, 11);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (121, 'Fijador de Maquillaje All Nighter Urban Decay', 'Descripción de Fijador de Maquillaje All Nighter Urban Decay', 30794, 75, 3, 18);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (122, 'Sérum Advanced Night Repair Estée Lauder', 'Descripción de Sérum Advanced Night Repair Estée Lauder', 86568, 47, 2, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (123, 'Sistema de 3 Pasos Clinique', 'Descripción de Sistema de 3 Pasos Clinique', 26505, 99, 4, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (124, 'Base Double Wear Estée Lauder', 'Descripción de Base Double Wear Estée Lauder', 41555, 47, 1, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (125, 'Paleta de Sombras Naked Urban Decay', 'Descripción de Paleta de Sombras Naked Urban Decay', 45180, 38, 5, 18);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (126, 'Sérum de Día C-Firma Drunk Elephant', 'Descripción de Sérum de Día C-Firma Drunk Elephant', 74588, 140, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (127, 'Labial Matte Revolution Pillow Talk Charlotte Tilbury', 'Descripción de Labial Matte Revolution Pillow Talk Charlotte Tilbury', 35359, 123, 6, 2);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (128, 'Rubor ''Orgasm'' NARS', 'Descripción de Rubor ''Orgasm'' NARS', 30730, 121, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (129, 'Corrector Radiante Cremoso NARS', 'Descripción de Corrector Radiante Cremoso NARS', 29333, 166, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (130, 'Bruma Fijadora Continuous Morphe', 'Descripción de Bruma Fijadora Continuous Morphe', 16484, 77, 3, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (131, 'Paleta de Sombras Naked Urban Decay', 'Descripción de Paleta de Sombras Naked Urban Decay', 44141, 129, 5, 18);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (132, 'Base Even Better Clinique', 'Descripción de Base Even Better Clinique', 30437, 162, 1, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (133, 'Base Pro Filt''r Soft Matte Fenty Beauty', 'Descripción de Base Pro Filt''r Soft Matte Fenty Beauty', 35011, 140, 1, 7);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (134, 'Fijador Fix+ MAC Cosmetics', 'Descripción de Fijador Fix+ MAC Cosmetics', 21463, 114, 3, 11);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (135, 'Bruma Fijadora Continuous Morphe', 'Descripción de Bruma Fijadora Continuous Morphe', 17454, 60, 3, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (136, 'Base Even Better Clinique', 'Descripción de Base Even Better Clinique', 33046, 36, 1, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (137, 'Agua Termal La Roche-Posay', 'Descripción de Agua Termal La Roche-Posay', 14193, 31, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (138, 'Iluminador Killawatt Fenty Beauty', 'Descripción de Iluminador Killawatt Fenty Beauty', 32854, 158, 1, 7);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (139, 'Base Forever Skin Glow Dior Beauty', 'Descripción de Base Forever Skin Glow Dior Beauty', 48400, 128, 1, 4);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (140, 'Corrector Shape Tape Tarte', 'Descripción de Corrector Shape Tape Tarte', 25474, 160, 1, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (141, 'Paleta de Sombras Tartelette Tarte', 'Descripción de Paleta de Sombras Tartelette Tarte', 39521, 133, 5, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (142, 'Agua Termal La Roche-Posay', 'Descripción de Agua Termal La Roche-Posay', 11323, 117, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (143, 'Paleta de Sombras Naked Urban Decay', 'Descripción de Paleta de Sombras Naked Urban Decay', 47270, 38, 5, 18);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (144, 'Crema Lala Retro Whipped Drunk Elephant', 'Descripción de Crema Lala Retro Whipped Drunk Elephant', 59844, 22, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (145, 'Brillo Gloss Bomb Fenty Beauty', 'Descripción de Brillo Gloss Bomb Fenty Beauty', 18741, 96, 6, 7);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (146, 'Gel de Cejas Boy Brow Glossier', 'Descripción de Gel de Cejas Boy Brow Glossier', 15081, 81, 5, 8);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (147, 'Base Ligera Liquid Touch Rare Beauty', 'Descripción de Base Ligera Liquid Touch Rare Beauty', 29865, 83, 1, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (148, 'Crema Lala Retro Whipped Drunk Elephant', 'Descripción de Crema Lala Retro Whipped Drunk Elephant', 58264, 45, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (149, 'Sistema de 3 Pasos Clinique', 'Descripción de Sistema de 3 Pasos Clinique', 24141, 168, 4, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (150, 'Máscara They''re Real! Benefit Cosmetics', 'Descripción de Máscara They''re Real! Benefit Cosmetics', 24527, 146, 5, 1);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (151, 'Base Even Better Clinique', 'Descripción de Base Even Better Clinique', 30082, 177, 1, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (152, 'Base Forever Skin Glow Dior Beauty', 'Descripción de Base Forever Skin Glow Dior Beauty', 51084, 58, 1, 4);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (153, 'Iluminador Killawatt Fenty Beauty', 'Descripción de Iluminador Killawatt Fenty Beauty', 31408, 26, 1, 7);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (154, 'Crema Effaclar Duo+ La Roche-Posay', 'Descripción de Crema Effaclar Duo+ La Roche-Posay', 25346, 91, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (155, 'Paleta de Sombras 35O Morphe', 'Descripción de Paleta de Sombras 35O Morphe', 25251, 199, 5, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (156, 'Set de Brochas Esenciales Morphe', 'Descripción de Set de Brochas Esenciales Morphe', 31384, 47, 3, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (157, 'Set de Brochas Esenciales Morphe', 'Descripción de Set de Brochas Esenciales Morphe', 31242, 70, 3, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (158, 'Sérum de Día C-Firma Drunk Elephant', 'Descripción de Sérum de Día C-Firma Drunk Elephant', 75626, 34, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (159, 'Bruma Fijadora Continuous Morphe', 'Descripción de Bruma Fijadora Continuous Morphe', 17308, 174, 3, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (160, 'Peeling Solution AHA 30% The Ordinary', 'Descripción de Peeling Solution AHA 30% The Ordinary', 9450, 103, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (161, 'Peeling Solution AHA 30% The Ordinary', 'Descripción de Peeling Solution AHA 30% The Ordinary', 9099, 55, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (162, 'Ácido Hialurónico 2% + B5 The Ordinary', 'Descripción de Ácido Hialurónico 2% + B5 The Ordinary', 9724, 107, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (163, 'Fijador Fix+ MAC Cosmetics', 'Descripción de Fijador Fix+ MAC Cosmetics', 22287, 78, 3, 11);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (164, 'Fijador de Maquillaje All Nighter Urban Decay', 'Descripción de Fijador de Maquillaje All Nighter Urban Decay', 28237, 130, 3, 18);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (165, 'Base Even Better Clinique', 'Descripción de Base Even Better Clinique', 30637, 48, 1, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (166, 'Crema Mágica Hidratante Charlotte Tilbury', 'Descripción de Crema Mágica Hidratante Charlotte Tilbury', 89544, 48, 2, 2);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (167, 'Base Pro Filt''r Soft Matte Fenty Beauty', 'Descripción de Base Pro Filt''r Soft Matte Fenty Beauty', 35137, 45, 1, 7);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (168, 'Base Even Better Clinique', 'Descripción de Base Even Better Clinique', 33125, 23, 1, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (169, 'Protector Solar Anthelios 50+ La Roche-Posay', 'Descripción de Protector Solar Anthelios 50+ La Roche-Posay', 21630, 61, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (170, 'Corrector Radiante Cremoso NARS', 'Descripción de Corrector Radiante Cremoso NARS', 27396, 48, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (171, 'Sérum Niacinamida 10% The Ordinary', 'Descripción de Sérum Niacinamida 10% The Ordinary', 9111, 20, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (172, 'Ácido Hialurónico 2% + B5 The Ordinary', 'Descripción de Ácido Hialurónico 2% + B5 The Ordinary', 10582, 111, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (173, 'Labial Retro Matte Ruby Woo MAC Cosmetics', 'Descripción de Labial Retro Matte Ruby Woo MAC Cosmetics', 17777, 45, 6, 11);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (174, 'Base Ligera Liquid Touch Rare Beauty', 'Descripción de Base Ligera Liquid Touch Rare Beauty', 31289, 166, 1, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (175, 'Base Ligera Liquid Touch Rare Beauty', 'Descripción de Base Ligera Liquid Touch Rare Beauty', 28332, 43, 1, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (176, 'Crema Lala Retro Whipped Drunk Elephant', 'Descripción de Crema Lala Retro Whipped Drunk Elephant', 60328, 72, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (177, 'Paleta de Sombras Naked Urban Decay', 'Descripción de Paleta de Sombras Naked Urban Decay', 47555, 165, 5, 18);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (178, 'Rubor ''Orgasm'' NARS', 'Descripción de Rubor ''Orgasm'' NARS', 32279, 161, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (179, 'Ácido Hialurónico 2% + B5 The Ordinary', 'Descripción de Ácido Hialurónico 2% + B5 The Ordinary', 11804, 47, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (180, 'Bruma Fijadora Continuous Morphe', 'Descripción de Bruma Fijadora Continuous Morphe', 16401, 133, 3, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (181, 'Gel para Cejas Gimme Brow+ Benefit Cosmetics', 'Descripción de Gel para Cejas Gimme Brow+ Benefit Cosmetics', 23808, 47, 5, 1);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (182, 'Base Pro Filt''r Soft Matte Fenty Beauty', 'Descripción de Base Pro Filt''r Soft Matte Fenty Beauty', 34563, 172, 1, 7);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (183, 'Limpiador Ultra Facial Kiehl''s', 'Descripción de Limpiador Ultra Facial Kiehl''s', 21742, 126, 2, 9);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (184, 'Sistema de 3 Pasos Clinique', 'Descripción de Sistema de 3 Pasos Clinique', 26020, 144, 4, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (185, 'Contorno de Ojos de Aguacate Kiehl''s', 'Descripción de Contorno de Ojos de Aguacate Kiehl''s', 31192, 178, 2, 9);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (186, 'Gel de Cejas Boy Brow Glossier', 'Descripción de Gel de Cejas Boy Brow Glossier', 15301, 84, 5, 8);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (187, 'Labial Retro Matte Ruby Woo MAC Cosmetics', 'Descripción de Labial Retro Matte Ruby Woo MAC Cosmetics', 18296, 24, 6, 11);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (188, 'Protector Solar Unseen SPF 40 Supergoop!', 'Descripción de Protector Solar Unseen SPF 40 Supergoop!', 35573, 97, 2, 15);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (189, 'Crema Lala Retro Whipped Drunk Elephant', 'Descripción de Crema Lala Retro Whipped Drunk Elephant', 59430, 120, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (190, 'Limpiador Ultra Facial Kiehl''s', 'Descripción de Limpiador Ultra Facial Kiehl''s', 18362, 126, 2, 9);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (191, 'Paleta de Sombras Tartelette Tarte', 'Descripción de Paleta de Sombras Tartelette Tarte', 38791, 161, 5, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (192, 'Rubor ''Orgasm'' NARS', 'Descripción de Rubor ''Orgasm'' NARS', 30818, 69, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (193, 'Bálsamo Labial Addict Dior Beauty', 'Descripción de Bálsamo Labial Addict Dior Beauty', 34526, 159, 6, 4);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (194, 'Ácido Hialurónico 2% + B5 The Ordinary', 'Descripción de Ácido Hialurónico 2% + B5 The Ordinary', 10117, 41, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (195, 'Fijador Fix+ MAC Cosmetics', 'Descripción de Fijador Fix+ MAC Cosmetics', 24283, 108, 3, 11);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (196, 'Base Light Reflecting NARS', 'Descripción de Base Light Reflecting NARS', 46217, 96, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (197, 'Glowscreen SPF 40 Supergoop!', 'Descripción de Glowscreen SPF 40 Supergoop!', 36070, 76, 2, 15);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (198, 'Sérum de Día C-Firma Drunk Elephant', 'Descripción de Sérum de Día C-Firma Drunk Elephant', 74937, 71, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (199, 'Sérum Advanced Night Repair Estée Lauder', 'Descripción de Sérum Advanced Night Repair Estée Lauder', 85567, 156, 2, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (200, 'Bálsamo Labial Addict Dior Beauty', 'Descripción de Bálsamo Labial Addict Dior Beauty', 35141, 126, 6, 4);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (201, 'Máscara They''re Real! Benefit Cosmetics', 'Descripción de Máscara They''re Real! Benefit Cosmetics', 24130, 31, 5, 1);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (202, 'Gel de Cejas Boy Brow Glossier', 'Descripción de Gel de Cejas Boy Brow Glossier', 17312, 135, 5, 8);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (203, 'Glowscreen SPF 40 Supergoop!', 'Descripción de Glowscreen SPF 40 Supergoop!', 36944, 94, 2, 15);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (204, 'Protector Solar Unseen SPF 40 Supergoop!', 'Descripción de Protector Solar Unseen SPF 40 Supergoop!', 33178, 153, 2, 15);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (205, 'Rubor en Crema Cloud Paint Glossier', 'Descripción de Rubor en Crema Cloud Paint Glossier', 17844, 110, 1, 8);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (206, 'Paleta de Sombras Naked Urban Decay', 'Descripción de Paleta de Sombras Naked Urban Decay', 45009, 133, 5, 18);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (207, 'Ácido Hialurónico 2% + B5 The Ordinary', 'Descripción de Ácido Hialurónico 2% + B5 The Ordinary', 11044, 79, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (208, 'Corrector Radiante Cremoso NARS', 'Descripción de Corrector Radiante Cremoso NARS', 28576, 124, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (209, 'Bálsamo Labial Addict Dior Beauty', 'Descripción de Bálsamo Labial Addict Dior Beauty', 35262, 70, 6, 4);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (210, 'Brillo Gloss Bomb Fenty Beauty', 'Descripción de Brillo Gloss Bomb Fenty Beauty', 18625, 50, 6, 7);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (211, 'Gel de Cejas Boy Brow Glossier', 'Descripción de Gel de Cejas Boy Brow Glossier', 17541, 192, 5, 8);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (212, 'Set de Brochas Esenciales Morphe', 'Descripción de Set de Brochas Esenciales Morphe', 28341, 135, 3, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (213, 'Brillo Gloss Bomb Fenty Beauty', 'Descripción de Brillo Gloss Bomb Fenty Beauty', 21519, 30, 6, 7);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (214, 'Fijador Fix+ MAC Cosmetics', 'Descripción de Fijador Fix+ MAC Cosmetics', 21595, 45, 3, 11);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (215, 'Brillo Gloss Bomb Fenty Beauty', 'Descripción de Brillo Gloss Bomb Fenty Beauty', 21459, 186, 6, 7);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (216, 'Bruma Fijadora Continuous Morphe', 'Descripción de Bruma Fijadora Continuous Morphe', 14218, 187, 3, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (217, 'Bruma Fijadora Continuous Morphe', 'Descripción de Bruma Fijadora Continuous Morphe', 17150, 149, 3, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (218, 'Polvos Airbrush Flawless Charlotte Tilbury', 'Descripción de Polvos Airbrush Flawless Charlotte Tilbury', 42442, 172, 1, 2);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (219, 'Base Light Reflecting NARS', 'Descripción de Base Light Reflecting NARS', 45675, 68, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (220, 'Bálsamo Labial Addict Dior Beauty', 'Descripción de Bálsamo Labial Addict Dior Beauty', 35996, 152, 6, 4);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (221, 'Rubor ''Orgasm'' NARS', 'Descripción de Rubor ''Orgasm'' NARS', 31958, 136, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (222, 'Polvos Airbrush Flawless Charlotte Tilbury', 'Descripción de Polvos Airbrush Flawless Charlotte Tilbury', 44043, 68, 1, 2);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (223, 'Máscara They''re Real! Benefit Cosmetics', 'Descripción de Máscara They''re Real! Benefit Cosmetics', 25061, 133, 5, 1);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (224, 'Paleta de Sombras Tartelette Tarte', 'Descripción de Paleta de Sombras Tartelette Tarte', 40133, 190, 5, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (225, 'Base Ligera Liquid Touch Rare Beauty', 'Descripción de Base Ligera Liquid Touch Rare Beauty', 30010, 130, 1, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (226, 'Crema Lala Retro Whipped Drunk Elephant', 'Descripción de Crema Lala Retro Whipped Drunk Elephant', 60146, 57, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (227, 'Base Pro Filt''r Soft Matte Fenty Beauty', 'Descripción de Base Pro Filt''r Soft Matte Fenty Beauty', 33542, 159, 1, 7);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (228, 'Base Forever Skin Glow Dior Beauty', 'Descripción de Base Forever Skin Glow Dior Beauty', 50799, 151, 1, 4);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (229, 'Ácido Hialurónico 2% + B5 The Ordinary', 'Descripción de Ácido Hialurónico 2% + B5 The Ordinary', 10378, 195, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (230, 'Labial Matte Revolution Pillow Talk Charlotte Tilbury', 'Descripción de Labial Matte Revolution Pillow Talk Charlotte Tilbury', 33983, 41, 6, 2);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (231, 'Contorno de Ojos de Aguacate Kiehl''s', 'Descripción de Contorno de Ojos de Aguacate Kiehl''s', 28330, 148, 2, 9);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (232, 'Paleta de Sombras 35O Morphe', 'Descripción de Paleta de Sombras 35O Morphe', 24654, 170, 5, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (233, 'Base Even Better Clinique', 'Descripción de Base Even Better Clinique', 31744, 151, 1, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (234, 'Gel para Cejas Gimme Brow+ Benefit Cosmetics', 'Descripción de Gel para Cejas Gimme Brow+ Benefit Cosmetics', 25326, 121, 5, 1);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (235, 'Base Ligera Liquid Touch Rare Beauty', 'Descripción de Base Ligera Liquid Touch Rare Beauty', 31944, 40, 1, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (236, 'Crema Effaclar Duo+ La Roche-Posay', 'Descripción de Crema Effaclar Duo+ La Roche-Posay', 26124, 110, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (237, 'Glowscreen SPF 40 Supergoop!', 'Descripción de Glowscreen SPF 40 Supergoop!', 35138, 143, 2, 15);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (238, 'Paleta de Sombras Tartelette Tarte', 'Descripción de Paleta de Sombras Tartelette Tarte', 41970, 136, 5, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (239, 'Corrector Radiante Cremoso NARS', 'Descripción de Corrector Radiante Cremoso NARS', 30415, 76, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (240, 'Protector Solar Unseen SPF 40 Supergoop!', 'Descripción de Protector Solar Unseen SPF 40 Supergoop!', 34689, 177, 2, 15);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (241, 'Sérum Advanced Night Repair Estée Lauder', 'Descripción de Sérum Advanced Night Repair Estée Lauder', 87271, 65, 2, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (242, 'Base Light Reflecting NARS', 'Descripción de Base Light Reflecting NARS', 46460, 139, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (243, 'Base Forever Skin Glow Dior Beauty', 'Descripción de Base Forever Skin Glow Dior Beauty', 49945, 194, 1, 4);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (244, 'Sistema de 3 Pasos Clinique', 'Descripción de Sistema de 3 Pasos Clinique', 26325, 40, 4, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (245, 'Protector Solar Anthelios 50+ La Roche-Posay', 'Descripción de Protector Solar Anthelios 50+ La Roche-Posay', 23653, 130, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (246, 'Ácido Hialurónico 2% + B5 The Ordinary', 'Descripción de Ácido Hialurónico 2% + B5 The Ordinary', 11820, 122, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (247, 'Primer POREfessional Benefit Cosmetics', 'Descripción de Primer POREfessional Benefit Cosmetics', 32956, 106, 1, 1);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (248, 'Corrector Shape Tape Tarte', 'Descripción de Corrector Shape Tape Tarte', 27827, 198, 1, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (249, 'Base Even Better Clinique', 'Descripción de Base Even Better Clinique', 30358, 23, 1, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (250, 'Paleta de Sombras Tartelette Tarte', 'Descripción de Paleta de Sombras Tartelette Tarte', 40405, 72, 5, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (251, 'Sérum de Día C-Firma Drunk Elephant', 'Descripción de Sérum de Día C-Firma Drunk Elephant', 76028, 108, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (252, 'Máscara They''re Real! Benefit Cosmetics', 'Descripción de Máscara They''re Real! Benefit Cosmetics', 25417, 122, 5, 1);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (253, 'Contorno de Ojos de Aguacate Kiehl''s', 'Descripción de Contorno de Ojos de Aguacate Kiehl''s', 30413, 40, 2, 9);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (254, 'Sistema de 3 Pasos Clinique', 'Descripción de Sistema de 3 Pasos Clinique', 26406, 151, 4, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (255, 'Sérum Advanced Night Repair Estée Lauder', 'Descripción de Sérum Advanced Night Repair Estée Lauder', 87526, 24, 2, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (256, 'Corrector Radiante Cremoso NARS', 'Descripción de Corrector Radiante Cremoso NARS', 27724, 182, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (257, 'Limpiador Ultra Facial Kiehl''s', 'Descripción de Limpiador Ultra Facial Kiehl''s', 19380, 111, 2, 9);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (258, 'Agua Termal La Roche-Posay', 'Descripción de Agua Termal La Roche-Posay', 13358, 92, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (259, 'Peeling Solution AHA 30% The Ordinary', 'Descripción de Peeling Solution AHA 30% The Ordinary', 12439, 157, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (260, 'Paleta de Sombras 35O Morphe', 'Descripción de Paleta de Sombras 35O Morphe', 25242, 90, 5, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (261, 'Peeling Solution AHA 30% The Ordinary', 'Descripción de Peeling Solution AHA 30% The Ordinary', 12437, 53, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (262, 'Esponja de Maquillaje Rare Beauty', 'Descripción de Esponja de Maquillaje Rare Beauty', 9374, 22, 3, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (263, 'Labial Retro Matte Ruby Woo MAC Cosmetics', 'Descripción de Labial Retro Matte Ruby Woo MAC Cosmetics', 20222, 64, 6, 11);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (264, 'Sérum Advanced Night Repair Estée Lauder', 'Descripción de Sérum Advanced Night Repair Estée Lauder', 85777, 21, 2, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (265, 'Sistema de 3 Pasos Clinique', 'Descripción de Sistema de 3 Pasos Clinique', 24273, 20, 4, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (266, 'Corrector Shape Tape Tarte', 'Descripción de Corrector Shape Tape Tarte', 27029, 78, 1, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (267, 'Corrector Radiante Cremoso NARS', 'Descripción de Corrector Radiante Cremoso NARS', 29386, 79, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (268, 'Fijador Fix+ MAC Cosmetics', 'Descripción de Fijador Fix+ MAC Cosmetics', 23779, 114, 3, 11);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (269, 'Corrector Shape Tape Tarte', 'Descripción de Corrector Shape Tape Tarte', 28469, 178, 1, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (270, 'Polvos Airbrush Flawless Charlotte Tilbury', 'Descripción de Polvos Airbrush Flawless Charlotte Tilbury', 45383, 96, 1, 2);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (271, 'Base Even Better Clinique', 'Descripción de Base Even Better Clinique', 31851, 71, 1, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (272, 'Rubor ''Orgasm'' NARS', 'Descripción de Rubor ''Orgasm'' NARS', 33154, 169, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (273, 'Corrector Shape Tape Tarte', 'Descripción de Corrector Shape Tape Tarte', 25363, 61, 1, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (274, 'Rubor en Crema Cloud Paint Glossier', 'Descripción de Rubor en Crema Cloud Paint Glossier', 18177, 47, 1, 8);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (275, 'Base Double Wear Estée Lauder', 'Descripción de Base Double Wear Estée Lauder', 41239, 137, 1, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (276, 'Contorno de Ojos de Aguacate Kiehl''s', 'Descripción de Contorno de Ojos de Aguacate Kiehl''s', 29128, 109, 2, 9);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (277, 'Labial Retro Matte Ruby Woo MAC Cosmetics', 'Descripción de Labial Retro Matte Ruby Woo MAC Cosmetics', 19033, 67, 6, 11);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (278, 'Ácido Hialurónico 2% + B5 The Ordinary', 'Descripción de Ácido Hialurónico 2% + B5 The Ordinary', 10443, 195, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (279, 'Crema Lala Retro Whipped Drunk Elephant', 'Descripción de Crema Lala Retro Whipped Drunk Elephant', 58095, 147, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (280, 'Sérum Advanced Night Repair Estée Lauder', 'Descripción de Sérum Advanced Night Repair Estée Lauder', 87557, 133, 2, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (281, 'Base Even Better Clinique', 'Descripción de Base Even Better Clinique', 30021, 183, 1, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (282, 'Bruma Fijadora Continuous Morphe', 'Descripción de Bruma Fijadora Continuous Morphe', 14329, 194, 3, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (283, 'Contorno de Ojos de Aguacate Kiehl''s', 'Descripción de Contorno de Ojos de Aguacate Kiehl''s', 29886, 75, 2, 9);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (284, 'Sérum Niacinamida 10% The Ordinary', 'Descripción de Sérum Niacinamida 10% The Ordinary', 9332, 22, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (285, 'Paleta de Sombras Tartelette Tarte', 'Descripción de Paleta de Sombras Tartelette Tarte', 41064, 97, 5, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (286, 'Rubor Líquido Soft Pinch Rare Beauty', 'Descripción de Rubor Líquido Soft Pinch Rare Beauty', 23891, 83, 1, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (287, 'Crema Effaclar Duo+ La Roche-Posay', 'Descripción de Crema Effaclar Duo+ La Roche-Posay', 25305, 135, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (288, 'Bálsamo Labial Addict Dior Beauty', 'Descripción de Bálsamo Labial Addict Dior Beauty', 34058, 147, 6, 4);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (289, 'Limpiador Ultra Facial Kiehl''s', 'Descripción de Limpiador Ultra Facial Kiehl''s', 18618, 123, 2, 9);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (290, 'Base Even Better Clinique', 'Descripción de Base Even Better Clinique', 30935, 150, 1, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (291, 'Glowscreen SPF 40 Supergoop!', 'Descripción de Glowscreen SPF 40 Supergoop!', 36664, 110, 2, 15);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (292, 'Crema Effaclar Duo+ La Roche-Posay', 'Descripción de Crema Effaclar Duo+ La Roche-Posay', 25729, 60, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (293, 'Polvos Airbrush Flawless Charlotte Tilbury', 'Descripción de Polvos Airbrush Flawless Charlotte Tilbury', 42471, 90, 1, 2);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (294, 'Limpiador Ultra Facial Kiehl''s', 'Descripción de Limpiador Ultra Facial Kiehl''s', 18815, 126, 2, 9);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (295, 'Esponja de Maquillaje Rare Beauty', 'Descripción de Esponja de Maquillaje Rare Beauty', 7790, 67, 3, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (296, 'Sistema de 3 Pasos Clinique', 'Descripción de Sistema de 3 Pasos Clinique', 26143, 43, 4, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (297, 'Paleta de Sombras 35O Morphe', 'Descripción de Paleta de Sombras 35O Morphe', 24085, 92, 5, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (298, 'Rubor Líquido Soft Pinch Rare Beauty', 'Descripción de Rubor Líquido Soft Pinch Rare Beauty', 22621, 185, 1, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (299, 'Fijador de Maquillaje All Nighter Urban Decay', 'Descripción de Fijador de Maquillaje All Nighter Urban Decay', 30520, 168, 3, 18);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (300, 'Fijador Fix+ MAC Cosmetics', 'Descripción de Fijador Fix+ MAC Cosmetics', 23042, 25, 3, 11);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (301, 'Bruma Fijadora Continuous Morphe', 'Descripción de Bruma Fijadora Continuous Morphe', 17483, 135, 3, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (302, 'Base Light Reflecting NARS', 'Descripción de Base Light Reflecting NARS', 45707, 167, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (303, 'Sérum Advanced Night Repair Estée Lauder', 'Descripción de Sérum Advanced Night Repair Estée Lauder', 87627, 36, 2, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (304, 'Base Light Reflecting NARS', 'Descripción de Base Light Reflecting NARS', 45382, 97, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (305, 'Sérum Advanced Night Repair Estée Lauder', 'Descripción de Sérum Advanced Night Repair Estée Lauder', 87462, 78, 2, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (306, 'Glowscreen SPF 40 Supergoop!', 'Descripción de Glowscreen SPF 40 Supergoop!', 34645, 122, 2, 15);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (307, 'Labial Retro Matte Ruby Woo MAC Cosmetics', 'Descripción de Labial Retro Matte Ruby Woo MAC Cosmetics', 17874, 130, 6, 11);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (308, 'Sérum de Día C-Firma Drunk Elephant', 'Descripción de Sérum de Día C-Firma Drunk Elephant', 77904, 166, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (309, 'Protector Solar Unseen SPF 40 Supergoop!', 'Descripción de Protector Solar Unseen SPF 40 Supergoop!', 36046, 194, 2, 15);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (310, 'Paleta de Sombras 35O Morphe', 'Descripción de Paleta de Sombras 35O Morphe', 26042, 181, 5, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (311, 'Sérum Advanced Night Repair Estée Lauder', 'Descripción de Sérum Advanced Night Repair Estée Lauder', 86401, 25, 2, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (312, 'Sérum Advanced Night Repair Estée Lauder', 'Descripción de Sérum Advanced Night Repair Estée Lauder', 85525, 173, 2, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (313, 'Rubor en Crema Cloud Paint Glossier', 'Descripción de Rubor en Crema Cloud Paint Glossier', 19655, 28, 1, 8);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (314, 'Máscara They''re Real! Benefit Cosmetics', 'Descripción de Máscara They''re Real! Benefit Cosmetics', 24476, 35, 5, 1);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (315, 'Máscara They''re Real! Benefit Cosmetics', 'Descripción de Máscara They''re Real! Benefit Cosmetics', 25691, 37, 5, 1);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (316, 'Rubor ''Orgasm'' NARS', 'Descripción de Rubor ''Orgasm'' NARS', 31919, 171, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (317, 'Ácido Hialurónico 2% + B5 The Ordinary', 'Descripción de Ácido Hialurónico 2% + B5 The Ordinary', 8913, 127, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (318, 'Peeling Solution AHA 30% The Ordinary', 'Descripción de Peeling Solution AHA 30% The Ordinary', 11812, 122, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (319, 'Corrector Shape Tape Tarte', 'Descripción de Corrector Shape Tape Tarte', 27621, 92, 1, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (320, 'Sérum Advanced Night Repair Estée Lauder', 'Descripción de Sérum Advanced Night Repair Estée Lauder', 85862, 24, 2, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (321, 'Esponja de Maquillaje Rare Beauty', 'Descripción de Esponja de Maquillaje Rare Beauty', 10062, 80, 3, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (322, 'Crema Lala Retro Whipped Drunk Elephant', 'Descripción de Crema Lala Retro Whipped Drunk Elephant', 60016, 151, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (323, 'Agua Termal La Roche-Posay', 'Descripción de Agua Termal La Roche-Posay', 12950, 60, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (324, 'Bruma Fijadora Continuous Morphe', 'Descripción de Bruma Fijadora Continuous Morphe', 14844, 155, 3, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (325, 'Rubor Líquido Soft Pinch Rare Beauty', 'Descripción de Rubor Líquido Soft Pinch Rare Beauty', 24828, 31, 1, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (326, 'Primer POREfessional Benefit Cosmetics', 'Descripción de Primer POREfessional Benefit Cosmetics', 32481, 84, 1, 1);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (327, 'Glowscreen SPF 40 Supergoop!', 'Descripción de Glowscreen SPF 40 Supergoop!', 34638, 155, 2, 15);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (328, 'Paleta de Sombras Naked Urban Decay', 'Descripción de Paleta de Sombras Naked Urban Decay', 44354, 171, 5, 18);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (329, 'Base Even Better Clinique', 'Descripción de Base Even Better Clinique', 33135, 173, 1, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (330, 'Rubor en Crema Cloud Paint Glossier', 'Descripción de Rubor en Crema Cloud Paint Glossier', 20827, 94, 1, 8);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (331, 'Sérum Advanced Night Repair Estée Lauder', 'Descripción de Sérum Advanced Night Repair Estée Lauder', 87468, 59, 2, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (332, 'Gel para Cejas Gimme Brow+ Benefit Cosmetics', 'Descripción de Gel para Cejas Gimme Brow+ Benefit Cosmetics', 24252, 189, 5, 1);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (333, 'Limpiador Ultra Facial Kiehl''s', 'Descripción de Limpiador Ultra Facial Kiehl''s', 18084, 40, 2, 9);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (334, 'Primer POREfessional Benefit Cosmetics', 'Descripción de Primer POREfessional Benefit Cosmetics', 31788, 80, 1, 1);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (335, 'Crema Mágica Hidratante Charlotte Tilbury', 'Descripción de Crema Mágica Hidratante Charlotte Tilbury', 89402, 167, 2, 2);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (336, 'Sérum Advanced Night Repair Estée Lauder', 'Descripción de Sérum Advanced Night Repair Estée Lauder', 87267, 60, 2, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (337, 'Sérum de Día C-Firma Drunk Elephant', 'Descripción de Sérum de Día C-Firma Drunk Elephant', 77977, 117, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (338, 'Bruma Fijadora Continuous Morphe', 'Descripción de Bruma Fijadora Continuous Morphe', 16990, 108, 3, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (339, 'Protector Solar Anthelios 50+ La Roche-Posay', 'Descripción de Protector Solar Anthelios 50+ La Roche-Posay', 23051, 142, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (340, 'Iluminador Killawatt Fenty Beauty', 'Descripción de Iluminador Killawatt Fenty Beauty', 31738, 82, 1, 7);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (341, 'Paleta de Sombras 35O Morphe', 'Descripción de Paleta de Sombras 35O Morphe', 25841, 75, 5, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (342, 'Sistema de 3 Pasos Clinique', 'Descripción de Sistema de 3 Pasos Clinique', 27896, 122, 4, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (343, 'Agua Termal La Roche-Posay', 'Descripción de Agua Termal La Roche-Posay', 13215, 91, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (344, 'Iluminador Killawatt Fenty Beauty', 'Descripción de Iluminador Killawatt Fenty Beauty', 34794, 103, 1, 7);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (345, 'Corrector Shape Tape Tarte', 'Descripción de Corrector Shape Tape Tarte', 26432, 117, 1, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (346, 'Crema Lala Retro Whipped Drunk Elephant', 'Descripción de Crema Lala Retro Whipped Drunk Elephant', 61335, 63, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (347, 'Base Light Reflecting NARS', 'Descripción de Base Light Reflecting NARS', 45226, 184, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (348, 'Base Ligera Liquid Touch Rare Beauty', 'Descripción de Base Ligera Liquid Touch Rare Beauty', 31865, 34, 1, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (349, 'Ácido Hialurónico 2% + B5 The Ordinary', 'Descripción de Ácido Hialurónico 2% + B5 The Ordinary', 11878, 51, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (350, 'Protector Solar Anthelios 50+ La Roche-Posay', 'Descripción de Protector Solar Anthelios 50+ La Roche-Posay', 20915, 177, 2, 10);

# cliente
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23432705, '4', 'Esteban', 'Javier', 'Cárdenas', 'Flores', '1964-10-18', 2, 8, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11598868, '9', 'Carolina', 'Paz', 'Molina', 'Ramírez', '1963-05-16', 1, 4, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21330611, '1', 'Patricio', 'Ricardo', 'Tapia', 'Vega', '1993-09-29', 2, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16058467, 'K', 'Bastián', 'Jorge', 'Espinoza', 'Muñoz', '1996-12-19', 2, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15116296, '7', 'Antonio', 'Cristian', 'Gutiérrez', 'García', '2000-01-25', 2, 2, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8713513, '6', 'Mateo', 'Manuel', 'Campos', 'Silva', '1988-07-19', 2, 3, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16794102, '8', 'Leonor', 'Amelia', 'Castillo', 'Molina', '1986-05-07', 1, 3, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23249014, '4', 'Pedro', 'Diego', 'Bravo', 'Rojas', '1972-12-23', 2, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (24528665, '1', 'Ignacio', 'Luciano', 'Sandoval', 'Espinoza', '1995-04-12', 2, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11074758, '6', 'Antonella', 'Dominga', 'Vergara', 'Araya', '1979-08-22', 1, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17741929, 'K', 'Leonor', 'Fernanda', 'Espinoza', 'Rodríguez', '1998-11-10', 1, 4, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16849878, '0', 'Gabriel', 'Felipe', 'Vera', 'Vásquez', '1976-01-16', 2, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15576565, '8', 'Isidora', 'Trinidad', 'Pérez', 'Silva', '1967-10-16', 1, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8802987, '9', 'Daniela', 'Pascal', 'González', 'Gutiérrez', '1987-10-20', 1, 1, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (24121947, 'K', 'Antonella', 'Ana', 'Jara', 'Fuentes', '1972-05-12', 1, 7, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20625454, '8', 'Luciano', 'Vicente', 'Riquelme', 'Pizarro', '1970-06-27', 2, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14212314, '2', 'Trinidad', 'Luciana', 'Sandoval', 'López', '1989-10-08', 1, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20569492, '7', 'Leonor', 'Daniela', 'Torres', 'Gómez', '2000-12-15', 1, 1, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16490602, '7', 'Luciana', 'Beatriz', 'Castillo', 'Jara', '1973-07-23', 1, 5, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8322588, '2', 'Leonor', 'Gabriela', 'Torres', 'Miranda', '1982-01-26', 1, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17788468, '5', 'Florencia', 'Sofía', 'Muñoz', 'Rodríguez', '1980-11-03', 1, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9047555, 'K', 'Amelia', 'Alejandra', 'Ramírez', 'Figueroa', '1969-07-07', 1, 3, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14777816, '3', 'Borja', 'Franco', 'Castro', 'Valenzuela', '1979-10-19', 2, 8, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15750161, '5', 'Rodrigo', 'Javier', 'Carrasco', 'Gómez', '1971-07-31', 2, 4, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22841480, '8', 'Facundo', 'Martín', 'Fuentes', 'Álvarez', '1964-06-27', 2, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18916071, '2', 'Ana', 'Luciana', 'Soto', 'Fernández', '1962-10-05', 1, 8, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9941991, '1', 'Paz', 'Fernanda', 'Campos', 'López', '1986-08-03', 1, 2, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12856545, '0', 'Olivia', 'Verónica', 'Vega', 'González', '1979-08-01', 1, 8, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10648897, '5', 'Daniel', 'Cristóbal', 'Morales', 'Núñez', '1997-12-13', 2, 8, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18114538, '2', 'Camila', 'Amparo', 'Silva', 'Gutiérrez', '1967-12-26', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11329702, '6', 'Verónica', 'Pascal', 'Díaz', 'Herrera', '1978-04-24', 1, 4, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14701048, '6', 'Leonor', 'Alejandra', 'Jara', 'Sepúlveda', '1972-07-18', 1, 2, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22752048, '5', 'Isabella', 'Emma', 'Flores', 'Herrera', '2002-12-17', 1, 9, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13991150, '4', 'Patricio', 'Liam', 'Araya', 'González', '2006-04-15', 2, 1, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13203266, '1', 'Gabriela', 'Amanda', 'Soto', 'Fuentes', '1966-01-15', 1, 5, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10024996, '0', 'Renata', 'Maite', 'Riquelme', 'Gutiérrez', '1961-05-04', 1, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13863609, '7', 'Alejandro', 'Pablo', 'Vergara', 'Soto', '1968-09-10', 2, 2, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8743725, '6', 'Anaís', 'Alejandra', 'Pizarro', 'Valenzuela', '2007-02-10', 1, 5, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21027149, 'K', 'Pedro', 'Bastián', 'Castillo', 'Gómez', '1988-06-04', 2, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7573789, '0', 'Alejandra', 'Sofía', 'Soto', 'Bravo', '2003-10-26', 1, 7, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9384676, '1', 'Luis', 'Liam', 'Muñoz', 'González', '1964-10-26', 2, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15532952, '1', 'Felipe', 'Liam', 'Valenzuela', 'Reyes', '1960-12-09', 2, 4, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13380886, '8', 'Cristian', 'Luis', 'Vera', 'Vera', '1978-12-12', 2, 1, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16365022, '3', 'Cristian', 'Emiliano', 'Bravo', 'Sánchez', '2006-09-12', 2, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7305911, '9', 'Matías', 'Agustín', 'Castillo', 'Silva', '1985-10-11', 2, 5, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22474893, '0', 'Gabriela', 'Gabriela', 'Cárdenas', 'Soto', '1982-12-20', 1, 5, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8289099, '8', 'Amelia', 'Anaís', 'Cortés', 'Pizarro', '1965-08-27', 1, 7, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17633655, '2', 'Ignacia', 'Agustina', 'Herrera', 'Espinoza', '1989-01-15', 1, 4, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7818213, 'K', 'Damián', 'Sebastián', 'Figueroa', 'Araya', '1978-02-26', 2, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16641839, '9', 'Constanza', 'Bárbara', 'Miranda', 'Miranda', '2006-03-27', 1, 5, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12075241, '3', 'Renata', 'Anaís', 'González', 'Álvarez', '1981-09-16', 1, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (6626531, '5', 'Valeria', 'Ignacia', 'Álvarez', 'Castro', '1996-10-04', 1, 5, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15022050, '5', 'Maite', 'Belén', 'Muñoz', 'Gutiérrez', '1973-01-29', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20523693, '7', 'Lía', 'Leonor', 'Tapia', 'Gutiérrez', '1962-08-22', 1, 1, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21480442, '5', 'Mía', 'Florencia', 'Jara', 'Martínez', '1991-11-03', 1, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17049113, '0', 'Martina', 'Daniela', 'Bravo', 'Flores', '1988-11-21', 1, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17608826, '5', 'Maite', 'Bárbara', 'Rojas', 'Carrasco', '2003-06-19', 1, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22562564, '6', 'Agustina', 'Trinidad', 'Flores', 'Herrera', '2000-01-28', 1, 9, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18931934, '7', 'Amelia', 'Leonor', 'García', 'Gutiérrez', '1974-11-12', 1, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12141352, '3', 'Felipe', 'Rodrigo', 'Tapia', 'López', '1965-05-21', 2, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20032892, '2', 'Fernanda', 'Isidora', 'Pizarro', 'Carrasco', '1992-04-11', 1, 9, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9499691, '0', 'María Paz', 'Agustina', 'Cárdenas', 'Sepúlveda', '2003-04-14', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15029440, '1', 'Camila', 'Catalina', 'Contreras', 'Herrera', '1985-01-25', 1, 5, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8167670, '4', 'Anaís', 'María Paz', 'Rodríguez', 'Sánchez', '2007-05-21', 1, 5, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14000124, '4', 'Josefa', 'Valentina', 'Pérez', 'González', '1982-12-29', 1, 5, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11553950, '7', 'Agustina', 'Gabriela', 'Miranda', 'Sepúlveda', '2000-08-29', 1, 9, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8188243, '6', 'Jacinta', 'Antonia', 'Castillo', 'Figueroa', '1974-12-27', 1, 4, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19040117, '0', 'Mía', 'Victoria', 'Figueroa', 'Rojas', '1961-02-16', 1, 8, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20542987, '5', 'Lía', 'Victoria', 'Sepúlveda', 'Rojas', '1967-07-28', 1, 8, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19602503, '0', 'José', 'Gaspar', 'Contreras', 'Álvarez', '2002-03-11', 2, 4, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9162736, '1', 'Verónica', 'Paulina', 'Sepúlveda', 'Fernández', '1996-09-19', 1, 8, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19245971, '0', 'Ignacia', 'Valentina', 'Vera', 'Soto', '1973-05-11', 1, 9, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18236669, '2', 'Paulina', 'Ana', 'Vergara', 'Contreras', '1999-07-27', 1, 5, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11495455, '1', 'Gaspar', 'Bruno', 'Castro', 'Molina', '1983-12-19', 2, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21460846, '4', 'Emma', 'Antonella', 'Torres', 'Pizarro', '1978-05-27', 1, 5, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21325906, '7', 'Trinidad', 'Amelia', 'Cortés', 'Flores', '1996-10-27', 1, 1, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10769865, '5', 'Ricardo', 'Pablo', 'Martínez', 'Sánchez', '2004-01-09', 2, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10645247, '4', 'Pascal', 'Amelia', 'Fuentes', 'Vásquez', '1989-02-25', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10723718, '6', 'Thiago', 'Juan Pablo', 'Herrera', 'Reyes', '1983-01-04', 2, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9061361, '8', 'Eloísa', 'Valentina', 'Valenzuela', 'Fuentes', '2003-08-15', 1, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16242950, '7', 'María Paz', 'Belén', 'Sandoval', 'Martínez', '1983-04-25', 1, 3, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18648926, '8', 'Dominga', 'Amparo', 'Sandoval', 'Molina', '1971-12-19', 1, 4, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16403039, '3', 'Gaspar', 'Emiliano', 'Castillo', 'Araya', '1988-11-25', 2, 1, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15996999, '1', 'Patricio', 'Fernando', 'Vergara', 'Martínez', '2006-02-28', 2, 9, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14422688, '7', 'Alonso', 'Franco', 'Araya', 'Carrasco', '1991-07-27', 2, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23653735, '8', 'Julieta', 'Luciana', 'Díaz', 'Rojas', '1973-06-09', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23690120, '3', 'Antonella', 'Mía', 'Rodríguez', 'Contreras', '1986-05-03', 1, 5, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18720339, '2', 'Rocío', 'Martina', 'Jara', 'Fuentes', '1974-06-25', 1, 5, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7152747, '6', 'León', 'Pedro', 'Vergara', 'Bravo', '1998-07-06', 2, 5, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19605979, '2', 'Luciana', 'Rocío', 'Rojas', 'García', '2007-02-12', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13030375, '7', 'Florencia', 'Emma', 'Fernández', 'Gutiérrez', '1973-10-07', 1, 3, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23692459, '9', 'Isidora', 'Renata', 'Sepúlveda', 'Araya', '1962-10-25', 1, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22536054, '5', 'Amparo', 'Javiera', 'Riquelme', 'Castillo', '1993-07-02', 1, 1, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21621998, '8', 'Valeria', 'Elena', 'Vergara', 'Gómez', '1998-04-24', 1, 2, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15520193, '2', 'Elena', 'Consuelo', 'Cortés', 'Cortés', '1967-08-23', 1, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17594194, '0', 'Paulina', 'Valeria', 'Contreras', 'Soto', '2004-01-19', 1, 9, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21903749, 'K', 'Cristian', 'Luciano', 'Silva', 'Álvarez', '1989-11-01', 2, 3, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21895059, '0', 'Patricio', 'Pedro', 'Rivera', 'Cárdenas', '1962-02-19', 2, 3, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16761841, '3', 'Antonia', 'Pascal', 'Figueroa', 'Rojas', '1988-01-13', 1, 4, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17559583, 'K', 'Eloísa', 'Martina', 'Pizarro', 'Cárdenas', '2002-04-16', 1, 3, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11326969, '3', 'Agustina', 'Celeste', 'Araya', 'Flores', '1974-05-20', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7049174, '5', 'Agustina', 'Carolina', 'Vera', 'Gutiérrez', '1985-01-30', 1, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23761234, '5', 'Belén', 'Luciana', 'Jara', 'Araya', '1996-02-04', 1, 9, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12895587, '9', 'Consuelo', 'Sofía', 'Fuentes', 'Valenzuela', '2003-09-07', 1, 3, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7127706, '2', 'Fernanda', 'Amelia', 'Espinoza', 'Martínez', '1985-12-15', 1, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (6549300, '4', 'Facundo', 'Miguel', 'Campos', 'Núñez', '2002-10-14', 2, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7223499, '5', 'Ángel', 'Francisco', 'Vera', 'Cortés', '1983-05-05', 2, 8, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11397346, '3', 'Felipe', 'Simón', 'Cortés', 'Figueroa', '1987-09-24', 2, 1, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15431514, '4', 'Sofía', 'María Paz', 'Orellana', 'Espinoza', '1974-07-09', 1, 9, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15454026, '1', 'Patricio', 'Francisco', 'Soto', 'Araya', '1976-10-02', 2, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23559293, '2', 'Agustina', 'Florencia', 'García', 'Vega', '1977-11-03', 1, 1, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15419183, '6', 'Verónica', 'Elena', 'Jara', 'Araya', '1988-05-28', 1, 2, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7372723, '5', 'María José', 'Consuelo', 'Campos', 'Pérez', '1989-12-20', 1, 4, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19476479, '0', 'Victoria', 'Rocío', 'Silva', 'Fuentes', '1990-08-30', 1, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15018361, '8', 'Antonia', 'Monserrat', 'Núñez', 'Cortés', '1984-12-30', 1, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22476316, '6', 'Rocío', 'Isidora', 'Gómez', 'Sandoval', '1978-02-16', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13903725, '1', 'Mía', 'Mía', 'Pizarro', 'Orellana', '1985-11-07', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21413596, '5', 'Celeste', 'Laura', 'Campos', 'Vásquez', '1980-12-01', 1, 4, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23142237, '4', 'Verónica', 'Amanda', 'Silva', 'Ramírez', '2000-01-24', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17317212, '5', 'Paz', 'Laura', 'Carrasco', 'Sánchez', '2001-05-14', 1, 8, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7792300, '4', 'Javiera', 'Maite', 'Contreras', 'Vergara', '1994-02-19', 1, 8, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22079036, '3', 'Andrea', 'Eloísa', 'Fernández', 'Reyes', '1977-10-06', 1, 8, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19701413, 'K', 'María Paz', 'Martina', 'García', 'Contreras', '2003-04-06', 1, 3, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22568801, 'K', 'Florencia', 'Lía', 'Pérez', 'Tapia', '1995-04-13', 1, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22399625, '6', 'Elena', 'Amanda', 'Riquelme', 'Riquelme', '1976-02-29', 1, 9, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16603086, '2', 'Dominga', 'María José', 'Riquelme', 'Jara', '1981-08-12', 1, 8, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18143219, '5', 'Beatriz', 'Javiera', 'Sánchez', 'Castro', '1994-05-02', 1, 7, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10862471, 'K', 'Luciana', 'Fernanda', 'Tapia', 'Orellana', '1998-03-11', 1, 5, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11095540, '5', 'Ricardo', 'Facundo', 'Miranda', 'Miranda', '1967-12-15', 2, 2, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17307651, '7', 'Monserrat', 'Maite', 'Pizarro', 'Jara', '2003-11-15', 1, 5, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21281726, '0', 'Elena', 'Belén', 'Tapia', 'Soto', '1991-09-13', 1, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22148796, '6', 'Ana', 'Alejandra', 'Araya', 'Espinoza', '1987-12-26', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23019547, '1', 'Eloísa', 'Celeste', 'Rojas', 'Rojas', '1966-01-09', 1, 3, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13763728, '6', 'Valentina', 'Antonia', 'Vega', 'Sánchez', '1966-10-23', 1, 8, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7745288, '5', 'Esteban', 'Miguel', 'Castro', 'Molina', '1963-07-24', 2, 9, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (24739229, '7', 'Monserrat', 'Rocío', 'Pizarro', 'Martínez', '1978-03-13', 1, 3, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9693511, '0', 'Paulina', 'Maite', 'Castro', 'Molina', '1976-02-29', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18348340, '4', 'Ana', 'Trinidad', 'Rojas', 'Orellana', '1967-02-09', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15562520, '1', 'Fernando', 'Fernando', 'Gómez', 'Gutiérrez', '1987-06-09', 2, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21386320, '7', 'Francisca', 'Antonella', 'Sánchez', 'Silva', '1988-08-10', 1, 2, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7645426, '4', 'Alejandra', 'Emilia', 'Vera', 'Castillo', '1974-11-24', 1, 2, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15578043, '6', 'Simón', 'Patricio', 'Pérez', 'Díaz', '2006-07-18', 2, 4, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22127775, '9', 'Olivia', 'Victoria', 'Valenzuela', 'Orellana', '1995-03-03', 1, 1, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12568193, 'K', 'Santiago', 'Joaquín', 'Torres', 'Rodríguez', '1989-01-22', 2, 9, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15451442, '2', 'Emma', 'Francisca', 'Álvarez', 'Carrasco', '1990-03-11', 1, 3, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8800481, '7', 'Florencia', 'Valentina', 'Díaz', 'Espinoza', '1960-06-29', 1, 5, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21676843, '4', 'Anaís', 'Amanda', 'Núñez', 'Vásquez', '2000-10-23', 1, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15418181, '4', 'Jacinta', 'Sofía Antonia', 'Rodríguez', 'Bravo', '2006-06-19', 1, 4, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18970477, '1', 'Trinidad', 'Catalina', 'Sandoval', 'Araya', '1967-01-12', 1, 8, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13893899, '9', 'Catalina', 'Fernanda', 'Vergara', 'Ramírez', '1999-07-30', 1, 8, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14470206, '9', 'Eloísa', 'Isidora', 'Sánchez', 'Muñoz', '1976-02-02', 1, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12492037, 'K', 'Elena', 'Valeria', 'Vergara', 'Miranda', '1978-05-01', 1, 1, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18584380, '7', 'Diego', 'Francisco', 'Rivera', 'Jara', '1974-01-11', 2, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18321861, '1', 'Martina', 'Leonor', 'Tapia', 'López', '1983-11-07', 1, 3, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15813452, '7', 'Gabriela', 'Mía', 'Valenzuela', 'Soto', '1999-05-18', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19044502, 'K', 'Eloísa', 'Celeste', 'Espinoza', 'Vega', '1967-05-16', 1, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14812507, '4', 'Rafaela', 'Paulina', 'Álvarez', 'García', '1975-11-28', 1, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22238356, '0', 'Olivia', 'Antonia', 'Cortés', 'Sandoval', '1997-10-29', 1, 7, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9160703, '4', 'Amelia', 'Javiera', 'Contreras', 'Orellana', '1995-10-07', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11668289, '3', 'Beatriz', 'Martina', 'Carrasco', 'Araya', '1979-11-06', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14542389, '9', 'María José', 'Antonia', 'Valenzuela', 'Riquelme', '1984-06-24', 1, 4, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9388127, '3', 'Florencia', 'Gabriela', 'Castro', 'Núñez', '1987-06-30', 1, 2, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21236875, 'K', 'Emilia', 'Paulina', 'Castro', 'Cortés', '1982-12-26', 1, 4, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20432101, '9', 'Josefa', 'Luciana', 'Castro', 'Campos', '1991-12-23', 1, 8, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23715924, '1', 'Pascal', 'Celeste', 'Jara', 'Contreras', '2002-01-08', 1, 2, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13738320, '9', 'Paulina', 'Elena', 'Pérez', 'Vega', '1979-10-13', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17800455, '7', 'Monserrat', 'Andrea', 'Araya', 'Rojas', '1990-05-04', 1, 1, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11647735, '1', 'Ana', 'Amanda', 'Rivera', 'Morales', '2002-10-06', 1, 5, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9328084, '9', 'Patricio', 'Facundo', 'Gutiérrez', 'Tapia', '1961-05-30', 2, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11219514, '9', 'Pascal', 'Emma', 'Cortés', 'Fernández', '1967-01-15', 1, 9, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18716077, '4', 'Thiago', 'Simón', 'Espinoza', 'Sánchez', '2000-06-21', 2, 5, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16984636, '7', 'Josefa', 'Alejandra', 'Vergara', 'Martínez', '1976-11-24', 1, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16071297, 'K', 'Rafaela', 'Belén', 'Soto', 'Figueroa', '1996-07-07', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16747736, '4', 'Rodrigo', 'Rodrigo', 'Castillo', 'Sánchez', '1969-07-30', 2, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8457139, '3', 'Javiera', 'Amelia', 'Rojas', 'Torres', '1963-12-21', 1, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14127438, '4', 'Maximiliano', 'Mateo', 'Sandoval', 'López', '1993-07-01', 2, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16418651, '2', 'Sofía Antonia', 'Pascal', 'Cortés', 'Fuentes', '1969-01-24', 1, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19099261, '6', 'Rocío', 'Belén', 'Castillo', 'Martínez', '2004-10-29', 1, 5, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22495396, '8', 'Manuel', 'Manuel', 'Molina', 'Carrasco', '2001-09-01', 2, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7033387, '2', 'Andrea', 'Josefa', 'Vega', 'Campos', '1992-08-20', 1, 5, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10450414, '0', 'Victoria', 'Antonella', 'Silva', 'Vásquez', '1960-10-07', 1, 9, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12011563, '4', 'Celeste', 'Eloísa', 'Vera', 'López', '1981-12-23', 1, 5, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (24834289, '7', 'Santiago', 'Pablo', 'Vergara', 'Ramírez', '1991-02-13', 2, 7, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11062596, '0', 'Ignacia', 'Isabella', 'Valenzuela', 'Flores', '1966-12-03', 1, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23321021, '8', 'Vicente', 'Tomás', 'Bravo', 'Molina', '2003-08-25', 2, 4, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11971747, '7', 'Eloísa', 'Monserrat', 'Campos', 'Silva', '1963-06-01', 1, 9, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13367735, '6', 'Catalina', 'Isabella', 'Vera', 'González', '1981-10-27', 1, 8, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19862271, '0', 'Anaís', 'Trinidad', 'Miranda', 'Martínez', '2004-07-11', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20080197, '0', 'Monserrat', 'Catalina', 'Muñoz', 'López', '1965-05-17', 1, 9, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16094361, '0', 'Fernando', 'Luis', 'Fernández', 'Núñez', '1974-12-07', 2, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11564881, '0', 'Thiago', 'David', 'Riquelme', 'Soto', '2004-04-18', 2, 1, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20214895, '6', 'Beatriz', 'Isidora', 'Cortés', 'Cortés', '1974-05-12', 1, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18074650, '1', 'Amanda', 'Daniela', 'Ramírez', 'Rodríguez', '2005-04-12', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8731592, '4', 'Juan Pablo', 'Ángel', 'Muñoz', 'Vergara', '1962-04-18', 2, 4, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14548247, 'K', 'Benjamín', 'Felipe', 'Tapia', 'Molina', '1995-12-22', 2, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11395606, '2', 'Rodrigo', 'Juan Pablo', 'Carrasco', 'Tapia', '1994-06-21', 2, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18362647, '7', 'Facundo', 'Patricio', 'Fuentes', 'Silva', '1994-11-28', 2, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23844543, '4', 'Paulina', 'Celeste', 'Rodríguez', 'Rojas', '1969-03-09', 1, 4, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18783810, 'K', 'Jacinta', 'Alejandra', 'Vera', 'Araya', '1996-09-10', 1, 2, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18325757, '9', 'Rocío', 'Renata', 'Vergara', 'Soto', '1999-12-13', 1, 8, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12135973, '1', 'Manuel', 'Vicente', 'Fernández', 'Gómez', '1996-06-09', 2, 5, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18297208, '8', 'Mateo', 'Luciano', 'Cortés', 'Vergara', '1971-03-02', 2, 2, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13809134, '1', 'Ricardo', 'Rodrigo', 'García', 'Campos', '1961-01-05', 2, 4, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17191421, '3', 'Antonella', 'Victoria', 'Valenzuela', 'Figueroa', '1989-12-18', 1, 4, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16042835, 'K', 'Trinidad', 'Carolina', 'Espinoza', 'Jara', '1999-04-20', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21701886, '2', 'Belén', 'Anaís', 'Gutiérrez', 'Bravo', '1996-06-02', 1, 9, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19263437, '7', 'Isabella', 'Isabella', 'García', 'Morales', '1976-02-08', 1, 9, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19341504, '0', 'Patricio', 'Clemente', 'Reyes', 'Silva', '1993-11-17', 2, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10935421, 'K', 'Javiera', 'Constanza', 'Gutiérrez', 'Soto', '1973-06-23', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12417402, '3', 'Trinidad', 'María Paz', 'Herrera', 'Campos', '1964-11-23', 1, 9, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18769513, '9', 'Beatriz', 'Rocío', 'Sandoval', 'Martínez', '1986-12-19', 1, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19973850, 'K', 'Luis', 'Cristóbal', 'Castro', 'Espinoza', '1998-01-24', 2, 9, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10606500, '4', 'Fernando', 'Vicente', 'Pizarro', 'Morales', '1998-10-08', 2, 5, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11150464, '4', 'Isidora', 'Celeste', 'Figueroa', 'Fernández', '1993-10-15', 1, 8, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19514935, '6', 'Antonia', 'Paulina', 'Vera', 'Fernández', '1982-06-18', 1, 3, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22662199, '7', 'Bárbara', 'Consuelo', 'Sánchez', 'Contreras', '1966-12-13', 1, 5, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7726277, '6', 'Olivia', 'Isabella', 'Figueroa', 'Araya', '1964-06-25', 1, 9, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9145235, '9', 'Constanza', 'Mía', 'Sandoval', 'Campos', '1965-01-25', 1, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18387219, '2', 'Luciano', 'Patricio', 'Fuentes', 'Castro', '1992-03-19', 2, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7880842, 'K', 'Gabriela', 'Martina', 'Silva', 'Rojas', '1978-05-27', 1, 8, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10170463, '7', 'Antonia', 'Catalina', 'Soto', 'Cárdenas', '1972-03-11', 1, 2, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (24266257, '1', 'Carolina', 'Antonella', 'Pizarro', 'Vásquez', '1979-03-24', 1, 4, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14190341, '1', 'Josefa', 'Emilia', 'Molina', 'Fuentes', '1977-03-07', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8987771, '7', 'Monserrat', 'Gabriela', 'Tapia', 'Orellana', '1994-01-28', 1, 9, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23962622, 'K', 'Laura', 'Catalina', 'Martínez', 'Araya', '1976-12-25', 1, 2, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8821508, '7', 'Mía', 'María José', 'Pizarro', 'Rojas', '1976-02-02', 1, 8, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20616053, '5', 'Olivia', 'Elena', 'García', 'Pizarro', '1986-08-06', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14665482, '7', 'Liam', 'Jorge', 'Castillo', 'Muñoz', '1972-11-17', 2, 3, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18712302, 'K', 'Victoria', 'Agustina', 'Espinoza', 'Bravo', '1971-03-12', 1, 3, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19672770, '1', 'Florencia', 'Amelia', 'Soto', 'Sandoval', '1986-07-24', 1, 1, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22103927, '0', 'Catalina', 'Elena', 'Martínez', 'Soto', '1974-07-23', 1, 4, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12544984, '0', 'Isabella', 'Belén', 'Morales', 'Molina', '1963-12-04', 1, 3, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14036047, '3', 'Rodrigo', 'Lucas', 'Rivera', 'Sánchez', '1972-08-30', 2, 5, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19922159, '0', 'Amparo', 'Leonor', 'Molina', 'Miranda', '1991-11-30', 1, 3, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22284402, '9', 'Victoria', 'Ana', 'Figueroa', 'Flores', '1962-11-26', 1, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18305291, '8', 'Fernando', 'Juan Pablo', 'Ramírez', 'Pizarro', '1963-06-04', 2, 4, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19745012, '6', 'Camila', 'Amparo', 'Silva', 'Cárdenas', '1997-07-16', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15880432, '8', 'Fernanda', 'Pascal', 'Soto', 'Muñoz', '1977-02-20', 1, 2, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21397229, '4', 'Leonor', 'Victoria', 'Gutiérrez', 'Núñez', '1960-12-18', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21933732, '9', 'Dominga', 'Javiera', 'Campos', 'Araya', '2000-02-08', 1, 4, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (24805182, '5', 'Alonso', 'Daniel', 'Vergara', 'Campos', '1977-03-11', 2, 9, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11285442, '8', 'Thiago', 'David', 'Pérez', 'Contreras', '1963-06-11', 2, 5, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22214703, '4', 'Amelia', 'Rafaela', 'Reyes', 'Contreras', '1965-01-03', 1, 1, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9761952, '2', 'Maite', 'Olivia', 'Reyes', 'Rivera', '1961-10-25', 1, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11640199, '1', 'Trinidad', 'Daniela', 'Vásquez', 'Cárdenas', '2004-07-15', 1, 9, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21466707, 'K', 'Emma', 'Martina', 'Sánchez', 'Rojas', '1989-11-16', 1, 9, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (24753534, '9', 'Carolina', 'Martina', 'Riquelme', 'Jara', '1979-09-26', 1, 5, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17062569, '2', 'Matías', 'Liam', 'Morales', 'Pizarro', '1990-10-03', 2, 2, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17658778, '4', 'Josefa', 'Consuelo', 'Vergara', 'Espinoza', '1973-07-12', 1, 1, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11675249, '2', 'Sofía Antonia', 'Isabella', 'Jara', 'Morales', '1997-07-27', 1, 9, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20775940, '6', 'Isabella', 'Anaís', 'Castro', 'Jara', '1966-03-04', 1, 4, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20931146, '1', 'Luciano', 'Miguel', 'Pérez', 'Sánchez', '1998-11-12', 2, 8, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10384683, '8', 'Gabriela', 'Rafaela', 'Gutiérrez', 'Gutiérrez', '1967-11-07', 1, 5, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23134526, '4', 'Patricio', 'Alejandro', 'Vásquez', 'González', '1968-03-16', 2, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18148211, '7', 'Victoria', 'Daniela', 'García', 'Pérez', '1971-12-03', 1, 8, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15430142, '9', 'Eloísa', 'Emma', 'Fuentes', 'Reyes', '2001-11-25', 1, 2, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19457043, '0', 'Ignacia', 'Eloísa', 'Muñoz', 'Jara', '1988-11-12', 1, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14072155, '7', 'Amanda', 'Florencia', 'Rivera', 'Silva', '1995-07-05', 1, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20174990, '5', 'Agustina', 'Florencia', 'Díaz', 'Gutiérrez', '2002-04-05', 1, 9, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11715850, '0', 'Martina', 'Jacinta', 'Gómez', 'Riquelme', '1968-07-26', 1, 9, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16013309, '0', 'Sofía Antonia', 'Consuelo', 'Soto', 'Vergara', '1997-06-07', 1, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13312176, '5', 'Isidora', 'Daniela', 'Sandoval', 'Silva', '1978-11-24', 1, 4, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18717356, '6', 'Agustín', 'Gabriel', 'Gutiérrez', 'Reyes', '1962-09-09', 2, 5, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (24739397, '8', 'Alonso', 'Mateo', 'Muñoz', 'Vásquez', '2007-03-16', 2, 4, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7382287, '4', 'Trinidad', 'Agustina', 'Torres', 'Castillo', '2003-03-11', 1, 5, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15316622, '6', 'Sofía', 'Valentina', 'Valenzuela', 'Vega', '1984-07-07', 1, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11593717, '0', 'Facundo', 'Javier', 'Contreras', 'Gómez', '1973-10-25', 2, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (24732931, '5', 'Beatriz', 'Anaís', 'Muñoz', 'Figueroa', '1970-11-08', 1, 4, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21913030, '9', 'Ángel', 'Rodrigo', 'Fuentes', 'Fuentes', '1988-05-18', 2, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17412447, '7', 'Paulina', 'Anaís', 'Figueroa', 'Gutiérrez', '1970-09-18', 1, 9, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14873924, '2', 'Victoria', 'Florencia', 'Díaz', 'Sandoval', '2000-03-15', 1, 9, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9333002, '1', 'Trinidad', 'Daniela', 'Rivera', 'Fernández', '1963-07-09', 1, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16055551, '3', 'Anaís', 'Pascal', 'Vásquez', 'Núñez', '1980-07-14', 1, 5, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18486027, '9', 'Celeste', 'Mía', 'Herrera', 'Gómez', '1968-01-13', 1, 5, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13358224, 'K', 'Victoria', 'Anaís', 'Riquelme', 'Miranda', '1985-03-16', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10456934, 'K', 'Catalina', 'Paulina', 'Araya', 'Figueroa', '1970-07-06', 1, 9, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11933319, '9', 'Verónica', 'Dominga', 'Cárdenas', 'Herrera', '1968-07-24', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22842661, 'K', 'Bastián', 'Renato', 'Pérez', 'Díaz', '1995-03-25', 2, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13111240, '8', 'Beatriz', 'María José', 'Morales', 'Vega', '1976-05-19', 1, 5, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (24923043, 'K', 'Lía', 'María José', 'Rivera', 'Vergara', '1976-01-26', 1, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18887268, '9', 'Beatriz', 'Lía', 'Pérez', 'Vera', '1981-11-18', 1, 9, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16270094, '4', 'Ignacia', 'Amelia', 'Cortés', 'Núñez', '1993-12-26', 1, 3, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22829240, '0', 'Luciana', 'Javiera', 'Araya', 'Fernández', '1987-06-16', 1, 2, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11368789, '4', 'Celeste', 'Consuelo', 'Martínez', 'Araya', '1979-06-03', 1, 9, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9599143, '2', 'Paz', 'Beatriz', 'Vergara', 'González', '1978-10-07', 1, 9, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18261227, '8', 'Catalina', 'Amelia', 'Rodríguez', 'Sandoval', '1962-09-20', 1, 9, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23136434, 'K', 'Felipe', 'Bruno', 'Vega', 'Flores', '1998-04-03', 2, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11777686, '7', 'Verónica', 'Amparo', 'García', 'Castillo', '2000-12-29', 1, 1, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13981577, '7', 'Carolina', 'Elena', 'Riquelme', 'Jara', '1994-04-21', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20801516, '8', 'Gabriela', 'Josefa', 'Carrasco', 'Reyes', '1972-06-27', 1, 5, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8310981, '5', 'Mía', 'Belén', 'Morales', 'Ramírez', '1968-05-08', 1, 1, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22119900, '6', 'David', 'Felipe', 'Fernández', 'Martínez', '1997-10-19', 2, 2, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16697606, '5', 'Juan Pablo', 'Borja', 'Sepúlveda', 'Morales', '1979-10-04', 2, 4, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10810817, '7', 'Josefa', 'Mía', 'Espinoza', 'Rivera', '1992-12-26', 1, 9, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23535805, '0', 'Fernando', 'Manuel', 'Pizarro', 'Reyes', '1998-12-21', 2, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7073090, '1', 'Daniela', 'María José', 'Campos', 'Torres', '1964-04-13', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14176134, 'K', 'Leonor', 'Jacinta', 'Tapia', 'Silva', '1961-03-20', 1, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15672821, '7', 'Amelia', 'Leonor', 'Orellana', 'Vásquez', '1974-11-23', 1, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19810921, '5', 'Gabriela', 'Monserrat', 'Molina', 'Álvarez', '1963-02-25', 1, 2, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14383316, 'K', 'Catalina', 'María Paz', 'Gutiérrez', 'Sepúlveda', '1987-10-28', 1, 5, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11045667, '0', 'Antonella', 'Julieta', 'Soto', 'Martínez', '1984-02-10', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17510894, '7', 'Rafaela', 'Emma', 'Álvarez', 'Morales', '1996-05-30', 1, 1, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9304849, '0', 'Amelia', 'Belén', 'Cárdenas', 'González', '1992-12-16', 1, 2, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14724171, '2', 'Leonor', 'Valeria', 'Tapia', 'González', '1973-07-01', 1, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8201573, '6', 'Eloísa', 'Dominga', 'Carrasco', 'Díaz', '1983-02-10', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17773770, '4', 'Florencia', 'Martina', 'González', 'García', '2004-11-02', 1, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19415989, '7', 'Pedro', 'Emiliano', 'Vega', 'García', '1979-02-22', 2, 7, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20077640, '2', 'Florencia', 'Elena', 'Ramírez', 'Rojas', '2007-05-12', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18020089, '4', 'Martina', 'Agustina', 'Castillo', 'Araya', '1980-01-18', 1, 4, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8254301, '5', 'Gabriela', 'Dominga', 'Vera', 'Campos', '1981-12-04', 1, 6, 2);

# Transacciones (Venta, Detalle, Promoción y Satisfacción)

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (1, 18887268, 4, '2025-04-05 15:49:00', 206006.00, 0.00, 206006.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (1, 259, 2, 12439.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (1, 274, 2, 18177.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (1, 267, 2, 29386.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (1, 112, 1, 86002.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (1, 2, 'No cumplió expectativas', '2025-04-09 02:49:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (2, 18348340, 3, '2025-05-07 16:41:00', 149523.00, 0.00, 149523.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (2, 174, 2, 31289.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (2, 105, 2, 24467.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (2, 194, 2, 10117.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (2, 173, 1, 17777.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (2, 9, 'Muy satisfecho', '2025-05-10 22:41:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (3, 7152747, 1, '2023-06-22 10:09:00', 45707.00, 3428.03, 42278.97);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (3, 302, 1, 45707.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (3, 7, '', '2023-06-24 15:09:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (4, 11219514, 4, '2023-07-25 17:22:00', 41871.00, 2093.55, 39777.45);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (4, 172, 1, 10582.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (4, 174, 1, 31289.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (4, 5, '', '2023-07-28 05:22:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (5, 13111240, 2, '2025-01-16 16:50:00', 50652.00, 0.00, 50652.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (5, 234, 2, 25326.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (5, 7, 'Muy satisfecho', '2025-01-19 19:50:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (6, 18261227, 3, '2025-04-09 17:39:00', 45338.00, 3400.35, 41937.65);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (6, 116, 1, 17614.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (6, 256, 1, 27724.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (6, 9, 'Producto defectuoso', '2025-04-12 23:39:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (7, 15576565, 3, '2023-08-22 13:01:00', 59844.00, 2992.20, 56851.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (7, 144, 1, 59844.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (7, 5, '', '2023-08-24 23:01:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (8, 11395606, 2, '2024-07-13 18:36:00', 193374.00, 0.00, 193374.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (8, 241, 1, 87271.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (8, 148, 1, 58264.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (8, 343, 1, 13215.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (8, 202, 2, 17312.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (8, 3, '', '2024-07-14 20:36:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (9, 8821508, 2, '2023-07-20 10:58:00', 108030.00, 5401.50, 102628.50);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (9, 206, 1, 45009.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (9, 283, 1, 29886.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (9, 329, 1, 33135.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (9, 5, 'Producto defectuoso', '2023-07-22 12:58:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (10, 24739229, 2, '2024-04-08 16:49:00', 376691.00, 28251.83, 348439.17);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (10, 158, 2, 75626.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (10, 292, 1, 25729.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (10, 208, 1, 28576.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (10, 199, 2, 85567.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (10, 6, 'No cumplió expectativas', '2024-04-12 00:49:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (11, 10862471, 3, '2023-07-24 13:33:00', 54120.00, 2706.00, 51414.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (11, 172, 2, 10582.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (11, 247, 1, 32956.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (11, 4, 'Muy satisfecho', '2023-07-25 18:33:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (12, 16603086, 1, '2024-09-13 18:07:00', 45675.00, 3425.62, 42249.38);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (12, 219, 1, 45675.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (12, 7, 'Rápida entrega', '2024-09-14 22:07:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (13, 9333002, 1, '2024-09-22 11:46:00', 117846.00, 0.00, 117846.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (13, 178, 1, 32279.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (13, 199, 1, 85567.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (13, 6, 'No cumplió expectativas', '2024-09-23 16:46:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (14, 20174990, 2, '2024-12-27 11:12:00', 150155.00, 7507.75, 142647.25);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (14, 309, 2, 36046.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (14, 155, 1, 25251.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (14, 254, 2, 26406.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (14, 3, 'No cumplió expectativas', '2024-12-30 20:12:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (15, 9388127, 2, '2025-04-28 10:17:00', 206122.00, 0.00, 206122.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (15, 134, 1, 21463.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (15, 294, 2, 18815.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (15, 193, 2, 34526.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (15, 337, 1, 77977.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (15, 2, 'Rápida entrega', '2025-04-30 17:17:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (16, 13863609, 3, '2024-02-13 18:02:00', 128077.00, 9605.77, 118471.23);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (16, 293, 1, 42471.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (16, 267, 1, 29386.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (16, 314, 1, 24476.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (16, 233, 1, 31744.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (16, 9, 'Producto defectuoso', '2024-02-16 19:02:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (17, 13738320, 2, '2023-10-16 19:28:00', 100488.00, 0.00, 100488.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (17, 263, 1, 20222.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (17, 224, 2, 40133.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (17, 7, 'Muy satisfecho', '2023-10-17 23:28:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (18, 15996999, 1, '2023-11-09 16:01:00', 91086.00, 0.00, 91086.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (18, 157, 1, 31242.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (18, 144, 1, 59844.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (18, 5, 'Rápida entrega', '2023-11-12 03:01:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (19, 7382287, 2, '2024-12-18 10:02:00', 69052.00, 5178.90, 63873.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (19, 193, 2, 34526.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (19, 6, 'Rápida entrega', '2024-12-20 15:02:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (20, 14777816, 4, '2024-09-03 11:16:00', 75340.00, 5650.50, 69689.50);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (20, 254, 1, 26406.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (20, 105, 2, 24467.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (20, 10, 'No cumplió expectativas', '2024-09-06 16:16:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (21, 16849878, 3, '2025-01-02 16:44:00', 167606.00, 12570.45, 155035.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (21, 281, 2, 30021.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (21, 200, 2, 35141.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (21, 289, 1, 18618.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (21, 284, 2, 9332.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (21, 1, '', '2025-01-04 04:44:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (22, 20569492, 2, '2025-01-08 10:26:00', 183524.00, 9176.20, 174347.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (22, 190, 2, 18362.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (22, 343, 2, 13215.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (22, 281, 2, 30021.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (22, 176, 1, 60328.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (22, 8, 'Excelente servicio!', '2025-01-11 16:26:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (23, 22829240, 2, '2023-06-19 10:23:00', 188223.00, 14116.73, 174106.27);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (23, 322, 2, 60016.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (23, 211, 1, 17541.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (23, 111, 2, 25325.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (23, 1, 'Excelente servicio!', '2023-06-21 14:23:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (24, 11397346, 3, '2024-07-28 13:32:00', 266517.00, 13325.85, 253191.15);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (24, 112, 2, 86002.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (24, 204, 1, 33178.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (24, 346, 1, 61335.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (24, 4, 'Producto defectuoso', '2024-07-30 20:32:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (25, 21027149, 2, '2024-02-12 11:32:00', 56682.00, 4251.15, 52430.85);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (25, 212, 2, 28341.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (25, 7, '', '2024-02-15 16:32:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (26, 18305291, 4, '2024-06-12 10:10:00', 19380.00, 969.00, 18411.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (26, 257, 1, 19380.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (26, 2, 'Muy satisfecho', '2024-06-13 12:10:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (27, 24732931, 1, '2023-08-07 12:34:00', 261114.00, 13055.70, 248058.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (27, 166, 2, 89544.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (27, 261, 2, 12437.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (27, 208, 2, 28576.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (27, 10, 'Producto defectuoso', '2023-08-09 14:34:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (28, 11553950, 3, '2024-03-08 16:29:00', 217380.00, 16303.50, 201076.50);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (28, 167, 2, 35137.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (28, 225, 1, 30010.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (28, 109, 2, 58548.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (28, 9, 'Rápida entrega', '2024-03-09 17:29:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (29, 21397229, 3, '2024-07-26 16:14:00', 61460.00, 0.00, 61460.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (29, 128, 2, 30730.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (29, 4, 'Muy satisfecho', '2024-07-30 04:14:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (30, 10384683, 1, '2023-12-10 13:50:00', 88616.00, 6646.20, 81969.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (30, 115, 1, 31956.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (30, 231, 2, 28330.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (30, 9, 'Rápida entrega', '2023-12-13 14:50:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (31, 12011563, 2, '2024-04-09 18:34:00', 324810.00, 16240.50, 308569.50);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (31, 198, 2, 74937.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (31, 331, 2, 87468.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (31, 1, 'Producto defectuoso', '2024-04-12 22:34:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (32, 19602503, 4, '2023-08-10 14:39:00', 226596.00, 16994.70, 209601.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (32, 322, 1, 60016.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (32, 183, 2, 21742.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (32, 128, 2, 30730.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (32, 192, 2, 30818.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (32, 1, '', '2023-08-12 20:39:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (33, 18783810, 4, '2024-09-29 13:21:00', 111797.00, 8384.77, 103412.23);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (33, 339, 1, 23051.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (33, 271, 1, 31851.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (33, 282, 2, 14329.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (33, 164, 1, 28237.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (33, 5, 'Excelente servicio!', '2024-09-30 16:21:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (34, 6549300, 1, '2024-12-12 16:47:00', 224849.00, 16863.67, 207985.33);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (34, 312, 1, 85525.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (34, 217, 2, 17150.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (34, 327, 2, 34638.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (34, 307, 2, 17874.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (34, 9, 'Excelente servicio!', '2024-12-13 18:47:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (35, 19415989, 3, '2024-12-06 19:07:00', 58548.00, 2927.40, 55620.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (35, 109, 1, 58548.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (35, 2, 'No cumplió expectativas', '2024-12-08 20:07:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (36, 17773770, 3, '2025-03-12 14:31:00', 47555.00, 0.00, 47555.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (36, 177, 1, 47555.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (36, 6, 'Excelente servicio!', '2025-03-13 19:31:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (37, 18783810, 2, '2024-04-19 11:11:00', 139183.00, 10438.73, 128744.27);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (37, 298, 1, 22621.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (37, 247, 1, 32956.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (37, 254, 2, 26406.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (37, 121, 1, 30794.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (37, 6, 'Muy satisfecho', '2024-04-20 12:11:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (38, 8731592, 1, '2024-03-02 15:49:00', 168482.00, 8424.10, 160057.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (38, 329, 2, 33135.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (38, 210, 2, 18625.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (38, 326, 2, 32481.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (38, 3, 'Muy satisfecho', '2024-03-05 17:49:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (39, 20523693, 3, '2025-03-04 11:14:00', 155683.00, 35028.68, 120654.32);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (39, 114, 1, 10540.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (39, 155, 1, 25251.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (39, 276, 1, 29128.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (39, 304, 2, 45382.00);
INSERT INTO `venta_promocion` (`id_venta`, `id_promocion`) VALUES (39, 2);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (39, 8, 'Excelente servicio!', '2025-03-07 18:14:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (40, 10606500, 2, '2024-08-23 11:27:00', 145658.00, 10924.35, 134733.65);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (40, 249, 2, 30358.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (40, 293, 2, 42471.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (40, 9, '', '2024-08-25 23:27:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (41, 17608826, 2, '2024-02-23 11:06:00', 209846.00, 0.00, 209846.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (41, 344, 1, 34794.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (41, 255, 2, 87526.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (41, 1, 'Producto defectuoso', '2024-02-25 22:06:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (42, 21413596, 4, '2024-02-19 15:08:00', 286333.00, 21474.97, 264858.03);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (42, 206, 1, 45009.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (42, 312, 2, 85525.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (42, 167, 2, 35137.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (42, 8, '', '2024-02-23 01:08:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (43, 8254301, 3, '2025-01-23 16:44:00', 79571.00, 5967.82, 73603.18);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (43, 343, 1, 13215.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (43, 204, 2, 33178.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (43, 5, 'Rápida entrega', '2025-01-25 02:44:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (44, 14190341, 3, '2025-03-22 18:29:00', 207679.00, 0.00, 207679.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (44, 212, 2, 28341.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (44, 155, 2, 25251.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (44, 251, 1, 76028.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (44, 105, 1, 24467.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (44, 6, 'Excelente servicio!', '2025-03-26 00:29:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (45, 13367735, 3, '2023-12-09 11:36:00', 161717.00, 12128.77, 149588.23);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (45, 249, 1, 30358.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (45, 239, 1, 30415.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (45, 103, 2, 50472.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (45, 1, 'Rápida entrega', '2023-12-12 17:36:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (46, 13981577, 2, '2024-09-14 18:40:00', 157297.00, 11797.27, 145499.73);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (46, 194, 1, 10117.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (46, 143, 1, 47270.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (46, 330, 2, 20827.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (46, 276, 2, 29128.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (46, 5, 'Producto defectuoso', '2024-09-16 00:40:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (47, 22495396, 2, '2024-01-04 18:32:00', 83640.00, 6273.00, 77367.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (47, 105, 2, 24467.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (47, 130, 1, 16484.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (47, 171, 2, 9111.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (47, 9, 'Producto defectuoso', '2024-01-07 19:32:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (48, 15813452, 2, '2024-02-21 15:25:00', 45690.00, 0.00, 45690.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (48, 194, 1, 10117.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (48, 188, 1, 35573.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (48, 3, 'No cumplió expectativas', '2024-02-24 17:25:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (49, 17608826, 2, '2024-09-07 15:54:00', 155702.00, 0.00, 155702.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (49, 294, 2, 18815.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (49, 309, 1, 36046.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (49, 185, 1, 31192.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (49, 252, 2, 25417.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (49, 4, 'Excelente servicio!', '2024-09-08 18:54:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (50, 15022050, 1, '2023-09-04 19:18:00', 288350.00, 0.00, 288350.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (50, 157, 1, 31242.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (50, 230, 2, 33983.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (50, 216, 1, 14218.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (50, 305, 2, 87462.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (50, 2, '', '2023-09-06 06:18:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (51, 18321861, 4, '2024-02-12 15:25:00', 113426.00, 8506.95, 104919.05);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (51, 287, 2, 25305.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (51, 153, 2, 31408.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (51, 5, 'Muy satisfecho', '2024-02-15 16:25:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (52, 15451442, 3, '2024-09-23 16:03:00', 59844.00, 0.00, 59844.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (52, 144, 1, 59844.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (52, 6, '', '2024-09-25 22:03:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (53, 11675249, 1, '2024-12-09 17:30:00', 75535.00, 5665.12, 69869.88);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (53, 227, 2, 33542.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (53, 118, 1, 8451.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (53, 7, 'No cumplió expectativas', '2024-12-13 01:30:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (54, 11553950, 4, '2024-10-07 17:22:00', 139415.00, 10456.12, 128958.88);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (54, 208, 1, 28576.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (54, 178, 1, 32279.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (54, 204, 1, 33178.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (54, 304, 1, 45382.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (54, 3, 'Excelente servicio!', '2024-10-11 01:22:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (55, 16747736, 1, '2023-07-26 13:45:00', 118840.00, 8913.00, 109927.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (55, 196, 1, 46217.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (55, 200, 1, 35141.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (55, 145, 2, 18741.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (55, 5, '', '2023-07-29 20:45:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (56, 15813452, 3, '2025-01-31 18:07:00', 13358.00, 0.00, 13358.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (56, 258, 1, 13358.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (56, 7, 'Excelente servicio!', '2025-02-03 01:07:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (57, 15451442, 4, '2025-01-26 10:30:00', 114276.00, 0.00, 114276.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (57, 261, 2, 12437.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (57, 335, 1, 89402.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (57, 7, 'Muy satisfecho', '2025-01-27 22:30:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (58, 15022050, 2, '2024-03-02 19:35:00', 138472.00, 0.00, 138472.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (58, 141, 2, 39521.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (58, 189, 1, 59430.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (58, 5, 'Excelente servicio!', '2024-03-05 07:35:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (59, 15532952, 2, '2024-11-07 17:55:00', 223490.00, 16761.75, 206728.25);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (59, 302, 1, 45707.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (59, 343, 2, 13215.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (59, 346, 1, 61335.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (59, 206, 2, 45009.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (59, 9, 'Rápida entrega', '2024-11-09 02:55:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (60, 18362647, 4, '2024-11-18 10:28:00', 145336.00, 10900.20, 134435.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (60, 276, 2, 29128.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (60, 152, 1, 51084.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (60, 220, 1, 35996.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (60, 6, 'Producto defectuoso', '2024-11-19 14:28:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (61, 18325757, 3, '2024-07-04 12:21:00', 114223.00, 8566.73, 105656.27);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (61, 211, 2, 17541.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (61, 165, 1, 30637.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (61, 332, 2, 24252.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (61, 3, 'Rápida entrega', '2024-07-07 21:21:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (62, 13763728, 1, '2024-03-28 13:29:00', 272550.00, 20441.25, 252108.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (62, 101, 2, 60625.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (62, 305, 1, 87462.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (62, 316, 2, 31919.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (62, 6, 'No cumplió expectativas', '2024-03-31 14:29:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (63, 14542389, 1, '2025-05-25 13:52:00', 70282.00, 3514.10, 66767.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (63, 200, 2, 35141.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (63, 1, 'Muy satisfecho', '2025-05-27 16:52:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (64, 20542987, 1, '2025-04-16 17:31:00', 31738.00, 0.00, 31738.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (64, 340, 1, 31738.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (64, 9, 'Muy satisfecho', '2025-04-20 00:31:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (65, 17049113, 4, '2025-04-30 14:09:00', 228300.00, 11415.00, 216885.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (65, 172, 2, 10582.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (65, 218, 1, 42442.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (65, 332, 2, 24252.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (65, 279, 2, 58095.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (65, 10, 'Rápida entrega', '2025-05-03 16:09:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (66, 19476479, 1, '2025-03-17 12:36:00', 309512.00, 23213.40, 286298.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (66, 293, 2, 42471.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (66, 154, 1, 25346.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (66, 109, 2, 58548.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (66, 285, 2, 41064.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (66, 4, 'Excelente servicio!', '2025-03-21 00:36:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (67, 18074650, 1, '2024-01-07 18:45:00', 74285.00, 5571.38, 68713.62);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (67, 275, 1, 41239.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (67, 136, 1, 33046.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (67, 4, 'Producto defectuoso', '2024-01-10 06:45:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (68, 19040117, 2, '2024-05-20 12:14:00', 86168.00, 0.00, 86168.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (68, 223, 2, 25061.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (68, 309, 1, 36046.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (68, 3, 'Rápida entrega', '2024-05-23 16:14:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (69, 18387219, 3, '2024-12-03 12:38:00', 238018.00, 11900.90, 226117.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (69, 335, 1, 89402.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (69, 252, 2, 25417.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (69, 153, 2, 31408.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (69, 301, 2, 17483.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (69, 6, 'Excelente servicio!', '2024-12-05 15:38:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (70, 19040117, 2, '2024-08-29 13:46:00', 106561.00, 0.00, 106561.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (70, 347, 1, 45226.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (70, 346, 1, 61335.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (70, 5, '', '2024-08-31 14:46:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (71, 18716077, 4, '2023-07-05 19:17:00', 283174.00, 14158.70, 269015.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (71, 125, 1, 45180.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (71, 329, 2, 33135.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (71, 320, 2, 85862.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (71, 3, '', '2023-07-07 22:17:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (72, 16697606, 1, '2023-07-10 11:16:00', 119688.00, 8976.60, 110711.40);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (72, 144, 2, 59844.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (72, 4, 'Rápida entrega', '2023-07-13 20:16:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (73, 11668289, 1, '2023-11-04 15:42:00', 159987.00, 0.00, 159987.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (73, 197, 2, 36070.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (73, 313, 1, 19655.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (73, 319, 2, 27621.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (73, 323, 1, 12950.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (73, 2, 'Muy satisfecho', '2023-11-07 01:42:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (74, 15532952, 1, '2023-09-11 18:28:00', 116783.00, 8758.73, 108024.27);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (74, 153, 1, 31408.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (74, 215, 1, 21459.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (74, 221, 2, 31958.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (74, 10, 'Excelente servicio!', '2023-09-13 23:28:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (75, 19415989, 2, '2024-11-24 19:15:00', 29865.00, 1493.25, 28371.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (75, 147, 1, 29865.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (75, 10, '', '2024-11-28 07:15:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (76, 15520193, 2, '2024-04-08 11:02:00', 117765.00, 5888.25, 111876.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (76, 164, 1, 28237.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (76, 345, 2, 26432.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (76, 291, 1, 36664.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (76, 10, 'Muy satisfecho', '2024-04-11 17:02:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (77, 24753534, 4, '2023-06-24 18:37:00', 118232.00, 0.00, 118232.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (77, 174, 2, 31289.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (77, 248, 2, 27827.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (77, 10, 'No cumplió expectativas', '2023-06-26 04:37:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (78, 23715924, 1, '2024-07-27 15:37:00', 31738.00, 1586.90, 30151.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (78, 340, 1, 31738.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (78, 3, 'Muy satisfecho', '2024-07-30 20:37:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (79, 18114538, 2, '2024-07-19 12:00:00', 173023.00, 0.00, 173023.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (79, 263, 2, 20222.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (79, 273, 1, 25363.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (79, 178, 1, 32279.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (79, 198, 1, 74937.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (79, 7, 'Excelente servicio!', '2024-07-22 21:00:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (80, 16242950, 2, '2024-08-29 18:46:00', 187877.00, 9393.85, 178483.15);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (80, 287, 2, 25305.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (80, 237, 2, 35138.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (80, 165, 1, 30637.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (80, 274, 2, 18177.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (80, 4, 'Rápida entrega', '2024-09-01 04:46:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (81, 23844543, 4, '2024-01-22 16:10:00', 66046.00, 3302.30, 62743.70);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (81, 327, 1, 34638.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (81, 153, 1, 31408.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (81, 1, 'Rápida entrega', '2024-01-24 18:10:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (82, 12492037, 2, '2025-04-11 19:48:00', 204777.00, 15358.27, 189418.73);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (82, 236, 2, 26124.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (82, 147, 1, 29865.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (82, 237, 1, 35138.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (82, 255, 1, 87526.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (82, 9, 'Excelente servicio!', '2025-04-14 02:48:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (83, 23844543, 1, '2024-08-14 10:56:00', 63888.00, 3194.40, 60693.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (83, 235, 2, 31944.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (83, 10, 'Producto defectuoso', '2024-08-16 12:56:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (84, 23653735, 2, '2024-01-04 10:57:00', 129376.00, 0.00, 129376.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (84, 195, 2, 24283.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (84, 250, 2, 40405.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (84, 2, 'Muy satisfecho', '2024-01-05 16:57:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (85, 16418651, 2, '2024-07-26 15:25:00', 167064.00, 0.00, 167064.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (85, 124, 1, 41555.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (85, 172, 2, 10582.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (85, 122, 1, 86568.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (85, 173, 1, 17777.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (85, 4, 'Excelente servicio!', '2024-07-30 02:25:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (86, 18584380, 1, '2024-07-20 15:22:00', 24527.00, 1839.52, 22687.47);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (86, 150, 1, 24527.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (86, 9, 'Excelente servicio!', '2024-07-22 03:22:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (87, 11326969, 1, '2023-07-18 13:47:00', 44199.00, 0.00, 44199.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (87, 118, 1, 8451.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (87, 307, 2, 17874.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (87, 2, 'Muy satisfecho', '2023-07-19 21:47:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (88, 7645426, 3, '2024-05-15 18:33:00', 84282.00, 6321.15, 77960.85);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (88, 268, 2, 23779.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (88, 190, 2, 18362.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (88, 7, 'No cumplió expectativas', '2024-05-17 02:33:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (89, 23653735, 1, '2024-07-01 15:24:00', 254365.00, 0.00, 254365.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (89, 285, 1, 41064.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (89, 159, 1, 17308.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (89, 215, 1, 21459.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (89, 336, 2, 87267.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (89, 3, 'Producto defectuoso', '2024-07-02 17:24:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (90, 24834289, 1, '2024-05-09 15:06:00', 146359.00, 7317.95, 139041.05);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (90, 284, 1, 9332.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (90, 102, 1, 41836.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (90, 197, 2, 36070.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (90, 339, 1, 23051.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (90, 1, 'Producto defectuoso', '2024-05-11 16:06:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (91, 19862271, 3, '2024-06-03 16:33:00', 143815.00, 0.00, 143815.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (91, 341, 2, 25841.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (91, 142, 1, 11323.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (91, 250, 2, 40405.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (91, 2, '', '2024-06-06 21:33:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (92, 14548247, 1, '2023-09-10 15:08:00', 65866.00, 0.00, 65866.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (92, 202, 2, 17312.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (92, 157, 1, 31242.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (92, 8, 'Muy satisfecho', '2023-09-13 02:08:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (93, 11647735, 4, '2024-03-01 16:55:00', 171216.00, 8560.80, 162655.20);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (93, 346, 2, 61335.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (93, 265, 2, 24273.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (93, 10, 'Muy satisfecho', '2024-03-05 03:55:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (94, 14000124, 1, '2024-02-06 18:27:00', 148564.00, 0.00, 148564.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (94, 275, 1, 41239.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (94, 134, 1, 21463.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (94, 320, 1, 85862.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (94, 5, 'Muy satisfecho', '2024-02-08 06:27:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (95, 8201573, 3, '2024-12-01 19:55:00', 267859.00, 0.00, 267859.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (95, 163, 2, 22287.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (95, 274, 1, 18177.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (95, 288, 1, 34058.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (95, 312, 2, 85525.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (95, 8, 'Excelente servicio!', '2024-12-05 03:55:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (96, 7305911, 3, '2023-12-28 18:53:00', 79372.00, 0.00, 79372.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (96, 201, 1, 24130.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (96, 319, 2, 27621.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (96, 8, '', '2023-12-30 19:53:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (97, 9304849, 2, '2024-06-10 18:33:00', 14329.00, 716.45, 13612.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (97, 282, 1, 14329.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (97, 3, 'Producto defectuoso', '2024-06-12 22:33:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (98, 21397229, 4, '2025-02-15 17:08:00', 26124.00, 0.00, 26124.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (98, 236, 1, 26124.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (98, 10, 'Rápida entrega', '2025-02-18 02:08:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (99, 7127706, 4, '2024-12-12 18:37:00', 242274.00, 0.00, 242274.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (99, 109, 1, 58548.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (99, 199, 1, 85567.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (99, 272, 2, 33154.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (99, 271, 1, 31851.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (99, 3, 'Muy satisfecho', '2024-12-15 20:37:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (100, 11074758, 1, '2024-05-11 16:23:00', 82478.00, 6185.85, 76292.15);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (100, 275, 2, 41239.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (100, 8, 'Excelente servicio!', '2024-05-15 01:23:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (101, 15672821, 1, '2024-11-21 14:30:00', 352965.00, 17648.25, 335316.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (101, 109, 2, 58548.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (101, 336, 2, 87267.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (101, 346, 1, 61335.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (101, 5, 'No cumplió expectativas', '2024-11-24 15:30:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (102, 12568193, 2, '2023-11-25 19:18:00', 70978.00, 3548.90, 67429.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (102, 274, 2, 18177.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (102, 202, 2, 17312.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (102, 9, 'Muy satisfecho', '2023-11-27 03:18:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (103, 16641839, 4, '2024-05-10 14:52:00', 84388.00, 4219.40, 80168.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (103, 175, 2, 28332.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (103, 256, 1, 27724.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (103, 10, 'Producto defectuoso', '2024-05-13 22:52:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (104, 13763728, 4, '2024-12-30 16:08:00', 93257.00, 6994.27, 86262.73);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (104, 128, 1, 30730.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (104, 285, 1, 41064.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (104, 134, 1, 21463.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (104, 4, 'Rápida entrega', '2024-12-31 22:08:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (105, 12135973, 2, '2025-05-12 13:51:00', 30021.00, 2251.57, 27769.42);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (105, 281, 1, 30021.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (105, 9, 'No cumplió expectativas', '2025-05-15 17:51:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (106, 18916071, 2, '2024-01-05 19:06:00', 82975.00, 4148.75, 78826.25);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (106, 181, 2, 23808.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (106, 127, 1, 35359.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (106, 4, 'Excelente servicio!', '2024-01-08 00:06:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (107, 15116296, 2, '2024-05-11 17:19:00', 146402.00, 10980.15, 135421.85);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (107, 212, 1, 28341.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (107, 336, 1, 87267.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (107, 121, 1, 30794.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (107, 5, 'Muy satisfecho', '2024-05-14 00:19:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (108, 22127775, 2, '2025-02-18 19:56:00', 217826.00, 10891.30, 206934.70);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (108, 341, 2, 25841.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (108, 143, 2, 47270.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (108, 263, 1, 20222.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (108, 315, 2, 25691.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (108, 10, 'Producto defectuoso', '2025-02-22 01:56:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (109, 10170463, 2, '2025-04-09 16:34:00', 101596.00, 0.00, 101596.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (109, 134, 1, 21463.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (109, 271, 1, 31851.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (109, 149, 2, 24141.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (109, 7, 'Rápida entrega', '2025-04-11 18:34:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (110, 17307651, 2, '2025-04-17 12:52:00', 36944.00, 2770.80, 34173.20);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (110, 203, 1, 36944.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (110, 5, 'Rápida entrega', '2025-04-20 14:52:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (111, 22127775, 1, '2024-06-18 11:49:00', 253885.00, 12694.25, 241190.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (111, 115, 1, 31956.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (111, 245, 1, 23653.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (111, 311, 2, 86401.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (111, 140, 1, 25474.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (111, 4, 'Rápida entrega', '2024-06-21 13:49:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (112, 17049113, 3, '2023-08-25 12:17:00', 20124.00, 1006.20, 19117.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (112, 321, 2, 10062.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (112, 1, 'Muy satisfecho', '2023-08-28 20:17:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (113, 15520193, 4, '2024-01-08 13:36:00', 119698.00, 5984.90, 113713.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (113, 147, 1, 29865.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (113, 340, 1, 31738.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (113, 279, 1, 58095.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (113, 7, 'Rápida entrega', '2024-01-11 17:36:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (114, 22495396, 1, '2023-09-06 12:24:00', 74619.00, 5596.43, 69022.57);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (114, 212, 1, 28341.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (114, 276, 1, 29128.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (114, 217, 1, 17150.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (114, 3, 'Rápida entrega', '2023-09-08 21:24:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (115, 21281726, 1, '2024-10-08 19:51:00', 113823.00, 5691.15, 108131.85);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (115, 292, 2, 25729.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (115, 236, 2, 26124.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (115, 194, 1, 10117.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (115, 8, 'Excelente servicio!', '2024-10-11 06:51:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (116, 7645426, 4, '2024-01-20 13:50:00', 227849.00, 17088.67, 210760.33);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (116, 334, 1, 31788.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (116, 175, 2, 28332.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (116, 145, 1, 18741.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (116, 176, 2, 60328.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (116, 7, 'Muy satisfecho', '2024-01-21 23:50:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (117, 16055551, 2, '2024-03-12 11:00:00', 151786.00, 11383.95, 140402.05);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (117, 237, 1, 35138.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (117, 240, 2, 34689.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (117, 143, 1, 47270.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (117, 1, 'Rápida entrega', '2024-03-14 18:00:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (118, 16013309, 2, '2023-07-20 13:37:00', 136047.00, 6802.35, 129244.65);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (118, 202, 1, 17312.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (118, 335, 1, 89402.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (118, 129, 1, 29333.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (118, 9, 'Producto defectuoso', '2023-07-23 23:37:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (119, 15419183, 4, '2024-06-02 11:21:00', 83551.00, 6266.32, 77284.68);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (119, 268, 1, 23779.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (119, 283, 2, 29886.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (119, 4, '', '2024-06-03 15:21:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (120, 16058467, 3, '2024-01-13 11:17:00', 269932.00, 0.00, 269932.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (120, 251, 2, 76028.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (120, 307, 2, 17874.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (120, 285, 2, 41064.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (120, 10, '', '2024-01-14 23:17:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (121, 19922159, 2, '2023-10-21 16:35:00', 165292.00, 0.00, 165292.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (121, 143, 1, 47270.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (121, 134, 1, 21463.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (121, 290, 2, 30935.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (121, 240, 1, 34689.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (121, 1, '', '2023-10-22 17:35:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (122, 13312176, 2, '2024-12-09 10:46:00', 97982.00, 7348.65, 90633.35);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (122, 170, 2, 27396.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (122, 214, 2, 21595.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (122, 7, 'Muy satisfecho', '2024-12-12 15:46:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (123, 16403039, 2, '2023-10-26 13:04:00', 31730.00, 0.00, 31730.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (123, 104, 1, 31730.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (123, 3, 'Excelente servicio!', '2023-10-29 18:04:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (124, 20569492, 4, '2023-07-02 16:21:00', 157750.00, 7887.50, 149862.50);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (124, 331, 1, 87468.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (124, 200, 2, 35141.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (124, 9, 'No cumplió expectativas', '2023-07-06 00:21:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (125, 11675249, 2, '2024-10-24 13:15:00', 277282.00, 20796.15, 256485.85);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (125, 327, 2, 34638.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (125, 158, 2, 75626.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (125, 153, 1, 31408.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (125, 154, 1, 25346.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (125, 1, 'No cumplió expectativas', '2024-10-26 18:15:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (126, 17594194, 4, '2025-01-15 18:43:00', 306482.00, 22986.15, 283495.85);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (126, 116, 1, 17614.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (126, 243, 2, 49945.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (126, 346, 2, 61335.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (126, 272, 2, 33154.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (126, 4, 'Rápida entrega', '2025-01-18 05:43:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (127, 13380886, 4, '2023-08-11 10:53:00', 127162.00, 6358.10, 120803.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (127, 104, 2, 31730.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (127, 271, 2, 31851.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (127, 5, 'Rápida entrega', '2023-08-12 11:53:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (128, 7745288, 4, '2023-07-03 16:19:00', 162081.00, 12156.07, 149924.92);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (128, 332, 1, 24252.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (128, 125, 1, 45180.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (128, 129, 2, 29333.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (128, 230, 1, 33983.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (128, 2, 'Rápida entrega', '2023-07-04 22:19:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (129, 11598868, 1, '2023-08-02 13:10:00', 61355.00, 4601.62, 56753.38);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (129, 222, 1, 44043.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (129, 202, 1, 17312.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (129, 2, 'Producto defectuoso', '2023-08-05 19:10:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (130, 20432101, 2, '2023-09-28 15:03:00', 156307.00, 7815.35, 148491.65);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (130, 211, 2, 17541.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (130, 122, 1, 86568.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (130, 284, 1, 9332.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (130, 111, 1, 25325.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (130, 10, 'Muy satisfecho', '2023-10-01 21:03:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (131, 21480442, 2, '2023-09-13 19:36:00', 200498.00, 15037.35, 185460.65);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (131, 149, 1, 24141.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (131, 199, 1, 85567.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (131, 245, 2, 23653.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (131, 183, 2, 21742.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (131, 7, 'No cumplió expectativas', '2023-09-15 04:36:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (132, 14036047, 4, '2024-02-11 19:18:00', 218160.00, 0.00, 218160.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (132, 138, 2, 32854.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (132, 265, 2, 24273.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (132, 159, 2, 17308.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (132, 306, 2, 34645.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (132, 1, 'Muy satisfecho', '2024-02-13 05:18:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (133, 23249014, 2, '2025-01-07 16:44:00', 119976.00, 8998.20, 110977.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (133, 161, 1, 9099.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (133, 286, 1, 23891.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (133, 319, 2, 27621.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (133, 233, 1, 31744.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (133, 6, 'Excelente servicio!', '2025-01-08 20:44:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (134, 18074650, 1, '2025-03-14 19:38:00', 71146.00, 5335.95, 65810.05);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (134, 188, 2, 35573.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (134, 2, 'Producto defectuoso', '2025-03-16 23:38:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (135, 20432101, 3, '2024-11-03 11:44:00', 80823.00, 4041.15, 76781.85);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (135, 212, 2, 28341.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (135, 149, 1, 24141.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (135, 8, 'Muy satisfecho', '2024-11-04 23:44:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (136, 19476479, 4, '2023-11-24 18:53:00', 141096.00, 10582.20, 130513.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (136, 249, 2, 30358.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (136, 194, 2, 10117.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (136, 226, 1, 60146.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (136, 10, 'Producto defectuoso', '2023-11-26 21:53:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (137, 22148796, 1, '2025-05-24 11:44:00', 183404.00, 0.00, 183404.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (137, 272, 2, 33154.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (137, 109, 2, 58548.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (137, 7, 'Muy satisfecho', '2025-05-27 16:44:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (138, 13203266, 4, '2025-03-13 19:04:00', 186694.00, 0.00, 186694.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (138, 251, 2, 76028.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (138, 327, 1, 34638.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (138, 6, 'Rápida entrega', '2025-03-16 01:04:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (139, 23715924, 3, '2023-10-11 19:28:00', 196323.00, 9816.15, 186506.85);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (139, 273, 2, 25363.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (139, 302, 1, 45707.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (139, 243, 2, 49945.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (139, 2, '', '2023-10-13 20:28:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (140, 13312176, 4, '2024-04-19 18:04:00', 96314.00, 7223.55, 89090.45);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (140, 115, 1, 31956.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (140, 187, 1, 18296.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (140, 277, 1, 19033.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (140, 266, 1, 27029.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (140, 5, 'No cumplió expectativas', '2024-04-20 19:04:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (141, 8289099, 1, '2023-10-19 15:08:00', 104518.00, 5225.90, 99292.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (141, 141, 1, 39521.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (141, 214, 2, 21595.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (141, 120, 1, 21807.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (141, 2, 'Excelente servicio!', '2023-10-21 19:08:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (142, 7033387, 4, '2024-06-04 10:40:00', 149311.00, 7465.55, 141845.45);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (142, 177, 1, 47555.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (142, 248, 2, 27827.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (142, 339, 2, 23051.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (142, 10, 'Muy satisfecho', '2024-06-05 12:40:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (143, 18916071, 3, '2024-02-28 10:45:00', 143724.00, 7186.20, 136537.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (143, 311, 1, 86401.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (143, 192, 1, 30818.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (143, 123, 1, 26505.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (143, 4, 'Producto defectuoso', '2024-02-29 22:45:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (144, 10648897, 2, '2025-05-22 19:31:00', 215190.00, 0.00, 215190.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (144, 335, 1, 89402.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (144, 253, 2, 30413.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (144, 326, 2, 32481.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (144, 7, 'Producto defectuoso', '2025-05-26 05:31:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (145, 18297208, 2, '2024-10-02 12:24:00', 95720.00, 4786.00, 90934.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (145, 181, 1, 23808.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (145, 286, 2, 23891.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (145, 201, 1, 24130.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (145, 5, 'Excelente servicio!', '2024-10-04 20:24:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (146, 9388127, 2, '2023-11-13 18:32:00', 303468.00, 0.00, 303468.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (146, 158, 2, 75626.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (146, 276, 1, 29128.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (146, 197, 2, 36070.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (146, 140, 2, 25474.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (146, 6, 'Producto defectuoso', '2023-11-16 01:32:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (147, 21397229, 3, '2024-12-07 19:52:00', 108701.00, 0.00, 108701.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (147, 157, 2, 31242.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (147, 196, 1, 46217.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (147, 2, 'Producto defectuoso', '2024-12-11 07:52:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (148, 11045667, 1, '2024-12-31 11:18:00', 48934.00, 0.00, 48934.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (148, 105, 2, 24467.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (148, 10, 'Rápida entrega', '2025-01-02 21:18:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (149, 13893899, 3, '2024-04-16 12:41:00', 247010.00, 0.00, 247010.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (149, 148, 1, 58264.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (149, 243, 2, 49945.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (149, 298, 2, 22621.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (149, 120, 2, 21807.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (149, 4, '', '2024-04-19 17:41:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (150, 14665482, 1, '2024-10-15 19:28:00', 150814.00, 11311.05, 139502.95);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (150, 202, 2, 17312.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (150, 279, 2, 58095.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (150, 8, 'Excelente servicio!', '2024-10-17 23:28:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (151, 15578043, 3, '2023-09-09 15:12:00', 253386.00, 0.00, 253386.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (151, 266, 2, 27029.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (151, 330, 2, 20827.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (151, 222, 2, 44043.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (151, 344, 2, 34794.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (151, 4, 'Producto defectuoso', '2023-09-10 18:12:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (152, 19514935, 1, '2025-02-11 11:28:00', 176224.00, 8811.20, 167412.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (152, 138, 2, 32854.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (152, 232, 1, 24654.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (152, 320, 1, 85862.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (152, 6, 'Rápida entrega', '2025-02-12 22:28:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (153, 8821508, 3, '2024-06-20 13:28:00', 52809.00, 2640.45, 50168.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (153, 272, 1, 33154.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (153, 313, 1, 19655.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (153, 7, 'Rápida entrega', '2024-06-23 18:28:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (154, 11715850, 2, '2023-08-14 16:49:00', 117867.00, 5893.35, 111973.65);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (154, 279, 1, 58095.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (154, 283, 2, 29886.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (154, 9, '', '2023-08-16 01:49:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (155, 20214895, 1, '2024-07-07 17:49:00', 141851.00, 10638.82, 131212.17);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (155, 165, 2, 30637.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (155, 224, 1, 40133.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (155, 263, 2, 20222.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (155, 2, 'Rápida entrega', '2024-07-09 23:49:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (156, 18321861, 3, '2023-11-18 17:23:00', 81936.00, 6145.20, 75790.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (156, 204, 2, 33178.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (156, 295, 2, 7790.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (156, 10, 'Excelente servicio!', '2023-11-22 04:23:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (157, 23690120, 1, '2024-12-10 13:47:00', 96837.00, 7262.77, 89574.23);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (157, 245, 1, 23653.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (157, 201, 1, 24130.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (157, 150, 2, 24527.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (157, 10, '', '2024-12-13 18:47:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (158, 14470206, 4, '2023-08-19 11:19:00', 154687.00, 7734.35, 146952.65);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (158, 204, 2, 33178.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (158, 169, 2, 21630.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (158, 179, 2, 11804.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (158, 134, 1, 21463.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (158, 9, '', '2023-08-22 18:19:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (159, 16984636, 3, '2024-07-18 11:38:00', 48566.00, 3642.45, 44923.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (159, 195, 2, 24283.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (159, 1, '', '2024-07-20 19:38:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (160, 19341504, 3, '2024-06-04 19:01:00', 359738.00, 26980.35, 332757.65);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (160, 197, 2, 36070.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (160, 337, 2, 77977.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (160, 250, 2, 40405.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (160, 252, 2, 25417.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (160, 7, 'Rápida entrega', '2024-06-06 20:01:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (161, 21386320, 1, '2024-05-15 19:22:00', 46217.00, 0.00, 46217.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (161, 196, 1, 46217.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (161, 3, 'Rápida entrega', '2024-05-19 06:22:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (162, 17510894, 3, '2024-02-26 18:51:00', 91529.00, 4576.45, 86952.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (162, 248, 1, 27827.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (162, 271, 2, 31851.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (162, 4, 'Producto defectuoso', '2024-02-29 20:51:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (163, 23761234, 3, '2023-09-03 14:01:00', 173992.00, 13049.40, 160942.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (163, 303, 1, 87627.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (163, 299, 2, 30520.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (163, 111, 1, 25325.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (163, 2, 'No cumplió expectativas', '2023-09-05 00:01:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (164, 16603086, 4, '2024-05-11 12:26:00', 283625.00, 21271.88, 262353.12);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (164, 298, 2, 22621.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (164, 285, 1, 41064.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (164, 106, 1, 24517.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (164, 311, 2, 86401.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (164, 8, 'Rápida entrega', '2024-05-12 15:26:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (165, 17559583, 1, '2024-04-18 15:39:00', 75019.00, 0.00, 75019.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (165, 225, 1, 30010.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (165, 206, 1, 45009.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (165, 1, '', '2024-04-22 02:39:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (166, 11045667, 3, '2024-06-21 15:01:00', 33178.00, 0.00, 33178.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (166, 204, 1, 33178.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (166, 4, 'No cumplió expectativas', '2024-06-22 19:01:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (167, 12135973, 2, '2023-12-31 17:07:00', 32968.00, 2472.60, 30495.40);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (167, 130, 2, 16484.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (167, 8, 'Producto defectuoso', '2024-01-02 03:07:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (168, 9047555, 4, '2025-03-28 17:53:00', 187594.00, 14069.55, 173524.45);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (168, 164, 2, 28237.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (168, 154, 2, 25346.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (168, 183, 2, 21742.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (168, 203, 1, 36944.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (168, 5, 'Rápida entrega', '2025-03-31 05:53:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (169, 16365022, 3, '2024-06-02 11:50:00', 263891.00, 19791.83, 244099.17);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (169, 275, 2, 41239.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (169, 141, 2, 39521.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (169, 107, 2, 34618.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (169, 329, 1, 33135.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (169, 2, 'No cumplió expectativas', '2024-06-03 18:50:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (170, 11326969, 3, '2023-11-22 16:59:00', 159310.00, 0.00, 159310.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (170, 227, 2, 33542.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (170, 220, 2, 35996.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (170, 194, 2, 10117.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (170, 3, '', '2023-11-24 18:59:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (171, 14036047, 2, '2023-06-18 19:31:00', 379335.00, 0.00, 379335.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (171, 222, 2, 44043.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (171, 286, 1, 23891.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (171, 196, 2, 46217.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (171, 305, 2, 87462.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (171, 6, 'Muy satisfecho', '2023-06-22 00:31:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (172, 21895059, 2, '2023-12-11 18:48:00', 105797.00, 5289.85, 100507.15);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (172, 275, 1, 41239.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (172, 178, 2, 32279.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (172, 8, 'Producto defectuoso', '2023-12-12 21:48:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (173, 14873924, 2, '2023-06-23 18:53:00', 112655.00, 0.00, 112655.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (173, 181, 2, 23808.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (173, 202, 2, 17312.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (173, 239, 1, 30415.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (173, 5, 'Muy satisfecho', '2023-06-25 21:53:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (174, 24528665, 4, '2024-09-21 11:34:00', 91414.00, 0.00, 91414.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (174, 302, 2, 45707.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (174, 3, '', '2024-09-23 22:34:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (175, 20801516, 2, '2025-03-25 17:16:00', 186638.00, 0.00, 186638.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (175, 233, 2, 31744.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (175, 271, 2, 31851.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (175, 344, 1, 34794.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (175, 232, 1, 24654.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (175, 10, 'Rápida entrega', '2025-03-26 23:16:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (176, 15578043, 3, '2025-01-04 17:06:00', 262912.00, 0.00, 262912.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (176, 174, 2, 31289.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (176, 234, 1, 25326.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (176, 158, 2, 75626.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (176, 349, 2, 11878.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (176, 2, '', '2025-01-07 00:06:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (177, 17773770, 3, '2025-05-22 18:57:00', 160578.00, 0.00, 160578.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (177, 199, 1, 85567.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (177, 163, 2, 22287.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (177, 132, 1, 30437.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (177, 6, 'Excelente servicio!', '2025-05-24 04:57:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (178, 11647735, 2, '2024-01-13 11:47:00', 17541.00, 877.05, 16663.95);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (178, 211, 1, 17541.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (178, 3, 'No cumplió expectativas', '2024-01-15 19:47:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (179, 8800481, 4, '2023-07-03 10:48:00', 16902.00, 0.00, 16902.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (179, 118, 2, 8451.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (179, 4, 'Excelente servicio!', '2023-07-05 19:48:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (180, 8731592, 3, '2023-09-21 12:41:00', 98513.00, 4925.65, 93587.35);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (180, 298, 1, 22621.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (180, 310, 2, 26042.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (180, 181, 1, 23808.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (180, 4, 'No cumplió expectativas', '2023-09-22 20:41:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (181, 18143219, 4, '2023-09-23 13:41:00', 146113.00, 7305.65, 138807.35);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (181, 210, 1, 18625.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (181, 334, 2, 31788.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (181, 115, 2, 31956.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (181, 7, 'Producto defectuoso', '2023-09-27 00:41:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (182, 10648897, 1, '2023-11-17 10:11:00', 46460.00, 0.00, 46460.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (182, 242, 1, 46460.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (182, 10, 'Muy satisfecho', '2023-11-20 22:11:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (183, 16603086, 4, '2023-08-12 17:47:00', 34689.00, 2601.67, 32087.33);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (183, 240, 1, 34689.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (183, 8, '', '2023-08-14 23:47:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (184, 22842661, 1, '2025-04-18 14:05:00', 256909.00, 12845.45, 244063.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (184, 199, 1, 85567.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (184, 157, 2, 31242.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (184, 143, 1, 47270.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (184, 121, 2, 30794.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (184, 10, 'Excelente servicio!', '2025-04-21 22:05:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (185, 13991150, 1, '2025-01-14 14:37:00', 158630.00, 11897.25, 146732.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (185, 271, 2, 31851.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (185, 160, 2, 9450.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (185, 251, 1, 76028.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (185, 3, 'Rápida entrega', '2025-01-17 00:37:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (186, 23249014, 3, '2025-04-22 14:13:00', 150678.00, 11300.85, 139377.15);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (186, 209, 1, 35262.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (186, 273, 2, 25363.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (186, 349, 1, 11878.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (186, 254, 2, 26406.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (186, 3, 'Muy satisfecho', '2025-04-26 00:13:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (187, 22119900, 2, '2024-07-03 15:21:00', 71011.00, 0.00, 71011.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (187, 212, 2, 28341.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (187, 282, 1, 14329.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (187, 3, 'Producto defectuoso', '2024-07-06 21:21:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (188, 14000124, 3, '2025-04-30 18:04:00', 37013.00, 0.00, 37013.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (188, 294, 1, 18815.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (188, 161, 2, 9099.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (188, 3, 'Muy satisfecho', '2025-05-02 05:04:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (189, 10384683, 2, '2024-12-09 17:07:00', 118330.00, 8874.75, 109455.25);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (189, 318, 2, 11812.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (189, 329, 2, 33135.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (189, 216, 2, 14218.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (189, 9, 'No cumplió expectativas', '2024-12-13 00:07:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (190, 7645426, 3, '2025-05-08 19:58:00', 35137.00, 2635.28, 32501.72);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (190, 167, 1, 35137.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (190, 4, 'No cumplió expectativas', '2025-05-10 21:58:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (191, 18114538, 4, '2023-11-29 15:41:00', 194521.00, 0.00, 194521.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (191, 335, 1, 89402.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (191, 232, 2, 24654.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (191, 151, 1, 30082.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (191, 292, 1, 25729.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (191, 1, 'No cumplió expectativas', '2023-12-02 03:41:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (192, 9499691, 4, '2025-02-17 17:58:00', 93782.00, 0.00, 93782.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (192, 247, 1, 32956.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (192, 253, 2, 30413.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (192, 8, 'Muy satisfecho', '2025-02-19 18:58:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (193, 22127775, 3, '2024-08-12 14:00:00', 177591.00, 8879.55, 168711.45);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (193, 295, 1, 7790.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (193, 101, 1, 60625.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (193, 134, 2, 21463.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (193, 168, 2, 33125.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (193, 6, 'Muy satisfecho', '2024-08-14 15:00:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (194, 15018361, 3, '2024-02-10 19:17:00', 306022.00, 22951.65, 283070.35);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (194, 126, 2, 74588.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (194, 312, 1, 85525.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (194, 151, 1, 30082.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (194, 275, 1, 41239.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (194, 2, 'No cumplió expectativas', '2024-02-12 06:17:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (195, 19602503, 4, '2024-03-24 12:14:00', 43183.00, 3238.72, 39944.28);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (195, 135, 1, 17454.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (195, 292, 1, 25729.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (195, 8, 'Producto defectuoso', '2024-03-26 13:14:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (196, 11219514, 2, '2024-01-11 10:26:00', 133783.00, 6689.15, 127093.85);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (196, 332, 1, 24252.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (196, 250, 1, 40405.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (196, 182, 2, 34563.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (196, 9, 'No cumplió expectativas', '2024-01-12 21:26:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (197, 23142237, 2, '2024-10-17 11:53:00', 43592.00, 3269.40, 40322.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (197, 200, 1, 35141.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (197, 118, 1, 8451.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (197, 5, 'Excelente servicio!', '2024-10-18 20:53:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (198, 19602503, 3, '2023-08-26 17:32:00', 44512.00, 3338.40, 41173.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (198, 262, 1, 9374.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (198, 237, 1, 35138.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (198, 6, 'Producto defectuoso', '2023-08-28 22:32:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (199, 22841480, 2, '2023-08-29 13:07:00', 125677.00, 9425.77, 116251.23);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (199, 253, 1, 30413.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (199, 334, 1, 31788.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (199, 340, 2, 31738.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (199, 10, 'Muy satisfecho', '2023-09-01 00:07:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (200, 19099261, 2, '2024-01-02 11:13:00', 14844.00, 0.00, 14844.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (200, 324, 1, 14844.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (200, 7, '', '2024-01-03 12:13:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (201, 18769513, 2, '2025-05-12 13:42:00', 94226.00, 4711.30, 89514.70);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (201, 161, 2, 9099.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (201, 251, 1, 76028.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (201, 10, '', '2025-05-14 21:42:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (202, 18887268, 3, '2024-01-30 18:35:00', 91056.00, 0.00, 91056.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (202, 207, 1, 11044.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (202, 231, 1, 28330.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (202, 341, 2, 25841.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (202, 8, 'Producto defectuoso', '2024-02-01 22:35:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (203, 18720339, 1, '2024-08-05 12:30:00', 30935.00, 2320.12, 28614.88);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (203, 290, 1, 30935.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (203, 3, 'Excelente servicio!', '2024-08-07 22:30:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (204, 15029440, 3, '2024-12-30 13:21:00', 203218.00, 10160.90, 193057.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (204, 178, 1, 32279.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (204, 336, 1, 87267.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (204, 102, 2, 41836.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (204, 1, 'Producto defectuoso', '2025-01-03 01:21:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (205, 11397346, 1, '2025-03-25 10:21:00', 31919.00, 1595.95, 30323.05);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (205, 316, 1, 31919.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (205, 6, 'Muy satisfecho', '2025-03-27 21:21:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (206, 14176134, 1, '2023-12-04 15:34:00', 163977.00, 12298.27, 151678.73);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (206, 312, 1, 85525.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (206, 209, 1, 35262.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (206, 214, 2, 21595.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (206, 10, 'No cumplió expectativas', '2023-12-05 21:34:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (207, 22238356, 4, '2024-09-04 14:04:00', 85065.00, 4253.25, 80811.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (207, 294, 1, 18815.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (207, 168, 2, 33125.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (207, 6, 'No cumplió expectativas', '2024-09-06 02:04:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (208, 8310981, 4, '2023-08-12 15:06:00', 135838.00, 0.00, 135838.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (208, 276, 2, 29128.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (208, 191, 2, 38791.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (208, 1, 'Excelente servicio!', '2023-08-13 21:06:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (209, 19973850, 4, '2024-03-16 11:32:00', 142915.00, 7145.75, 135769.25);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (209, 106, 1, 24517.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (209, 128, 2, 30730.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (209, 269, 2, 28469.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (209, 2, 'Excelente servicio!', '2024-03-17 14:32:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (210, 7372723, 1, '2025-02-19 11:38:00', 85567.00, 4278.35, 81288.65);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (210, 199, 1, 85567.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (210, 5, 'Muy satisfecho', '2025-02-21 14:38:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (211, 11564881, 2, '2025-04-09 14:36:00', 190493.00, 9524.65, 180968.35);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (211, 248, 2, 27827.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (211, 126, 1, 74588.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (211, 175, 1, 28332.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (211, 316, 1, 31919.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (211, 4, '', '2025-04-12 15:36:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (212, 23690120, 2, '2024-02-13 18:26:00', 56682.00, 4251.15, 52430.85);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (212, 212, 2, 28341.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (212, 4, '', '2024-02-16 19:26:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (213, 16747736, 1, '2024-04-07 14:58:00', 95278.00, 7145.85, 88132.15);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (213, 107, 2, 34618.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (213, 310, 1, 26042.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (213, 9, 'Excelente servicio!', '2024-04-08 21:58:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (214, 18148211, 3, '2023-08-06 16:35:00', 115213.00, 8640.98, 106572.02);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (214, 312, 1, 85525.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (214, 324, 2, 14844.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (214, 1, '', '2023-08-07 22:35:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (215, 7073090, 2, '2024-02-16 15:47:00', 96689.00, 7251.68, 89437.32);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (215, 103, 1, 50472.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (215, 196, 1, 46217.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (215, 10, 'Muy satisfecho', '2024-02-19 00:47:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (216, 18970477, 4, '2024-12-07 18:05:00', 102012.00, 5100.60, 96911.40);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (216, 274, 2, 18177.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (216, 170, 1, 27396.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (216, 211, 1, 17541.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (216, 110, 1, 20721.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (216, 7, 'Rápida entrega', '2024-12-09 22:05:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (217, 14212314, 2, '2024-08-26 10:00:00', 218354.00, 10917.70, 207436.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (217, 322, 1, 60016.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (217, 344, 1, 34794.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (217, 325, 2, 24828.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (217, 203, 2, 36944.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (217, 10, '', '2024-08-27 13:00:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (218, 18720339, 3, '2024-11-07 15:32:00', 82751.00, 6206.32, 76544.68);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (218, 129, 2, 29333.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (218, 297, 1, 24085.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (218, 3, 'Excelente servicio!', '2024-11-10 00:32:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (219, 17741929, 2, '2025-02-08 13:43:00', 132986.00, 9973.95, 123012.05);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (219, 315, 1, 25691.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (219, 302, 1, 45707.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (219, 121, 2, 30794.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (219, 4, 'No cumplió expectativas', '2025-02-12 01:43:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (220, 23142237, 3, '2024-02-08 15:03:00', 70274.00, 5270.55, 65003.45);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (220, 167, 2, 35137.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (220, 7, '', '2024-02-09 19:03:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (221, 23692459, 2, '2025-01-08 11:27:00', 193327.00, 14499.52, 178827.48);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (221, 200, 2, 35141.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (221, 178, 1, 32279.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (221, 270, 2, 45383.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (221, 4, 'Muy satisfecho', '2025-01-11 15:27:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (222, 24266257, 1, '2023-12-12 15:48:00', 42442.00, 2122.10, 40319.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (222, 218, 1, 42442.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (222, 5, 'Muy satisfecho', '2023-12-14 02:48:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (223, 18712302, 3, '2024-09-06 16:18:00', 253632.00, 19022.40, 234609.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (223, 302, 2, 45707.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (223, 165, 2, 30637.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (223, 103, 2, 50472.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (223, 5, 'Excelente servicio!', '2024-09-09 21:18:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (224, 17559583, 3, '2024-07-17 12:58:00', 226416.00, 0.00, 226416.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (224, 319, 2, 27621.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (224, 231, 1, 28330.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (224, 224, 2, 40133.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (224, 174, 2, 31289.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (224, 3, 'Excelente servicio!', '2024-07-20 18:58:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (225, 7645426, 4, '2023-09-18 15:13:00', 32956.00, 2471.70, 30484.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (225, 247, 1, 32956.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (225, 6, 'Producto defectuoso', '2023-09-22 01:13:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (226, 10456934, 2, '2024-12-21 13:12:00', 289560.00, 0.00, 289560.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (226, 320, 2, 85862.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (226, 297, 2, 24085.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (226, 216, 1, 14218.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (226, 256, 2, 27724.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (226, 1, 'Excelente servicio!', '2024-12-23 16:12:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (227, 7049174, 3, '2023-09-15 17:53:00', 153707.00, 11528.02, 142178.98);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (227, 272, 2, 33154.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (227, 184, 2, 26020.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (227, 127, 1, 35359.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (227, 3, 'Producto defectuoso', '2023-09-17 02:53:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (228, 19672770, 3, '2023-08-23 10:26:00', 141443.00, 0.00, 141443.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (228, 106, 2, 24517.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (228, 247, 1, 32956.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (228, 238, 1, 41970.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (228, 301, 1, 17483.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (228, 1, 'Rápida entrega', '2023-08-24 20:26:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (229, 12417402, 2, '2025-01-28 12:55:00', 320807.00, 24060.52, 296746.47);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (229, 320, 2, 85862.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (229, 113, 1, 44620.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (229, 245, 1, 23653.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (229, 250, 2, 40405.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (229, 4, 'Muy satisfecho', '2025-01-29 18:55:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (230, 15672821, 1, '2024-03-23 16:14:00', 10117.00, 505.85, 9611.15);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (230, 194, 1, 10117.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (230, 6, 'Muy satisfecho', '2024-03-25 21:14:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (231, 19341504, 3, '2024-03-26 11:10:00', 92276.00, 6920.70, 85355.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (231, 110, 2, 20721.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (231, 252, 2, 25417.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (231, 9, 'Producto defectuoso', '2024-03-29 14:10:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (232, 11329702, 1, '2024-08-21 15:31:00', 73105.00, 3655.25, 69449.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (232, 167, 1, 35137.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (232, 321, 2, 10062.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (232, 205, 1, 17844.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (232, 1, 'Muy satisfecho', '2024-08-22 19:31:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (233, 18261227, 2, '2024-02-09 12:21:00', 35937.00, 2695.28, 33241.72);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (233, 202, 1, 17312.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (233, 210, 1, 18625.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (233, 6, '', '2024-02-10 14:21:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (234, 13893899, 3, '2023-09-16 19:48:00', 88664.00, 0.00, 88664.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (234, 105, 2, 24467.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (234, 350, 1, 20915.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (234, 294, 1, 18815.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (234, 5, 'No cumplió expectativas', '2023-09-18 03:48:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (235, 18970477, 3, '2023-06-22 13:20:00', 56660.00, 2833.00, 53827.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (235, 231, 2, 28330.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (235, 8, 'Muy satisfecho', '2023-06-24 16:20:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (236, 23249014, 4, '2023-11-19 18:35:00', 50948.00, 3821.10, 47126.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (236, 140, 2, 25474.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (236, 1, 'Rápida entrega', '2023-11-21 19:35:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (237, 20080197, 4, '2024-05-29 11:26:00', 24283.00, 0.00, 24283.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (237, 195, 1, 24283.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (237, 2, 'Excelente servicio!', '2024-05-31 17:26:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (238, 16071297, 1, '2023-08-30 13:06:00', 86002.00, 0.00, 86002.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (238, 112, 1, 86002.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (238, 1, 'Rápida entrega', '2023-09-02 19:06:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (239, 21480442, 2, '2025-04-02 16:25:00', 165222.00, 12391.65, 152830.35);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (239, 312, 1, 85525.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (239, 190, 1, 18362.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (239, 346, 1, 61335.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (239, 7, 'No cumplió expectativas', '2025-04-05 21:25:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (240, 23692459, 2, '2023-10-16 14:21:00', 149322.00, 11199.15, 138122.85);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (240, 131, 2, 44141.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (240, 299, 2, 30520.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (240, 1, 'Excelente servicio!', '2023-10-18 18:21:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (241, 19245971, 4, '2024-06-05 19:10:00', 45675.00, 0.00, 45675.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (241, 219, 1, 45675.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (241, 5, 'No cumplió expectativas', '2024-06-09 03:10:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (242, 11933319, 1, '2024-05-11 16:47:00', 107742.00, 8080.65, 99661.35);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (242, 350, 2, 20915.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (242, 247, 2, 32956.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (242, 9, 'Muy satisfecho', '2024-05-13 23:47:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (243, 14470206, 4, '2024-08-14 14:17:00', 170812.00, 8540.60, 162271.40);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (243, 181, 2, 23808.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (243, 232, 2, 24654.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (243, 203, 2, 36944.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (243, 1, '', '2024-08-15 15:17:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (244, 12141352, 3, '2024-11-25 16:23:00', 21742.00, 0.00, 21742.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (244, 183, 1, 21742.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (244, 9, 'Muy satisfecho', '2024-11-27 01:23:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (245, 8802987, 2, '2023-08-01 12:55:00', 127120.00, 9534.00, 117586.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (245, 270, 2, 45383.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (245, 274, 2, 18177.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (245, 6, 'Excelente servicio!', '2023-08-02 20:55:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (246, 11285442, 1, '2025-01-12 19:44:00', 41239.00, 0.00, 41239.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (246, 275, 1, 41239.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (246, 2, 'Producto defectuoso', '2025-01-14 01:44:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (247, 6626531, 1, '2024-05-30 19:39:00', 111873.00, 0.00, 111873.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (247, 287, 1, 25305.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (247, 122, 1, 86568.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (247, 7, 'Producto defectuoso', '2024-05-31 21:39:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (248, 16794102, 3, '2025-06-10 11:14:00', 23653.00, 1773.97, 21879.03);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (248, 245, 1, 23653.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (248, 3, 'No cumplió expectativas', '2025-06-11 22:14:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (249, 17773770, 2, '2024-06-28 14:36:00', 37236.00, 0.00, 37236.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (249, 289, 2, 18618.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (249, 2, '', '2024-06-30 22:36:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (250, 19672770, 1, '2023-07-05 17:03:00', 136495.00, 0.00, 136495.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (250, 234, 2, 25326.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (250, 207, 2, 11044.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (250, 123, 1, 26505.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (250, 210, 2, 18625.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (250, 6, 'Muy satisfecho', '2023-07-07 04:03:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (251, 19476479, 4, '2023-11-12 15:53:00', 150217.00, 11266.27, 138950.73);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (251, 222, 1, 44043.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (251, 315, 2, 25691.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (251, 170, 2, 27396.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (251, 4, 'Rápida entrega', '2023-11-15 20:53:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (252, 19415989, 1, '2025-04-02 12:10:00', 145454.00, 7272.70, 138181.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (252, 145, 2, 18741.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (252, 332, 2, 24252.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (252, 267, 1, 29386.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (252, 151, 1, 30082.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (252, 2, 'Muy satisfecho', '2025-04-04 17:10:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (253, 17317212, 3, '2025-03-28 12:18:00', 144160.00, 10812.00, 133348.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (253, 290, 2, 30935.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (253, 208, 1, 28576.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (253, 262, 2, 9374.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (253, 301, 2, 17483.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (253, 10, 'Producto defectuoso', '2025-03-29 22:18:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (254, 7073090, 2, '2023-08-30 14:22:00', 30818.00, 2311.35, 28506.65);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (254, 192, 1, 30818.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (254, 10, 'Rápida entrega', '2023-09-03 01:22:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (255, 20214895, 1, '2025-05-29 19:50:00', 135935.00, 10195.12, 125739.88);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (255, 186, 2, 15301.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (255, 108, 1, 75323.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (255, 225, 1, 30010.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (255, 3, 'Rápida entrega', '2025-05-31 21:50:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (256, 16761841, 4, '2024-08-07 14:31:00', 44574.00, 2228.70, 42345.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (256, 163, 2, 22287.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (256, 6, 'Excelente servicio!', '2024-08-08 17:31:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (257, 11777686, 3, '2023-06-19 14:37:00', 132597.00, 9944.77, 122652.23);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (257, 269, 1, 28469.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (257, 325, 1, 24828.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (257, 288, 1, 34058.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (257, 298, 2, 22621.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (257, 3, 'Excelente servicio!', '2023-06-21 17:37:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (258, 17741929, 3, '2025-04-22 14:08:00', 61514.00, 4613.55, 56900.45);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (258, 154, 1, 25346.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (258, 333, 2, 18084.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (258, 8, 'Muy satisfecho', '2025-04-26 01:08:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (259, 23321021, 1, '2025-02-14 18:51:00', 35554.00, 1777.70, 33776.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (259, 173, 2, 17777.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (259, 10, 'No cumplió expectativas', '2025-02-16 06:51:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (260, 20032892, 3, '2023-10-10 19:58:00', 66943.00, 5020.72, 61922.28);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (260, 153, 1, 31408.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (260, 186, 1, 15301.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (260, 194, 2, 10117.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (260, 1, 'Producto defectuoso', '2023-10-13 04:58:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (261, 8167670, 1, '2025-01-29 11:06:00', 109623.00, 5481.15, 104141.85);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (261, 328, 2, 44354.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (261, 350, 1, 20915.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (261, 10, 'Excelente servicio!', '2025-02-01 22:06:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (262, 15562520, 3, '2024-04-21 18:46:00', 66761.00, 0.00, 66761.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (262, 213, 1, 21519.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (262, 298, 2, 22621.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (262, 10, 'Producto defectuoso', '2024-04-24 05:46:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (263, 15562520, 4, '2025-04-27 13:34:00', 164298.00, 0.00, 164298.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (263, 260, 1, 25242.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (263, 238, 1, 41970.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (263, 309, 1, 36046.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (263, 299, 2, 30520.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (263, 2, 'Excelente servicio!', '2025-04-28 21:34:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (264, 21903749, 1, '2023-11-09 10:16:00', 139053.00, 10428.98, 128624.02);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (264, 348, 2, 31865.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (264, 108, 1, 75323.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (264, 10, 'Rápida entrega', '2023-11-12 18:16:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (265, 6549300, 3, '2024-01-08 14:45:00', 345313.00, 25898.47, 319414.53);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (265, 243, 2, 49945.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (265, 288, 2, 34058.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (265, 251, 2, 76028.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (265, 155, 1, 25251.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (265, 3, 'No cumplió expectativas', '2024-01-10 15:45:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (266, 12011563, 3, '2024-01-06 17:32:00', 129051.00, 6452.55, 122598.45);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (266, 210, 2, 18625.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (266, 213, 2, 21519.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (266, 178, 1, 32279.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (266, 130, 1, 16484.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (266, 3, 'Excelente servicio!', '2024-01-07 22:32:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (267, 18348340, 4, '2024-08-19 14:31:00', 179495.00, 0.00, 179495.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (267, 333, 2, 18084.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (267, 189, 2, 59430.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (267, 105, 1, 24467.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (267, 4, 'No cumplió expectativas', '2024-08-21 00:31:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (268, 8713513, 3, '2024-07-19 18:02:00', 53010.00, 3975.75, 49034.25);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (268, 123, 2, 26505.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (268, 1, '', '2024-07-23 05:02:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (269, 21027149, 1, '2023-11-22 14:23:00', 60830.00, 4562.25, 56267.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (269, 239, 2, 30415.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (269, 6, 'Producto defectuoso', '2023-11-23 20:23:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (270, 17317212, 3, '2023-09-11 15:38:00', 45976.00, 3448.20, 42527.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (270, 223, 1, 25061.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (270, 350, 1, 20915.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (270, 5, 'Muy satisfecho', '2023-09-13 22:38:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (271, 16042835, 3, '2024-02-19 15:17:00', 160191.00, 0.00, 160191.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (271, 268, 2, 23779.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (271, 223, 2, 25061.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (271, 168, 1, 33125.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (271, 267, 1, 29386.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (271, 5, 'Rápida entrega', '2024-02-20 20:17:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (272, 21903749, 4, '2024-11-26 17:06:00', 77977.00, 5848.27, 72128.73);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (272, 337, 1, 77977.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (272, 8, 'No cumplió expectativas', '2024-11-28 01:06:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (273, 17608826, 1, '2024-07-17 12:00:00', 51382.00, 0.00, 51382.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (273, 315, 2, 25691.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (273, 4, 'Excelente servicio!', '2024-07-19 16:00:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (274, 24923043, 4, '2025-03-28 14:12:00', 214979.00, 0.00, 214979.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (274, 209, 2, 35262.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (274, 219, 1, 45675.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (274, 297, 2, 24085.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (274, 287, 2, 25305.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (274, 2, 'Excelente servicio!', '2025-03-30 16:12:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (275, 10935421, 1, '2023-10-28 18:58:00', 183248.00, 0.00, 183248.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (275, 305, 1, 87462.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (275, 214, 1, 21595.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (275, 288, 1, 34058.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (275, 224, 1, 40133.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (275, 6, 'Producto defectuoso', '2023-10-30 03:58:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (276, 21397229, 1, '2023-08-02 19:22:00', 71039.00, 0.00, 71039.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (276, 257, 2, 19380.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (276, 178, 1, 32279.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (276, 7, 'No cumplió expectativas', '2023-08-04 20:22:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (277, 16490602, 3, '2023-07-17 18:52:00', 80963.00, 6072.22, 74890.77);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (277, 141, 1, 39521.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (277, 110, 2, 20721.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (277, 5, 'Rápida entrega', '2023-07-20 20:52:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (278, 18236669, 2, '2025-04-06 16:18:00', 52040.00, 3903.00, 48137.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (278, 184, 2, 26020.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (278, 5, 'No cumplió expectativas', '2025-04-09 00:18:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (279, 15750161, 2, '2024-09-09 14:33:00', 184038.00, 13802.85, 170235.15);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (279, 326, 2, 32481.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (279, 131, 2, 44141.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (279, 121, 1, 30794.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (279, 6, 'Rápida entrega', '2024-09-10 18:33:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (280, 15576565, 3, '2024-11-06 17:37:00', 233696.00, 11684.80, 222011.20);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (280, 198, 1, 74937.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (280, 191, 1, 38791.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (280, 208, 2, 28576.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (280, 153, 2, 31408.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (280, 2, 'Muy satisfecho', '2024-11-08 22:37:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (281, 14542389, 1, '2025-01-25 14:22:00', 117096.00, 5854.80, 111241.20);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (281, 109, 2, 58548.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (281, 9, 'Excelente servicio!', '2025-01-27 20:22:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (282, 16013309, 1, '2024-12-21 16:00:00', 123948.00, 6197.40, 117750.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (282, 234, 1, 25326.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (282, 267, 1, 29386.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (282, 107, 2, 34618.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (282, 9, 'Muy satisfecho', '2024-12-22 21:00:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (283, 8457139, 1, '2024-06-03 12:04:00', 20124.00, 0.00, 20124.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (283, 321, 2, 10062.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (283, 3, '', '2024-06-06 19:04:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (284, 18769513, 1, '2024-02-29 18:47:00', 191227.00, 9561.35, 181665.65);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (284, 348, 2, 31865.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (284, 203, 2, 36944.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (284, 294, 1, 18815.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (284, 344, 1, 34794.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (284, 1, 'Rápida entrega', '2024-03-02 02:47:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (285, 15451442, 3, '2025-04-04 14:48:00', 30935.00, 0.00, 30935.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (285, 290, 1, 30935.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (285, 5, 'Rápida entrega', '2025-04-07 01:48:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (286, 10384683, 2, '2024-06-16 18:57:00', 120292.00, 9021.90, 111270.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (286, 226, 2, 60146.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (286, 3, 'Rápida entrega', '2024-06-20 00:57:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (287, 22476316, 1, '2024-08-02 15:32:00', 87506.00, 6562.95, 80943.05);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (287, 184, 1, 26020.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (287, 272, 1, 33154.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (287, 175, 1, 28332.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (287, 3, 'Producto defectuoso', '2024-08-04 01:32:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (288, 23321021, 3, '2024-09-17 16:16:00', 108121.00, 5406.05, 102714.95);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (288, 229, 2, 10378.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (288, 192, 2, 30818.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (288, 292, 1, 25729.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (288, 9, 'Excelente servicio!', '2024-09-21 01:16:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (289, 10810817, 1, '2024-05-14 12:46:00', 158462.00, 0.00, 158462.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (289, 246, 2, 11820.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (289, 246, 2, 11820.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (289, 206, 2, 45009.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (289, 172, 2, 10582.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (289, 2, 'No cumplió expectativas', '2024-05-16 14:46:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (290, 17773770, 3, '2025-06-08 18:15:00', 35137.00, 0.00, 35137.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (290, 167, 1, 35137.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (290, 9, 'Muy satisfecho', '2025-06-09 23:15:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (291, 14383316, 4, '2023-08-29 12:10:00', 87463.00, 0.00, 87463.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (291, 228, 1, 50799.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (291, 291, 1, 36664.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (291, 6, 'No cumplió expectativas', '2023-08-31 22:10:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (292, 22148796, 4, '2023-12-26 19:54:00', 71317.00, 0.00, 71317.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (292, 132, 2, 30437.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (292, 278, 1, 10443.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (292, 9, '', '2023-12-27 21:54:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (293, 19476479, 4, '2024-01-08 13:32:00', 57587.00, 4319.02, 53267.97);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (293, 224, 1, 40133.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (293, 135, 1, 17454.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (293, 6, 'Rápida entrega', '2024-01-10 21:32:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (294, 21027149, 4, '2023-11-09 13:42:00', 242058.00, 18154.35, 223903.65);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (294, 297, 1, 24085.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (294, 178, 1, 32279.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (294, 308, 2, 77904.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (294, 283, 1, 29886.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (294, 1, '', '2023-11-12 20:42:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (295, 9384676, 1, '2024-11-29 13:49:00', 108371.00, 35220.57, 73150.43);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (295, 202, 2, 17312.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (295, 202, 1, 17312.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (295, 184, 1, 26020.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (295, 239, 1, 30415.00);
INSERT INTO `venta_promocion` (`id_venta`, `id_promocion`) VALUES (295, 3);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (295, 4, 'No cumplió expectativas', '2024-12-01 00:49:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (296, 11095540, 4, '2024-07-24 17:18:00', 193798.00, 9689.90, 184108.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (296, 157, 2, 31242.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (296, 216, 1, 14218.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (296, 109, 2, 58548.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (296, 9, 'Producto defectuoso', '2024-07-25 22:18:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (297, 13981577, 2, '2023-10-07 14:37:00', 48934.00, 3670.05, 45263.95);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (297, 105, 2, 24467.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (297, 9, 'Rápida entrega', '2023-10-08 18:37:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (298, 16058467, 3, '2023-06-24 10:33:00', 139408.00, 0.00, 139408.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (298, 169, 2, 21630.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (298, 129, 2, 29333.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (298, 145, 2, 18741.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (298, 1, 'Muy satisfecho', '2023-06-27 21:33:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (299, 21933732, 2, '2024-07-09 10:13:00', 115984.00, 0.00, 115984.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (299, 194, 1, 10117.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (299, 214, 2, 21595.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (299, 349, 1, 11878.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (299, 228, 1, 50799.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (299, 6, 'Producto defectuoso', '2024-07-11 20:13:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (300, 15018361, 2, '2025-04-23 14:16:00', 115585.00, 8668.88, 106916.12);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (300, 287, 1, 25305.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (300, 244, 2, 26325.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (300, 294, 2, 18815.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (300, 4, '', '2025-04-27 01:16:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (301, 23142237, 2, '2024-04-24 15:51:00', 31289.00, 2346.67, 28942.33);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (301, 174, 1, 31289.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (301, 10, 'No cumplió expectativas', '2024-04-25 19:51:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (302, 15316622, 4, '2024-08-17 16:38:00', 260908.00, 13045.40, 247862.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (302, 185, 2, 31192.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (302, 336, 1, 87267.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (302, 177, 1, 47555.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (302, 271, 2, 31851.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (302, 3, 'No cumplió expectativas', '2024-08-19 04:38:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (303, 18362647, 2, '2025-02-28 15:07:00', 249151.00, 18686.33, 230464.67);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (303, 207, 2, 11044.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (303, 280, 1, 87557.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (303, 150, 2, 24527.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (303, 347, 2, 45226.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (303, 5, 'Excelente servicio!', '2025-03-02 22:07:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (304, 24739397, 1, '2024-07-19 15:12:00', 136634.00, 0.00, 136634.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (304, 222, 2, 44043.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (304, 295, 2, 7790.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (304, 130, 2, 16484.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (304, 9, 'Excelente servicio!', '2024-07-21 19:12:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (305, 10862471, 1, '2024-11-07 10:37:00', 9111.00, 455.55, 8655.45);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (305, 171, 1, 9111.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (305, 5, '', '2024-11-10 15:37:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (306, 16403039, 1, '2025-01-01 12:47:00', 118450.00, 0.00, 118450.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (306, 260, 2, 25242.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (306, 230, 2, 33983.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (306, 3, '', '2025-01-04 23:47:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (307, 22103927, 2, '2024-05-15 18:37:00', 162609.00, 8130.45, 154478.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (307, 147, 2, 29865.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (307, 199, 1, 85567.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (307, 202, 1, 17312.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (307, 9, 'Rápida entrega', '2024-05-17 02:37:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (308, 24739229, 2, '2024-01-27 19:18:00', 115490.00, 8661.75, 106828.25);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (308, 184, 1, 26020.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (308, 133, 2, 35011.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (308, 162, 2, 9724.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (308, 6, '', '2024-01-30 04:18:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (309, 11668289, 3, '2024-09-10 15:42:00', 172798.00, 0.00, 172798.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (309, 278, 2, 10443.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (309, 267, 1, 29386.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (309, 281, 2, 30021.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (309, 157, 2, 31242.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (309, 9, 'Muy satisfecho', '2024-09-11 20:42:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (310, 14212314, 4, '2023-11-21 15:21:00', 24654.00, 1232.70, 23421.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (310, 232, 1, 24654.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (310, 6, 'Excelente servicio!', '2023-11-22 16:21:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (311, 8457139, 2, '2024-09-23 10:36:00', 143214.00, 0.00, 143214.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (311, 139, 1, 48400.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (311, 225, 2, 30010.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (311, 344, 1, 34794.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (311, 1, 'Producto defectuoso', '2024-09-24 15:36:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (312, 18387219, 1, '2024-07-21 13:29:00', 76424.00, 3821.20, 72602.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (312, 341, 2, 25841.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (312, 119, 1, 24742.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (312, 2, 'Muy satisfecho', '2024-07-23 17:29:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (313, 9145235, 2, '2025-01-27 17:19:00', 144697.00, 10852.27, 133844.73);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (313, 206, 2, 45009.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (313, 106, 1, 24517.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (313, 146, 2, 15081.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (313, 4, '', '2025-01-28 22:19:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (314, 13981577, 3, '2023-09-14 14:00:00', 122590.00, 9194.25, 113395.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (314, 272, 1, 33154.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (314, 259, 2, 12439.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (314, 178, 2, 32279.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (314, 1, 'Rápida entrega', '2023-09-15 18:00:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (315, 16761841, 4, '2025-02-16 13:30:00', 203451.00, 10172.55, 193278.45);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (315, 106, 1, 24517.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (315, 309, 2, 36046.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (315, 305, 1, 87462.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (315, 257, 1, 19380.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (315, 10, 'No cumplió expectativas', '2025-02-18 23:30:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (316, 11150464, 4, '2024-01-08 13:15:00', 153832.00, 7691.60, 146140.40);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (316, 203, 1, 36944.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (316, 140, 1, 25474.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (316, 302, 2, 45707.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (316, 1, 'Excelente servicio!', '2024-01-11 18:15:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (317, 7792300, 1, '2024-09-07 15:37:00', 156561.00, 7828.05, 148732.95);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (317, 306, 2, 34645.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (317, 241, 1, 87271.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (317, 5, 'No cumplió expectativas', '2024-09-08 17:37:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (318, 24805182, 4, '2024-06-27 12:03:00', 153466.00, 11509.95, 141956.05);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (318, 281, 1, 30021.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (318, 127, 1, 35359.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (318, 222, 2, 44043.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (318, 4, 'Producto defectuoso', '2024-06-30 21:03:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (319, 17412447, 1, '2023-06-20 13:33:00', 56332.00, 4224.90, 52107.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (319, 142, 1, 11323.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (319, 206, 1, 45009.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (319, 5, 'No cumplió expectativas', '2023-06-22 19:33:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (320, 23136434, 4, '2024-07-10 14:18:00', 149874.00, 11240.55, 138633.45);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (320, 198, 2, 74937.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (320, 7, 'No cumplió expectativas', '2024-07-11 18:18:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (321, 14548247, 3, '2023-11-09 17:50:00', 52248.00, 0.00, 52248.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (321, 236, 2, 26124.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (321, 8, 'Rápida entrega', '2023-11-13 05:50:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (322, 18020089, 2, '2023-11-15 15:45:00', 279790.00, 20984.25, 258805.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (322, 126, 2, 74588.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (322, 322, 2, 60016.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (322, 172, 1, 10582.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (322, 5, 'Rápida entrega', '2023-11-18 01:45:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (323, 22841480, 3, '2025-01-04 18:04:00', 66301.00, 4972.57, 61328.43);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (323, 340, 1, 31738.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (323, 182, 1, 34563.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (323, 6, 'Excelente servicio!', '2025-01-08 04:04:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (324, 17594194, 3, '2024-11-06 10:17:00', 133550.00, 10016.25, 123533.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (324, 214, 2, 21595.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (324, 125, 2, 45180.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (324, 7, 'No cumplió expectativas', '2024-11-07 19:17:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (325, 7726277, 2, '2024-09-08 15:26:00', 17541.00, 1315.58, 16225.42);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (325, 211, 1, 17541.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (325, 6, 'Rápida entrega', '2024-09-09 21:26:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (326, 15029440, 2, '2024-05-27 18:58:00', 93833.00, 4691.65, 89141.35);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (326, 163, 2, 22287.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (326, 119, 1, 24742.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (326, 106, 1, 24517.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (326, 10, 'Producto defectuoso', '2024-05-29 22:58:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (327, 21913030, 3, '2024-05-20 11:50:00', 59772.00, 4482.90, 55289.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (327, 283, 2, 29886.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (327, 5, 'No cumplió expectativas', '2024-05-22 21:50:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (328, 19040117, 4, '2024-10-09 16:23:00', 216480.00, 0.00, 216480.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (328, 169, 1, 21630.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (328, 322, 2, 60016.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (328, 128, 2, 30730.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (328, 258, 1, 13358.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (328, 8, 'No cumplió expectativas', '2024-10-13 04:23:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (329, 24266257, 4, '2025-05-13 14:05:00', 131410.00, 6570.50, 124839.50);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (329, 133, 1, 35011.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (329, 127, 1, 35359.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (329, 299, 2, 30520.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (329, 1, 'Muy satisfecho', '2025-05-15 19:05:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (330, 22752048, 1, '2024-10-11 11:29:00', 248950.00, 0.00, 248950.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (330, 158, 2, 75626.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (330, 111, 1, 25325.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (330, 167, 1, 35137.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (330, 289, 2, 18618.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (330, 10, 'Excelente servicio!', '2024-10-12 16:29:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (331, 14724171, 3, '2025-04-13 17:08:00', 121250.00, 6062.50, 115187.50);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (331, 101, 2, 60625.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (331, 1, 'Producto defectuoso', '2025-04-14 20:08:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (332, 21701886, 4, '2025-01-01 14:43:00', 185679.00, 9283.95, 176395.05);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (332, 346, 1, 61335.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (332, 240, 2, 34689.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (332, 298, 2, 22621.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (332, 162, 1, 9724.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (332, 10, '', '2025-01-02 15:43:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (333, 13763728, 4, '2024-11-21 10:25:00', 23051.00, 1728.83, 21322.17);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (333, 339, 1, 23051.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (333, 1, '', '2024-11-22 19:25:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (334, 14190341, 4, '2024-10-24 11:46:00', 210068.00, 0.00, 210068.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (334, 177, 2, 47555.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (334, 219, 2, 45675.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (334, 179, 2, 11804.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (334, 6, '', '2024-10-26 15:46:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (335, 23432705, 2, '2024-01-25 15:54:00', 101853.00, 7638.97, 94214.02);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (335, 138, 1, 32854.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (335, 211, 1, 17541.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (335, 292, 2, 25729.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (335, 4, 'No cumplió expectativas', '2024-01-28 03:54:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (336, 22079036, 4, '2024-08-23 13:52:00', 54770.00, 2738.50, 52031.50);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (336, 323, 2, 12950.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (336, 207, 1, 11044.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (336, 317, 2, 8913.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (336, 5, 'Rápida entrega', '2024-08-25 16:52:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (337, 11329702, 3, '2023-10-03 19:57:00', 102164.00, 5108.20, 97055.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (337, 306, 1, 34645.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (337, 182, 1, 34563.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (337, 247, 1, 32956.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (337, 4, 'No cumplió expectativas', '2023-10-07 00:57:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (338, 11095540, 4, '2024-04-18 19:54:00', 213858.00, 10692.90, 203165.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (338, 329, 2, 33135.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (338, 221, 2, 31958.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (338, 102, 2, 41836.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (338, 5, '', '2024-04-19 23:54:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (339, 17559583, 2, '2025-04-13 19:04:00', 111338.00, 0.00, 111338.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (339, 167, 2, 35137.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (339, 285, 1, 41064.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (339, 2, 'Rápida entrega', '2025-04-15 04:04:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (340, 18114538, 3, '2023-08-08 13:42:00', 87543.00, 0.00, 87543.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (340, 214, 1, 21595.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (340, 131, 1, 44141.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (340, 120, 1, 21807.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (340, 2, '', '2023-08-10 20:42:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (341, 15532952, 4, '2024-08-17 19:37:00', 151425.00, 11356.88, 140068.12);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (341, 293, 1, 42471.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (341, 114, 2, 10540.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (341, 185, 1, 31192.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (341, 212, 2, 28341.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (341, 9, '', '2024-08-19 04:37:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (342, 22495396, 1, '2023-11-15 11:31:00', 37630.00, 2822.25, 34807.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (342, 294, 2, 18815.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (342, 1, 'Muy satisfecho', '2023-11-17 17:31:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (343, 21236875, 4, '2023-09-09 11:36:00', 421555.00, 21077.75, 400477.25);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (343, 311, 1, 86401.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (343, 335, 2, 89402.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (343, 221, 2, 31958.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (343, 196, 2, 46217.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (343, 4, 'Muy satisfecho', '2023-09-10 16:36:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (344, 24266257, 2, '2024-08-02 17:19:00', 91051.00, 4552.55, 86498.45);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (344, 317, 1, 8913.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (344, 123, 2, 26505.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (344, 276, 1, 29128.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (344, 4, 'Excelente servicio!', '2024-08-04 21:19:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (345, 10606500, 2, '2024-07-05 16:34:00', 208442.00, 15633.15, 192808.85);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (345, 193, 2, 34526.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (345, 145, 2, 18741.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (345, 220, 1, 35996.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (345, 247, 2, 32956.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (345, 3, 'No cumplió expectativas', '2024-07-06 21:34:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (346, 17559583, 2, '2024-01-07 10:30:00', 89889.00, 0.00, 89889.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (346, 126, 1, 74588.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (346, 186, 1, 15301.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (346, 8, 'Muy satisfecho', '2024-01-10 14:30:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (347, 24732931, 1, '2024-03-17 18:21:00', 191685.00, 9584.25, 182100.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (347, 127, 1, 35359.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (347, 138, 2, 32854.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (347, 186, 2, 15301.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (347, 322, 1, 60016.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (347, 1, 'Producto defectuoso', '2024-03-20 06:21:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (348, 22752048, 2, '2025-01-24 12:01:00', 183040.00, 0.00, 183040.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (348, 133, 1, 35011.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (348, 219, 1, 45675.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (348, 309, 1, 36046.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (348, 272, 2, 33154.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (348, 9, 'No cumplió expectativas', '2025-01-26 13:01:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (349, 13203266, 1, '2025-04-19 18:14:00', 299418.00, 0.00, 299418.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (349, 241, 2, 87271.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (349, 115, 1, 31956.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (349, 242, 2, 46460.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (349, 1, 'Producto defectuoso', '2025-04-22 20:14:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (350, 13738320, 1, '2024-10-16 19:06:00', 46118.00, 0.00, 46118.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (350, 342, 1, 27896.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (350, 171, 2, 9111.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (350, 8, 'No cumplió expectativas', '2024-10-19 07:06:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (351, 22562564, 4, '2023-08-31 14:36:00', 57434.00, 4307.55, 53126.45);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (351, 274, 2, 18177.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (351, 114, 2, 10540.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (351, 10, 'Rápida entrega', '2023-09-03 20:36:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (352, 13358224, 2, '2024-02-11 14:54:00', 295369.00, 0.00, 295369.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (352, 343, 1, 13215.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (352, 241, 1, 87271.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (352, 206, 1, 45009.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (352, 198, 2, 74937.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (352, 6, 'Excelente servicio!', '2024-02-14 00:54:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (353, 19745012, 2, '2023-11-15 14:10:00', 189260.00, 14194.50, 175065.50);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (353, 252, 1, 25417.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (353, 305, 1, 87462.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (353, 292, 1, 25729.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (353, 234, 2, 25326.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (353, 8, 'Muy satisfecho', '2023-11-18 01:10:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (354, 18716077, 3, '2025-01-17 19:59:00', 22287.00, 1114.35, 21172.65);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (354, 163, 1, 22287.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (354, 4, '', '2025-01-20 23:59:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (355, 9941991, 3, '2023-08-28 15:13:00', 130265.00, 6513.25, 123751.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (355, 279, 1, 58095.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (355, 172, 1, 10582.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (355, 121, 2, 30794.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (355, 10, 'Producto defectuoso', '2023-08-31 18:13:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (356, 12544984, 1, '2023-09-24 13:18:00', 307274.00, 15363.70, 291910.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (356, 108, 2, 75323.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (356, 227, 2, 33542.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (356, 166, 1, 89544.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (356, 1, 'Producto defectuoso', '2023-09-25 23:18:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (357, 19514935, 3, '2025-02-20 15:40:00', 188869.00, 9443.45, 179425.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (357, 180, 1, 16401.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (357, 322, 1, 60016.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (357, 342, 2, 27896.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (357, 231, 2, 28330.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (357, 7, 'No cumplió expectativas', '2025-02-23 21:40:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (358, 19862271, 3, '2023-09-21 13:00:00', 139196.00, 0.00, 139196.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (358, 302, 2, 45707.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (358, 286, 2, 23891.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (358, 2, 'Muy satisfecho', '2023-09-23 00:00:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (359, 21933732, 1, '2024-05-29 19:23:00', 38066.00, 0.00, 38066.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (359, 277, 2, 19033.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (359, 3, '', '2024-06-02 05:23:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (360, 22238356, 1, '2024-04-19 16:43:00', 162253.00, 8112.65, 154140.35);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (360, 195, 1, 24283.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (360, 331, 1, 87468.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (360, 155, 2, 25251.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (360, 8, '', '2024-04-22 17:43:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (361, 14873924, 3, '2024-07-16 11:48:00', 251276.00, 0.00, 251276.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (361, 188, 2, 35573.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (361, 288, 2, 34058.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (361, 283, 1, 29886.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (361, 285, 2, 41064.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (361, 7, 'Muy satisfecho', '2024-07-19 20:48:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (362, 15029440, 3, '2023-08-05 12:23:00', 63684.00, 3184.20, 60499.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (362, 278, 2, 10443.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (362, 282, 1, 14329.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (362, 269, 1, 28469.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (362, 7, 'Producto defectuoso', '2023-08-08 23:23:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (363, 16071297, 3, '2023-09-13 18:48:00', 149162.00, 0.00, 149162.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (363, 216, 2, 14218.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (363, 307, 2, 17874.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (363, 343, 2, 13215.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (363, 109, 1, 58548.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (363, 8, 'Producto defectuoso', '2023-09-15 01:48:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (364, 15029440, 3, '2023-10-22 11:12:00', 157632.00, 7881.60, 149750.40);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (364, 133, 1, 35011.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (364, 140, 2, 25474.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (364, 286, 2, 23891.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (364, 286, 1, 23891.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (364, 9, 'No cumplió expectativas', '2023-10-24 12:12:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (365, 22536054, 2, '2024-06-17 19:17:00', 125928.00, 0.00, 125928.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (365, 276, 1, 29128.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (365, 139, 2, 48400.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (365, 10, 'No cumplió expectativas', '2024-06-18 21:17:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (366, 18261227, 3, '2023-11-01 18:07:00', 285966.00, 21447.45, 264518.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (366, 230, 2, 33983.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (366, 308, 1, 77904.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (366, 240, 2, 34689.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (366, 127, 2, 35359.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (366, 6, '', '2023-11-04 00:07:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (367, 14873924, 2, '2025-05-29 16:34:00', 135848.00, 0.00, 135848.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (367, 130, 2, 16484.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (367, 159, 1, 17308.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (367, 239, 2, 30415.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (367, 119, 1, 24742.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (367, 2, 'Excelente servicio!', '2025-05-31 00:34:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (368, 23535805, 4, '2023-09-05 13:19:00', 99779.00, 7483.42, 92295.57);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (368, 339, 2, 23051.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (368, 110, 1, 20721.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (368, 247, 1, 32956.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (368, 9, 'Rápida entrega', '2023-09-07 23:19:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (369, 10024996, 4, '2025-03-29 19:32:00', 143559.00, 0.00, 143559.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (369, 164, 1, 28237.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (369, 190, 1, 18362.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (369, 203, 1, 36944.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (369, 322, 1, 60016.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (369, 10, 'No cumplió expectativas', '2025-03-31 21:32:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (370, 14548247, 4, '2024-04-08 13:54:00', 14329.00, 0.00, 14329.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (370, 282, 1, 14329.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (370, 5, '', '2024-04-11 01:54:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (371, 23321021, 3, '2024-09-25 16:27:00', 277478.00, 13873.90, 263604.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (371, 104, 1, 31730.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (371, 212, 1, 28341.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (371, 331, 2, 87468.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (371, 293, 1, 42471.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (371, 9, '', '2024-09-26 23:27:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (372, 16242950, 2, '2024-08-01 19:16:00', 258942.00, 12947.10, 245994.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (372, 310, 2, 26042.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (372, 280, 2, 87557.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (372, 233, 1, 31744.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (372, 9, 'No cumplió expectativas', '2024-08-03 00:16:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (373, 10170463, 2, '2023-10-04 12:41:00', 222116.00, 0.00, 222116.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (373, 208, 2, 28576.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (373, 292, 1, 25729.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (373, 115, 2, 31956.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (373, 108, 1, 75323.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (373, 9, 'Producto defectuoso', '2023-10-07 23:41:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (374, 19922159, 4, '2023-06-13 17:28:00', 73824.00, 0.00, 73824.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (374, 310, 1, 26042.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (374, 286, 2, 23891.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (374, 7, 'Excelente servicio!', '2023-06-15 00:28:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (375, 20931146, 4, '2024-12-11 19:25:00', 201967.00, 10098.35, 191868.65);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (375, 237, 2, 35138.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (375, 275, 1, 41239.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (375, 347, 2, 45226.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (375, 7, 'Rápida entrega', '2024-12-13 05:25:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (376, 22214703, 3, '2023-10-22 19:32:00', 36724.00, 0.00, 36724.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (376, 190, 2, 18362.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (376, 9, 'Producto defectuoso', '2023-10-25 01:32:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (377, 21676843, 1, '2024-07-26 16:24:00', 212821.00, 10641.05, 202179.95);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (377, 216, 2, 14218.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (377, 108, 1, 75323.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (377, 187, 1, 18296.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (377, 270, 2, 45383.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (377, 10, 'No cumplió expectativas', '2024-07-28 19:24:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (378, 12075241, 3, '2024-09-28 18:01:00', 224426.00, 16831.95, 207594.05);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (378, 218, 2, 42442.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (378, 148, 1, 58264.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (378, 260, 2, 25242.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (378, 121, 1, 30794.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (378, 4, 'Producto defectuoso', '2024-10-01 22:01:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (379, 22495396, 4, '2024-05-06 19:00:00', 24874.00, 1865.55, 23008.45);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (379, 261, 2, 12437.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (379, 1, 'Excelente servicio!', '2024-05-07 21:00:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (380, 19672770, 4, '2024-02-23 10:56:00', 124721.00, 0.00, 124721.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (380, 216, 2, 14218.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (380, 133, 1, 35011.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (380, 165, 2, 30637.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (380, 9, 'Producto defectuoso', '2024-02-26 14:56:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (381, 20569492, 1, '2023-11-14 10:55:00', 84998.00, 4249.90, 80748.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (381, 314, 2, 24476.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (381, 309, 1, 36046.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (381, 7, 'Muy satisfecho', '2023-11-15 18:55:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (382, 9145235, 4, '2023-07-14 17:16:00', 184089.00, 13806.67, 170282.33);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (382, 348, 2, 31865.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (382, 282, 1, 14329.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (382, 200, 2, 35141.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (382, 307, 2, 17874.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (382, 6, 'No cumplió expectativas', '2023-07-17 03:16:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (383, 22214703, 1, '2023-07-08 17:17:00', 140819.00, 0.00, 140819.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (383, 168, 1, 33125.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (383, 184, 2, 26020.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (383, 248, 2, 27827.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (383, 10, 'No cumplió expectativas', '2023-07-12 03:17:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (384, 22284402, 1, '2025-02-19 12:08:00', 207205.00, 0.00, 207205.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (384, 290, 2, 30935.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (384, 297, 1, 24085.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (384, 101, 2, 60625.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (384, 4, 'Rápida entrega', '2025-02-21 21:08:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (385, 19922159, 1, '2025-01-19 10:23:00', 52040.00, 0.00, 52040.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (385, 184, 2, 26020.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (385, 1, 'Excelente servicio!', '2025-01-22 14:23:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (386, 9061361, 3, '2025-01-26 10:16:00', 53941.00, 2697.05, 51243.95);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (386, 277, 1, 19033.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (386, 135, 2, 17454.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (386, 3, 'Muy satisfecho', '2025-01-29 19:16:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (387, 14777816, 2, '2023-12-10 14:10:00', 211394.00, 15854.55, 195539.45);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (387, 151, 1, 30082.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (387, 340, 2, 31738.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (387, 328, 2, 44354.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (387, 276, 1, 29128.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (387, 6, 'Muy satisfecho', '2023-12-14 02:10:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (388, 16013309, 3, '2024-04-20 18:28:00', 133643.00, 6682.15, 126960.85);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (388, 275, 1, 41239.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (388, 261, 1, 12437.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (388, 157, 2, 31242.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (388, 301, 1, 17483.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (388, 4, '', '2024-04-24 01:28:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (389, 22148796, 4, '2023-11-15 16:16:00', 113708.00, 0.00, 113708.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (389, 297, 1, 24085.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (389, 197, 2, 36070.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (389, 301, 1, 17483.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (389, 3, 'Excelente servicio!', '2023-11-16 18:16:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (390, 9047555, 3, '2023-12-24 11:22:00', 172004.00, 12900.30, 159103.70);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (390, 112, 2, 86002.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (390, 4, 'Rápida entrega', '2023-12-25 18:22:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (391, 23690120, 1, '2023-07-05 11:46:00', 124277.00, 9320.77, 114956.23);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (391, 261, 2, 12437.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (391, 239, 1, 30415.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (391, 154, 2, 25346.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (391, 187, 1, 18296.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (391, 2, 'Excelente servicio!', '2023-07-08 19:46:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (392, 20616053, 2, '2023-12-23 16:36:00', 106775.00, 8008.12, 98766.88);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (392, 104, 1, 31730.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (392, 245, 1, 23653.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (392, 130, 1, 16484.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (392, 135, 2, 17454.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (392, 10, '', '2023-12-27 01:36:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (393, 19922159, 4, '2025-03-27 10:46:00', 130302.00, 0.00, 130302.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (393, 200, 2, 35141.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (393, 225, 2, 30010.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (393, 7, 'Producto defectuoso', '2025-03-29 19:46:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (394, 21460846, 4, '2025-05-08 14:25:00', 351634.00, 0.00, 351634.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (394, 121, 1, 30794.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (394, 113, 2, 44620.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (394, 331, 2, 87468.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (394, 175, 2, 28332.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (394, 7, 'Rápida entrega', '2025-05-10 23:25:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (395, 9599143, 1, '2025-03-28 11:55:00', 32576.00, 1628.80, 30947.20);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (395, 229, 2, 10378.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (395, 246, 1, 11820.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (395, 9, 'Rápida entrega', '2025-03-31 20:55:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (396, 22842661, 2, '2024-03-17 19:31:00', 106506.00, 5325.30, 101180.70);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (396, 204, 1, 33178.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (396, 291, 2, 36664.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (396, 6, 'Excelente servicio!', '2024-03-21 03:31:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (397, 13358224, 3, '2023-12-15 16:16:00', 145965.00, 0.00, 145965.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (397, 258, 1, 13358.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (397, 203, 1, 36944.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (397, 106, 1, 24517.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (397, 188, 2, 35573.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (397, 7, 'Excelente servicio!', '2023-12-17 17:16:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (398, 23559293, 4, '2023-07-26 14:43:00', 9332.00, 699.90, 8632.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (398, 284, 1, 9332.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (398, 4, 'Rápida entrega', '2023-07-28 21:43:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (399, 18648926, 2, '2025-04-26 11:25:00', 31384.00, 1569.20, 29814.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (399, 156, 1, 31384.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (399, 9, 'Producto defectuoso', '2025-04-29 20:25:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (400, 10606500, 2, '2024-03-03 13:40:00', 225899.00, 16942.42, 208956.58);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (400, 185, 1, 31192.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (400, 153, 2, 31408.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (400, 241, 1, 87271.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (400, 113, 1, 44620.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (400, 7, 'Rápida entrega', '2024-03-05 15:40:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (401, 16365022, 3, '2024-11-30 18:44:00', 31354.00, 10190.05, 21163.95);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (401, 162, 1, 9724.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (401, 169, 1, 21630.00);
INSERT INTO `venta_promocion` (`id_venta`, `id_promocion`) VALUES (401, 3);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (401, 2, 'Muy satisfecho', '2024-12-03 05:44:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (402, 22103927, 1, '2024-12-28 17:18:00', 141731.00, 7086.55, 134644.45);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (402, 298, 1, 22621.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (402, 158, 1, 75626.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (402, 183, 2, 21742.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (402, 4, 'Rápida entrega', '2024-12-30 05:18:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (403, 14036047, 3, '2024-10-14 10:39:00', 45383.00, 0.00, 45383.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (403, 270, 1, 45383.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (403, 9, '', '2024-10-16 12:39:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (404, 22829240, 1, '2024-11-01 11:35:00', 216278.00, 16220.85, 200057.15);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (404, 155, 2, 25251.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (404, 119, 2, 24742.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (404, 210, 2, 18625.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (404, 141, 2, 39521.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (404, 8, 'Producto defectuoso', '2024-11-02 13:35:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (405, 9599143, 4, '2025-01-10 10:54:00', 115302.00, 5765.10, 109536.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (405, 272, 2, 33154.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (405, 119, 1, 24742.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (405, 332, 1, 24252.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (405, 4, 'Producto defectuoso', '2025-01-11 17:54:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (406, 9693511, 2, '2024-01-06 19:35:00', 150646.00, 0.00, 150646.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (406, 108, 2, 75323.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (406, 9, 'No cumplió expectativas', '2024-01-09 06:35:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (407, 15520193, 2, '2023-08-02 19:33:00', 124281.00, 6214.05, 118066.95);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (407, 163, 2, 22287.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (407, 289, 2, 18618.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (407, 293, 1, 42471.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (407, 7, 'Muy satisfecho', '2023-08-04 03:33:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (408, 17594194, 4, '2024-07-15 18:01:00', 110348.00, 8276.10, 102071.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (408, 310, 2, 26042.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (408, 148, 1, 58264.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (408, 4, 'Muy satisfecho', '2024-07-19 02:01:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (409, 21895059, 2, '2024-05-14 19:55:00', 139432.00, 6971.60, 132460.40);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (409, 205, 2, 17844.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (409, 182, 2, 34563.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (409, 107, 1, 34618.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (409, 4, 'Muy satisfecho', '2024-05-17 21:55:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (410, 23692459, 2, '2024-09-15 12:34:00', 178804.00, 13410.30, 165393.70);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (410, 335, 2, 89402.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (410, 1, 'Rápida entrega', '2024-09-16 17:34:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (411, 19922159, 4, '2023-12-30 12:12:00', 117007.00, 0.00, 117007.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (411, 338, 1, 16990.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (411, 210, 1, 18625.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (411, 225, 1, 30010.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (411, 315, 2, 25691.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (411, 10, 'Producto defectuoso', '2024-01-02 14:12:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (412, 23559293, 1, '2023-11-17 12:34:00', 110211.00, 8265.82, 101945.18);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (412, 161, 1, 9099.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (412, 155, 2, 25251.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (412, 287, 2, 25305.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (412, 8, 'Producto defectuoso', '2023-11-20 17:34:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (413, 12141352, 4, '2025-03-04 17:49:00', 144944.00, 0.00, 144944.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (413, 318, 1, 11812.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (413, 231, 2, 28330.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (413, 179, 2, 11804.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (413, 345, 2, 26432.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (413, 1, '', '2025-03-07 02:49:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (414, 13903725, 1, '2025-03-24 10:37:00', 253670.00, 0.00, 253670.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (414, 308, 1, 77904.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (414, 287, 2, 25305.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (414, 174, 2, 31289.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (414, 174, 2, 31289.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (414, 9, 'Producto defectuoso', '2025-03-26 15:37:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (415, 21460846, 1, '2024-04-08 16:34:00', 69937.00, 0.00, 69937.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (415, 253, 2, 30413.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (415, 171, 1, 9111.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (415, 1, 'Muy satisfecho', '2024-04-11 00:34:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (416, 21413596, 1, '2023-12-13 14:00:00', 93299.00, 6997.43, 86301.57);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (416, 269, 1, 28469.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (416, 123, 2, 26505.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (416, 246, 1, 11820.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (416, 9, 'No cumplió expectativas', '2023-12-15 22:00:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (417, 18970477, 1, '2024-06-12 19:05:00', 294461.00, 14723.05, 279737.95);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (417, 198, 2, 74937.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (417, 101, 1, 60625.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (417, 262, 1, 9374.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (417, 126, 1, 74588.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (417, 2, 'Excelente servicio!', '2024-06-14 21:05:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (418, 19040117, 4, '2024-02-03 13:50:00', 219282.00, 0.00, 219282.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (418, 268, 2, 23779.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (418, 320, 2, 85862.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (418, 2, 'Rápida entrega', '2024-02-06 14:50:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (419, 14212314, 3, '2023-09-19 16:29:00', 11323.00, 566.15, 10756.85);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (419, 142, 1, 11323.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (419, 4, 'Producto defectuoso', '2023-09-23 01:29:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (420, 23134526, 1, '2024-09-03 16:46:00', 110032.00, 0.00, 110032.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (420, 289, 1, 18618.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (420, 302, 2, 45707.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (420, 8, 'Excelente servicio!', '2024-09-06 00:46:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (421, 20801516, 4, '2024-03-14 17:59:00', 67275.00, 0.00, 67275.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (421, 214, 2, 21595.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (421, 297, 1, 24085.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (421, 10, 'No cumplió expectativas', '2024-03-15 22:59:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (422, 15454026, 1, '2024-06-30 14:41:00', 165806.00, 8290.30, 157515.70);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (422, 170, 1, 27396.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (422, 329, 2, 33135.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (422, 197, 2, 36070.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (422, 6, 'No cumplió expectativas', '2024-07-02 02:41:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (423, 14470206, 2, '2024-06-02 19:01:00', 250562.00, 12528.10, 238033.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (423, 279, 2, 58095.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (423, 206, 2, 45009.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (423, 328, 1, 44354.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (423, 9, 'Excelente servicio!', '2024-06-05 23:01:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (424, 18648926, 3, '2024-05-22 18:39:00', 125211.00, 6260.55, 118950.45);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (424, 130, 1, 16484.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (424, 287, 1, 25305.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (424, 109, 1, 58548.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (424, 261, 2, 12437.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (424, 9, 'Excelente servicio!', '2024-05-26 03:39:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (425, 9328084, 1, '2023-08-15 13:33:00', 111568.00, 8367.60, 103200.40);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (425, 170, 1, 27396.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (425, 237, 1, 35138.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (425, 106, 2, 24517.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (425, 1, 'Rápida entrega', '2023-08-17 22:33:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (426, 7382287, 2, '2024-05-21 16:10:00', 190328.00, 14274.60, 176053.40);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (426, 218, 1, 42442.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (426, 342, 1, 27896.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (426, 144, 1, 59844.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (426, 226, 1, 60146.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (426, 4, 'Excelente servicio!', '2024-05-24 04:10:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (427, 15419183, 4, '2023-12-09 15:55:00', 283555.00, 21266.62, 262288.38);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (427, 322, 2, 60016.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (427, 311, 1, 86401.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (427, 261, 2, 12437.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (427, 236, 2, 26124.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (427, 7, 'Muy satisfecho', '2023-12-11 21:55:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (428, 24739229, 2, '2024-07-08 17:59:00', 49850.00, 3738.75, 46111.25);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (428, 114, 1, 10540.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (428, 313, 2, 19655.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (428, 2, 'Producto defectuoso', '2024-07-10 04:59:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (429, 15451442, 1, '2024-12-04 13:58:00', 30637.00, 0.00, 30637.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (429, 165, 1, 30637.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (429, 7, 'Rápida entrega', '2024-12-06 21:58:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (430, 14548247, 4, '2024-11-08 10:40:00', 171050.00, 0.00, 171050.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (430, 312, 2, 85525.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (430, 1, 'No cumplió expectativas', '2024-11-11 19:40:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (431, 7049174, 3, '2024-09-09 18:49:00', 146998.00, 11024.85, 135973.15);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (431, 149, 2, 24141.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (431, 133, 1, 35011.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (431, 317, 1, 8913.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (431, 170, 2, 27396.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (431, 4, 'No cumplió expectativas', '2024-09-12 00:49:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (432, 12492037, 3, '2023-11-26 11:39:00', 50610.00, 3795.75, 46814.25);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (432, 287, 2, 25305.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (432, 10, 'Producto defectuoso', '2023-11-28 17:39:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (433, 13991150, 2, '2024-03-03 14:47:00', 191513.00, 14363.48, 177149.52);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (433, 108, 1, 75323.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (433, 279, 2, 58095.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (433, 8, 'Producto defectuoso', '2024-03-06 20:47:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (434, 20569492, 1, '2023-08-06 10:58:00', 222742.00, 11137.10, 211604.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (434, 188, 2, 35573.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (434, 188, 2, 35573.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (434, 338, 1, 16990.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (434, 104, 2, 31730.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (434, 9, 'Rápida entrega', '2023-08-07 20:58:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (435, 18712302, 1, '2024-01-24 16:59:00', 158791.00, 11909.32, 146881.67);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (435, 296, 2, 26143.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (435, 239, 2, 30415.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (435, 219, 1, 45675.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (435, 7, '', '2024-01-25 21:59:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (436, 12141352, 2, '2025-05-09 17:54:00', 155553.00, 0.00, 155553.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (436, 341, 2, 25841.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (436, 147, 2, 29865.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (436, 131, 1, 44141.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (436, 3, 'Muy satisfecho', '2025-05-12 03:54:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (437, 13380886, 1, '2024-08-26 13:34:00', 189169.00, 9458.45, 179710.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (437, 136, 2, 33046.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (437, 204, 2, 33178.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (437, 209, 1, 35262.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (437, 215, 1, 21459.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (437, 1, '', '2024-08-28 19:34:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (438, 15672821, 2, '2024-09-11 14:00:00', 63248.00, 3162.40, 60085.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (438, 133, 1, 35011.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (438, 164, 1, 28237.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (438, 8, 'Muy satisfecho', '2024-09-13 15:00:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (439, 11074758, 1, '2024-07-27 13:26:00', 145882.00, 10941.15, 134940.85);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (439, 239, 2, 30415.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (439, 221, 2, 31958.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (439, 179, 1, 11804.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (439, 284, 1, 9332.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (439, 10, 'Rápida entrega', '2024-07-29 16:26:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (440, 20080197, 1, '2023-12-08 10:32:00', 97393.00, 0.00, 97393.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (440, 193, 2, 34526.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (440, 212, 1, 28341.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (440, 10, '', '2023-12-11 17:32:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (441, 9941991, 1, '2024-07-08 16:03:00', 55654.00, 2782.70, 52871.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (441, 248, 2, 27827.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (441, 1, 'Rápida entrega', '2024-07-10 04:03:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (442, 20432101, 1, '2025-05-09 19:45:00', 122398.00, 6119.90, 116278.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (442, 166, 1, 89544.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (442, 138, 1, 32854.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (442, 3, 'Producto defectuoso', '2025-05-12 02:45:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (443, 21330611, 2, '2023-10-06 11:41:00', 39257.00, 0.00, 39257.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (443, 310, 1, 26042.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (443, 343, 1, 13215.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (443, 3, 'Muy satisfecho', '2023-10-09 22:41:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (444, 21895059, 4, '2024-04-14 12:24:00', 45009.00, 2250.45, 42758.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (444, 206, 1, 45009.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (444, 3, 'No cumplió expectativas', '2024-04-15 13:24:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (445, 10648897, 2, '2025-05-13 14:07:00', 198822.00, 0.00, 198822.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (445, 311, 2, 86401.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (445, 184, 1, 26020.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (445, 6, 'Rápida entrega', '2025-05-16 02:07:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (446, 10024996, 3, '2024-06-23 13:04:00', 28469.00, 0.00, 28469.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (446, 269, 1, 28469.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (446, 1, 'No cumplió expectativas', '2024-06-26 22:04:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (447, 14072155, 4, '2025-03-02 12:13:00', 75916.00, 3795.80, 72120.20);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (447, 117, 2, 37958.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (447, 10, '', '2025-03-04 17:13:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (448, 19476479, 3, '2025-04-17 16:55:00', 122142.00, 9160.65, 112981.35);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (448, 277, 2, 19033.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (448, 127, 2, 35359.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (448, 258, 1, 13358.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (448, 6, 'Producto defectuoso', '2025-04-20 21:55:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (449, 6626531, 4, '2024-09-18 14:31:00', 133640.00, 0.00, 133640.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (449, 339, 2, 23051.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (449, 244, 1, 26325.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (449, 224, 1, 40133.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (449, 114, 2, 10540.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (449, 1, 'Rápida entrega', '2024-09-21 16:31:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (450, 24753534, 3, '2025-04-12 13:01:00', 147882.00, 0.00, 147882.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (450, 133, 1, 35011.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (450, 115, 2, 31956.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (450, 297, 1, 24085.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (450, 261, 2, 12437.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (450, 4, 'Excelente servicio!', '2025-04-13 22:01:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (451, 10456934, 4, '2024-09-15 13:48:00', 157918.00, 0.00, 157918.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (451, 257, 2, 19380.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (451, 254, 1, 26406.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (451, 267, 2, 29386.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (451, 338, 2, 16990.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (451, 6, 'Producto defectuoso', '2024-09-17 20:48:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (452, 11640199, 2, '2025-06-03 15:17:00', 255773.00, 19182.97, 236590.02);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (452, 122, 2, 86568.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (452, 177, 1, 47555.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (452, 211, 2, 17541.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (452, 5, 'No cumplió expectativas', '2025-06-05 00:17:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (453, 18074650, 4, '2025-05-17 12:26:00', 45226.00, 3391.95, 41834.05);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (453, 347, 1, 45226.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (453, 10, 'Rápida entrega', '2025-05-18 23:26:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (454, 16071297, 4, '2024-09-05 19:15:00', 145965.00, 0.00, 145965.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (454, 306, 2, 34645.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (454, 252, 2, 25417.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (454, 341, 1, 25841.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (454, 3, 'Rápida entrega', '2024-09-08 21:15:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (455, 10606500, 4, '2023-07-20 19:00:00', 45927.00, 3444.53, 42482.47);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (455, 246, 2, 11820.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (455, 163, 1, 22287.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (455, 3, 'Excelente servicio!', '2023-07-23 02:00:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (456, 20616053, 3, '2023-10-06 13:03:00', 250387.00, 18779.02, 231607.98);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (456, 242, 2, 46460.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (456, 134, 1, 21463.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (456, 309, 2, 36046.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (456, 115, 2, 31956.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (456, 2, 'Excelente servicio!', '2023-10-09 18:03:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (457, 9499691, 4, '2024-12-04 16:48:00', 116194.00, 0.00, 116194.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (457, 306, 1, 34645.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (457, 343, 2, 13215.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (457, 186, 2, 15301.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (457, 106, 1, 24517.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (457, 3, 'Rápida entrega', '2024-12-06 18:48:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (458, 24121947, 3, '2023-10-04 17:59:00', 107263.00, 5363.15, 101899.85);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (458, 219, 1, 45675.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (458, 121, 2, 30794.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (458, 5, '', '2023-10-07 20:59:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (459, 15029440, 2, '2023-09-11 18:55:00', 125080.00, 6254.00, 118826.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (459, 284, 1, 9332.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (459, 283, 1, 29886.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (459, 320, 1, 85862.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (459, 4, 'Producto defectuoso', '2023-09-15 02:55:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (460, 19341504, 2, '2023-09-03 17:31:00', 29333.00, 2199.97, 27133.03);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (460, 129, 1, 29333.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (460, 4, 'Muy satisfecho', '2023-09-05 21:31:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (461, 8254301, 2, '2024-12-29 13:58:00', 174534.00, 13090.05, 161443.95);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (461, 336, 2, 87267.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (461, 4, '', '2025-01-01 17:58:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (462, 7792300, 2, '2024-10-02 12:53:00', 83964.00, 4198.20, 79765.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (462, 194, 2, 10117.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (462, 348, 2, 31865.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (462, 2, 'Muy satisfecho', '2024-10-04 14:53:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (463, 17191421, 4, '2024-08-24 15:34:00', 213923.00, 0.00, 213923.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (463, 238, 2, 41970.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (463, 170, 2, 27396.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (463, 161, 1, 9099.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (463, 136, 2, 33046.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (463, 9, 'Producto defectuoso', '2024-08-26 23:34:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (464, 18321861, 1, '2025-05-10 16:52:00', 284297.00, 21322.27, 262974.72);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (464, 328, 1, 44354.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (464, 226, 2, 60146.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (464, 152, 2, 51084.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (464, 301, 1, 17483.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (464, 2, 'No cumplió expectativas', '2025-05-12 17:52:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (465, 24923043, 1, '2025-01-16 13:50:00', 51682.00, 0.00, 51682.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (465, 341, 2, 25841.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (465, 2, 'No cumplió expectativas', '2025-01-20 01:50:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (466, 14127438, 4, '2023-10-19 17:10:00', 85035.00, 6377.62, 78657.38);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (466, 287, 1, 25305.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (466, 147, 2, 29865.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (466, 6, 'No cumplió expectativas', '2023-10-20 20:10:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (467, 19514935, 3, '2023-08-06 18:44:00', 250709.00, 12535.45, 238173.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (467, 200, 2, 35141.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (467, 285, 2, 41064.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (467, 320, 1, 85862.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (467, 261, 1, 12437.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (467, 3, 'Producto defectuoso', '2023-08-08 02:44:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (468, 7152747, 1, '2024-12-31 11:59:00', 247974.00, 18598.05, 229375.95);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (468, 226, 2, 60146.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (468, 120, 2, 21807.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (468, 266, 2, 27029.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (468, 225, 1, 30010.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (468, 5, 'No cumplió expectativas', '2025-01-02 16:59:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (469, 22214703, 1, '2023-11-11 13:52:00', 188006.00, 0.00, 188006.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (469, 202, 2, 17312.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (469, 316, 2, 31919.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (469, 166, 1, 89544.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (469, 4, 'No cumplió expectativas', '2023-11-15 01:52:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (470, 22568801, 1, '2024-06-25 17:00:00', 72950.00, 5471.25, 67478.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (470, 134, 1, 21463.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (470, 168, 1, 33125.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (470, 190, 1, 18362.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (470, 8, 'Producto defectuoso', '2024-06-29 04:00:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (471, 16849878, 1, '2023-11-15 15:28:00', 32956.00, 2471.70, 30484.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (471, 247, 1, 32956.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (471, 10, 'Muy satisfecho', '2023-11-18 00:28:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (472, 10170463, 2, '2023-08-04 18:13:00', 305329.00, 0.00, 305329.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (472, 264, 2, 85777.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (472, 139, 1, 48400.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (472, 134, 1, 21463.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (472, 115, 2, 31956.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (472, 3, 'Rápida entrega', '2023-08-08 05:13:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (473, 17741929, 2, '2025-05-12 11:49:00', 37250.00, 2793.75, 34456.25);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (473, 210, 2, 18625.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (473, 2, 'Excelente servicio!', '2025-05-14 17:49:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (474, 18074650, 2, '2025-05-22 19:41:00', 100426.00, 7531.95, 92894.05);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (474, 250, 1, 40405.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (474, 307, 2, 17874.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (474, 265, 1, 24273.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (474, 10, 'Muy satisfecho', '2025-05-24 01:41:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (475, 13380886, 2, '2024-03-23 10:07:00', 108912.00, 5445.60, 103466.40);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (475, 337, 1, 77977.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (475, 290, 1, 30935.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (475, 3, 'Excelente servicio!', '2024-03-25 22:07:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (476, 7818213, 4, '2025-04-30 10:05:00', 198002.00, 0.00, 198002.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (476, 227, 2, 33542.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (476, 224, 2, 40133.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (476, 234, 2, 25326.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (476, 7, '', '2025-05-01 16:05:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (477, 16270094, 4, '2024-09-01 19:45:00', 59220.00, 0.00, 59220.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (477, 310, 1, 26042.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (477, 204, 1, 33178.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (477, 8, 'Muy satisfecho', '2024-09-03 03:45:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (478, 15813452, 4, '2023-09-27 16:06:00', 180846.00, 0.00, 180846.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (478, 219, 1, 45675.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (478, 168, 1, 33125.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (478, 304, 1, 45382.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (478, 175, 2, 28332.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (478, 2, 'No cumplió expectativas', '2023-09-29 00:06:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (479, 8743725, 2, '2024-01-04 10:43:00', 337872.00, 16893.60, 320978.40);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (479, 337, 2, 77977.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (479, 153, 2, 31408.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (479, 123, 2, 26505.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (479, 136, 2, 33046.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (479, 9, 'No cumplió expectativas', '2024-01-05 13:43:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (480, 14422688, 2, '2024-09-07 16:35:00', 58256.00, 0.00, 58256.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (480, 276, 2, 29128.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (480, 6, 'Producto defectuoso', '2024-09-11 01:35:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (481, 18783810, 4, '2024-04-20 16:06:00', 24130.00, 1809.75, 22320.25);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (481, 201, 1, 24130.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (481, 7, 'Rápida entrega', '2024-04-22 18:06:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (482, 24266257, 3, '2024-03-14 16:58:00', 17150.00, 857.50, 16292.50);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (482, 217, 1, 17150.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (482, 1, 'Producto defectuoso', '2024-03-18 00:58:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (483, 9599143, 4, '2024-08-27 15:59:00', 159040.00, 7952.00, 151088.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (483, 233, 1, 31744.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (483, 138, 2, 32854.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (483, 121, 2, 30794.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (483, 4, 'No cumplió expectativas', '2024-08-28 16:59:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (484, 24732931, 1, '2025-02-13 18:30:00', 79940.00, 3997.00, 75943.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (484, 114, 1, 10540.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (484, 136, 1, 33046.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (484, 274, 2, 18177.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (484, 10, '', '2025-02-16 04:30:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (485, 16641839, 1, '2025-01-16 12:58:00', 162508.00, 8125.40, 154382.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (485, 200, 2, 35141.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (485, 114, 2, 10540.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (485, 188, 2, 35573.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (485, 5, 'No cumplió expectativas', '2025-01-17 13:58:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (486, 18348340, 4, '2023-12-01 19:40:00', 141621.00, 0.00, 141621.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (486, 137, 1, 14193.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (486, 291, 1, 36664.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (486, 304, 2, 45382.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (486, 8, 'Muy satisfecho', '2023-12-04 07:40:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (487, 11062596, 3, '2025-04-23 10:32:00', 326699.00, 0.00, 326699.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (487, 138, 2, 32854.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (487, 303, 2, 87627.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (487, 273, 2, 25363.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (487, 133, 1, 35011.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (487, 3, 'Producto defectuoso', '2025-04-25 20:32:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (488, 16058467, 2, '2023-07-10 18:43:00', 54641.00, 0.00, 54641.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (488, 262, 1, 9374.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (488, 181, 1, 23808.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (488, 215, 1, 21459.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (488, 1, 'No cumplió expectativas', '2023-07-12 01:43:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (489, 22568801, 1, '2024-11-11 16:34:00', 114969.00, 8622.67, 106346.32);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (489, 289, 2, 18618.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (489, 111, 1, 25325.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (489, 344, 1, 34794.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (489, 116, 1, 17614.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (489, 10, 'Rápida entrega', '2024-11-15 03:34:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (490, 18387219, 1, '2024-05-29 16:01:00', 130910.00, 6545.50, 124364.50);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (490, 250, 1, 40405.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (490, 267, 1, 29386.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (490, 187, 2, 18296.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (490, 150, 1, 24527.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (490, 10, 'No cumplió expectativas', '2024-05-30 19:01:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (491, 17800455, 2, '2024-08-13 12:34:00', 105685.00, 5284.25, 100400.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (491, 314, 1, 24476.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (491, 212, 2, 28341.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (491, 150, 1, 24527.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (491, 2, 'No cumplió expectativas', '2024-08-16 16:34:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (492, 14724171, 1, '2025-02-22 16:40:00', 61112.00, 3055.60, 58056.40);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (492, 179, 1, 11804.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (492, 232, 2, 24654.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (492, 4, 'Producto defectuoso', '2025-02-25 21:40:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (493, 19245971, 2, '2024-02-01 17:09:00', 30413.00, 0.00, 30413.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (493, 253, 1, 30413.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (493, 10, 'No cumplió expectativas', '2024-02-03 23:09:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (494, 7033387, 2, '2025-05-26 17:07:00', 56718.00, 2835.90, 53882.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (494, 172, 2, 10582.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (494, 173, 2, 17777.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (494, 5, 'Producto defectuoso', '2025-05-29 01:07:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (495, 24739229, 2, '2024-10-10 12:31:00', 85210.00, 6390.75, 78819.25);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (495, 171, 1, 9111.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (495, 131, 1, 44141.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (495, 221, 1, 31958.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (495, 4, 'No cumplió expectativas', '2024-10-11 18:31:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (496, 11647735, 3, '2024-02-09 14:22:00', 61582.00, 3079.10, 58502.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (496, 117, 1, 37958.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (496, 318, 2, 11812.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (496, 3, '', '2024-02-11 00:22:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (497, 19040117, 4, '2025-03-01 10:20:00', 188210.00, 0.00, 188210.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (497, 305, 1, 87462.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (497, 286, 1, 23891.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (497, 224, 1, 40133.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (497, 190, 2, 18362.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (497, 4, 'Rápida entrega', '2025-03-04 18:20:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (498, 14777816, 2, '2023-10-18 19:38:00', 152616.00, 11446.20, 141169.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (498, 175, 2, 28332.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (498, 258, 1, 13358.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (498, 258, 1, 13358.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (498, 107, 2, 34618.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (498, 4, 'No cumplió expectativas', '2023-10-22 05:38:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (499, 14422688, 1, '2024-06-24 18:37:00', 83672.00, 0.00, 83672.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (499, 102, 2, 41836.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (499, 3, 'Excelente servicio!', '2024-06-26 06:37:00');

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (500, 23844543, 4, '2023-07-11 16:53:00', 45675.00, 2283.75, 43391.25);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (500, 219, 1, 45675.00);
INSERT INTO `satisfaccion_venta` (`id_venta`, `puntuacion`, `comentario`, `fecha_registro`) VALUES (500, 6, 'Excelente servicio!', '2023-07-12 23:53:00');

COMMIT;