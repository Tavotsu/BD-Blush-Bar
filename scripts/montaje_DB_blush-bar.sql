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

#Comienza el poblado de la base de datos

START TRANSACTION;

# genero
INSERT INTO `genero` (`id_genero`, `descripcion`) VALUES (1, 'Femenino');
INSERT INTO `genero` (`id_genero`, `descripcion`) VALUES (2, 'Masculino');
INSERT INTO `genero` (`id_genero`, `descripcion`) VALUES (3, 'Otro');

# comuna
INSERT INTO `comuna` (`id_comuna`, `descripcion`) VALUES (1, 'Puerto Montt');
INSERT INTO `comuna` (`id_comuna`, `descripcion`) VALUES (2, 'Puerto Varas');
INSERT INTO `comuna` (`id_comuna`, `descripcion`) VALUES (3, 'Osorno');
INSERT INTO `comuna` (`id_comuna`, `descripcion`) VALUES (4, 'Frutillar');
INSERT INTO `comuna` (`id_comuna`, `descripcion`) VALUES (5, 'Llanquihue');
INSERT INTO `comuna` (`id_comuna`, `descripcion`) VALUES (6, 'Calbuco');
INSERT INTO `comuna` (`id_comuna`, `descripcion`) VALUES (7, 'Alerce');

# tipo_cliente
INSERT INTO `tipo_cliente` (`id_tipo_cliente`, `descripcion`, `porc_desc`) VALUES (1, 'Regular', 0.0);
INSERT INTO `tipo_cliente` (`id_tipo_cliente`, `descripcion`, `porc_desc`) VALUES (2, 'Frecuente', 7.5);
INSERT INTO `tipo_cliente` (`id_tipo_cliente`, `descripcion`, `porc_desc`) VALUES (3, 'Suscrito', 5.0);

# metodo_pago
INSERT INTO `metodo_pago` (`id_metodo_pago`, `descripcion`) VALUES (1, 'Tarjeta');
INSERT INTO `metodo_pago` (`id_metodo_pago`, `descripcion`) VALUES (2, 'Efectivo');
INSERT INTO `metodo_pago` (`id_metodo_pago`, `descripcion`) VALUES (3, 'App');

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
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (101, 'Crema Effaclar Duo+ La Roche-Posay', 'Descripción de Crema Effaclar Duo+ La Roche-Posay', 26643, 52, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (102, 'Paleta de Sombras Naked Urban Decay', 'Descripción de Paleta de Sombras Naked Urban Decay', 43996, 84, 5, 18);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (103, 'Base Double Wear Estée Lauder', 'Descripción de Base Double Wear Estée Lauder', 41469, 42, 1, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (104, 'Limpiador Ultra Facial Kiehl''s', 'Descripción de Limpiador Ultra Facial Kiehl''s', 18671, 150, 2, 9);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (105, 'Paleta de Sombras Naked Urban Decay', 'Descripción de Paleta de Sombras Naked Urban Decay', 46460, 68, 5, 18);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (106, 'Gel de Cejas Boy Brow Glossier', 'Descripción de Gel de Cejas Boy Brow Glossier', 17476, 26, 5, 8);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (107, 'Fijador Fix+ MAC Cosmetics', 'Descripción de Fijador Fix+ MAC Cosmetics', 22855, 35, 3, 11);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (108, 'Crema Lala Retro Whipped Drunk Elephant', 'Descripción de Crema Lala Retro Whipped Drunk Elephant', 59975, 77, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (109, 'Gel de Cejas Boy Brow Glossier', 'Descripción de Gel de Cejas Boy Brow Glossier', 18407, 179, 5, 8);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (110, 'Base Light Reflecting NARS', 'Descripción de Base Light Reflecting NARS', 44674, 30, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (111, 'Esponja de Maquillaje Rare Beauty', 'Descripción de Esponja de Maquillaje Rare Beauty', 8001, 93, 3, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (112, 'Bruma Fijadora Continuous Morphe', 'Descripción de Bruma Fijadora Continuous Morphe', 17418, 61, 3, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (113, 'Agua Termal La Roche-Posay', 'Descripción de Agua Termal La Roche-Posay', 14205, 176, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (114, 'Paleta de Sombras 35O Morphe', 'Descripción de Paleta de Sombras 35O Morphe', 27850, 22, 5, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (115, 'Iluminador Killawatt Fenty Beauty', 'Descripción de Iluminador Killawatt Fenty Beauty', 31728, 175, 1, 7);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (116, 'Crema Effaclar Duo+ La Roche-Posay', 'Descripción de Crema Effaclar Duo+ La Roche-Posay', 23264, 108, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (117, 'Base Even Better Clinique', 'Descripción de Base Even Better Clinique', 30724, 183, 1, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (118, 'Contorno de Ojos de Aguacate Kiehl''s', 'Descripción de Contorno de Ojos de Aguacate Kiehl''s', 28850, 198, 2, 9);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (119, 'Base Forever Skin Glow Dior Beauty', 'Descripción de Base Forever Skin Glow Dior Beauty', 51960, 69, 1, 4);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (120, 'Agua Termal La Roche-Posay', 'Descripción de Agua Termal La Roche-Posay', 13401, 131, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (121, 'Labial Matte Revolution Pillow Talk Charlotte Tilbury', 'Descripción de Labial Matte Revolution Pillow Talk Charlotte Tilbury', 34249, 134, 6, 2);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (122, 'Base Ligera Liquid Touch Rare Beauty', 'Descripción de Base Ligera Liquid Touch Rare Beauty', 30958, 50, 1, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (123, 'Labial Retro Matte Ruby Woo MAC Cosmetics', 'Descripción de Labial Retro Matte Ruby Woo MAC Cosmetics', 20115, 24, 6, 11);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (124, 'Contorno de Ojos de Aguacate Kiehl''s', 'Descripción de Contorno de Ojos de Aguacate Kiehl''s', 28884, 77, 2, 9);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (125, 'Glowscreen SPF 40 Supergoop!', 'Descripción de Glowscreen SPF 40 Supergoop!', 35887, 74, 2, 15);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (126, 'Brillo Gloss Bomb Fenty Beauty', 'Descripción de Brillo Gloss Bomb Fenty Beauty', 19045, 20, 6, 7);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (127, 'Sérum de Día C-Firma Drunk Elephant', 'Descripción de Sérum de Día C-Firma Drunk Elephant', 77064, 156, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (128, 'Sérum de Día C-Firma Drunk Elephant', 'Descripción de Sérum de Día C-Firma Drunk Elephant', 74854, 198, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (129, 'Protector Solar Anthelios 50+ La Roche-Posay', 'Descripción de Protector Solar Anthelios 50+ La Roche-Posay', 21333, 138, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (130, 'Gel de Cejas Boy Brow Glossier', 'Descripción de Gel de Cejas Boy Brow Glossier', 17633, 30, 5, 8);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (131, 'Crema Mágica Hidratante Charlotte Tilbury', 'Descripción de Crema Mágica Hidratante Charlotte Tilbury', 88206, 70, 2, 2);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (132, 'Limpiador Ultra Facial Kiehl''s', 'Descripción de Limpiador Ultra Facial Kiehl''s', 19557, 62, 2, 9);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (133, 'Paleta de Sombras Naked Urban Decay', 'Descripción de Paleta de Sombras Naked Urban Decay', 46750, 47, 5, 18);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (134, 'Base Forever Skin Glow Dior Beauty', 'Descripción de Base Forever Skin Glow Dior Beauty', 48001, 45, 1, 4);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (135, 'Rubor ''Orgasm'' NARS', 'Descripción de Rubor ''Orgasm'' NARS', 31667, 39, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (136, 'Base Forever Skin Glow Dior Beauty', 'Descripción de Base Forever Skin Glow Dior Beauty', 48677, 20, 1, 4);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (137, 'Limpiador Ultra Facial Kiehl''s', 'Descripción de Limpiador Ultra Facial Kiehl''s', 19654, 23, 2, 9);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (138, 'Corrector Shape Tape Tarte', 'Descripción de Corrector Shape Tape Tarte', 28427, 192, 1, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (139, 'Rubor ''Orgasm'' NARS', 'Descripción de Rubor ''Orgasm'' NARS', 31924, 117, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (140, 'Peeling Solution AHA 30% The Ordinary', 'Descripción de Peeling Solution AHA 30% The Ordinary', 11841, 129, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (141, 'Fijador Fix+ MAC Cosmetics', 'Descripción de Fijador Fix+ MAC Cosmetics', 23041, 164, 3, 11);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (142, 'Sérum Advanced Night Repair Estée Lauder', 'Descripción de Sérum Advanced Night Repair Estée Lauder', 87744, 103, 2, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (143, 'Base Ligera Liquid Touch Rare Beauty', 'Descripción de Base Ligera Liquid Touch Rare Beauty', 30807, 198, 1, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (144, 'Crema Mágica Hidratante Charlotte Tilbury', 'Descripción de Crema Mágica Hidratante Charlotte Tilbury', 91265, 140, 2, 2);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (145, 'Sistema de 3 Pasos Clinique', 'Descripción de Sistema de 3 Pasos Clinique', 24857, 88, 4, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (146, 'Sistema de 3 Pasos Clinique', 'Descripción de Sistema de 3 Pasos Clinique', 24645, 83, 4, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (147, 'Labial Retro Matte Ruby Woo MAC Cosmetics', 'Descripción de Labial Retro Matte Ruby Woo MAC Cosmetics', 18670, 66, 6, 11);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (148, 'Brillo Gloss Bomb Fenty Beauty', 'Descripción de Brillo Gloss Bomb Fenty Beauty', 21876, 36, 6, 7);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (149, 'Corrector Shape Tape Tarte', 'Descripción de Corrector Shape Tape Tarte', 25225, 190, 1, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (150, 'Crema Mágica Hidratante Charlotte Tilbury', 'Descripción de Crema Mágica Hidratante Charlotte Tilbury', 88116, 74, 2, 2);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (151, 'Base Even Better Clinique', 'Descripción de Base Even Better Clinique', 33674, 192, 1, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (152, 'Gel de Cejas Boy Brow Glossier', 'Descripción de Gel de Cejas Boy Brow Glossier', 16021, 134, 5, 8);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (153, 'Labial Matte Revolution Pillow Talk Charlotte Tilbury', 'Descripción de Labial Matte Revolution Pillow Talk Charlotte Tilbury', 34362, 89, 6, 2);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (154, 'Ácido Hialurónico 2% + B5 The Ordinary', 'Descripción de Ácido Hialurónico 2% + B5 The Ordinary', 11739, 53, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (155, 'Paleta de Sombras Naked Urban Decay', 'Descripción de Paleta de Sombras Naked Urban Decay', 45215, 131, 5, 18);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (156, 'Base Ligera Liquid Touch Rare Beauty', 'Descripción de Base Ligera Liquid Touch Rare Beauty', 31756, 88, 1, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (157, 'Paleta de Sombras Tartelette Tarte', 'Descripción de Paleta de Sombras Tartelette Tarte', 40475, 94, 5, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (158, 'Paleta de Sombras Naked Urban Decay', 'Descripción de Paleta de Sombras Naked Urban Decay', 45481, 144, 5, 18);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (159, 'Base Forever Skin Glow Dior Beauty', 'Descripción de Base Forever Skin Glow Dior Beauty', 51465, 189, 1, 4);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (160, 'Sérum Niacinamida 10% The Ordinary', 'Descripción de Sérum Niacinamida 10% The Ordinary', 10677, 117, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (161, 'Rubor Líquido Soft Pinch Rare Beauty', 'Descripción de Rubor Líquido Soft Pinch Rare Beauty', 24401, 53, 1, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (162, 'Sérum de Día C-Firma Drunk Elephant', 'Descripción de Sérum de Día C-Firma Drunk Elephant', 77485, 71, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (163, 'Glowscreen SPF 40 Supergoop!', 'Descripción de Glowscreen SPF 40 Supergoop!', 34624, 199, 2, 15);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (164, 'Gel de Cejas Boy Brow Glossier', 'Descripción de Gel de Cejas Boy Brow Glossier', 16552, 146, 5, 8);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (165, 'Protector Solar Unseen SPF 40 Supergoop!', 'Descripción de Protector Solar Unseen SPF 40 Supergoop!', 33887, 63, 2, 15);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (166, 'Paleta de Sombras Naked Urban Decay', 'Descripción de Paleta de Sombras Naked Urban Decay', 44957, 160, 5, 18);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (167, 'Glowscreen SPF 40 Supergoop!', 'Descripción de Glowscreen SPF 40 Supergoop!', 37121, 89, 2, 15);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (168, 'Base Ligera Liquid Touch Rare Beauty', 'Descripción de Base Ligera Liquid Touch Rare Beauty', 29966, 130, 1, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (169, 'Crema Effaclar Duo+ La Roche-Posay', 'Descripción de Crema Effaclar Duo+ La Roche-Posay', 25280, 127, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (170, 'Paleta de Sombras Tartelette Tarte', 'Descripción de Paleta de Sombras Tartelette Tarte', 41849, 52, 5, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (171, 'Corrector Shape Tape Tarte', 'Descripción de Corrector Shape Tape Tarte', 26211, 36, 1, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (172, 'Rubor en Crema Cloud Paint Glossier', 'Descripción de Rubor en Crema Cloud Paint Glossier', 18557, 131, 1, 8);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (173, 'Esponja de Maquillaje Rare Beauty', 'Descripción de Esponja de Maquillaje Rare Beauty', 9674, 28, 3, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (174, 'Crema Mágica Hidratante Charlotte Tilbury', 'Descripción de Crema Mágica Hidratante Charlotte Tilbury', 89824, 68, 2, 2);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (175, 'Sérum Advanced Night Repair Estée Lauder', 'Descripción de Sérum Advanced Night Repair Estée Lauder', 84250, 25, 2, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (176, 'Base Forever Skin Glow Dior Beauty', 'Descripción de Base Forever Skin Glow Dior Beauty', 48879, 133, 1, 4);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (177, 'Paleta de Sombras Tartelette Tarte', 'Descripción de Paleta de Sombras Tartelette Tarte', 38141, 134, 5, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (178, 'Corrector Shape Tape Tarte', 'Descripción de Corrector Shape Tape Tarte', 27977, 182, 1, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (179, 'Fijador Fix+ MAC Cosmetics', 'Descripción de Fijador Fix+ MAC Cosmetics', 24540, 37, 3, 11);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (180, 'Corrector Shape Tape Tarte', 'Descripción de Corrector Shape Tape Tarte', 25631, 107, 1, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (181, 'Polvos Airbrush Flawless Charlotte Tilbury', 'Descripción de Polvos Airbrush Flawless Charlotte Tilbury', 44527, 193, 1, 2);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (182, 'Gel de Cejas Boy Brow Glossier', 'Descripción de Gel de Cejas Boy Brow Glossier', 15177, 92, 5, 8);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (183, 'Rubor en Crema Cloud Paint Glossier', 'Descripción de Rubor en Crema Cloud Paint Glossier', 17464, 138, 1, 8);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (184, 'Polvos Airbrush Flawless Charlotte Tilbury', 'Descripción de Polvos Airbrush Flawless Charlotte Tilbury', 43368, 56, 1, 2);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (185, 'Set de Brochas Esenciales Morphe', 'Descripción de Set de Brochas Esenciales Morphe', 30321, 56, 3, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (186, 'Sérum Advanced Night Repair Estée Lauder', 'Descripción de Sérum Advanced Night Repair Estée Lauder', 85287, 79, 2, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (187, 'Base Double Wear Estée Lauder', 'Descripción de Base Double Wear Estée Lauder', 44380, 165, 1, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (188, 'Paleta de Sombras Tartelette Tarte', 'Descripción de Paleta de Sombras Tartelette Tarte', 40692, 101, 5, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (189, 'Rubor Líquido Soft Pinch Rare Beauty', 'Descripción de Rubor Líquido Soft Pinch Rare Beauty', 23654, 67, 1, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (190, 'Gel de Cejas Boy Brow Glossier', 'Descripción de Gel de Cejas Boy Brow Glossier', 15857, 41, 5, 8);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (191, 'Protector Solar Anthelios 50+ La Roche-Posay', 'Descripción de Protector Solar Anthelios 50+ La Roche-Posay', 20558, 94, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (192, 'Gel para Cejas Gimme Brow+ Benefit Cosmetics', 'Descripción de Gel para Cejas Gimme Brow+ Benefit Cosmetics', 23116, 110, 5, 1);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (193, 'Fijador de Maquillaje All Nighter Urban Decay', 'Descripción de Fijador de Maquillaje All Nighter Urban Decay', 30854, 196, 3, 18);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (194, 'Paleta de Sombras Tartelette Tarte', 'Descripción de Paleta de Sombras Tartelette Tarte', 39255, 108, 5, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (195, 'Fijador de Maquillaje All Nighter Urban Decay', 'Descripción de Fijador de Maquillaje All Nighter Urban Decay', 29244, 47, 3, 18);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (196, 'Glowscreen SPF 40 Supergoop!', 'Descripción de Glowscreen SPF 40 Supergoop!', 34419, 47, 2, 15);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (197, 'Base Light Reflecting NARS', 'Descripción de Base Light Reflecting NARS', 46657, 127, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (198, 'Base Ligera Liquid Touch Rare Beauty', 'Descripción de Base Ligera Liquid Touch Rare Beauty', 28476, 103, 1, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (199, 'Primer POREfessional Benefit Cosmetics', 'Descripción de Primer POREfessional Benefit Cosmetics', 31982, 35, 1, 1);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (200, 'Contorno de Ojos de Aguacate Kiehl''s', 'Descripción de Contorno de Ojos de Aguacate Kiehl''s', 31119, 20, 2, 9);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (201, 'Corrector Radiante Cremoso NARS', 'Descripción de Corrector Radiante Cremoso NARS', 29385, 152, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (202, 'Glowscreen SPF 40 Supergoop!', 'Descripción de Glowscreen SPF 40 Supergoop!', 36323, 47, 2, 15);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (203, 'Limpiador Ultra Facial Kiehl''s', 'Descripción de Limpiador Ultra Facial Kiehl''s', 19390, 57, 2, 9);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (204, 'Sérum Niacinamida 10% The Ordinary', 'Descripción de Sérum Niacinamida 10% The Ordinary', 10955, 93, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (205, 'Limpiador Ultra Facial Kiehl''s', 'Descripción de Limpiador Ultra Facial Kiehl''s', 20890, 91, 2, 9);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (206, 'Gel de Cejas Boy Brow Glossier', 'Descripción de Gel de Cejas Boy Brow Glossier', 16882, 154, 5, 8);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (207, 'Peeling Solution AHA 30% The Ordinary', 'Descripción de Peeling Solution AHA 30% The Ordinary', 9426, 71, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (208, 'Base Forever Skin Glow Dior Beauty', 'Descripción de Base Forever Skin Glow Dior Beauty', 50436, 175, 1, 4);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (209, 'Crema Lala Retro Whipped Drunk Elephant', 'Descripción de Crema Lala Retro Whipped Drunk Elephant', 60785, 39, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (210, 'Rubor Líquido Soft Pinch Rare Beauty', 'Descripción de Rubor Líquido Soft Pinch Rare Beauty', 24325, 156, 1, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (211, 'Gel para Cejas Gimme Brow+ Benefit Cosmetics', 'Descripción de Gel para Cejas Gimme Brow+ Benefit Cosmetics', 26195, 120, 5, 1);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (212, 'Glowscreen SPF 40 Supergoop!', 'Descripción de Glowscreen SPF 40 Supergoop!', 34336, 151, 2, 15);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (213, 'Sistema de 3 Pasos Clinique', 'Descripción de Sistema de 3 Pasos Clinique', 27198, 111, 4, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (214, 'Bálsamo Labial Addict Dior Beauty', 'Descripción de Bálsamo Labial Addict Dior Beauty', 36502, 136, 6, 4);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (215, 'Base Double Wear Estée Lauder', 'Descripción de Base Double Wear Estée Lauder', 41361, 157, 1, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (216, 'Fijador de Maquillaje All Nighter Urban Decay', 'Descripción de Fijador de Maquillaje All Nighter Urban Decay', 28379, 90, 3, 18);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (217, 'Paleta de Sombras Naked Urban Decay', 'Descripción de Paleta de Sombras Naked Urban Decay', 45858, 36, 5, 18);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (218, 'Base Ligera Liquid Touch Rare Beauty', 'Descripción de Base Ligera Liquid Touch Rare Beauty', 28180, 38, 1, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (219, 'Bálsamo Labial Addict Dior Beauty', 'Descripción de Bálsamo Labial Addict Dior Beauty', 36622, 183, 6, 4);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (220, 'Gel de Cejas Boy Brow Glossier', 'Descripción de Gel de Cejas Boy Brow Glossier', 15871, 97, 5, 8);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (221, 'Rubor en Crema Cloud Paint Glossier', 'Descripción de Rubor en Crema Cloud Paint Glossier', 18116, 94, 1, 8);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (222, 'Base Even Better Clinique', 'Descripción de Base Even Better Clinique', 32689, 150, 1, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (223, 'Base Double Wear Estée Lauder', 'Descripción de Base Double Wear Estée Lauder', 43259, 195, 1, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (224, 'Brillo Gloss Bomb Fenty Beauty', 'Descripción de Brillo Gloss Bomb Fenty Beauty', 19958, 182, 6, 7);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (225, 'Paleta de Sombras 35O Morphe', 'Descripción de Paleta de Sombras 35O Morphe', 27198, 113, 5, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (226, 'Primer POREfessional Benefit Cosmetics', 'Descripción de Primer POREfessional Benefit Cosmetics', 33525, 100, 1, 1);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (227, 'Rubor ''Orgasm'' NARS', 'Descripción de Rubor ''Orgasm'' NARS', 32319, 113, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (228, 'Protector Solar Unseen SPF 40 Supergoop!', 'Descripción de Protector Solar Unseen SPF 40 Supergoop!', 35303, 184, 2, 15);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (229, 'Sérum de Día C-Firma Drunk Elephant', 'Descripción de Sérum de Día C-Firma Drunk Elephant', 75604, 45, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (230, 'Sérum Advanced Night Repair Estée Lauder', 'Descripción de Sérum Advanced Night Repair Estée Lauder', 87306, 184, 2, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (231, 'Labial Retro Matte Ruby Woo MAC Cosmetics', 'Descripción de Labial Retro Matte Ruby Woo MAC Cosmetics', 17373, 176, 6, 11);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (232, 'Agua Termal La Roche-Posay', 'Descripción de Agua Termal La Roche-Posay', 12767, 122, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (233, 'Base Light Reflecting NARS', 'Descripción de Base Light Reflecting NARS', 45650, 188, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (234, 'Iluminador Killawatt Fenty Beauty', 'Descripción de Iluminador Killawatt Fenty Beauty', 31300, 118, 1, 7);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (235, 'Sérum Advanced Night Repair Estée Lauder', 'Descripción de Sérum Advanced Night Repair Estée Lauder', 87520, 176, 2, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (236, 'Sérum Niacinamida 10% The Ordinary', 'Descripción de Sérum Niacinamida 10% The Ordinary', 8328, 146, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (237, 'Esponja de Maquillaje Rare Beauty', 'Descripción de Esponja de Maquillaje Rare Beauty', 8480, 26, 3, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (238, 'Corrector Radiante Cremoso NARS', 'Descripción de Corrector Radiante Cremoso NARS', 30148, 59, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (239, 'Set de Brochas Esenciales Morphe', 'Descripción de Set de Brochas Esenciales Morphe', 28170, 96, 3, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (240, 'Máscara They''re Real! Benefit Cosmetics', 'Descripción de Máscara They''re Real! Benefit Cosmetics', 26085, 111, 5, 1);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (241, 'Paleta de Sombras Tartelette Tarte', 'Descripción de Paleta de Sombras Tartelette Tarte', 38123, 184, 5, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (242, 'Gel de Cejas Boy Brow Glossier', 'Descripción de Gel de Cejas Boy Brow Glossier', 16245, 95, 5, 8);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (243, 'Fijador de Maquillaje All Nighter Urban Decay', 'Descripción de Fijador de Maquillaje All Nighter Urban Decay', 30337, 170, 3, 18);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (244, 'Bálsamo Labial Addict Dior Beauty', 'Descripción de Bálsamo Labial Addict Dior Beauty', 34346, 193, 6, 4);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (245, 'Brillo Gloss Bomb Fenty Beauty', 'Descripción de Brillo Gloss Bomb Fenty Beauty', 18442, 96, 6, 7);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (246, 'Sérum de Día C-Firma Drunk Elephant', 'Descripción de Sérum de Día C-Firma Drunk Elephant', 75142, 83, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (247, 'Protector Solar Anthelios 50+ La Roche-Posay', 'Descripción de Protector Solar Anthelios 50+ La Roche-Posay', 21615, 159, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (248, 'Glowscreen SPF 40 Supergoop!', 'Descripción de Glowscreen SPF 40 Supergoop!', 36758, 137, 2, 15);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (249, 'Base Light Reflecting NARS', 'Descripción de Base Light Reflecting NARS', 44654, 74, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (250, 'Limpiador Ultra Facial Kiehl''s', 'Descripción de Limpiador Ultra Facial Kiehl''s', 19911, 56, 2, 9);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (251, 'Primer POREfessional Benefit Cosmetics', 'Descripción de Primer POREfessional Benefit Cosmetics', 34648, 151, 1, 1);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (252, 'Labial Retro Matte Ruby Woo MAC Cosmetics', 'Descripción de Labial Retro Matte Ruby Woo MAC Cosmetics', 18715, 105, 6, 11);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (253, 'Base Light Reflecting NARS', 'Descripción de Base Light Reflecting NARS', 47031, 47, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (254, 'Corrector Shape Tape Tarte', 'Descripción de Corrector Shape Tape Tarte', 26847, 83, 1, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (255, 'Crema Lala Retro Whipped Drunk Elephant', 'Descripción de Crema Lala Retro Whipped Drunk Elephant', 58866, 187, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (256, 'Sistema de 3 Pasos Clinique', 'Descripción de Sistema de 3 Pasos Clinique', 26889, 35, 4, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (257, 'Peeling Solution AHA 30% The Ordinary', 'Descripción de Peeling Solution AHA 30% The Ordinary', 12206, 58, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (258, 'Base Double Wear Estée Lauder', 'Descripción de Base Double Wear Estée Lauder', 44983, 122, 1, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (259, 'Ácido Hialurónico 2% + B5 The Ordinary', 'Descripción de Ácido Hialurónico 2% + B5 The Ordinary', 11292, 46, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (260, 'Crema Lala Retro Whipped Drunk Elephant', 'Descripción de Crema Lala Retro Whipped Drunk Elephant', 60400, 173, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (261, 'Sistema de 3 Pasos Clinique', 'Descripción de Sistema de 3 Pasos Clinique', 26515, 97, 4, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (262, 'Base Double Wear Estée Lauder', 'Descripción de Base Double Wear Estée Lauder', 43141, 75, 1, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (263, 'Paleta de Sombras Tartelette Tarte', 'Descripción de Paleta de Sombras Tartelette Tarte', 41678, 87, 5, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (264, 'Limpiador Ultra Facial Kiehl''s', 'Descripción de Limpiador Ultra Facial Kiehl''s', 21642, 50, 2, 9);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (265, 'Brillo Gloss Bomb Fenty Beauty', 'Descripción de Brillo Gloss Bomb Fenty Beauty', 20053, 31, 6, 7);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (266, 'Crema Lala Retro Whipped Drunk Elephant', 'Descripción de Crema Lala Retro Whipped Drunk Elephant', 61534, 187, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (267, 'Brillo Gloss Bomb Fenty Beauty', 'Descripción de Brillo Gloss Bomb Fenty Beauty', 18030, 86, 6, 7);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (268, 'Fijador de Maquillaje All Nighter Urban Decay', 'Descripción de Fijador de Maquillaje All Nighter Urban Decay', 30185, 146, 3, 18);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (269, 'Labial Retro Matte Ruby Woo MAC Cosmetics', 'Descripción de Labial Retro Matte Ruby Woo MAC Cosmetics', 17279, 70, 6, 11);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (270, 'Máscara They''re Real! Benefit Cosmetics', 'Descripción de Máscara They''re Real! Benefit Cosmetics', 27950, 49, 5, 1);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (271, 'Crema Effaclar Duo+ La Roche-Posay', 'Descripción de Crema Effaclar Duo+ La Roche-Posay', 23452, 104, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (272, 'Contorno de Ojos de Aguacate Kiehl''s', 'Descripción de Contorno de Ojos de Aguacate Kiehl''s', 29848, 101, 2, 9);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (273, 'Sérum Advanced Night Repair Estée Lauder', 'Descripción de Sérum Advanced Night Repair Estée Lauder', 84320, 78, 2, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (274, 'Ácido Hialurónico 2% + B5 The Ordinary', 'Descripción de Ácido Hialurónico 2% + B5 The Ordinary', 9990, 183, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (275, 'Protector Solar Anthelios 50+ La Roche-Posay', 'Descripción de Protector Solar Anthelios 50+ La Roche-Posay', 22247, 26, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (276, 'Rubor Líquido Soft Pinch Rare Beauty', 'Descripción de Rubor Líquido Soft Pinch Rare Beauty', 24126, 173, 1, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (277, 'Corrector Radiante Cremoso NARS', 'Descripción de Corrector Radiante Cremoso NARS', 30648, 109, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (278, 'Limpiador Ultra Facial Kiehl''s', 'Descripción de Limpiador Ultra Facial Kiehl''s', 18947, 25, 2, 9);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (279, 'Base Forever Skin Glow Dior Beauty', 'Descripción de Base Forever Skin Glow Dior Beauty', 50201, 90, 1, 4);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (280, 'Protector Solar Unseen SPF 40 Supergoop!', 'Descripción de Protector Solar Unseen SPF 40 Supergoop!', 34059, 124, 2, 15);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (281, 'Paleta de Sombras Naked Urban Decay', 'Descripción de Paleta de Sombras Naked Urban Decay', 47913, 41, 5, 18);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (282, 'Rubor ''Orgasm'' NARS', 'Descripción de Rubor ''Orgasm'' NARS', 33364, 21, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (283, 'Paleta de Sombras 35O Morphe', 'Descripción de Paleta de Sombras 35O Morphe', 24296, 170, 5, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (284, 'Brillo Gloss Bomb Fenty Beauty', 'Descripción de Brillo Gloss Bomb Fenty Beauty', 18174, 136, 6, 7);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (285, 'Agua Termal La Roche-Posay', 'Descripción de Agua Termal La Roche-Posay', 12782, 169, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (286, 'Paleta de Sombras Naked Urban Decay', 'Descripción de Paleta de Sombras Naked Urban Decay', 47752, 68, 5, 18);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (287, 'Paleta de Sombras Naked Urban Decay', 'Descripción de Paleta de Sombras Naked Urban Decay', 44796, 173, 5, 18);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (288, 'Corrector Shape Tape Tarte', 'Descripción de Corrector Shape Tape Tarte', 26903, 115, 1, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (289, 'Bruma Fijadora Continuous Morphe', 'Descripción de Bruma Fijadora Continuous Morphe', 14736, 93, 3, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (290, 'Primer POREfessional Benefit Cosmetics', 'Descripción de Primer POREfessional Benefit Cosmetics', 33055, 78, 1, 1);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (291, 'Sérum Advanced Night Repair Estée Lauder', 'Descripción de Sérum Advanced Night Repair Estée Lauder', 86516, 41, 2, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (292, 'Rubor Líquido Soft Pinch Rare Beauty', 'Descripción de Rubor Líquido Soft Pinch Rare Beauty', 23296, 54, 1, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (293, 'Fijador Fix+ MAC Cosmetics', 'Descripción de Fijador Fix+ MAC Cosmetics', 23456, 135, 3, 11);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (294, 'Sérum Advanced Night Repair Estée Lauder', 'Descripción de Sérum Advanced Night Repair Estée Lauder', 85997, 28, 2, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (295, 'Paleta de Sombras 35O Morphe', 'Descripción de Paleta de Sombras 35O Morphe', 26733, 177, 5, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (296, 'Crema Mágica Hidratante Charlotte Tilbury', 'Descripción de Crema Mágica Hidratante Charlotte Tilbury', 88799, 97, 2, 2);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (297, 'Sérum Advanced Night Repair Estée Lauder', 'Descripción de Sérum Advanced Night Repair Estée Lauder', 85183, 108, 2, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (298, 'Base Light Reflecting NARS', 'Descripción de Base Light Reflecting NARS', 46343, 44, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (299, 'Rubor ''Orgasm'' NARS', 'Descripción de Rubor ''Orgasm'' NARS', 30523, 91, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (300, 'Protector Solar Unseen SPF 40 Supergoop!', 'Descripción de Protector Solar Unseen SPF 40 Supergoop!', 35038, 183, 2, 15);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (301, 'Crema Effaclar Duo+ La Roche-Posay', 'Descripción de Crema Effaclar Duo+ La Roche-Posay', 26964, 103, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (302, 'Crema Lala Retro Whipped Drunk Elephant', 'Descripción de Crema Lala Retro Whipped Drunk Elephant', 58515, 169, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (303, 'Primer POREfessional Benefit Cosmetics', 'Descripción de Primer POREfessional Benefit Cosmetics', 31079, 159, 1, 1);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (304, 'Gel de Cejas Boy Brow Glossier', 'Descripción de Gel de Cejas Boy Brow Glossier', 16374, 166, 5, 8);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (305, 'Labial Retro Matte Ruby Woo MAC Cosmetics', 'Descripción de Labial Retro Matte Ruby Woo MAC Cosmetics', 20589, 50, 6, 11);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (306, 'Paleta de Sombras 35O Morphe', 'Descripción de Paleta de Sombras 35O Morphe', 25973, 60, 5, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (307, 'Crema Mágica Hidratante Charlotte Tilbury', 'Descripción de Crema Mágica Hidratante Charlotte Tilbury', 91062, 176, 2, 2);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (308, 'Bruma Fijadora Continuous Morphe', 'Descripción de Bruma Fijadora Continuous Morphe', 17206, 95, 3, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (309, 'Set de Brochas Esenciales Morphe', 'Descripción de Set de Brochas Esenciales Morphe', 31437, 43, 3, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (310, 'Bálsamo Labial Addict Dior Beauty', 'Descripción de Bálsamo Labial Addict Dior Beauty', 36109, 101, 6, 4);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (311, 'Crema Mágica Hidratante Charlotte Tilbury', 'Descripción de Crema Mágica Hidratante Charlotte Tilbury', 88213, 79, 2, 2);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (312, 'Fijador de Maquillaje All Nighter Urban Decay', 'Descripción de Fijador de Maquillaje All Nighter Urban Decay', 30186, 43, 3, 18);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (313, 'Base Even Better Clinique', 'Descripción de Base Even Better Clinique', 33538, 99, 1, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (314, 'Base Double Wear Estée Lauder', 'Descripción de Base Double Wear Estée Lauder', 41013, 133, 1, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (315, 'Contorno de Ojos de Aguacate Kiehl''s', 'Descripción de Contorno de Ojos de Aguacate Kiehl''s', 31428, 195, 2, 9);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (316, 'Protector Solar Anthelios 50+ La Roche-Posay', 'Descripción de Protector Solar Anthelios 50+ La Roche-Posay', 21101, 95, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (317, 'Crema Lala Retro Whipped Drunk Elephant', 'Descripción de Crema Lala Retro Whipped Drunk Elephant', 58257, 160, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (318, 'Fijador Fix+ MAC Cosmetics', 'Descripción de Fijador Fix+ MAC Cosmetics', 24128, 200, 3, 11);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (319, 'Máscara They''re Real! Benefit Cosmetics', 'Descripción de Máscara They''re Real! Benefit Cosmetics', 25978, 82, 5, 1);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (320, 'Peeling Solution AHA 30% The Ordinary', 'Descripción de Peeling Solution AHA 30% The Ordinary', 12847, 163, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (321, 'Crema Effaclar Duo+ La Roche-Posay', 'Descripción de Crema Effaclar Duo+ La Roche-Posay', 24474, 158, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (322, 'Contorno de Ojos de Aguacate Kiehl''s', 'Descripción de Contorno de Ojos de Aguacate Kiehl''s', 29702, 124, 2, 9);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (323, 'Sérum de Día C-Firma Drunk Elephant', 'Descripción de Sérum de Día C-Firma Drunk Elephant', 77744, 94, 2, 5);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (324, 'Base Double Wear Estée Lauder', 'Descripción de Base Double Wear Estée Lauder', 41062, 151, 1, 6);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (325, 'Paleta de Sombras 35O Morphe', 'Descripción de Paleta de Sombras 35O Morphe', 26119, 159, 5, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (326, 'Limpiador Ultra Facial Kiehl''s', 'Descripción de Limpiador Ultra Facial Kiehl''s', 18732, 42, 2, 9);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (327, 'Paleta de Sombras 35O Morphe', 'Descripción de Paleta de Sombras 35O Morphe', 26975, 170, 5, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (328, 'Fijador de Maquillaje All Nighter Urban Decay', 'Descripción de Fijador de Maquillaje All Nighter Urban Decay', 29107, 118, 3, 18);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (329, 'Protector Solar Unseen SPF 40 Supergoop!', 'Descripción de Protector Solar Unseen SPF 40 Supergoop!', 35879, 20, 2, 15);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (330, 'Protector Solar Anthelios 50+ La Roche-Posay', 'Descripción de Protector Solar Anthelios 50+ La Roche-Posay', 20956, 83, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (331, 'Brillo Gloss Bomb Fenty Beauty', 'Descripción de Brillo Gloss Bomb Fenty Beauty', 20396, 124, 6, 7);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (332, 'Base Light Reflecting NARS', 'Descripción de Base Light Reflecting NARS', 47118, 133, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (333, 'Polvos Airbrush Flawless Charlotte Tilbury', 'Descripción de Polvos Airbrush Flawless Charlotte Tilbury', 42244, 166, 1, 2);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (334, 'Paleta de Sombras Tartelette Tarte', 'Descripción de Paleta de Sombras Tartelette Tarte', 40138, 58, 5, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (335, 'Protector Solar Unseen SPF 40 Supergoop!', 'Descripción de Protector Solar Unseen SPF 40 Supergoop!', 35620, 79, 2, 15);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (336, 'Paleta de Sombras Tartelette Tarte', 'Descripción de Paleta de Sombras Tartelette Tarte', 40893, 42, 5, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (337, 'Paleta de Sombras Tartelette Tarte', 'Descripción de Paleta de Sombras Tartelette Tarte', 41152, 181, 5, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (338, 'Iluminador Killawatt Fenty Beauty', 'Descripción de Iluminador Killawatt Fenty Beauty', 32000, 149, 1, 7);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (339, 'Protector Solar Anthelios 50+ La Roche-Posay', 'Descripción de Protector Solar Anthelios 50+ La Roche-Posay', 23437, 88, 2, 10);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (340, 'Rubor ''Orgasm'' NARS', 'Descripción de Rubor ''Orgasm'' NARS', 30613, 79, 1, 13);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (341, 'Rubor en Crema Cloud Paint Glossier', 'Descripción de Rubor en Crema Cloud Paint Glossier', 19831, 23, 1, 8);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (342, 'Corrector Shape Tape Tarte', 'Descripción de Corrector Shape Tape Tarte', 28305, 161, 1, 16);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (343, 'Gel de Cejas Boy Brow Glossier', 'Descripción de Gel de Cejas Boy Brow Glossier', 18732, 32, 5, 8);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (344, 'Bálsamo Labial Addict Dior Beauty', 'Descripción de Bálsamo Labial Addict Dior Beauty', 35533, 44, 6, 4);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (345, 'Bruma Fijadora Continuous Morphe', 'Descripción de Bruma Fijadora Continuous Morphe', 16350, 184, 3, 12);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (346, 'Esponja de Maquillaje Rare Beauty', 'Descripción de Esponja de Maquillaje Rare Beauty', 10170, 164, 3, 14);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (347, 'Sistema de 3 Pasos Clinique', 'Descripción de Sistema de 3 Pasos Clinique', 26735, 196, 4, 3);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (348, 'Peeling Solution AHA 30% The Ordinary', 'Descripción de Peeling Solution AHA 30% The Ordinary', 11172, 44, 2, 17);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (349, 'Base Forever Skin Glow Dior Beauty', 'Descripción de Base Forever Skin Glow Dior Beauty', 48463, 27, 1, 4);
INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES (350, 'Sérum Niacinamida 10% The Ordinary', 'Descripción de Sérum Niacinamida 10% The Ordinary', 9165, 22, 2, 17);

# cliente
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8233353, '3', 'Emma', 'Antonia', 'Valenzuela', 'Vera', '2004-02-10', 1, 4, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (6876845, '4', 'Consuelo', 'Carolina', 'Araya', 'Cortés', '1990-04-01', 1, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22841837, '4', 'Maite', 'Mía', 'Araya', 'Molina', '1979-04-25', 1, 5, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19873072, '6', 'Valentina', 'Paz', 'Herrera', 'Rojas', '2001-09-09', 1, 1, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14987078, '4', 'Gabriela', 'Isabella', 'Vega', 'Valenzuela', '1979-08-06', 1, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15469471, '4', 'Isidora', 'Rafaela', 'Martínez', 'López', '1976-12-06', 1, 4, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10901799, 'K', 'Monserrat', 'Pascal', 'Sepúlveda', 'Riquelme', '1996-06-08', 1, 5, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11409393, '9', 'Miguel', 'Martín', 'Pérez', 'Rodríguez', '1979-06-19', 2, 3, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21707055, '4', 'Bastián', 'Manuel', 'Carrasco', 'Sandoval', '1962-12-02', 2, 4, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8903100, '1', 'Laura', 'Agustina', 'González', 'Silva', '1996-10-18', 1, 2, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7836337, '1', 'Monserrat', 'Leonor', 'Jara', 'Sánchez', '1965-01-19', 1, 2, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17921382, '6', 'Belén', 'Celeste', 'Espinoza', 'Reyes', '1972-12-15', 1, 3, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12258848, '3', 'José Tomás', 'Miguel', 'Ramírez', 'Vera', '1996-07-12', 2, 2, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19004780, '6', 'Josefa', 'Pascal', 'López', 'González', '1971-07-13', 1, 2, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8756179, '8', 'Anaís', 'Isabella', 'Sepúlveda', 'Vergara', '1998-04-20', 1, 4, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17231954, '8', 'Eloísa', 'Sofía Antonia', 'Álvarez', 'Sánchez', '1994-02-18', 1, 4, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20711636, 'K', 'Julieta', 'Victoria', 'Pérez', 'Silva', '1996-04-09', 1, 1, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22118312, '6', 'Antonia', 'Olivia', 'González', 'Rodríguez', '1979-09-27', 1, 1, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10889399, '0', 'Celeste', 'Pascal', 'Contreras', 'Muñoz', '1961-04-22', 1, 4, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9977295, '6', 'Paulina', 'Luciana', 'Silva', 'Núñez', '2004-09-18', 1, 3, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11015275, '2', 'Catalina', 'Consuelo', 'Vergara', 'Cortés', '1993-08-11', 1, 4, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7563573, '7', 'Bárbara', 'Pascal', 'Sandoval', 'Herrera', '1962-05-31', 1, 4, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (6698025, '1', 'Jorge', 'Luis', 'Gutiérrez', 'Soto', '1970-10-12', 2, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19185736, '4', 'Francisca', 'Rafaela', 'Rivera', 'Flores', '1961-11-18', 1, 3, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9913697, '9', 'Beatriz', 'Florencia', 'Fernández', 'Rivera', '1984-07-29', 1, 2, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10085511, '9', 'Valeria', 'Bárbara', 'Fuentes', 'Muñoz', '1962-09-09', 1, 3, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23077662, '8', 'Vicente', 'Emiliano', 'Sandoval', 'Martínez', '1961-02-01', 2, 1, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11846433, '8', 'Josefa', 'Maite', 'Molina', 'Contreras', '1976-02-27', 1, 1, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23629755, '1', 'Emiliano', 'José', 'Vega', 'Sandoval', '1976-07-27', 2, 4, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21734205, '8', 'Rocío', 'Consuelo', 'Pérez', 'Valenzuela', '1981-10-30', 1, 4, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18198189, 'K', 'Florencia', 'Antonella', 'Carrasco', 'Sandoval', '1989-08-29', 1, 3, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21330851, '3', 'Juan Pablo', 'Javier', 'Díaz', 'Castillo', '1970-10-06', 2, 5, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13301840, '9', 'Gabriel', 'Eduardo', 'Riquelme', 'Castillo', '1983-03-26', 2, 2, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (24415853, '6', 'Francisca', 'Trinidad', 'Díaz', 'Vega', '1967-02-21', 1, 3, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21711459, '4', 'Constanza', 'Dominga', 'Silva', 'González', '1996-10-17', 1, 2, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (24347852, '9', 'Olivia', 'Amelia', 'Vásquez', 'Cárdenas', '1981-08-14', 1, 2, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12238614, '7', 'Valeria', 'Monserrat', 'Pizarro', 'Reyes', '1960-07-04', 1, 3, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8285146, '1', 'José', 'Felipe', 'Gómez', 'Silva', '1989-02-24', 2, 4, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20795938, '3', 'Amanda', 'Martina', 'Bravo', 'Núñez', '1988-06-20', 1, 5, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14966594, '3', 'Javiera', 'Renata', 'Fernández', 'Sepúlveda', '1964-11-01', 1, 7, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8888836, '7', 'Valeria', 'Valeria', 'Cárdenas', 'Díaz', '1998-06-27', 1, 5, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21881714, '9', 'Paulina', 'Dominga', 'Reyes', 'Castillo', '1981-11-21', 1, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (24190014, '2', 'María José', 'Dominga', 'Miranda', 'Díaz', '1975-08-30', 1, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17504669, '0', 'Elena', 'Eloísa', 'García', 'Pizarro', '1964-02-10', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18745244, '9', 'Catalina', 'Ana', 'Vergara', 'Martínez', '1992-10-28', 1, 3, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11857031, '6', 'David', 'Miguel', 'Herrera', 'Araya', '1992-07-08', 2, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12880526, '5', 'Olivia', 'Valeria', 'Molina', 'Gutiérrez', '1985-10-22', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14280017, '9', 'Agustina', 'Victoria', 'Castro', 'Sepúlveda', '1985-11-09', 1, 3, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18050900, '3', 'Victoria', 'Amelia', 'García', 'Vergara', '1970-10-31', 1, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12788725, 'K', 'Juan Pablo', 'Maximiliano', 'Castro', 'Miranda', '1978-09-27', 2, 5, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17203441, '1', 'Gaspar', 'Santiago', 'Valenzuela', 'Pizarro', '2004-02-19', 2, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20751429, '2', 'Pascal', 'Emilia', 'Morales', 'Muñoz', '2003-03-20', 1, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22245529, '4', 'Bárbara', 'Camila', 'Herrera', 'Molina', '1975-10-18', 1, 1, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19625626, '1', 'Josefa', 'Sofía', 'Díaz', 'Castro', '1996-04-04', 1, 1, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20420241, '9', 'Miguel', 'Santiago', 'Riquelme', 'Martínez', '1997-01-28', 2, 3, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11388836, '9', 'Jacinta', 'Julieta', 'Carrasco', 'García', '1975-11-20', 1, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10583581, '7', 'María Paz', 'Valeria', 'Carrasco', 'Orellana', '1986-08-30', 1, 7, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13420977, '1', 'Jacinta', 'Valeria', 'Torres', 'Sandoval', '1971-07-09', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (24321848, '9', 'Agustina', 'María José', 'Núñez', 'Silva', '1974-10-06', 1, 2, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (24016080, '3', 'Belén', 'Monserrat', 'Castro', 'Pizarro', '1989-03-23', 1, 7, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21028464, '8', 'Rafaela', 'Renata', 'Álvarez', 'Miranda', '1983-11-07', 1, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14516687, 'K', 'María Paz', 'Elena', 'Vera', 'Carrasco', '1964-09-16', 1, 7, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7599108, '8', 'Antonella', 'Josefa', 'Fuentes', 'Vega', '1988-02-28', 1, 4, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18511322, '1', 'Leonor', 'Amanda', 'Ramírez', 'Núñez', '1988-12-01', 1, 5, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15103819, '0', 'Javiera', 'Martina', 'Miranda', 'Ramírez', '1977-07-14', 1, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12659869, '6', 'Agustina', 'Alejandra', 'Gómez', 'Campos', '1970-09-13', 1, 2, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13679296, '2', 'Consuelo', 'Consuelo', 'Campos', 'Tapia', '1991-08-23', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9402072, '7', 'Tomás', 'Simón', 'Silva', 'González', '1999-02-13', 2, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10198725, '6', 'Camila', 'Agustina', 'Jara', 'Contreras', '2003-12-25', 1, 7, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13678228, '2', 'Rocío', 'Andrea', 'Tapia', 'Cárdenas', '1977-11-25', 1, 2, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22860681, '2', 'Monserrat', 'Verónica', 'Castillo', 'Miranda', '1983-08-29', 1, 1, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15858745, '9', 'Valentina', 'Verónica', 'Gutiérrez', 'Rojas', '1974-07-21', 1, 7, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12356780, '3', 'Laura', 'Paulina', 'Soto', 'Pérez', '1976-10-28', 1, 4, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12222640, '9', 'Pablo', 'Damián', 'Silva', 'Herrera', '1962-05-17', 2, 2, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16097227, '0', 'Josefa', 'Consuelo', 'Flores', 'Núñez', '1989-10-23', 1, 2, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18825990, '1', 'Leonor', 'Gabriela', 'Morales', 'Silva', '1972-03-22', 1, 1, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21833342, '7', 'Simón', 'Ignacio', 'Vera', 'Sandoval', '2000-10-04', 2, 5, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19196629, '5', 'Daniel', 'Clemente', 'Rodríguez', 'Muñoz', '2002-12-07', 2, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20705546, '8', 'Monserrat', 'Constanza', 'Molina', 'Contreras', '1980-08-01', 1, 2, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (24730195, 'K', 'Emiliano', 'Arturo', 'Flores', 'Gómez', '1964-09-15', 2, 3, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16795682, '3', 'Laura', 'Julieta', 'Araya', 'Reyes', '1991-11-22', 1, 1, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8637318, '1', 'Paulina', 'Verónica', 'Araya', 'Gutiérrez', '1989-05-02', 1, 3, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10103740, '1', 'Gabriela', 'Paz', 'Campos', 'Rodríguez', '1977-11-16', 1, 4, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17061716, '9', 'Olivia', 'Fernanda', 'Martínez', 'Araya', '1964-02-17', 1, 3, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7207889, '6', 'Patricio', 'Ángel', 'Araya', 'Gómez', '1965-05-21', 2, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15145931, '5', 'Catalina', 'Bárbara', 'Sandoval', 'Cortés', '1969-02-19', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8388074, '0', 'Alejandra', 'Beatriz', 'Molina', 'Jara', '1988-07-30', 1, 2, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18760991, '7', 'Luciano', 'Jorge', 'Ramírez', 'Torres', '1994-05-19', 2, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8239007, '3', 'Amparo', 'Leonor', 'Sandoval', 'Bravo', '1962-04-23', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7211294, '6', 'Santiago', 'Ángel', 'Vera', 'Espinoza', '1967-07-10', 2, 3, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16667654, '1', 'Florencia', 'Victoria', 'Martínez', 'Rivera', '1961-12-27', 1, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13436345, '2', 'José Tomás', 'Rodrigo', 'Sandoval', 'Vásquez', '1963-08-17', 2, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7621560, 'K', 'Alejandra', 'Antonella', 'López', 'Castillo', '2007-06-09', 1, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21910197, 'K', 'Julieta', 'Olivia', 'Rojas', 'Tapia', '1968-03-26', 1, 2, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20494398, '2', 'Arturo', 'Ángel', 'Torres', 'Silva', '1969-05-11', 2, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23179235, 'K', 'Eloísa', 'Dominga', 'Castro', 'Molina', '1996-11-22', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (24147267, '1', 'Renata', 'Elena', 'Riquelme', 'Vega', '1991-07-21', 1, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17178489, '1', 'Victoria', 'Renata', 'Díaz', 'Ramírez', '1968-11-07', 1, 3, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13410269, '1', 'Fernanda', 'Pascal', 'Orellana', 'Vega', '1990-10-06', 1, 2, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7929706, '2', 'Rocío', 'Jacinta', 'Reyes', 'Jara', '1999-10-31', 1, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17153199, '3', 'Amanda', 'Florencia', 'Pérez', 'Castro', '1974-04-23', 1, 4, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18930039, '5', 'Monserrat', 'Paulina', 'Castillo', 'Vásquez', '2000-04-27', 1, 1, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21390893, '6', 'Dominga', 'Antonia', 'Álvarez', 'Silva', '1964-12-27', 1, 1, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19542811, '5', 'Catalina', 'Rafaela', 'Cortés', 'García', '1985-02-04', 1, 1, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10582811, 'K', 'Verónica', 'Antonia', 'Miranda', 'Castro', '2002-04-27', 1, 4, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7431149, '0', 'Victoria', 'María Paz', 'Díaz', 'Pizarro', '1976-12-14', 1, 4, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12959207, '9', 'Emiliano', 'Liam', 'Fernández', 'Álvarez', '1979-03-19', 2, 3, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11085075, '1', 'Fernanda', 'Sofía', 'Valenzuela', 'Morales', '1974-07-31', 1, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13374462, '2', 'Vicente', 'Ignacio', 'Herrera', 'Riquelme', '1990-07-16', 2, 5, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8846833, '3', 'Mía', 'Celeste', 'Rodríguez', 'Sandoval', '1994-03-04', 1, 4, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22392932, 'K', 'Valeria', 'Josefa', 'Morales', 'Rodríguez', '1978-08-01', 1, 5, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20324783, '4', 'Lía', 'Eloísa', 'Martínez', 'Vergara', '2003-01-16', 1, 3, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23735746, '9', 'León', 'Borja', 'Espinoza', 'Orellana', '2001-05-22', 2, 3, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22638793, '5', 'Santiago', 'Juan Pablo', 'Pizarro', 'Carrasco', '1998-02-26', 2, 1, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22303745, '3', 'Cristóbal', 'Esteban', 'Díaz', 'Castro', '1962-03-28', 2, 4, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (6764853, '6', 'Anaís', 'Catalina', 'Díaz', 'Ramírez', '1994-10-05', 1, 3, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18063378, '2', 'Valeria', 'Josefa', 'Jara', 'Contreras', '1960-11-06', 1, 1, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20568715, '7', 'Martina', 'Josefa', 'Castro', 'González', '2006-02-22', 1, 2, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8007213, '9', 'Constanza', 'Leonor', 'Díaz', 'Contreras', '1983-04-20', 1, 1, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18553667, 'K', 'Gabriela', 'Eloísa', 'Araya', 'Gómez', '1976-11-08', 1, 4, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15282292, '8', 'Monserrat', 'Martina', 'Vásquez', 'Araya', '1996-07-06', 1, 1, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20438317, '0', 'Nicolás', 'Damián', 'Gómez', 'Morales', '2001-05-20', 2, 4, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12159890, '6', 'Lucas', 'Diego', 'Castillo', 'Cárdenas', '1997-05-19', 2, 5, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22342644, '1', 'Sofía', 'Emma', 'Riquelme', 'Campos', '2001-11-19', 1, 2, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13791434, '4', 'Consuelo', 'Catalina', 'Álvarez', 'López', '1973-07-16', 1, 4, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20086912, '5', 'Cristian', 'Gaspar', 'Gómez', 'Cortés', '1973-07-22', 2, 5, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19060316, '4', 'Ignacio', 'Diego', 'Orellana', 'Cortés', '2004-09-25', 2, 3, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17570964, '9', 'Rocío', 'Julieta', 'Vera', 'Castro', '1997-02-01', 1, 1, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10513342, '1', 'Fernanda', 'Isidora', 'Campos', 'Castro', '1991-05-19', 1, 5, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8579885, '5', 'Esteban', 'Alonso', 'Pérez', 'Araya', '1979-04-11', 2, 4, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7436279, '6', 'Amparo', 'Daniela', 'Herrera', 'Álvarez', '1989-07-18', 1, 5, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19198092, '1', 'Cristóbal', 'Daniel', 'Contreras', 'Contreras', '1996-03-26', 2, 3, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9648629, '4', 'Isabella', 'Alejandra', 'Díaz', 'Soto', '1979-11-26', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (6837883, '4', 'Sofía', 'Lía', 'Fuentes', 'Rodríguez', '2005-03-08', 1, 2, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10608485, '8', 'Antonella', 'María José', 'Espinoza', 'Flores', '2006-09-28', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16798949, '7', 'Javier', 'Facundo', 'Ramírez', 'Valenzuela', '1991-05-17', 2, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10460397, '1', 'Facundo', 'Luciano', 'Rodríguez', 'Pérez', '1998-01-24', 2, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13267445, '0', 'Beatriz', 'Sofía', 'Vergara', 'Gómez', '1991-07-25', 1, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23789493, '6', 'Catalina', 'Emilia', 'Vega', 'Fuentes', '2003-07-31', 1, 3, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (6687766, '3', 'Gabriela', 'Luciana', 'Vera', 'Carrasco', '1978-08-27', 1, 4, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13029428, '6', 'Olivia', 'Emma', 'Pizarro', 'Cortés', '1987-10-02', 1, 5, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22582437, '1', 'Ana', 'Dominga', 'Gómez', 'Sandoval', '2002-10-04', 1, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21414711, '4', 'Fernanda', 'Amelia', 'Castro', 'Pérez', '2005-11-03', 1, 2, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21373004, '5', 'Lucas', 'Sebastián', 'Molina', 'Figueroa', '1996-12-08', 2, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11735850, 'K', 'Ángel', 'Ricardo', 'García', 'Bravo', '1975-08-24', 2, 2, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22602377, '1', 'Lía', 'Victoria', 'López', 'Rivera', '1973-03-28', 1, 3, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7740672, '7', 'Agustina', 'Constanza', 'Flores', 'Castillo', '1985-03-12', 1, 2, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20466944, '9', 'Olivia', 'Victoria', 'Valenzuela', 'Sepúlveda', '1998-07-04', 1, 1, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8491818, '0', 'Ignacia', 'Eloísa', 'Gómez', 'Vergara', '1968-09-28', 1, 1, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22585884, '5', 'Paz', 'Maite', 'Rodríguez', 'Pizarro', '1977-01-02', 1, 4, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17253517, '8', 'Agustina', 'Paulina', 'Riquelme', 'Castillo', '1977-11-21', 1, 4, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (24897578, '4', 'Catalina', 'Laura', 'Castro', 'Vega', '1980-02-17', 1, 4, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11601922, '1', 'Olivia', 'Celeste', 'Fuentes', 'Fernández', '1975-07-03', 1, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18428428, '6', 'Belén', 'Paz', 'Fuentes', 'Castillo', '1989-02-01', 1, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8018862, '5', 'Camila', 'Fernanda', 'Rojas', 'Vásquez', '1972-03-15', 1, 7, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (24051105, '3', 'Juan Pablo', 'Patricio', 'Sandoval', 'Torres', '2004-05-07', 2, 2, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16196942, '7', 'Mía', 'Victoria', 'González', 'Martínez', '1973-08-03', 1, 3, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7857128, '4', 'Rodrigo', 'Diego', 'Campos', 'Cárdenas', '1991-05-12', 2, 7, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23873326, 'K', 'Jorge', 'Joaquín', 'Gómez', 'Pizarro', '1982-04-26', 2, 7, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8617298, '4', 'Luciano', 'Ignacio', 'Vera', 'Silva', '1990-03-28', 2, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19542269, '9', 'Gaspar', 'Esteban', 'Silva', 'Espinoza', '1969-12-19', 2, 7, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22997369, 'K', 'Thiago', 'Liam', 'Pizarro', 'Vásquez', '1993-05-15', 2, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20607606, '2', 'Martín', 'Santiago', 'Gutiérrez', 'Cortés', '1994-09-22', 2, 4, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23020138, '2', 'Lucas', 'Tomás', 'Pérez', 'Araya', '2002-06-20', 2, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12371335, '4', 'Leonor', 'Amparo', 'García', 'Vergara', '1976-08-24', 1, 7, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13322803, '9', 'Verónica', 'Renata', 'Cárdenas', 'Núñez', '1983-10-25', 1, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17466974, '0', 'Valeria', 'Amelia', 'Castillo', 'López', '2003-11-30', 1, 7, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9631908, '8', 'Victoria', 'Renata', 'Flores', 'Campos', '2002-11-02', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17830951, 'K', 'Julieta', 'Isabella', 'Álvarez', 'González', '1963-09-20', 1, 4, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17485236, '7', 'Francisca', 'Isidora', 'Molina', 'Castro', '1966-05-25', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16292755, '8', 'Jorge', 'Jorge', 'Vera', 'Reyes', '1992-09-15', 2, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9990023, '7', 'Celeste', 'Belén', 'Vega', 'Valenzuela', '1961-01-30', 1, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17223376, '7', 'Juan Pablo', 'Luciano', 'Silva', 'Pizarro', '1963-05-28', 2, 7, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20525051, '4', 'Sofía Antonia', 'Ana', 'Sánchez', 'Martínez', '1990-11-14', 1, 7, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20270921, '4', 'Valentina', 'Elena', 'Cortés', 'Pérez', '1991-09-30', 1, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12787081, '0', 'Alonso', 'Pedro', 'Muñoz', 'Orellana', '1999-07-04', 2, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13034997, '8', 'Pablo', 'Damián', 'Campos', 'Contreras', '1987-03-23', 2, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21659881, '4', 'Ignacia', 'Olivia', 'Contreras', 'Cortés', '1992-11-07', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16784983, '0', 'Trinidad', 'Emma', 'Araya', 'Reyes', '1973-12-25', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14961860, '0', 'Agustina', 'Ignacia', 'Díaz', 'Miranda', '1997-03-20', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23472616, '1', 'Gaspar', 'José Tomás', 'Sánchez', 'Gómez', '1969-10-21', 2, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12066568, '5', 'Monserrat', 'Rocío', 'Gómez', 'Sánchez', '1997-03-25', 1, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12685591, '5', 'Francisca', 'Florencia', 'Riquelme', 'Rivera', '2006-02-19', 1, 7, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10961989, '2', 'Antonio', 'Mateo', 'Vergara', 'Vega', '1992-08-14', 2, 7, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9913599, '9', 'Joaquín', 'Bruno', 'Silva', 'Campos', '1968-04-04', 2, 3, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15482491, 'K', 'Fernanda', 'Florencia', 'Ramírez', 'Sepúlveda', '1990-01-09', 1, 7, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8783521, '9', 'Luis', 'León', 'Herrera', 'Rodríguez', '1966-12-19', 2, 1, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15391921, '6', 'Julieta', 'Gabriela', 'Martínez', 'Vera', '1974-11-10', 1, 5, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9920287, '4', 'Daniela', 'Carolina', 'Vega', 'Sandoval', '1995-12-07', 1, 7, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10368721, '7', 'Luis', 'Patricio', 'Jara', 'Sepúlveda', '1964-05-27', 2, 4, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (24858164, '6', 'Agustina', 'Isidora', 'Cárdenas', 'Vásquez', '1979-07-30', 1, 4, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8686359, '6', 'Florencia', 'Monserrat', 'Vera', 'Orellana', '1989-06-15', 1, 3, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9769958, '5', 'Celeste', 'Bárbara', 'Jara', 'Díaz', '1997-02-15', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9869514, '1', 'Renata', 'Luciana', 'Soto', 'Morales', '1994-01-01', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22013160, '2', 'Eloísa', 'Monserrat', 'Castro', 'Fernández', '1961-08-25', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19353280, '2', 'Camila', 'Lía', 'Reyes', 'López', '1990-02-11', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8637088, '3', 'Daniela', 'Sofía Antonia', 'Morales', 'Vásquez', '2004-02-18', 1, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17822919, '2', 'Anaís', 'Catalina', 'Valenzuela', 'Núñez', '1995-05-27', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18284684, '8', 'Gabriel', 'José', 'Contreras', 'Vega', '1978-09-04', 2, 2, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9722011, '5', 'Fernanda', 'Lía', 'Vásquez', 'Vergara', '1966-12-08', 1, 3, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11092779, '7', 'Maximiliano', 'Martín', 'Vásquez', 'Sandoval', '1969-02-10', 2, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20170464, '2', 'Javiera', 'Bárbara', 'Bravo', 'Orellana', '2003-12-27', 1, 2, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20855835, '8', 'Carlos', 'Franco', 'Bravo', 'Silva', '1981-05-11', 2, 5, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20815272, '6', 'Damián', 'Mateo', 'Torres', 'Miranda', '2003-07-12', 2, 4, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15171211, '8', 'Agustín', 'Alejandro', 'Fernández', 'Valenzuela', '1984-12-07', 2, 5, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15208002, '6', 'Mateo', 'Daniel', 'Soto', 'Torres', '1982-09-18', 2, 2, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13688156, '6', 'Francisca', 'Antonia', 'Vera', 'Vásquez', '1982-10-29', 1, 3, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23737234, '4', 'María Paz', 'Francisca', 'Silva', 'Álvarez', '1989-08-06', 1, 5, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14538616, '0', 'Beatriz', 'Belén', 'Castro', 'Rojas', '1999-02-15', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15069824, '3', 'Pedro', 'Renato', 'Herrera', 'Muñoz', '1990-07-14', 2, 1, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9956770, '8', 'Francisco', 'Antonio', 'Muñoz', 'Rivera', '1988-02-13', 2, 5, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20947158, '2', 'Consuelo', 'Trinidad', 'Carrasco', 'Cortés', '2005-01-27', 1, 7, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11492221, '8', 'Javiera', 'Anaís', 'Fuentes', 'Rojas', '1974-12-31', 1, 4, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22000652, '2', 'José Tomás', 'Antonio', 'Muñoz', 'Castillo', '1995-07-11', 2, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22199482, '5', 'Isabella', 'Carolina', 'Rivera', 'Vega', '1977-05-29', 1, 4, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7856390, '7', 'Ignacia', 'Valeria', 'Muñoz', 'Figueroa', '1975-11-21', 1, 1, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10490069, '0', 'Paulina', 'Camila', 'García', 'Flores', '2001-04-25', 1, 5, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11700745, '6', 'Laura', 'Elena', 'Fernández', 'Fuentes', '1998-11-16', 1, 2, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7697637, '6', 'José', 'Borja', 'Castillo', 'Molina', '2004-06-09', 2, 4, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16310535, '7', 'Eloísa', 'María Paz', 'Castro', 'Álvarez', '1981-07-19', 1, 1, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18642731, '9', 'Amanda', 'Bárbara', 'Molina', 'Díaz', '1964-04-13', 1, 2, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (24689764, '6', 'Francisca', 'Rafaela', 'Vega', 'Reyes', '1975-08-21', 1, 4, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9598276, 'K', 'Monserrat', 'Valentina', 'Rodríguez', 'Fernández', '1982-10-12', 1, 1, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12179018, '1', 'Elena', 'Laura', 'Ramírez', 'González', '1991-03-03', 1, 3, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16364042, '2', 'Pedro', 'Lucas', 'Ramírez', 'Cárdenas', '1972-05-02', 2, 5, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19663067, '8', 'Francisca', 'Paulina', 'Rojas', 'Vera', '1975-05-03', 1, 5, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7994240, '5', 'Esteban', 'Matías', 'Castro', 'Bravo', '2002-11-21', 2, 5, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18665712, '8', 'Gabriela', 'Isabella', 'Núñez', 'Carrasco', '1980-09-02', 1, 2, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14971176, '7', 'Andrea', 'Alejandra', 'Núñez', 'Contreras', '1976-03-09', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14972431, '1', 'Daniela', 'Rafaela', 'Espinoza', 'Sandoval', '1992-12-03', 1, 3, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14665691, '9', 'Eduardo', 'Renato', 'Reyes', 'González', '1998-01-24', 2, 2, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7226654, '4', 'Olivia', 'Jacinta', 'Tapia', 'Morales', '2000-10-25', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18374137, '3', 'Bruno', 'Ricardo', 'Valenzuela', 'Miranda', '2005-03-01', 2, 5, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15641110, '8', 'Ricardo', 'Pablo', 'Pizarro', 'Valenzuela', '2003-02-10', 2, 1, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16801685, '9', 'Jacinta', 'Constanza', 'Sandoval', 'Torres', '1970-03-29', 1, 4, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23290657, 'K', 'Pablo', 'Franco', 'Martínez', 'Castro', '2003-02-05', 2, 3, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10014252, 'K', 'Jorge', 'Thiago', 'Espinoza', 'Jara', '1973-04-07', 2, 3, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21945656, '5', 'Florencia', 'Luciana', 'Araya', 'Fuentes', '1990-07-14', 1, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12375332, '1', 'Verónica', 'Gabriela', 'García', 'Campos', '1978-05-15', 1, 5, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9531764, '2', 'Emma', 'Maite', 'Fuentes', 'Gutiérrez', '1962-06-01', 1, 3, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22626364, '0', 'Julieta', 'Ana', 'Carrasco', 'García', '1994-04-05', 1, 4, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10544924, '0', 'Antonia', 'Jacinta', 'Soto', 'Pizarro', '2004-07-10', 1, 4, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21447525, '1', 'Emilia', 'Antonia', 'Castillo', 'Reyes', '1969-01-16', 1, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8552376, '7', 'Laura', 'Florencia', 'Pérez', 'Campos', '1988-03-28', 1, 2, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (14674561, 'K', 'Laura', 'Andrea', 'Núñez', 'Flores', '1982-08-03', 1, 4, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15763604, '9', 'Cristian', 'Liam', 'Vera', 'Campos', '1963-11-24', 2, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18033097, '6', 'Mateo', 'Agustín', 'Figueroa', 'Muñoz', '1970-03-23', 2, 1, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9935843, '2', 'Andrea', 'Monserrat', 'Muñoz', 'García', '2006-01-13', 1, 1, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17915469, '2', 'Amanda', 'Antonia', 'Muñoz', 'Flores', '1982-01-01', 1, 2, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20810316, '4', 'Luis', 'Damián', 'Carrasco', 'López', '2004-09-19', 2, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9118313, '7', 'Julieta', 'Amelia', 'Orellana', 'Carrasco', '1974-04-21', 1, 3, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20626204, '4', 'Thiago', 'Gabriel', 'Fuentes', 'Ramírez', '2004-09-19', 2, 4, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9005366, '3', 'Celeste', 'Florencia', 'Espinoza', 'Riquelme', '2005-11-07', 1, 2, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15278551, '8', 'Juan Pablo', 'Maximiliano', 'Cortés', 'Vásquez', '2003-10-24', 2, 4, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21025574, '5', 'Francisco', 'David', 'Rodríguez', 'Vera', '1977-08-11', 2, 6, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12678947, '5', 'Isidora', 'Valentina', 'Sepúlveda', 'Pérez', '1965-07-31', 1, 4, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (24528077, '7', 'Francisca', 'Victoria', 'Contreras', 'Herrera', '2006-09-03', 1, 4, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21450143, '0', 'Dominga', 'Eloísa', 'Jara', 'Vergara', '1960-07-24', 1, 1, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (17253917, '3', 'Miguel', 'Emiliano', 'Pizarro', 'López', '1979-03-09', 2, 5, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22686719, '8', 'Florencia', 'Jacinta', 'Contreras', 'Torres', '1975-10-25', 1, 2, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8621610, '8', 'Verónica', 'Bárbara', 'Espinoza', 'Cortés', '2004-05-30', 1, 5, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12397139, '6', 'Facundo', 'Bastián', 'González', 'García', '2003-01-07', 2, 2, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7593686, '9', 'Bastián', 'Bastián', 'García', 'González', '1999-08-09', 2, 2, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16443077, '4', 'Amelia', 'Consuelo', 'Gutiérrez', 'Espinoza', '1974-10-22', 1, 6, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11589515, 'K', 'Celeste', 'Olivia', 'Rodríguez', 'Núñez', '1993-08-09', 1, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11699863, '7', 'Josefa', 'Josefa', 'Miranda', 'Flores', '1988-05-22', 1, 1, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21514813, '0', 'Antonella', 'Sofía Antonia', 'Vera', 'Cortés', '2000-04-15', 1, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10548512, '3', 'Florencia', 'Camila', 'Araya', 'Orellana', '2003-10-16', 1, 5, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10832765, '0', 'Consuelo', 'Amparo', 'Orellana', 'Tapia', '1982-04-10', 1, 5, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21003257, '6', 'Cristian', 'Joaquín', 'Sandoval', 'Silva', '1977-09-04', 2, 1, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23193164, '3', 'Catalina', 'Laura', 'Díaz', 'Díaz', '1964-09-02', 1, 5, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23113502, '2', 'Miguel', 'Martín', 'Muñoz', 'Muñoz', '2001-10-21', 2, 2, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21491889, '7', 'Mateo', 'Lucas', 'Vásquez', 'Castillo', '1962-10-09', 2, 3, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10582617, '6', 'Amanda', 'Leonor', 'Vásquez', 'Álvarez', '1987-09-12', 1, 4, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21733432, '2', 'Daniel', 'Manuel', 'Miranda', 'Sepúlveda', '1983-03-18', 2, 5, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18364590, '0', 'Camila', 'Alejandra', 'Valenzuela', 'Contreras', '1992-07-26', 1, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11560538, '0', 'Pascal', 'Lía', 'Muñoz', 'Campos', '1992-10-05', 1, 3, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8646844, '1', 'Rocío', 'Paulina', 'Riquelme', 'Pizarro', '2006-01-31', 1, 3, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (24295525, '0', 'Sofía Antonia', 'Beatriz', 'López', 'Herrera', '1974-11-12', 1, 5, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23030762, '8', 'Gaspar', 'Ricardo', 'Bravo', 'Fuentes', '1972-12-13', 2, 1, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (12738829, '6', 'Ignacio', 'Damián', 'Jara', 'Silva', '2003-09-05', 2, 2, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23847683, '6', 'Santiago', 'Francisco', 'Miranda', 'Vásquez', '1996-11-13', 2, 4, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11781807, '1', 'Antonella', 'Sofía Antonia', 'Herrera', 'Ramírez', '2005-05-01', 1, 5, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19546617, '3', 'Isabella', 'Bárbara', 'Molina', 'Cortés', '2005-08-28', 1, 4, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19320108, '3', 'Javier', 'Antonio', 'Núñez', 'Vera', '1992-07-30', 2, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23050787, '2', 'Luciana', 'Camila', 'Molina', 'Sepúlveda', '1970-11-28', 1, 2, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21150542, '7', 'Sofía Antonia', 'Emma', 'Cárdenas', 'Miranda', '1971-10-26', 1, 1, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (10780446, '3', 'Emilia', 'Antonia', 'Vega', 'Molina', '1982-06-11', 1, 5, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15753963, '9', 'Gabriel', 'Fernando', 'Flores', 'Miranda', '1989-03-14', 2, 2, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (11262279, '9', 'Camila', 'Celeste', 'Gómez', 'Reyes', '1990-09-25', 1, 2, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (15850238, '0', 'Bárbara', 'Emma', 'Vásquez', 'Morales', '1961-01-22', 1, 7, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23563272, '1', 'Monserrat', 'Paz', 'Gómez', 'Valenzuela', '2003-04-10', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (16812183, '0', 'Fernanda', 'Emma', 'Figueroa', 'Muñoz', '1976-06-10', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21729717, '6', 'Gabriela', 'Pascal', 'Espinoza', 'Vera', '1993-10-21', 1, 4, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (13263385, '1', 'Emma', 'Camila', 'Martínez', 'Silva', '1962-06-02', 1, 4, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20044863, '4', 'Amanda', 'Leonor', 'Contreras', 'Pérez', '1984-08-22', 1, 2, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (21243581, '3', 'Francisca', 'Rocío', 'Araya', 'López', '1963-06-12', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9626249, '3', 'Amanda', 'Belén', 'Rojas', 'Torres', '1980-07-20', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9022667, '3', 'Javiera', 'Paz', 'Riquelme', 'Cárdenas', '1997-01-20', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (6592313, '0', 'Isabella', 'Dominga', 'Rodríguez', 'Jara', '1979-01-23', 1, 7, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (8957021, '2', 'Pascal', 'Emilia', 'Herrera', 'Ramírez', '1996-03-12', 1, 7, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18429663, '2', 'Constanza', 'María José', 'Vera', 'Riquelme', '1981-11-06', 1, 3, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (23665385, '4', 'Bastián', 'Rodrigo', 'Contreras', 'Cortés', '1963-05-31', 2, 2, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (22955309, '7', 'Sofía', 'Anaís', 'Espinoza', 'Valenzuela', '1981-08-10', 1, 4, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (19294513, '5', 'María José', 'Constanza', 'Molina', 'Campos', '1968-01-19', 1, 5, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7343339, '8', 'Pascal', 'Rafaela', 'Miranda', 'Fernández', '1983-07-05', 1, 2, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (18512791, '5', 'Luciana', 'Luciana', 'Silva', 'Castillo', '1968-04-27', 1, 5, 1);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (20745880, '5', 'Florencia', 'Paz', 'Álvarez', 'Sandoval', '2003-11-21', 1, 5, 3);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (9566953, '0', 'Jacinta', 'Sofía', 'Morales', 'Rodríguez', '1980-06-15', 1, 6, 2);
INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES (7943528, '7', 'Florencia', 'Ignacia', 'Sánchez', 'Núñez', '2007-06-16', 1, 5, 1);

# venta
# detalle_venta
# venta_promocion

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (1, 12371335, 2, '2024-02-22 00:50:17', 221120.00, 11056.00, 210064.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (1, 208, 2, 50436.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (1, 152, 2, 16021.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (1, 131, 1, 88206.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (2, 21711459, 3, '2024-03-08 00:36:17', 117030.00, 5851.50, 111178.50);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (2, 302, 2, 58515.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (3, 23847683, 3, '2024-01-11 07:16:17', 35887.00, 0.00, 35887.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (3, 125, 1, 35887.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (4, 16097227, 2, '2025-04-18 02:05:17', 386790.00, 29009.25, 357780.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (4, 296, 2, 88799.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (4, 188, 1, 40692.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (4, 175, 2, 84250.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (5, 21373004, 2, '2024-01-29 01:00:17', 163808.00, 8190.40, 155617.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (5, 244, 2, 34346.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (5, 268, 2, 30185.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (5, 231, 2, 17373.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (6, 11015275, 1, '2023-08-12 19:43:17', 207465.00, 0.00, 207465.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (6, 335, 1, 35620.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (6, 201, 2, 29385.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (6, 166, 1, 44957.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (6, 280, 2, 34059.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (7, 7857128, 3, '2024-12-17 13:14:17', 97246.00, 4862.30, 92383.70);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (7, 229, 1, 75604.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (7, 264, 1, 21642.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (8, 15482491, 1, '2025-01-13 10:06:17', 85248.00, 4262.40, 80985.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (8, 295, 1, 26733.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (8, 302, 1, 58515.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (9, 21330851, 1, '2024-04-28 06:46:17', 44796.00, 2239.80, 42556.20);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (9, 287, 1, 44796.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (10, 8846833, 1, '2024-12-08 15:44:17', 52422.00, 0.00, 52422.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (10, 171, 2, 26211.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (11, 17061716, 1, '2024-08-25 16:45:17', 268668.00, 20150.10, 248517.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (11, 179, 2, 24540.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (11, 343, 2, 18732.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (11, 307, 2, 91062.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (12, 6764853, 1, '2023-08-11 02:31:17', 63609.00, 3180.45, 60428.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (12, 286, 1, 47752.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (12, 190, 1, 15857.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (13, 12066568, 1, '2024-05-15 00:54:17', 94265.00, 0.00, 94265.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (13, 259, 1, 11292.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (13, 338, 1, 32000.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (13, 106, 2, 17476.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (13, 152, 1, 16021.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (14, 10014252, 1, '2023-06-13 14:43:17', 277325.00, 20799.38, 256525.62);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (14, 194, 2, 39255.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (14, 227, 2, 32319.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (14, 197, 1, 46657.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (14, 235, 1, 87520.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (15, 22997369, 1, '2024-05-16 04:13:17', 373868.00, 28040.10, 345827.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (15, 128, 2, 74854.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (15, 323, 2, 77744.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (15, 212, 2, 34336.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (16, 21025574, 3, '2024-11-03 00:17:17', 243140.00, 0.00, 243140.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (16, 209, 2, 60785.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (16, 209, 2, 60785.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (17, 9005366, 2, '2025-05-12 23:20:17', 127547.00, 9566.02, 117980.98);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (17, 124, 1, 28884.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (17, 188, 2, 40692.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (17, 269, 1, 17279.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (18, 18050900, 1, '2024-06-05 08:15:17', 80268.00, 0.00, 80268.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (18, 282, 1, 33364.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (18, 271, 2, 23452.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (19, 8637088, 2, '2025-04-08 19:09:17', 216984.00, 16273.80, 200710.20);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (19, 268, 1, 30185.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (19, 223, 2, 43259.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (19, 241, 1, 38123.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (19, 303, 2, 31079.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (20, 21833342, 2, '2024-11-20 10:11:17', 70604.00, 3530.20, 67073.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (20, 111, 1, 8001.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (20, 180, 1, 25631.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (20, 346, 1, 10170.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (20, 120, 2, 13401.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (21, 13679296, 3, '2023-10-16 15:05:17', 101818.00, 7636.35, 94181.65);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (21, 232, 2, 12767.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (21, 219, 1, 36622.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (21, 341, 2, 19831.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (22, 22013160, 1, '2024-08-28 05:33:17', 93698.00, 7027.35, 86670.65);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (22, 183, 2, 17464.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (22, 201, 2, 29385.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (23, 9722011, 2, '2023-06-17 19:03:17', 86516.00, 4325.80, 82190.20);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (23, 291, 1, 86516.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (24, 10103740, 3, '2024-09-09 07:25:17', 36758.00, 0.00, 36758.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (24, 248, 1, 36758.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (25, 8686359, 1, '2024-01-16 19:58:17', 235736.00, 17680.20, 218055.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (25, 218, 2, 28180.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (25, 125, 2, 35887.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (25, 128, 1, 74854.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (25, 304, 2, 16374.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (26, 22841837, 2, '2025-04-04 22:56:17', 87454.00, 4372.70, 83081.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (26, 257, 1, 12206.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (26, 232, 2, 12767.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (26, 145, 2, 24857.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (27, 14961860, 2, '2023-08-12 16:33:17', 62391.00, 4679.32, 57711.68);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (27, 322, 1, 29702.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (27, 222, 1, 32689.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (28, 17203441, 1, '2023-10-01 16:15:17', 162870.00, 12215.25, 150654.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (28, 239, 1, 28170.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (28, 205, 2, 20890.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (28, 105, 2, 46460.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (29, 14972431, 1, '2024-11-03 00:41:17', 183250.00, 0.00, 183250.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (29, 194, 2, 39255.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (29, 326, 1, 18732.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (29, 266, 1, 61534.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (29, 321, 1, 24474.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (30, 11846433, 2, '2025-03-17 05:30:17', 104809.00, 5240.45, 99568.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (30, 130, 2, 17633.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (30, 231, 1, 17373.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (30, 240, 2, 26085.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (31, 21390893, 2, '2025-05-24 11:55:17', 42244.00, 0.00, 42244.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (31, 333, 1, 42244.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (32, 12397139, 2, '2023-09-11 11:25:17', 169407.00, 12705.52, 156701.48);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (32, 322, 2, 29702.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (32, 170, 1, 41849.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (32, 252, 2, 18715.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (32, 117, 1, 30724.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (33, 18429663, 2, '2024-09-20 18:43:17', 340335.00, 17016.75, 323318.25);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (33, 314, 1, 41013.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (33, 307, 1, 91062.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (33, 278, 2, 18947.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (33, 297, 2, 85183.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (34, 19196629, 3, '2024-06-24 12:31:17', 271454.00, 20359.05, 251094.95);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (34, 170, 2, 41849.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (34, 110, 1, 44674.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (34, 336, 2, 40893.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (34, 277, 2, 30648.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (35, 18930039, 3, '2023-11-20 03:07:17', 139522.00, 6976.10, 132545.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (35, 112, 2, 17418.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (35, 137, 2, 19654.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (35, 222, 2, 32689.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (36, 8646844, 3, '2025-05-24 22:46:17', 33321.00, 1666.05, 31654.95);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (36, 190, 1, 15857.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (36, 183, 1, 17464.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (37, 9913599, 1, '2025-04-14 02:04:17', 62056.00, 3102.80, 58953.20);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (37, 129, 2, 21333.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (37, 203, 1, 19390.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (38, 8888836, 2, '2023-09-19 10:23:17', 163954.00, 12296.55, 151657.45);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (38, 120, 2, 13401.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (38, 235, 1, 87520.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (38, 339, 1, 23437.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (38, 211, 1, 26195.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (39, 8552376, 1, '2023-06-26 22:04:17', 114773.00, 8607.98, 106165.02);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (39, 175, 1, 84250.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (39, 299, 1, 30523.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (40, 11735850, 2, '2024-12-15 03:40:17', 100001.00, 0.00, 100001.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (40, 269, 1, 17279.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (40, 215, 2, 41361.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (41, 20745880, 2, '2023-12-08 02:45:17', 30337.00, 1516.85, 28820.15);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (41, 243, 1, 30337.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (42, 12258848, 3, '2023-12-15 13:40:17', 139066.00, 0.00, 139066.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (42, 267, 2, 18030.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (42, 138, 1, 28427.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (42, 188, 1, 40692.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (42, 165, 1, 33887.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (43, 8903100, 1, '2025-06-07 13:05:17', 91684.00, 6876.30, 84807.70);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (43, 236, 1, 8328.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (43, 263, 2, 41678.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (44, 22585884, 1, '2023-07-01 17:39:17', 153424.00, 0.00, 153424.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (44, 193, 2, 30854.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (44, 217, 2, 45858.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (45, 24897578, 3, '2025-04-29 15:02:17', 46750.00, 3506.25, 43243.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (45, 133, 1, 46750.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (46, 15145931, 3, '2024-02-25 02:25:17', 142046.00, 10653.45, 131392.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (46, 152, 1, 16021.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (46, 149, 1, 25225.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (46, 300, 2, 35038.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (46, 117, 1, 30724.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (47, 16196942, 3, '2025-05-05 14:14:17', 239766.00, 17982.45, 221783.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (47, 249, 2, 44654.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (47, 229, 1, 75604.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (47, 128, 1, 74854.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (48, 18745244, 1, '2024-12-15 00:35:17', 130029.00, 6501.45, 123527.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (48, 222, 2, 32689.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (48, 201, 1, 29385.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (48, 130, 2, 17633.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (49, 11589515, 2, '2023-08-09 13:38:17', 58489.00, 4386.68, 54102.32);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (49, 314, 1, 41013.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (49, 106, 1, 17476.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (50, 20270921, 1, '2024-03-20 06:48:17', 155394.00, 0.00, 155394.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (50, 348, 2, 11172.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (50, 181, 2, 44527.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (50, 102, 1, 43996.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (51, 21733432, 1, '2023-10-09 12:59:17', 279639.00, 20972.92, 258666.08);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (51, 347, 2, 26735.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (51, 334, 1, 40138.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (51, 202, 1, 36323.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (51, 128, 2, 74854.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (52, 19542269, 3, '2024-05-18 00:32:17', 263470.00, 13173.50, 250296.50);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (52, 332, 1, 47118.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (52, 317, 2, 58257.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (52, 242, 2, 16245.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (52, 151, 2, 33674.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (53, 19625626, 3, '2023-07-09 00:28:17', 46232.00, 3467.40, 42764.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (53, 192, 2, 23116.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (54, 18284684, 2, '2024-05-01 17:52:17', 161668.00, 0.00, 161668.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (54, 228, 2, 35303.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (54, 307, 1, 91062.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (55, 8846833, 3, '2024-04-03 01:29:17', 18732.00, 0.00, 18732.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (55, 343, 1, 18732.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (56, 17822919, 1, '2024-10-13 13:44:17', 23264.00, 1744.80, 21519.20);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (56, 116, 1, 23264.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (57, 18642731, 3, '2024-08-10 02:51:17', 194738.00, 9736.90, 185001.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (57, 193, 1, 30854.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (57, 292, 2, 23296.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (57, 314, 2, 41013.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (57, 130, 2, 17633.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (58, 17822919, 2, '2025-03-18 23:27:17', 121446.00, 9108.45, 112337.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (58, 126, 2, 19045.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (58, 263, 2, 41678.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (59, 22997369, 3, '2023-11-30 19:15:17', 51946.00, 3895.95, 48050.05);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (59, 306, 2, 25973.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (60, 12258848, 2, '2024-06-21 07:55:17', 127883.00, 0.00, 127883.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (60, 159, 1, 51465.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (60, 214, 1, 36502.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (60, 224, 2, 19958.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (61, 11492221, 1, '2025-02-14 03:26:17', 32319.00, 1615.95, 30703.05);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (61, 227, 1, 32319.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (62, 19546617, 1, '2025-05-31 23:55:17', 124161.00, 0.00, 124161.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (62, 206, 1, 16882.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (62, 180, 1, 25631.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (62, 167, 1, 37121.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (62, 181, 1, 44527.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (63, 12738829, 2, '2024-10-05 02:10:17', 20340.00, 0.00, 20340.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (63, 346, 2, 10170.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (64, 21414711, 2, '2023-07-02 05:11:17', 51718.00, 2585.90, 49132.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (64, 206, 1, 16882.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (64, 112, 2, 17418.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (65, 14665691, 2, '2024-02-02 22:13:17', 40138.00, 3010.35, 37127.65);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (65, 334, 1, 40138.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (66, 14971176, 1, '2024-07-26 11:20:17', 149440.00, 0.00, 149440.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (66, 152, 2, 16021.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (66, 191, 2, 20558.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (66, 177, 2, 38141.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (67, 11092779, 2, '2025-04-06 01:40:17', 163547.00, 12266.02, 151280.98);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (67, 188, 1, 40692.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (67, 163, 1, 34624.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (67, 134, 1, 48001.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (67, 123, 2, 20115.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (68, 11409393, 2, '2024-01-19 12:11:17', 36109.00, 2708.17, 33400.82);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (68, 164, 1, 16552.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (68, 132, 1, 19557.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (69, 8686359, 1, '2024-05-20 23:53:17', 12847.00, 963.52, 11883.48);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (69, 320, 1, 12847.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (70, 22000652, 3, '2024-10-30 21:07:17', 303353.00, 22751.47, 280601.53);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (70, 285, 1, 12782.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (70, 131, 2, 88206.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (70, 215, 2, 41361.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (70, 309, 1, 31437.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (71, 12066568, 2, '2024-03-14 14:32:17', 18671.00, 0.00, 18671.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (71, 104, 1, 18671.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (72, 17231954, 3, '2023-07-25 08:10:17', 55700.00, 2785.00, 52915.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (72, 114, 2, 27850.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (73, 21390893, 3, '2025-02-05 22:52:17', 41152.00, 0.00, 41152.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (73, 337, 1, 41152.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (74, 22392932, 3, '2024-11-13 23:12:17', 82124.00, 0.00, 82124.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (74, 324, 2, 41062.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (75, 15850238, 2, '2025-01-08 15:21:17', 185256.00, 9262.80, 175993.20);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (75, 160, 2, 10677.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (75, 336, 2, 40893.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (75, 303, 2, 31079.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (75, 224, 1, 19958.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (76, 12738829, 3, '2023-11-06 07:07:17', 87744.00, 0.00, 87744.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (76, 142, 1, 87744.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (77, 12738829, 1, '2023-10-22 17:41:17', 106413.00, 0.00, 106413.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (77, 167, 1, 37121.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (77, 326, 1, 18732.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (77, 169, 2, 25280.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (78, 7593686, 3, '2024-07-30 13:16:17', 30854.00, 1542.70, 29311.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (78, 193, 1, 30854.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (79, 18760991, 1, '2024-10-10 08:37:17', 110819.00, 8311.42, 102507.57);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (79, 344, 1, 35533.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (79, 240, 2, 26085.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (79, 192, 1, 23116.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (80, 10961989, 1, '2025-01-05 20:57:17', 33289.00, 1664.45, 31624.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (80, 220, 1, 15871.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (80, 112, 1, 17418.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (81, 23735746, 1, '2024-12-12 03:01:17', 281797.00, 14089.85, 267707.15);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (81, 151, 1, 33674.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (81, 287, 2, 44796.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (81, 219, 2, 36622.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (81, 186, 1, 85287.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (82, 13263385, 1, '2025-05-22 20:24:17', 60372.00, 0.00, 60372.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (82, 312, 2, 30186.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (83, 22955309, 3, '2025-05-29 07:37:17', 139703.00, 0.00, 139703.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (83, 279, 1, 50201.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (83, 141, 1, 23041.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (83, 271, 2, 23452.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (83, 132, 1, 19557.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (84, 9118313, 2, '2025-02-19 21:27:17', 31428.00, 0.00, 31428.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (84, 315, 1, 31428.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (85, 6698025, 2, '2024-05-06 23:43:17', 97258.00, 0.00, 97258.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (85, 207, 2, 9426.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (85, 184, 1, 43368.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (85, 300, 1, 35038.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (86, 20170464, 2, '2024-11-04 14:52:17', 185884.00, 9294.20, 176589.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (86, 158, 2, 45481.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (86, 288, 2, 26903.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (86, 191, 2, 20558.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (87, 21659881, 2, '2023-06-12 22:52:17', 197566.00, 14817.45, 182748.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (87, 136, 2, 48677.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (87, 119, 1, 51960.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (87, 276, 2, 24126.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (88, 16310535, 2, '2025-01-20 14:34:17', 18732.00, 936.60, 17795.40);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (88, 343, 1, 18732.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (89, 23290657, 2, '2025-02-25 00:25:17', 45916.00, 0.00, 45916.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (89, 240, 1, 26085.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (89, 341, 1, 19831.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (90, 20270921, 2, '2023-12-05 16:27:17', 121286.00, 0.00, 121286.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (90, 258, 1, 44983.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (90, 202, 1, 36323.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (90, 213, 1, 27198.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (90, 285, 1, 12782.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (91, 12959207, 1, '2023-07-31 21:28:17', 117706.00, 8827.95, 108878.05);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (91, 326, 2, 18732.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (91, 242, 2, 16245.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (91, 286, 1, 47752.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (92, 8756179, 3, '2023-10-25 13:38:17', 92586.00, 6943.95, 85642.05);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (92, 203, 2, 19390.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (92, 288, 2, 26903.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (93, 21711459, 1, '2024-05-08 15:39:17', 64603.00, 3230.15, 61372.85);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (93, 182, 2, 15177.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (93, 121, 1, 34249.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (94, 9598276, 2, '2025-05-28 02:16:17', 30186.00, 1509.30, 28676.70);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (94, 312, 1, 30186.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (95, 18511322, 2, '2024-05-26 12:51:17', 268445.00, 20133.38, 248311.62);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (95, 279, 2, 50201.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (95, 133, 2, 46750.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (95, 350, 1, 9165.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (95, 222, 2, 32689.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (96, 9869514, 2, '2024-06-10 11:10:17', 37464.00, 2809.80, 34654.20);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (96, 343, 2, 18732.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (97, 11846433, 3, '2025-01-27 05:42:17', 96908.00, 4845.40, 92062.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (97, 113, 2, 14205.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (97, 121, 2, 34249.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (98, 10544924, 3, '2025-05-25 08:14:17', 190786.00, 0.00, 190786.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (98, 208, 2, 50436.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (98, 166, 2, 44957.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (99, 24730195, 2, '2025-03-09 19:56:17', 210963.00, 15822.22, 195140.77);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (99, 166, 1, 44957.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (99, 287, 1, 44796.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (99, 262, 2, 43141.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (99, 183, 2, 17464.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (100, 20815272, 3, '2024-07-14 00:21:17', 167465.00, 0.00, 167465.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (100, 331, 2, 20396.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (100, 108, 1, 59975.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (100, 203, 1, 19390.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (100, 189, 2, 23654.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (101, 9531764, 2, '2024-12-24 14:49:17', 127533.00, 0.00, 127533.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (101, 347, 1, 26735.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (101, 104, 2, 18671.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (101, 115, 2, 31728.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (102, 7211294, 1, '2024-12-24 17:34:17', 380015.00, 0.00, 380015.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (102, 296, 2, 88799.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (102, 291, 2, 86516.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (102, 201, 1, 29385.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (103, 8579885, 3, '2024-05-26 13:15:17', 67942.00, 3397.10, 64544.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (103, 221, 1, 18116.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (103, 148, 1, 21876.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (103, 270, 1, 27950.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (104, 17061716, 2, '2024-09-09 18:57:17', 122342.00, 9175.65, 113166.35);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (104, 299, 2, 30523.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (104, 277, 2, 30648.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (105, 23193164, 1, '2023-07-21 22:48:17', 180585.00, 0.00, 180585.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (105, 265, 1, 20053.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (105, 326, 2, 18732.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (105, 266, 2, 61534.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (106, 8018862, 3, '2024-07-30 01:56:17', 40138.00, 2006.90, 38131.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (106, 334, 1, 40138.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (107, 21447525, 2, '2024-08-04 04:42:17', 67300.00, 3365.00, 63935.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (107, 331, 1, 20396.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (107, 271, 2, 23452.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (108, 20751429, 1, '2025-05-03 22:36:17', 115764.00, 11576.40, 104187.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (108, 222, 1, 32689.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (108, 204, 1, 10955.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (108, 188, 1, 40692.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (108, 315, 1, 31428.00);
INSERT INTO `venta_promocion` (`id_venta`, `id_promocion`) VALUES (108, 4);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (109, 21414711, 3, '2024-04-27 17:28:17', 119886.00, 5994.30, 113891.70);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (109, 183, 2, 17464.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (109, 137, 2, 19654.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (109, 233, 1, 45650.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (110, 8617298, 2, '2025-06-04 21:18:17', 61046.00, 4578.45, 56467.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (110, 299, 2, 30523.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (111, 19320108, 3, '2025-04-04 02:47:17', 41849.00, 3138.67, 38710.32);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (111, 170, 1, 41849.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (112, 13267445, 3, '2024-02-17 22:22:17', 104029.00, 5201.45, 98827.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (112, 106, 1, 17476.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (112, 349, 1, 48463.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (112, 126, 2, 19045.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (113, 13322803, 2, '2025-06-09 13:12:17', 80421.00, 0.00, 80421.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (113, 101, 1, 26643.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (113, 256, 2, 26889.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (114, 24051105, 3, '2024-01-15 04:53:17', 48677.00, 2433.85, 46243.15);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (114, 136, 1, 48677.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (115, 21390893, 1, '2023-11-26 06:37:17', 114831.00, 0.00, 114831.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (115, 123, 2, 20115.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (115, 216, 1, 28379.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (115, 221, 2, 18116.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (115, 274, 1, 9990.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (116, 10460397, 1, '2024-02-06 04:11:17', 120201.00, 0.00, 120201.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (116, 257, 1, 12206.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (116, 259, 2, 11292.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (116, 241, 2, 38123.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (116, 350, 1, 9165.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (117, 12238614, 3, '2023-12-06 10:00:17', 62874.00, 3143.70, 59730.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (117, 309, 2, 31437.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (118, 14674561, 3, '2024-01-08 19:38:17', 285189.00, 0.00, 285189.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (118, 214, 2, 36502.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (118, 282, 2, 33364.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (118, 138, 1, 28427.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (118, 302, 2, 58515.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (119, 19625626, 1, '2024-07-11 03:37:17', 150786.00, 11308.95, 139477.05);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (119, 125, 1, 35887.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (119, 262, 1, 43141.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (119, 329, 2, 35879.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (120, 23030762, 3, '2024-02-20 06:22:17', 59379.00, 2968.95, 56410.05);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (120, 242, 2, 16245.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (120, 256, 1, 26889.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (121, 13420977, 1, '2024-07-06 15:28:17', 61916.00, 4643.70, 57272.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (121, 122, 2, 30958.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (122, 23179235, 3, '2025-05-23 16:50:17', 37464.00, 2809.80, 34654.20);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (122, 326, 2, 18732.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (123, 20751429, 2, '2025-03-19 12:42:17', 251682.00, 0.00, 251682.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (123, 322, 2, 29702.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (123, 110, 2, 44674.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (123, 159, 2, 51465.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (124, 22303745, 1, '2024-01-25 08:34:17', 53778.00, 4033.35, 49744.65);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (124, 256, 2, 26889.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (125, 10014252, 1, '2025-03-04 11:06:17', 89914.00, 20230.65, 69683.35);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (125, 166, 2, 44957.00);
INSERT INTO `venta_promocion` (`id_venta`, `id_promocion`) VALUES (125, 2);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (126, 10085511, 2, '2023-11-15 02:40:17', 346300.00, 17315.00, 328985.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (126, 128, 1, 74854.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (126, 186, 2, 85287.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (126, 208, 2, 50436.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (127, 13263385, 2, '2023-08-15 14:41:17', 16374.00, 0.00, 16374.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (127, 304, 1, 16374.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (128, 23847683, 2, '2023-12-28 21:06:17', 44983.00, 0.00, 44983.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (128, 258, 1, 44983.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (129, 22342644, 2, '2023-07-10 07:32:17', 250975.00, 18823.12, 232151.88);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (129, 174, 2, 89824.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (129, 275, 1, 22247.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (129, 179, 2, 24540.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (130, 24347852, 2, '2023-08-15 17:40:17', 253716.00, 0.00, 253716.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (130, 185, 2, 30321.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (130, 197, 2, 46657.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (130, 177, 2, 38141.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (130, 154, 2, 11739.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (131, 24295525, 3, '2024-04-30 02:58:17', 319166.00, 15958.30, 303207.70);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (131, 142, 2, 87744.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (131, 204, 2, 10955.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (131, 338, 2, 32000.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (131, 124, 2, 28884.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (132, 9648629, 1, '2024-03-24 22:43:17', 65803.00, 0.00, 65803.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (132, 252, 2, 18715.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (132, 204, 1, 10955.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (132, 112, 1, 17418.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (133, 7207889, 2, '2023-11-29 15:02:17', 48619.00, 2430.95, 46188.05);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (133, 304, 2, 16374.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (133, 220, 1, 15871.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (134, 8637318, 3, '2023-11-21 04:58:17', 151795.00, 7589.75, 144205.25);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (134, 255, 1, 58866.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (134, 226, 1, 33525.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (134, 322, 2, 29702.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (135, 9648629, 1, '2024-08-25 04:53:17', 53694.00, 0.00, 53694.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (135, 254, 2, 26847.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (136, 9956770, 3, '2023-10-01 19:44:17', 120006.00, 6000.30, 114005.70);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (136, 124, 2, 28884.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (136, 200, 2, 31119.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (137, 17253917, 1, '2025-05-09 09:44:17', 95979.00, 0.00, 95979.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (137, 172, 1, 18557.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (137, 298, 1, 46343.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (137, 303, 1, 31079.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (138, 8007213, 3, '2023-08-08 00:20:17', 214680.00, 0.00, 214680.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (138, 249, 2, 44654.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (138, 270, 2, 27950.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (138, 324, 1, 41062.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (138, 113, 2, 14205.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (139, 12738829, 2, '2023-09-07 01:36:17', 132195.00, 0.00, 132195.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (139, 298, 2, 46343.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (139, 116, 1, 23264.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (139, 242, 1, 16245.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (140, 6687766, 2, '2024-04-27 07:48:17', 206688.00, 15501.60, 191186.40);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (140, 125, 2, 35887.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (140, 139, 2, 31924.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (140, 344, 2, 35533.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (141, 20705546, 1, '2024-05-28 01:23:17', 123857.00, 0.00, 123857.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (141, 106, 2, 17476.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (141, 317, 1, 58257.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (141, 277, 1, 30648.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (142, 16310535, 3, '2024-07-04 02:09:17', 221786.00, 11089.30, 210696.70);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (142, 114, 2, 27850.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (142, 189, 2, 23654.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (142, 184, 2, 43368.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (142, 152, 2, 16021.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (143, 9913599, 3, '2024-10-19 17:51:17', 220682.00, 11034.10, 209647.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (143, 144, 1, 91265.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (143, 275, 1, 22247.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (143, 185, 2, 30321.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (143, 116, 2, 23264.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (144, 7836337, 2, '2023-12-04 16:26:17', 55900.00, 4192.50, 51707.50);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (144, 270, 2, 27950.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (145, 21028464, 3, '2023-07-15 13:37:17', 85183.00, 0.00, 85183.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (145, 297, 1, 85183.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (146, 23789493, 1, '2023-08-05 11:26:17', 131944.00, 9895.80, 122048.20);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (146, 229, 1, 75604.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (146, 239, 2, 28170.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (147, 21734205, 2, '2024-03-19 06:42:17', 116352.00, 8726.40, 107625.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (147, 327, 2, 26975.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (147, 345, 2, 16350.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (147, 322, 1, 29702.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (148, 12685591, 1, '2024-08-26 14:09:17', 61226.00, 3061.30, 58164.70);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (148, 340, 2, 30613.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (149, 21028464, 3, '2023-11-08 06:51:17', 341666.00, 0.00, 341666.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (149, 235, 2, 87520.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (149, 284, 1, 18174.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (149, 199, 2, 31982.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (149, 333, 2, 42244.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (150, 8957021, 3, '2024-04-01 12:55:17', 328974.00, 24673.05, 304300.95);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (150, 151, 2, 33674.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (150, 214, 2, 36502.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (150, 108, 2, 59975.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (150, 212, 2, 34336.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (151, 23665385, 1, '2025-03-20 03:54:17', 102003.00, 0.00, 102003.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (151, 185, 2, 30321.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (151, 215, 1, 41361.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (152, 22955309, 1, '2023-09-19 02:35:17', 328849.00, 0.00, 328849.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (152, 226, 1, 33525.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (152, 307, 2, 91062.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (152, 296, 1, 88799.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (152, 161, 1, 24401.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (153, 12375332, 3, '2024-09-26 00:15:17', 78814.00, 5911.05, 72902.95);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (153, 303, 2, 31079.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (153, 236, 2, 8328.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (154, 21414711, 1, '2023-06-29 04:51:17', 450141.00, 22507.05, 427633.95);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (154, 105, 2, 46460.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (154, 307, 2, 91062.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (154, 166, 2, 44957.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (154, 297, 1, 85183.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (155, 11700745, 1, '2024-07-23 11:30:17', 97279.00, 0.00, 97279.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (155, 232, 1, 12767.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (155, 348, 1, 11172.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (155, 327, 2, 26975.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (155, 203, 1, 19390.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (156, 20525051, 1, '2024-10-11 10:33:17', 89054.00, 4452.70, 84601.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (156, 181, 2, 44527.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (157, 19196629, 1, '2024-05-14 00:32:17', 39255.00, 2944.12, 36310.88);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (157, 194, 1, 39255.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (158, 11409393, 2, '2024-04-23 13:28:17', 111200.00, 8340.00, 102860.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (158, 293, 1, 23456.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (158, 142, 1, 87744.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (159, 7211294, 2, '2024-08-22 19:24:17', 31079.00, 0.00, 31079.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (159, 303, 1, 31079.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (160, 12375332, 3, '2023-12-03 17:39:17', 129052.00, 9678.90, 119373.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (160, 158, 1, 45481.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (160, 126, 2, 19045.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (160, 158, 1, 45481.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (161, 20810316, 2, '2025-05-26 13:36:17', 180309.00, 0.00, 180309.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (161, 209, 1, 60785.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (161, 205, 2, 20890.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (161, 323, 1, 77744.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (162, 17504669, 2, '2024-06-06 10:17:17', 103920.00, 7794.00, 96126.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (162, 119, 2, 51960.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (163, 15171211, 2, '2025-02-02 20:00:17', 218692.00, 16401.90, 202290.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (163, 260, 2, 60400.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (163, 318, 2, 24128.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (163, 257, 1, 12206.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (163, 252, 2, 18715.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (164, 24190014, 3, '2023-10-05 18:22:17', 24325.00, 1216.25, 23108.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (164, 210, 1, 24325.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (165, 23113502, 3, '2024-01-16 06:13:17', 96252.00, 7218.90, 89033.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (165, 122, 2, 30958.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (165, 212, 1, 34336.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (166, 18428428, 1, '2023-07-21 10:39:17', 122709.00, 0.00, 122709.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (166, 153, 1, 34362.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (166, 178, 1, 27977.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (166, 268, 2, 30185.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (167, 23030762, 2, '2023-12-01 10:25:17', 49760.00, 2488.00, 47272.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (167, 164, 2, 16552.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (167, 236, 2, 8328.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (168, 19060316, 1, '2024-01-01 19:05:17', 92604.00, 6945.30, 85658.70);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (168, 165, 1, 33887.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (168, 220, 2, 15871.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (168, 327, 1, 26975.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (169, 17253917, 1, '2023-11-01 12:45:17', 74757.00, 0.00, 74757.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (169, 233, 1, 45650.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (169, 328, 1, 29107.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (170, 15850238, 3, '2024-03-18 11:02:17', 300239.00, 15011.95, 285227.05);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (170, 279, 2, 50201.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (170, 230, 2, 87306.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (170, 149, 1, 25225.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (171, 17466974, 1, '2024-04-23 01:04:17', 91089.00, 4554.45, 86534.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (171, 238, 1, 30148.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (171, 231, 2, 17373.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (171, 211, 1, 26195.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (172, 9722011, 2, '2023-11-23 13:43:17', 199624.00, 9981.20, 189642.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (172, 249, 1, 44654.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (172, 162, 2, 77485.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (173, 15641110, 3, '2023-07-09 14:07:17', 28180.00, 0.00, 28180.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (173, 218, 1, 28180.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (174, 9920287, 3, '2025-01-21 12:54:17', 35879.00, 0.00, 35879.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (174, 329, 1, 35879.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (175, 8388074, 3, '2024-08-01 11:46:17', 65773.00, 4932.97, 60840.03);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (175, 191, 1, 20558.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (175, 155, 1, 45215.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (176, 16443077, 3, '2023-12-29 16:01:17', 111793.00, 5589.65, 106203.35);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (176, 225, 2, 27198.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (176, 337, 1, 41152.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (176, 242, 1, 16245.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (177, 10548512, 1, '2025-01-17 19:27:17', 257119.00, 12855.95, 244263.05);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (177, 179, 2, 24540.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (177, 287, 2, 44796.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (177, 168, 2, 29966.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (177, 302, 1, 58515.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (178, 24858164, 2, '2023-12-20 13:47:17', 43429.00, 3257.17, 40171.82);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (178, 237, 2, 8480.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (178, 259, 1, 11292.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (178, 182, 1, 15177.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (179, 18374137, 1, '2024-06-19 22:05:17', 148761.00, 0.00, 148761.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (179, 261, 1, 26515.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (179, 137, 2, 19654.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (179, 103, 2, 41469.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (180, 18512791, 2, '2024-03-04 17:36:17', 60468.00, 0.00, 60468.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (180, 109, 2, 18407.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (180, 189, 1, 23654.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (181, 7697637, 1, '2024-06-20 19:16:17', 127265.00, 9544.88, 117720.12);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (181, 271, 2, 23452.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (181, 318, 1, 24128.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (181, 240, 1, 26085.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (181, 238, 1, 30148.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (182, 21707055, 1, '2025-02-07 10:24:17', 236316.00, 0.00, 236316.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (182, 180, 1, 25631.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (182, 333, 2, 42244.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (182, 223, 1, 43259.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (182, 103, 2, 41469.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (183, 8552376, 1, '2023-09-16 01:08:17', 313641.00, 23523.08, 290117.92);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (183, 200, 1, 31119.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (183, 235, 2, 87520.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (183, 124, 2, 28884.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (183, 145, 2, 24857.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (184, 20626204, 1, '2023-09-25 04:17:17', 175040.00, 0.00, 175040.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (184, 235, 2, 87520.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (185, 21910197, 1, '2024-06-26 19:30:17', 30321.00, 0.00, 30321.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (185, 185, 1, 30321.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (186, 9956770, 3, '2024-06-19 15:52:17', 172602.00, 8630.10, 163971.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (186, 243, 2, 30337.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (186, 122, 1, 30958.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (186, 200, 2, 31119.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (186, 343, 1, 18732.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (187, 21659881, 1, '2025-06-09 01:59:17', 41013.00, 3075.97, 37937.03);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (187, 314, 1, 41013.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (188, 18642731, 2, '2024-06-05 05:16:17', 183325.00, 9166.25, 174158.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (188, 202, 1, 36323.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (188, 272, 2, 29848.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (188, 230, 1, 87306.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (189, 16784983, 1, '2024-09-22 13:22:17', 210731.00, 15804.82, 194926.17);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (189, 281, 1, 47913.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (189, 115, 2, 31728.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (189, 241, 2, 38123.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (189, 192, 1, 23116.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (190, 9022667, 1, '2023-06-27 11:30:17', 130463.00, 9784.73, 120678.27);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (190, 136, 1, 48677.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (190, 336, 2, 40893.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (191, 7593686, 2, '2024-10-02 17:23:17', 113180.00, 5659.00, 107521.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (191, 254, 1, 26847.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (191, 157, 1, 40475.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (191, 217, 1, 45858.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (192, 17921382, 2, '2024-10-02 02:45:17', 82920.00, 4146.00, 78774.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (192, 242, 1, 16245.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (192, 332, 1, 47118.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (192, 132, 1, 19557.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (193, 22303745, 2, '2024-11-17 04:09:17', 53466.00, 4009.95, 49456.05);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (193, 295, 2, 26733.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (194, 11085075, 2, '2024-07-02 01:51:17', 87715.00, 6578.62, 81136.38);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (194, 191, 1, 20558.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (194, 169, 1, 25280.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (194, 161, 1, 24401.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (194, 106, 1, 17476.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (195, 18428428, 2, '2025-06-01 19:48:17', 131404.00, 0.00, 131404.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (195, 292, 2, 23296.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (195, 289, 1, 14736.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (195, 300, 2, 35038.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (196, 14516687, 1, '2024-06-20 01:22:17', 88213.00, 4410.65, 83802.35);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (196, 311, 1, 88213.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (197, 8637318, 1, '2024-02-02 08:04:17', 136569.00, 6828.45, 129740.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (197, 279, 1, 50201.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (197, 301, 1, 26964.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (197, 322, 2, 29702.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (198, 22000652, 1, '2024-08-25 16:53:17', 190879.00, 14315.92, 176563.08);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (198, 337, 1, 41152.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (198, 130, 1, 17633.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (198, 212, 1, 34336.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (198, 176, 2, 48879.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (199, 17178489, 1, '2024-03-12 17:12:17', 107328.00, 5366.40, 101961.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (199, 240, 1, 26085.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (199, 123, 2, 20115.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (199, 314, 1, 41013.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (200, 18050900, 1, '2024-04-13 19:35:17', 256361.00, 0.00, 256361.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (200, 108, 2, 59975.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (200, 200, 2, 31119.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (200, 321, 2, 24474.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (200, 149, 1, 25225.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (201, 22955309, 1, '2025-04-03 21:30:17', 110615.00, 0.00, 110615.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (201, 222, 1, 32689.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (201, 184, 1, 43368.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (201, 269, 2, 17279.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (202, 21729717, 1, '2023-11-20 09:05:17', 154128.00, 7706.40, 146421.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (202, 127, 2, 77064.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (203, 18033097, 3, '2024-03-06 00:49:17', 158351.00, 11876.32, 146474.67);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (203, 178, 2, 27977.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (203, 134, 1, 48001.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (203, 225, 2, 27198.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (204, 11262279, 1, '2023-09-10 05:19:17', 214457.00, 10722.85, 203734.15);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (204, 272, 2, 29848.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (204, 201, 2, 29385.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (204, 222, 2, 32689.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (204, 340, 1, 30613.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (205, 13374462, 1, '2023-07-09 08:08:17', 209262.00, 15694.65, 193567.35);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (205, 129, 2, 21333.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (205, 196, 2, 34419.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (205, 176, 2, 48879.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (206, 7436279, 1, '2025-04-22 16:03:17', 68118.00, 0.00, 68118.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (206, 280, 2, 34059.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (207, 12880526, 3, '2024-02-27 07:33:17', 148096.00, 11107.20, 136988.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (207, 232, 1, 12767.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (207, 236, 1, 8328.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (207, 336, 2, 40893.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (207, 155, 1, 45215.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (208, 19542269, 3, '2024-12-13 18:30:17', 274273.00, 13713.65, 260559.35);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (208, 131, 2, 88206.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (208, 247, 1, 21615.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (208, 241, 2, 38123.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (209, 8646844, 3, '2024-05-04 22:43:17', 125954.00, 6297.70, 119656.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (209, 234, 2, 31300.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (209, 301, 2, 26964.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (209, 207, 1, 9426.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (210, 9913599, 2, '2025-03-18 13:26:17', 56952.00, 2847.60, 54104.40);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (210, 198, 2, 28476.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (211, 22013160, 3, '2024-07-16 23:55:17', 66338.00, 4975.35, 61362.65);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (211, 241, 1, 38123.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (211, 140, 1, 11841.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (211, 304, 1, 16374.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (212, 7621560, 2, '2023-11-20 18:00:17', 375910.00, 0.00, 375910.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (212, 175, 2, 84250.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (212, 119, 2, 51960.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (212, 133, 2, 46750.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (212, 274, 1, 9990.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (213, 21373004, 1, '2023-09-05 22:08:17', 183155.00, 9157.75, 173997.25);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (213, 254, 2, 26847.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (213, 182, 1, 15177.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (213, 139, 2, 31924.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (213, 208, 1, 50436.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (214, 22000652, 1, '2025-05-05 22:43:17', 36232.00, 2717.40, 33514.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (214, 221, 2, 18116.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (215, 10832765, 2, '2025-03-05 07:17:17', 40374.00, 0.00, 40374.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (215, 264, 1, 21642.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (215, 326, 1, 18732.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (216, 12788725, 3, '2024-11-06 19:34:17', 60386.00, 4528.95, 55857.05);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (216, 233, 1, 45650.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (216, 289, 1, 14736.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (217, 22199482, 2, '2024-11-23 04:29:17', 202586.00, 10129.30, 192456.70);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (217, 153, 1, 34362.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (217, 108, 2, 59975.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (217, 139, 1, 31924.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (217, 345, 1, 16350.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (218, 18284684, 1, '2023-08-16 13:44:17', 123068.00, 0.00, 123068.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (218, 266, 2, 61534.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (219, 12238614, 1, '2023-10-24 19:48:17', 75604.00, 3780.20, 71823.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (219, 229, 1, 75604.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (220, 21734205, 1, '2024-06-14 03:19:17', 47031.00, 3527.32, 43503.68);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (220, 253, 1, 47031.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (221, 22245529, 2, '2023-08-30 15:46:17', 182941.00, 0.00, 182941.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (221, 297, 1, 85183.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (221, 176, 2, 48879.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (222, 11781807, 2, '2024-10-07 00:19:17', 37114.00, 2783.55, 34330.45);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (222, 172, 2, 18557.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (223, 11409393, 3, '2024-11-10 21:57:17', 44796.00, 3359.70, 41436.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (223, 287, 1, 44796.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (224, 7343339, 3, '2023-08-25 07:55:17', 19557.00, 0.00, 19557.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (224, 132, 1, 19557.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (225, 13263385, 1, '2025-04-26 23:17:17', 118332.00, 0.00, 118332.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (225, 300, 2, 35038.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (225, 318, 2, 24128.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (226, 23563272, 1, '2025-04-01 14:24:17', 23116.00, 1733.70, 21382.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (226, 192, 1, 23116.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (227, 20568715, 1, '2024-04-22 00:10:17', 120914.00, 9068.55, 111845.45);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (227, 200, 1, 31119.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (227, 267, 1, 18030.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (227, 221, 2, 18116.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (227, 344, 1, 35533.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (228, 8957021, 3, '2024-05-30 15:19:17', 153610.00, 11520.75, 142089.25);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (228, 238, 2, 30148.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (228, 197, 2, 46657.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (229, 6876845, 3, '2024-02-04 15:57:17', 96624.00, 4831.20, 91792.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (229, 201, 1, 29385.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (229, 326, 2, 18732.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (229, 120, 1, 13401.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (229, 304, 1, 16374.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (230, 15850238, 3, '2024-10-17 18:19:17', 115447.00, 5772.35, 109674.65);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (230, 266, 1, 61534.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (230, 216, 1, 28379.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (230, 232, 2, 12767.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (231, 11560538, 2, '2025-05-24 19:06:17', 157242.00, 11793.15, 145448.85);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (231, 317, 2, 58257.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (231, 220, 1, 15871.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (231, 145, 1, 24857.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (232, 18511322, 2, '2024-06-22 08:57:17', 196166.00, 14712.45, 181453.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (232, 186, 1, 85287.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (232, 210, 1, 24325.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (232, 193, 1, 30854.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (232, 114, 2, 27850.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (233, 21373004, 2, '2024-07-27 17:18:17', 150366.00, 7518.30, 142847.70);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (233, 223, 2, 43259.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (233, 139, 2, 31924.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (234, 15145931, 1, '2025-01-27 08:58:17', 43259.00, 3244.42, 40014.57);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (234, 223, 1, 43259.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (235, 10889399, 2, '2024-06-20 05:49:17', 72824.00, 3641.20, 69182.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (235, 249, 1, 44654.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (235, 239, 1, 28170.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (236, 8388074, 2, '2024-08-18 03:11:17', 188118.00, 14108.85, 174009.15);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (236, 116, 1, 23264.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (236, 266, 1, 61534.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (236, 251, 1, 34648.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (236, 212, 2, 34336.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (237, 24051105, 2, '2025-05-05 20:55:17', 140748.00, 7037.40, 133710.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (237, 231, 1, 17373.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (237, 204, 2, 10955.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (237, 161, 1, 24401.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (237, 127, 1, 77064.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (238, 10085511, 3, '2025-03-02 00:41:17', 143295.00, 7164.75, 136130.25);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (238, 224, 2, 19958.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (238, 293, 1, 23456.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (238, 306, 2, 25973.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (238, 178, 1, 27977.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (239, 7563573, 1, '2023-12-29 06:35:17', 72131.00, 5409.82, 66721.18);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (239, 189, 1, 23654.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (239, 331, 1, 20396.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (239, 109, 1, 18407.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (239, 173, 1, 9674.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (240, 7211294, 1, '2023-08-20 22:50:17', 50201.00, 0.00, 50201.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (240, 279, 1, 50201.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (241, 11700745, 2, '2025-02-23 19:27:17', 168535.00, 0.00, 168535.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (241, 294, 1, 85997.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (241, 137, 2, 19654.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (241, 247, 2, 21615.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (242, 15763604, 1, '2025-02-02 13:38:17', 135769.00, 0.00, 135769.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (242, 230, 1, 87306.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (242, 349, 1, 48463.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (243, 11601922, 2, '2023-09-27 20:54:17', 283883.00, 0.00, 283883.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (243, 215, 1, 41361.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (243, 131, 2, 88206.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (243, 290, 2, 33055.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (244, 13374462, 1, '2024-03-12 20:15:17', 28379.00, 2128.42, 26250.58);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (244, 216, 1, 28379.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (245, 12659869, 2, '2025-04-20 20:50:17', 73300.00, 3665.00, 69635.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (245, 306, 2, 25973.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (245, 160, 2, 10677.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (246, 13410269, 1, '2025-01-31 07:45:17', 44527.00, 2226.35, 42300.65);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (246, 181, 1, 44527.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (247, 13436345, 3, '2024-11-28 17:22:17', 105590.00, 7919.25, 97670.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (247, 183, 1, 17464.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (247, 338, 2, 32000.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (247, 276, 1, 24126.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (248, 13263385, 3, '2023-10-04 06:04:17', 180354.00, 0.00, 180354.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (248, 169, 1, 25280.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (248, 261, 2, 26515.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (248, 304, 2, 16374.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (248, 251, 2, 34648.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (249, 13374462, 3, '2025-03-05 09:41:17', 214851.00, 48341.47, 166509.52);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (249, 203, 2, 19390.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (249, 316, 1, 21101.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (249, 162, 2, 77485.00);
INSERT INTO `venta_promocion` (`id_venta`, `id_promocion`) VALUES (249, 2);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (250, 20810316, 2, '2024-09-09 22:04:17', 44380.00, 0.00, 44380.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (250, 187, 1, 44380.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (251, 22303745, 3, '2023-06-17 16:39:17', 17279.00, 1295.92, 15983.08);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (251, 269, 1, 17279.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (252, 22342644, 2, '2025-03-03 07:53:17', 89308.00, 6698.10, 82609.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (252, 249, 2, 44654.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (253, 16292755, 2, '2024-04-30 21:13:17', 99660.00, 7474.50, 92185.50);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (253, 327, 2, 26975.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (253, 107, 2, 22855.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (254, 7740672, 1, '2023-12-26 21:55:17', 119234.00, 5961.70, 113272.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (254, 231, 2, 17373.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (254, 333, 2, 42244.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (255, 21881714, 3, '2024-04-13 23:01:17', 154128.00, 0.00, 154128.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (255, 127, 2, 77064.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (256, 24897578, 2, '2024-01-11 17:55:17', 250397.00, 18779.77, 231617.23);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (256, 230, 1, 87306.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (256, 262, 1, 43141.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (256, 108, 2, 59975.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (257, 12787081, 3, '2023-07-10 11:19:17', 57998.00, 0.00, 57998.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (257, 308, 1, 17206.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (257, 331, 2, 20396.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (258, 9977295, 3, '2023-10-24 22:54:17', 61614.00, 0.00, 61614.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (258, 143, 2, 30807.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (259, 16443077, 3, '2024-04-09 18:26:17', 93315.00, 4665.75, 88649.25);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (259, 336, 1, 40893.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (259, 171, 2, 26211.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (260, 16812183, 1, '2024-04-14 02:24:17', 104115.00, 7808.62, 96306.38);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (260, 317, 1, 58257.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (260, 217, 1, 45858.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (261, 21711459, 2, '2024-06-04 03:39:17', 110782.00, 5539.10, 105242.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (261, 138, 2, 28427.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (261, 301, 2, 26964.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (262, 22582437, 1, '2025-05-09 00:55:17', 53466.00, 9356.55, 44109.45);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (262, 295, 2, 26733.00);
INSERT INTO `venta_promocion` (`id_venta`, `id_promocion`) VALUES (262, 4);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (263, 9869514, 1, '2024-07-13 14:01:17', 101127.00, 7584.52, 93542.48);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (263, 103, 1, 41469.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (263, 304, 1, 16374.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (263, 264, 2, 21642.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (264, 10513342, 1, '2024-07-04 08:08:17', 288241.00, 0.00, 288241.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (264, 280, 2, 34059.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (264, 174, 2, 89824.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (264, 157, 1, 40475.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (265, 17485236, 3, '2024-04-11 21:38:17', 78907.00, 5918.02, 72988.98);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (265, 278, 2, 18947.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (265, 314, 1, 41013.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (266, 23629755, 1, '2023-07-21 16:52:17', 34624.00, 2596.80, 32027.20);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (266, 163, 1, 34624.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (267, 8233353, 1, '2023-06-13 15:54:17', 122041.00, 0.00, 122041.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (267, 203, 1, 19390.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (267, 228, 1, 35303.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (267, 151, 2, 33674.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (268, 7226654, 3, '2024-10-06 05:03:17', 48252.00, 0.00, 48252.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (268, 276, 2, 24126.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (269, 16443077, 3, '2024-03-04 07:49:17', 119133.00, 5956.65, 113176.35);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (269, 145, 2, 24857.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (269, 270, 1, 27950.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (269, 103, 1, 41469.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (270, 6837883, 1, '2025-03-08 08:57:17', 51465.00, 2573.25, 48891.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (270, 159, 1, 51465.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (271, 8617298, 2, '2025-02-26 12:28:17', 71596.00, 5369.70, 66226.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (271, 203, 1, 19390.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (271, 206, 2, 16882.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (271, 245, 1, 18442.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (272, 13034997, 3, '2025-01-17 17:22:17', 268557.00, 20141.77, 248415.23);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (272, 192, 1, 23116.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (272, 154, 1, 11739.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (272, 328, 2, 29107.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (272, 142, 2, 87744.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (273, 23735746, 1, '2024-02-28 18:54:17', 229433.00, 11471.65, 217961.35);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (273, 160, 2, 10677.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (273, 137, 1, 19654.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (273, 177, 1, 38141.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (273, 246, 2, 75142.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (274, 6698025, 3, '2024-07-29 01:56:17', 217223.00, 0.00, 217223.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (274, 103, 1, 41469.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (274, 127, 1, 77064.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (274, 340, 2, 30613.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (274, 343, 2, 18732.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (275, 7836337, 3, '2023-08-18 16:43:17', 156812.00, 11760.90, 145051.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (275, 133, 2, 46750.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (275, 198, 1, 28476.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (275, 112, 2, 17418.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (276, 6764853, 1, '2023-11-02 05:46:17', 239900.00, 11995.00, 227905.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (276, 337, 1, 41152.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (276, 150, 1, 88116.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (276, 264, 2, 21642.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (276, 151, 2, 33674.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (277, 23179235, 1, '2024-02-20 20:19:17', 103295.00, 7747.12, 95547.88);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (277, 261, 2, 26515.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (277, 267, 2, 18030.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (277, 113, 1, 14205.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (278, 8756179, 2, '2024-05-05 21:12:17', 104144.00, 7810.80, 96333.20);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (278, 149, 2, 25225.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (278, 254, 2, 26847.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (279, 10901799, 3, '2023-10-12 17:14:17', 36348.00, 1817.40, 34530.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (279, 284, 2, 18174.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (280, 22013160, 3, '2023-11-29 13:56:17', 63848.00, 4788.60, 59059.40);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (280, 139, 2, 31924.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (281, 22199482, 2, '2023-07-06 01:31:17', 119191.00, 5959.55, 113231.45);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (281, 317, 1, 58257.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (281, 261, 1, 26515.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (281, 196, 1, 34419.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (282, 23290657, 3, '2024-06-16 22:15:17', 218713.00, 0.00, 218713.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (282, 329, 1, 35879.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (282, 166, 2, 44957.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (282, 105, 2, 46460.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (283, 13791434, 3, '2023-10-11 11:16:17', 61916.00, 0.00, 61916.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (283, 122, 2, 30958.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (284, 9913697, 1, '2024-12-22 13:00:17', 73661.00, 5524.57, 68136.43);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (284, 237, 2, 8480.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (284, 347, 1, 26735.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (284, 168, 1, 29966.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (285, 8756179, 2, '2024-10-18 21:00:17', 162256.00, 12169.20, 150086.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (285, 204, 2, 10955.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (285, 204, 2, 10955.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (285, 188, 1, 40692.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (285, 323, 1, 77744.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (286, 13374462, 1, '2023-07-26 02:09:17', 182124.00, 13659.30, 168464.70);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (286, 307, 2, 91062.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (287, 17253517, 1, '2023-10-11 02:47:17', 136372.00, 10227.90, 126144.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (287, 318, 2, 24128.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (287, 150, 1, 88116.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (288, 13410269, 2, '2023-09-18 16:23:17', 142835.00, 7141.75, 135693.25);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (288, 302, 1, 58515.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (288, 273, 1, 84320.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (289, 22955309, 3, '2024-10-08 09:18:17', 201576.00, 0.00, 201576.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (289, 230, 2, 87306.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (289, 301, 1, 26964.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (290, 8233353, 3, '2024-05-08 22:43:17', 38515.00, 0.00, 38515.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (290, 172, 1, 18557.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (290, 224, 1, 19958.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (291, 7994240, 3, '2024-11-24 09:15:17', 153403.00, 0.00, 153403.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (291, 227, 2, 32319.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (291, 314, 1, 41013.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (291, 286, 1, 47752.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (292, 13034997, 1, '2023-12-19 03:59:17', 46592.00, 3494.40, 43097.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (292, 292, 2, 23296.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (293, 17485236, 2, '2024-12-13 01:00:17', 33887.00, 2541.53, 31345.47);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (293, 165, 1, 33887.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (294, 20420241, 1, '2024-02-20 05:18:17', 78671.00, 0.00, 78671.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (294, 184, 1, 43368.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (294, 228, 1, 35303.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (295, 21028464, 1, '2023-09-23 12:38:17', 212240.00, 0.00, 212240.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (295, 299, 1, 30523.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (295, 254, 1, 26847.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (295, 187, 2, 44380.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (295, 290, 2, 33055.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (296, 6698025, 2, '2025-04-24 18:50:17', 63632.00, 0.00, 63632.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (296, 133, 1, 46750.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (296, 206, 1, 16882.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (297, 22638793, 3, '2023-07-31 17:31:17', 269784.00, 13489.20, 256294.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (297, 315, 1, 31428.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (297, 349, 2, 48463.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (297, 314, 2, 41013.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (297, 322, 2, 29702.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (298, 21733432, 3, '2023-10-26 19:14:17', 77214.00, 5791.05, 71422.95);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (298, 327, 2, 26975.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (298, 116, 1, 23264.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (299, 22841837, 1, '2023-12-05 22:09:17', 143840.00, 7192.00, 136648.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (299, 141, 2, 23041.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (299, 176, 2, 48879.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (300, 23472616, 2, '2023-09-21 02:33:17', 140445.00, 0.00, 140445.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (300, 249, 2, 44654.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (300, 206, 2, 16882.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (300, 231, 1, 17373.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (301, 21025574, 2, '2025-05-21 22:20:17', 206352.00, 0.00, 206352.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (301, 310, 2, 36109.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (301, 122, 2, 30958.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (301, 310, 2, 36109.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (302, 14665691, 3, '2025-01-19 23:39:17', 22855.00, 1714.12, 21140.88);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (302, 107, 1, 22855.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (303, 24147267, 1, '2024-10-18 17:19:17', 62786.00, 0.00, 62786.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (303, 200, 1, 31119.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (303, 135, 1, 31667.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (304, 15391921, 1, '2023-06-19 20:30:17', 87130.00, 0.00, 87130.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (304, 250, 2, 19911.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (304, 189, 2, 23654.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (305, 15763604, 2, '2024-05-22 05:18:17', 141355.00, 0.00, 141355.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (305, 302, 2, 58515.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (305, 210, 1, 24325.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (306, 24730195, 3, '2025-04-09 09:22:17', 255069.00, 19130.17, 235938.83);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (306, 129, 1, 21333.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (306, 184, 2, 43368.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (306, 233, 2, 45650.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (306, 114, 2, 27850.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (307, 20420241, 2, '2024-10-06 22:03:17', 27977.00, 0.00, 27977.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (307, 178, 1, 27977.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (308, 15069824, 2, '2024-12-18 21:43:17', 160620.00, 0.00, 160620.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (308, 327, 1, 26975.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (308, 211, 2, 26195.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (308, 138, 2, 28427.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (308, 161, 1, 24401.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (309, 10368721, 2, '2023-11-02 19:19:17', 204969.00, 15372.67, 189596.33);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (309, 199, 1, 31982.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (309, 321, 2, 24474.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (309, 200, 1, 31119.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (309, 105, 2, 46460.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (310, 8903100, 3, '2024-05-13 03:22:17', 80054.00, 6004.05, 74049.95);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (310, 224, 2, 19958.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (310, 334, 1, 40138.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (311, 13678228, 1, '2024-08-16 07:32:17', 200190.00, 15014.25, 185175.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (311, 185, 2, 30321.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (311, 261, 2, 26515.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (311, 223, 2, 43259.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (312, 12375332, 2, '2023-08-16 03:01:17', 28410.00, 2130.75, 26279.25);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (312, 113, 2, 14205.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (313, 10014252, 3, '2025-03-30 10:03:17', 110013.00, 8250.98, 101762.02);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (313, 269, 1, 17279.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (313, 276, 1, 24126.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (313, 279, 1, 50201.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (313, 109, 1, 18407.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (314, 16801685, 1, '2025-04-28 12:55:17', 46904.00, 2345.20, 44558.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (314, 271, 2, 23452.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (315, 7211294, 1, '2023-12-18 00:01:17', 100402.00, 0.00, 100402.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (315, 279, 2, 50201.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (316, 23665385, 3, '2023-10-16 01:14:17', 203379.00, 0.00, 203379.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (316, 124, 2, 28884.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (316, 216, 2, 28379.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (316, 132, 1, 19557.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (316, 251, 2, 34648.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (317, 13420977, 2, '2023-08-04 03:49:17', 233445.00, 17508.38, 215936.62);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (317, 140, 1, 11841.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (317, 278, 2, 18947.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (317, 286, 2, 47752.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (317, 131, 1, 88206.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (318, 9977295, 1, '2024-12-23 00:37:17', 48463.00, 0.00, 48463.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (318, 349, 1, 48463.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (319, 15641110, 2, '2025-03-08 14:36:17', 21101.00, 0.00, 21101.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (319, 316, 1, 21101.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (320, 17830951, 2, '2023-08-17 09:48:17', 89348.00, 4467.40, 84880.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (320, 110, 2, 44674.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (321, 10582811, 3, '2025-02-02 05:26:17', 75229.00, 0.00, 75229.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (321, 290, 1, 33055.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (321, 207, 1, 9426.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (321, 304, 2, 16374.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (322, 13791434, 3, '2024-10-05 15:27:17', 41062.00, 0.00, 41062.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (322, 324, 1, 41062.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (323, 17915469, 3, '2023-06-24 13:51:17', 56610.00, 2830.50, 53779.50);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (323, 342, 2, 28305.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (324, 7599108, 3, '2023-08-17 05:42:17', 150522.00, 11289.15, 139232.85);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (324, 290, 2, 33055.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (324, 115, 2, 31728.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (324, 330, 1, 20956.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (325, 14280017, 1, '2023-11-05 22:10:17', 124233.00, 6211.65, 118021.35);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (325, 113, 2, 14205.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (325, 206, 1, 16882.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (325, 141, 1, 23041.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (325, 270, 2, 27950.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (326, 21659881, 2, '2024-10-06 05:54:17', 139057.00, 10429.27, 128627.73);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (326, 341, 1, 19831.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (326, 248, 2, 36758.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (326, 107, 2, 22855.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (327, 13436345, 1, '2024-10-31 19:53:17', 89662.00, 6724.65, 82937.35);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (327, 168, 1, 29966.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (327, 272, 2, 29848.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (328, 21028464, 2, '2024-02-21 17:02:17', 222972.00, 0.00, 222972.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (328, 257, 2, 12206.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (328, 326, 1, 18732.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (328, 166, 2, 44957.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (328, 166, 2, 44957.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (329, 10582811, 2, '2025-04-24 06:25:17', 89592.00, 0.00, 89592.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (329, 287, 2, 44796.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (330, 15391921, 2, '2024-11-20 19:01:17', 116681.00, 0.00, 116681.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (330, 267, 2, 18030.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (330, 165, 2, 33887.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (330, 320, 1, 12847.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (331, 15069824, 3, '2024-01-15 16:42:17', 46343.00, 0.00, 46343.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (331, 298, 1, 46343.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (332, 20810316, 1, '2025-02-23 02:10:17', 105005.00, 0.00, 105005.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (332, 187, 2, 44380.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (332, 242, 1, 16245.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (333, 15641110, 1, '2023-11-17 14:21:17', 42604.00, 0.00, 42604.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (333, 220, 1, 15871.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (333, 295, 1, 26733.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (334, 20494398, 1, '2023-07-31 19:31:17', 46904.00, 0.00, 46904.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (334, 271, 2, 23452.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (335, 7599108, 1, '2024-02-17 11:16:17', 89824.00, 6736.80, 83087.20);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (335, 174, 1, 89824.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (336, 8903100, 3, '2024-04-11 03:36:17', 139999.00, 10499.92, 129499.07);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (336, 274, 1, 9990.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (336, 102, 1, 43996.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (336, 254, 2, 26847.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (336, 227, 1, 32319.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (337, 16801685, 1, '2023-10-11 19:04:17', 29244.00, 1462.20, 27781.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (337, 195, 1, 29244.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (338, 12880526, 1, '2023-09-06 12:59:17', 69017.00, 5176.27, 63840.72);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (338, 136, 1, 48677.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (338, 346, 2, 10170.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (339, 12738829, 1, '2024-08-29 04:36:17', 174800.00, 0.00, 174800.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (339, 151, 2, 33674.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (339, 203, 2, 19390.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (339, 212, 2, 34336.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (340, 20525051, 2, '2025-05-31 11:36:17', 14736.00, 736.80, 13999.20);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (340, 289, 1, 14736.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (341, 18825990, 1, '2024-06-28 19:34:17', 284674.00, 14233.70, 270440.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (341, 346, 2, 10170.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (341, 296, 2, 88799.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (341, 184, 2, 43368.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (342, 17570964, 3, '2025-01-11 19:20:17', 149708.00, 11228.10, 138479.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (342, 128, 2, 74854.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (343, 24897578, 1, '2024-06-11 06:55:17', 32542.00, 2440.65, 30101.35);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (343, 207, 1, 9426.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (343, 192, 1, 23116.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (344, 13791434, 1, '2024-01-13 14:17:17', 89966.00, 0.00, 89966.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (344, 258, 2, 44983.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (345, 8233353, 3, '2024-06-02 07:41:17', 87744.00, 0.00, 87744.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (345, 142, 1, 87744.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (346, 24897578, 3, '2025-06-01 06:14:17', 96288.00, 7221.60, 89066.40);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (346, 280, 2, 34059.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (346, 239, 1, 28170.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (347, 12787081, 2, '2023-10-27 16:59:17', 117495.00, 0.00, 117495.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (347, 211, 1, 26195.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (347, 233, 2, 45650.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (348, 12659869, 3, '2024-08-13 11:48:17', 135877.00, 6793.85, 129083.15);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (348, 131, 1, 88206.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (348, 164, 1, 16552.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (348, 200, 1, 31119.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (349, 17231954, 3, '2025-03-17 19:05:17', 68540.00, 3427.00, 65113.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (349, 274, 2, 9990.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (349, 222, 1, 32689.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (349, 220, 1, 15871.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (350, 16784983, 3, '2024-12-28 11:54:17', 67685.00, 5076.38, 62608.62);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (350, 161, 1, 24401.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (350, 264, 2, 21642.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (351, 10548512, 2, '2025-02-12 12:29:17', 144042.00, 7202.10, 136839.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (351, 205, 1, 20890.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (351, 187, 1, 44380.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (351, 106, 1, 17476.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (351, 277, 2, 30648.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (352, 19663067, 3, '2025-02-06 10:09:17', 115402.00, 5770.10, 109631.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (352, 287, 1, 44796.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (352, 228, 2, 35303.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (353, 9598276, 2, '2025-05-31 04:52:17', 192045.00, 9602.25, 182442.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (353, 207, 2, 9426.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (353, 263, 2, 41678.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (353, 163, 2, 34624.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (353, 305, 1, 20589.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (354, 21243581, 1, '2024-11-04 05:30:17', 58866.00, 4414.95, 54451.05);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (354, 255, 1, 58866.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (355, 9977295, 1, '2024-08-20 12:20:17', 110190.00, 0.00, 110190.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (355, 124, 2, 28884.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (355, 171, 2, 26211.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (356, 10832765, 1, '2023-08-13 21:51:17', 108380.00, 0.00, 108380.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (356, 219, 1, 36622.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (356, 329, 2, 35879.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (357, 16097227, 1, '2024-07-25 00:18:17', 16882.00, 1266.15, 15615.85);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (357, 206, 1, 16882.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (358, 19542811, 1, '2024-08-24 12:55:17', 147465.00, 11059.88, 136405.12);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (358, 334, 1, 40138.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (358, 238, 2, 30148.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (358, 253, 1, 47031.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (359, 10198725, 1, '2024-02-10 06:20:17', 171468.00, 8573.40, 162894.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (359, 199, 2, 31982.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (359, 203, 2, 19390.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (359, 153, 2, 34362.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (360, 21390893, 2, '2023-12-12 10:48:17', 144686.00, 0.00, 144686.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (360, 209, 2, 60785.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (360, 192, 1, 23116.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (361, 11492221, 2, '2025-01-04 08:36:17', 82870.00, 4143.50, 78726.50);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (361, 348, 2, 11172.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (361, 305, 2, 20589.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (361, 173, 2, 9674.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (362, 17485236, 1, '2025-04-10 12:27:17', 151763.00, 11382.23, 140380.77);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (362, 191, 2, 20558.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (362, 317, 1, 58257.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (362, 211, 2, 26195.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (363, 12356780, 1, '2023-11-21 01:16:17', 116951.00, 5847.55, 111103.45);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (363, 337, 1, 41152.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (363, 165, 1, 33887.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (363, 330, 2, 20956.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (364, 8957021, 1, '2023-09-05 09:36:17', 81786.00, 6133.95, 75652.05);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (364, 336, 2, 40893.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (365, 9722011, 1, '2023-11-16 09:42:17', 78510.00, 3925.50, 74584.50);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (365, 194, 2, 39255.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (366, 21734205, 2, '2024-09-25 17:18:17', 68724.00, 5154.30, 63569.70);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (366, 153, 2, 34362.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (367, 13678228, 3, '2024-03-13 00:04:17', 96332.00, 7224.90, 89107.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (367, 148, 2, 21876.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (367, 335, 1, 35620.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (367, 237, 2, 8480.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (368, 10582811, 2, '2024-06-05 14:34:17', 146177.00, 0.00, 146177.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (368, 125, 1, 35887.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (368, 169, 1, 25280.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (368, 247, 2, 21615.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (368, 205, 2, 20890.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (369, 21707055, 2, '2023-10-20 08:33:17', 66962.00, 0.00, 66962.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (369, 300, 1, 35038.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (369, 139, 1, 31924.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (370, 10832765, 1, '2024-05-03 18:10:17', 167252.00, 0.00, 167252.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (370, 342, 2, 28305.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (370, 300, 1, 35038.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (370, 229, 1, 75604.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (371, 8239007, 3, '2024-05-03 07:03:17', 106462.00, 7984.65, 98477.35);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (371, 109, 1, 18407.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (371, 121, 1, 34249.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (371, 288, 2, 26903.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (372, 9913697, 3, '2024-12-31 04:33:17', 104836.00, 7862.70, 96973.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (372, 206, 2, 16882.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (372, 255, 1, 58866.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (372, 257, 1, 12206.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (373, 20170464, 1, '2024-08-26 23:57:17', 99357.00, 4967.85, 94389.15);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (373, 109, 1, 18407.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (373, 277, 2, 30648.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (373, 137, 1, 19654.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (374, 23290657, 1, '2023-08-31 02:58:17', 30337.00, 0.00, 30337.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (374, 243, 1, 30337.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (375, 9631908, 2, '2024-03-11 22:31:17', 257182.00, 19288.65, 237893.35);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (375, 150, 2, 88116.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (375, 157, 2, 40475.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (376, 14674561, 1, '2025-02-18 14:36:17', 125408.00, 0.00, 125408.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (376, 324, 2, 41062.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (376, 264, 2, 21642.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (377, 14280017, 1, '2025-06-10 14:34:17', 61448.00, 3072.40, 58375.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (377, 117, 2, 30724.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (378, 13420977, 3, '2024-03-23 10:10:17', 156606.00, 11745.45, 144860.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (378, 297, 1, 85183.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (378, 224, 1, 19958.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (378, 159, 1, 51465.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (379, 7207889, 1, '2023-10-23 22:56:17', 156281.00, 7814.05, 148466.95);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (379, 305, 1, 20589.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (379, 225, 1, 27198.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (379, 147, 1, 18670.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (379, 174, 1, 89824.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (380, 7994240, 3, '2024-03-14 17:15:17', 24474.00, 0.00, 24474.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (380, 321, 1, 24474.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (381, 17822919, 2, '2023-08-08 15:45:17', 64638.00, 4847.85, 59790.15);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (381, 227, 2, 32319.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (382, 13029428, 3, '2024-06-30 14:05:17', 35266.00, 1763.30, 33502.70);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (382, 130, 2, 17633.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (383, 20705546, 1, '2025-05-28 23:32:17', 11292.00, 0.00, 11292.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (383, 259, 1, 11292.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (384, 12659869, 3, '2024-07-08 23:11:17', 216234.00, 10811.70, 205422.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (384, 131, 2, 88206.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (384, 250, 2, 19911.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (385, 18745244, 1, '2023-07-15 04:46:17', 122017.00, 6100.85, 115916.15);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (385, 279, 1, 50201.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (385, 247, 1, 21615.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (385, 279, 1, 50201.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (386, 21833342, 3, '2025-04-22 22:16:17', 135240.00, 6762.00, 128478.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (386, 305, 2, 20589.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (386, 253, 2, 47031.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (387, 7593686, 2, '2023-10-12 03:46:17', 26643.00, 1332.15, 25310.85);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (387, 101, 1, 26643.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (388, 20568715, 3, '2023-11-12 16:07:17', 163465.00, 12259.88, 151205.12);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (388, 202, 2, 36323.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (388, 274, 1, 9990.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (388, 115, 2, 31728.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (388, 231, 1, 17373.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (389, 20324783, 3, '2024-12-08 11:28:17', 86743.00, 6505.72, 80237.27);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (389, 221, 1, 18116.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (389, 329, 1, 35879.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (389, 304, 2, 16374.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (390, 9722011, 2, '2025-05-11 16:49:17', 52310.00, 2615.50, 49694.50);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (390, 168, 1, 29966.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (390, 348, 2, 11172.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (391, 11589515, 3, '2025-03-19 13:06:17', 121674.00, 9125.55, 112548.45);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (391, 251, 1, 34648.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (391, 199, 1, 31982.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (391, 331, 1, 20396.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (391, 251, 1, 34648.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (392, 16292755, 1, '2024-10-30 05:12:17', 386396.00, 28979.70, 357416.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (392, 144, 2, 91265.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (392, 103, 2, 41469.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (392, 158, 2, 45481.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (392, 168, 1, 29966.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (393, 19663067, 1, '2025-04-23 00:27:17', 231260.00, 11563.00, 219697.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (393, 251, 1, 34648.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (393, 113, 2, 14205.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (393, 108, 2, 59975.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (393, 276, 2, 24126.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (394, 20494398, 2, '2023-08-07 21:27:17', 125868.00, 0.00, 125868.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (394, 166, 1, 44957.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (394, 227, 1, 32319.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (394, 283, 2, 24296.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (395, 20494398, 3, '2024-03-02 05:18:17', 377856.00, 0.00, 377856.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (395, 298, 2, 46343.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (395, 174, 2, 89824.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (395, 129, 2, 21333.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (395, 315, 2, 31428.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (396, 13029428, 3, '2024-03-17 09:33:17', 114298.00, 5714.90, 108583.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (396, 321, 1, 24474.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (396, 174, 1, 89824.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (397, 10544924, 3, '2024-04-02 17:17:17', 46431.00, 0.00, 46431.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (397, 242, 1, 16245.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (397, 312, 1, 30186.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (398, 8903100, 3, '2025-01-16 06:18:17', 170630.00, 12797.25, 157832.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (398, 133, 1, 46750.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (398, 279, 2, 50201.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (398, 154, 2, 11739.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (399, 11589515, 1, '2025-03-30 09:41:17', 178664.00, 13399.80, 165264.20);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (399, 195, 1, 29244.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (399, 209, 2, 60785.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (399, 114, 1, 27850.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (400, 9913599, 3, '2025-03-18 04:17:17', 154885.00, 7744.25, 147140.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (400, 165, 2, 33887.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (400, 113, 1, 14205.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (400, 259, 1, 11292.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (400, 143, 2, 30807.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (401, 17921382, 2, '2023-11-21 12:51:17', 265592.00, 13279.60, 252312.40);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (401, 205, 2, 20890.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (401, 188, 2, 40692.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (401, 336, 2, 40893.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (401, 185, 2, 30321.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (402, 8637088, 2, '2024-12-27 03:34:17', 46592.00, 3494.40, 43097.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (402, 292, 2, 23296.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (403, 13322803, 3, '2025-05-18 06:30:17', 50560.00, 0.00, 50560.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (403, 169, 2, 25280.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (404, 18050900, 2, '2025-04-03 01:05:17', 93294.00, 0.00, 93294.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (404, 178, 2, 27977.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (404, 147, 2, 18670.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (405, 20438317, 2, '2025-02-17 19:26:17', 235227.00, 17642.02, 217584.98);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (405, 284, 1, 18174.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (405, 140, 1, 11841.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (405, 285, 2, 12782.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (405, 174, 2, 89824.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (406, 24528077, 1, '2023-08-07 06:20:17', 28801.00, 2160.07, 26640.92);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (406, 237, 2, 8480.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (406, 140, 1, 11841.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (407, 12258848, 1, '2023-10-04 22:06:17', 166239.00, 0.00, 166239.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (407, 108, 1, 59975.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (407, 248, 2, 36758.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (407, 304, 2, 16374.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (408, 17466974, 1, '2025-01-05 07:40:17', 180704.00, 9035.20, 171668.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (408, 235, 1, 87520.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (408, 297, 1, 85183.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (408, 111, 1, 8001.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (409, 23472616, 3, '2024-03-25 19:53:17', 110362.00, 0.00, 110362.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (409, 165, 1, 33887.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (409, 218, 2, 28180.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (409, 123, 1, 20115.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (410, 18745244, 1, '2025-03-06 06:28:17', 204871.00, 40974.20, 163896.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (410, 175, 1, 84250.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (410, 271, 2, 23452.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (410, 250, 1, 19911.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (410, 288, 2, 26903.00);
INSERT INTO `venta_promocion` (`id_venta`, `id_promocion`) VALUES (410, 2);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (411, 7431149, 1, '2025-05-31 21:12:17', 249313.00, 18698.47, 230614.52);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (411, 128, 2, 74854.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (411, 106, 2, 17476.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (411, 342, 1, 28305.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (411, 284, 2, 18174.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (412, 19294513, 2, '2023-10-28 02:14:17', 11841.00, 888.07, 10952.92);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (412, 140, 1, 11841.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (413, 17178489, 2, '2024-02-05 07:11:17', 190610.00, 9530.50, 181079.50);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (413, 297, 1, 85183.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (413, 293, 2, 23456.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (413, 302, 1, 58515.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (414, 19546617, 1, '2024-04-28 21:43:17', 290714.00, 0.00, 290714.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (414, 150, 2, 88116.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (414, 130, 1, 17633.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (414, 234, 2, 31300.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (414, 121, 1, 34249.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (415, 21450143, 3, '2023-07-29 14:34:17', 261884.00, 19641.30, 242242.70);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (415, 307, 2, 91062.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (415, 275, 2, 22247.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (415, 130, 2, 17633.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (416, 10583581, 3, '2025-03-14 15:08:17', 147464.00, 7373.20, 140090.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (416, 119, 1, 51960.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (416, 286, 2, 47752.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (417, 8637318, 3, '2024-06-06 16:16:17', 86341.00, 4317.05, 82023.95);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (417, 290, 1, 33055.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (417, 101, 2, 26643.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (418, 22303745, 1, '2024-07-24 03:59:17', 187750.00, 14081.25, 173668.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (418, 322, 2, 29702.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (418, 150, 1, 88116.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (418, 123, 2, 20115.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (419, 13791434, 2, '2024-12-29 03:00:17', 114064.00, 0.00, 114064.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (419, 254, 2, 26847.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (419, 268, 2, 30185.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (420, 12959207, 1, '2023-10-29 12:45:17', 57531.00, 4314.82, 53216.18);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (420, 177, 1, 38141.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (420, 203, 1, 19390.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (421, 20745880, 1, '2023-11-24 10:23:17', 59975.00, 2998.75, 56976.25);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (421, 108, 1, 59975.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (422, 17231954, 3, '2024-06-23 20:34:17', 222889.00, 11144.45, 211744.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (422, 187, 2, 44380.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (422, 258, 1, 44983.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (422, 118, 1, 28850.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (422, 238, 2, 30148.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (423, 7211294, 2, '2024-05-20 22:43:17', 37340.00, 0.00, 37340.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (423, 147, 2, 18670.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (424, 12238614, 1, '2024-04-02 15:35:17', 161478.00, 8073.90, 153404.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (424, 150, 1, 88116.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (424, 216, 1, 28379.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (424, 258, 1, 44983.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (425, 20438317, 2, '2025-03-28 16:43:17', 125434.00, 9407.55, 116026.45);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (425, 188, 2, 40692.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (425, 331, 1, 20396.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (425, 189, 1, 23654.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (426, 11388836, 1, '2024-04-16 07:31:17', 17464.00, 0.00, 17464.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (426, 183, 1, 17464.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (427, 19060316, 3, '2024-06-24 01:07:17', 71240.00, 5343.00, 65897.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (427, 335, 2, 35620.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (428, 16801685, 1, '2024-01-27 03:49:17', 46750.00, 2337.50, 44412.50);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (428, 133, 1, 46750.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (429, 13436345, 2, '2023-08-03 02:35:17', 21876.00, 1640.70, 20235.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (429, 148, 1, 21876.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (430, 10544924, 1, '2025-04-06 03:45:17', 191002.00, 0.00, 191002.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (430, 134, 2, 48001.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (430, 107, 2, 22855.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (430, 146, 2, 24645.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (431, 6876845, 3, '2023-08-20 13:19:17', 180947.00, 9047.35, 171899.65);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (431, 196, 1, 34419.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (431, 161, 2, 24401.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (431, 246, 1, 75142.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (431, 259, 2, 11292.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (432, 8621610, 3, '2023-07-15 12:13:17', 249645.00, 0.00, 249645.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (432, 189, 2, 23654.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (432, 118, 1, 28850.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (432, 162, 1, 77485.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (432, 134, 2, 48001.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (433, 11092779, 3, '2024-04-05 05:18:17', 193354.00, 14501.55, 178852.45);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (433, 319, 1, 25978.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (433, 190, 2, 15857.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (433, 220, 2, 15871.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (433, 119, 2, 51960.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (434, 23020138, 2, '2023-12-04 06:14:17', 111206.00, 0.00, 111206.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (434, 335, 1, 35620.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (434, 138, 2, 28427.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (434, 343, 1, 18732.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (435, 15763604, 2, '2023-07-20 02:47:17', 171886.00, 0.00, 171886.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (435, 280, 2, 34059.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (435, 260, 1, 60400.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (435, 184, 1, 43368.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (436, 9769958, 2, '2025-05-28 09:18:17', 49714.00, 0.00, 49714.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (436, 145, 2, 24857.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (437, 20466944, 2, '2023-10-20 13:08:17', 133806.00, 6690.30, 127115.70);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (437, 171, 2, 26211.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (437, 188, 2, 40692.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (438, 9990023, 2, '2023-07-04 22:55:17', 164755.00, 0.00, 164755.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (438, 161, 1, 24401.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (438, 324, 2, 41062.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (438, 263, 1, 41678.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (438, 164, 1, 16552.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (439, 7207889, 2, '2025-03-13 13:20:17', 61534.00, 3076.70, 58457.30);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (439, 266, 1, 61534.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (440, 14961860, 3, '2023-08-16 02:57:17', 85246.00, 6393.45, 78852.55);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (440, 261, 1, 26515.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (440, 170, 1, 41849.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (440, 206, 1, 16882.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (441, 12179018, 2, '2024-02-28 06:43:17', 39916.00, 1995.80, 37920.20);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (441, 224, 2, 19958.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (442, 22841837, 1, '2023-09-29 00:24:17', 236820.00, 11841.00, 224979.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (442, 193, 2, 30854.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (442, 210, 2, 24325.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (442, 172, 2, 18557.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (442, 110, 2, 44674.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (443, 15641110, 3, '2024-05-31 14:01:17', 113400.00, 0.00, 113400.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (443, 114, 2, 27850.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (443, 118, 2, 28850.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (444, 18553667, 2, '2025-02-14 02:41:17', 85183.00, 0.00, 85183.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (444, 297, 1, 85183.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (445, 19542811, 3, '2025-04-14 23:45:17', 272243.00, 20418.22, 251824.77);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (445, 307, 2, 91062.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (445, 338, 2, 32000.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (445, 325, 1, 26119.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (446, 24295525, 3, '2025-02-08 12:38:17', 176347.00, 8817.35, 167529.65);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (446, 167, 1, 37121.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (446, 226, 2, 33525.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (446, 139, 2, 31924.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (446, 236, 1, 8328.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (447, 12356780, 2, '2024-03-26 16:40:17', 184882.00, 9244.10, 175637.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (447, 211, 1, 26195.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (447, 238, 2, 30148.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (447, 145, 2, 24857.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (447, 136, 1, 48677.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (448, 13678228, 1, '2023-07-25 05:58:17', 56572.00, 4242.90, 52329.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (448, 236, 2, 8328.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (448, 224, 2, 19958.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (449, 23472616, 2, '2025-04-04 20:25:17', 22584.00, 0.00, 22584.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (449, 259, 2, 11292.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (450, 13410269, 3, '2023-07-29 12:55:17', 46750.00, 2337.50, 44412.50);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (450, 133, 1, 46750.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (451, 20751429, 1, '2023-07-23 08:24:17', 94125.00, 0.00, 94125.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (451, 156, 2, 31756.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (451, 340, 1, 30613.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (452, 12222640, 3, '2023-08-17 12:13:17', 36933.00, 0.00, 36933.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (452, 137, 1, 19654.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (452, 269, 1, 17279.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (453, 7436279, 1, '2025-02-09 06:58:17', 62158.00, 0.00, 62158.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (453, 303, 2, 31079.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (454, 16310535, 1, '2024-04-21 21:15:17', 132622.00, 6631.10, 125990.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (454, 177, 2, 38141.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (454, 239, 2, 28170.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (455, 11601922, 3, '2024-10-17 11:21:17', 26643.00, 0.00, 26643.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (455, 101, 1, 26643.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (456, 22013160, 2, '2023-09-23 12:59:17', 71066.00, 5329.95, 65736.05);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (456, 344, 2, 35533.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (457, 18642731, 3, '2024-03-05 14:18:17', 69343.00, 3467.15, 65875.85);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (457, 146, 2, 24645.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (457, 265, 1, 20053.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (458, 12787081, 3, '2025-05-16 11:20:17', 30186.00, 0.00, 30186.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (458, 312, 1, 30186.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (459, 21659881, 3, '2024-09-05 02:56:17', 163280.00, 12246.00, 151034.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (459, 223, 1, 43259.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (459, 170, 2, 41849.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (459, 202, 1, 36323.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (460, 6687766, 3, '2023-08-23 06:16:17', 178488.00, 13386.60, 165101.40);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (460, 116, 2, 23264.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (460, 230, 1, 87306.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (460, 249, 1, 44654.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (461, 11857031, 2, '2024-06-14 16:22:17', 103370.00, 0.00, 103370.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (461, 231, 1, 17373.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (461, 294, 1, 85997.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (462, 21447525, 1, '2024-12-12 03:07:17', 308662.00, 15433.10, 293228.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (462, 311, 2, 88213.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (462, 121, 1, 34249.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (462, 261, 2, 26515.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (462, 166, 1, 44957.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (463, 12787081, 3, '2024-01-23 18:51:17', 107034.00, 0.00, 107034.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (463, 287, 1, 44796.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (463, 200, 2, 31119.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (464, 22841837, 2, '2025-05-25 03:13:17', 38273.00, 1913.65, 36359.35);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (464, 341, 1, 19831.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (464, 245, 1, 18442.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (465, 8491818, 2, '2024-04-27 00:38:17', 41678.00, 3125.85, 38552.15);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (465, 263, 1, 41678.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (466, 15858745, 3, '2025-05-16 08:40:17', 115528.00, 5776.40, 109751.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (466, 251, 2, 34648.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (466, 192, 2, 23116.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (467, 21028464, 1, '2025-04-29 21:37:17', 35852.00, 0.00, 35852.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (467, 152, 1, 16021.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (467, 341, 1, 19831.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (468, 20270921, 3, '2023-09-12 11:51:17', 44527.00, 0.00, 44527.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (468, 181, 1, 44527.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (469, 13410269, 1, '2023-12-23 04:38:17', 68498.00, 3424.90, 65073.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (469, 121, 2, 34249.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (470, 9631908, 2, '2024-07-13 07:33:17', 28850.00, 2163.75, 26686.25);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (470, 118, 1, 28850.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (471, 23179235, 3, '2024-03-16 08:21:17', 119281.00, 8946.07, 110334.93);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (471, 283, 2, 24296.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (471, 211, 1, 26195.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (471, 275, 2, 22247.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (472, 15641110, 2, '2023-08-12 02:09:17', 139915.00, 0.00, 139915.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (472, 304, 1, 16374.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (472, 137, 1, 19654.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (472, 171, 2, 26211.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (472, 159, 1, 51465.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (473, 24147267, 2, '2025-02-20 07:50:17', 225840.00, 0.00, 225840.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (473, 150, 1, 88116.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (473, 315, 2, 31428.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (473, 255, 1, 58866.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (473, 111, 2, 8001.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (474, 9769958, 1, '2024-03-23 17:59:17', 436767.00, 0.00, 436767.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (474, 266, 1, 61534.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (474, 131, 2, 88206.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (474, 185, 1, 30321.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (474, 175, 2, 84250.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (475, 7994240, 1, '2024-07-05 20:29:17', 68692.00, 0.00, 68692.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (475, 244, 2, 34346.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (476, 8579885, 1, '2025-02-21 23:52:17', 88213.00, 4410.65, 83802.35);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (476, 311, 1, 88213.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (477, 17153199, 3, '2025-02-26 11:48:17', 287680.00, 0.00, 287680.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (477, 235, 2, 87520.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (477, 248, 1, 36758.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (477, 267, 2, 18030.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (477, 250, 2, 19911.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (478, 13436345, 1, '2025-03-26 07:32:17', 34362.00, 2577.15, 31784.85);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (478, 153, 1, 34362.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (479, 22585884, 3, '2025-01-08 10:10:17', 210559.00, 0.00, 210559.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (479, 199, 2, 31982.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (479, 229, 1, 75604.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (479, 287, 1, 44796.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (479, 211, 1, 26195.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (480, 19353280, 3, '2025-01-06 13:00:17', 129542.00, 9715.65, 119826.35);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (480, 283, 2, 24296.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (480, 157, 2, 40475.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (481, 13034997, 2, '2024-09-26 18:20:17', 345667.00, 25925.02, 319741.97);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (481, 324, 2, 41062.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (481, 161, 1, 24401.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (481, 290, 2, 33055.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (481, 291, 2, 86516.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (482, 7211294, 1, '2024-10-04 21:30:17', 108887.00, 0.00, 108887.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (482, 145, 1, 24857.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (482, 165, 1, 33887.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (482, 292, 1, 23296.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (482, 254, 1, 26847.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (483, 10368721, 3, '2023-06-29 16:08:17', 25564.00, 1917.30, 23646.70);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (483, 285, 2, 12782.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (484, 23290657, 1, '2025-03-17 13:12:17', 172138.00, 0.00, 172138.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (484, 173, 1, 9674.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (484, 270, 2, 27950.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (484, 244, 1, 34346.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (484, 310, 2, 36109.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (485, 18198189, 2, '2025-04-12 05:55:17', 127015.00, 0.00, 127015.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (485, 283, 2, 24296.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (485, 146, 1, 24645.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (485, 256, 2, 26889.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (486, 21373004, 3, '2024-10-04 12:41:17', 37875.00, 1893.75, 35981.25);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (486, 225, 1, 27198.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (486, 160, 1, 10677.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (487, 10832765, 1, '2023-08-31 04:17:17', 152067.00, 0.00, 152067.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (487, 135, 1, 31667.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (487, 229, 1, 75604.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (487, 287, 1, 44796.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (488, 16443077, 2, '2023-12-04 11:35:17', 132704.00, 6635.20, 126068.80);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (488, 293, 1, 23456.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (488, 349, 1, 48463.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (488, 209, 1, 60785.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (489, 22997369, 2, '2024-02-22 06:17:17', 50664.00, 3799.80, 46864.20);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (489, 284, 1, 18174.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (489, 242, 2, 16245.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (490, 22841837, 1, '2023-07-13 19:47:17', 91265.00, 4563.25, 86701.75);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (490, 144, 1, 91265.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (491, 20810316, 2, '2025-05-07 18:18:17', 78733.00, 0.00, 78733.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (491, 330, 1, 20956.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (491, 137, 1, 19654.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (491, 241, 1, 38123.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (492, 19320108, 3, '2024-12-18 18:08:17', 280348.00, 21026.10, 259321.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (492, 166, 1, 44957.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (492, 187, 2, 44380.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (492, 302, 1, 58515.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (492, 150, 1, 88116.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (493, 18512791, 1, '2023-10-02 10:40:17', 210211.00, 0.00, 210211.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (493, 215, 2, 41361.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (493, 177, 1, 38141.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (493, 110, 2, 44674.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (494, 20270921, 3, '2024-08-19 10:37:17', 129154.00, 0.00, 129154.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (494, 204, 2, 10955.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (494, 295, 2, 26733.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (494, 256, 2, 26889.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (495, 9022667, 1, '2024-09-26 17:19:17', 60652.00, 4548.90, 56103.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (495, 102, 1, 43996.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (495, 236, 2, 8328.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (496, 24528077, 1, '2025-03-09 08:47:17', 174432.00, 13082.40, 161349.60);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (496, 267, 1, 18030.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (496, 260, 1, 60400.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (496, 134, 2, 48001.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (497, 18642731, 2, '2025-01-19 13:09:17', 194262.00, 9713.10, 184548.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (497, 168, 2, 29966.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (497, 152, 2, 16021.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (497, 340, 2, 30613.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (497, 324, 1, 41062.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (498, 18429663, 3, '2023-06-21 22:47:17', 34362.00, 1718.10, 32643.90);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (498, 153, 1, 34362.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (499, 21025574, 2, '2024-03-04 02:57:17', 167666.00, 0.00, 167666.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (499, 156, 2, 31756.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (499, 281, 2, 47913.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (499, 236, 1, 8328.00);

INSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES (500, 19198092, 3, '2024-09-23 07:54:17', 157812.00, 11835.90, 145976.10);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (500, 141, 2, 23041.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (500, 205, 2, 20890.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (500, 350, 1, 9165.00);
INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES (500, 209, 1, 60785.00);

COMMIT;