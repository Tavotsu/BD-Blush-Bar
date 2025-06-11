import random
from datetime import datetime, timedelta

# --- CONSTANTES Y DATOS BASE ---
NOMBRES_FEMENINOS = [
    'Sofía', 'Emilia', 'Isabella', 'Julieta', 'Trinidad', 'Isidora', 'Emma', 'Agustina', 'Amanda', 'Florencia',
    'Mía', 'Antonella', 'Josefa', 'Catalina', 'Martina', 'Valentina', 'Victoria', 'Maite', 'Antonia', 'Renata',
    'Amparo', 'Elena', 'Luciana', 'Leonor', 'Amelia', 'Dominga', 'Lía', 'Olivia', 'Rafaela', 'Ignacia',
    'Celeste', 'Laura', 'Jacinta', 'Pascal', 'Eloísa', 'Gabriela', 'Paz', 'Consuelo', 'Javiera', 'Daniela',
    'Fernanda', 'Camila', 'Andrea', 'Rocío', 'Constanza', 'Bárbara', 'Beatriz', 'Paulina', 'Alejandra', 'Verónica',
    'Valeria', 'Monserrat', 'Francisca', 'Carolina', 'Ana', 'María José', 'María Paz', 'Sofía Antonia', 'Anaís', 'Belén'
]
NOMBRES_MASCULINOS = [
    'Mateo', 'Gaspar', 'Liam', 'Lucas', 'Santiago', 'Benjamín', 'Vicente', 'Agustín', 'Maximiliano', 'Tomás',
    'Joaquín', 'Bastián', 'Martín', 'Matías', 'Facundo', 'Emiliano', 'Alonso', 'Thiago', 'Bruno', 'Gabriel',
    'Nicolás', 'Diego', 'Sebastián', 'Cristóbal', 'Luciano', 'Damián', 'Francisco', 'Felipe', 'Andrés', 'Carlos',
    'Fernando', 'Javier', 'Ignacio', 'Franco', 'León', 'José', 'Simón', 'Renato', 'Borja', 'Clemente',
    'Ricardo', 'Eduardo', 'Miguel', 'Antonio', 'Esteban', 'Ángel', 'David', 'Pablo', 'Alejandro', 'Daniel',
    'Juan Pablo', 'José Tomás', 'Luis', 'Pedro', 'Arturo', 'Cristian', 'Rodrigo', 'Manuel', 'Jorge', 'Patricio'
]
APELLIDOS = [
    'González', 'Muñoz', 'Rojas', 'Díaz', 'Pérez', 'Soto', 'Contreras', 'Silva', 'Martínez', 'Sepúlveda',
    'Morales', 'Rodríguez', 'López', 'Fuentes', 'Torres', 'Araya', 'Flores', 'Espinoza', 'Valenzuela', 'Castillo',
    'Tapia', 'Reyes', 'Gutiérrez', 'Castro', 'Pizarro', 'Álvarez', 'Vásquez', 'Sánchez', 'Fernández', 'Ramírez',
    'Carrasco', 'Gómez', 'Cortés', 'Herrera', 'Núñez', 'Jara', 'Vergara', 'Rivera', 'Figueroa', 'Riquelme',
    'García', 'Miranda', 'Bravo', 'Vera', 'Molina', 'Vega', 'Campos', 'Sandoval', 'Orellana', 'Cárdenas'
]
MARCAS_BLUSH_BAR = [
    'Benefit Cosmetics', 'Charlotte Tilbury', 'Clinique', 'Dior Beauty', 'Drunk Elephant',
    'Estée Lauder', 'Fenty Beauty', 'Glossier', 'Kiehl\'s', 'La Roche-Posay',
    'MAC Cosmetics', 'Morphe', 'NARS', 'Rare Beauty', 'Supergoop!', 'Tarte',
    'The Ordinary', 'Urban Decay'
]

# --- CONFIGURACIÓN DE GENERACIÓN ---
NUM_CLIENTES = 310
NUM_PRODUCTOS = 250
NUM_VENTAS = 500
RUT_MIN = 6500000
RUT_MAX = 25000000

# --- DATOS ESTÁTICOS DE LA BD ---
generos = [(1, 'Femenino'), (2, 'Masculino'), (3, 'Otro')]
comunas = [(1, 'Puerto Montt'), (2, 'Puerto Varas'), (3, 'Osorno'), (4, 'Frutillar'), (5, 'Llanquihue'), (6, 'Calbuco')]
tipos_cliente = [(1, 'Regular', 0.00), (2, 'Frecuente', 7.50), (3, 'Suscrito', 5.00)]
metodos_pago = [(1, 'Tarjeta'), (2, 'Efectivo'), (3, 'App')]
categorias = [(1, 'Maquillaje'), (2, 'Cuidado de la piel'), (3, 'Accesorios'), (4, 'Kits y Sets'), (5, 'Maquillaje Ojos'), (6, 'Maquillaje Labios')]
promociones = [
    (1, 'Cyber Day 2024', 20.00, '2024-10-21', '2024-10-23'),
    (2, 'Promo Aniversario Blush Bar', 15.00, '2025-03-01', '2025-03-15'),
    (3, 'Black Friday 2024', 25.00, '2024-11-29', '2024-12-01'),
    (4, 'Especial Día de la Madre 2025', 10.00, '2025-05-01', '2025-05-11'),
    (5, 'Liquidación de Invierno 2025', 30.00, '2025-07-20', '2025-07-31')
]

# Plantillas de productos para dar realismo
plantillas_productos = {
    'The Ordinary': [("Sérum Niacinamida 10%", 2, 8990), ("Ácido Hialurónico 2% + B5", 2, 9990), ("Peeling Solution AHA 30%", 2, 10990)],
    'NARS': [("Corrector Radiante Cremoso", 1, 28990), ("Rubor 'Orgasm'", 1, 31990), ("Base Light Reflecting", 1, 45990)],
    'Fenty Beauty': [("Base Pro Filt'r Soft Matte", 1, 34990), ("Brillo Gloss Bomb", 6, 19990), ("Iluminador Killawatt", 1, 32990)],
    'Rare Beauty': [("Rubor Líquido Soft Pinch", 1, 22990), ("Base Ligera Liquid Touch", 1, 29990), ("Esponja de Maquillaje", 3, 8990)],
    'Benefit Cosmetics': [("Gel para Cejas Gimme Brow+", 5, 24990), ("Primer POREfessional", 1, 32990), ("Máscara They're Real!", 5, 25990)],
    'La Roche-Posay': [("Protector Solar Anthelios 50+", 2, 21990), ("Crema Effaclar Duo+", 2, 24990), ("Agua Termal", 2, 12990)],
    'Morphe': [("Paleta de Sombras 35O", 5, 25990), ("Set de Brochas Esenciales", 3, 29990), ("Bruma Fijadora Continuous", 3, 15990)],
    'Charlotte Tilbury': [("Labial Matte Revolution Pillow Talk", 6, 33990), ("Crema Mágica Hidratante", 2, 89990), ("Polvos Airbrush Flawless", 1, 43990)],
    'Clinique': [("Sistema de 3 Pasos", 4, 25990), ("Base Even Better", 1, 31990)],
    'Dior Beauty': [("Base Forever Skin Glow", 1, 49990), ("Bálsamo Labial Addict", 6, 35990)],
    'Drunk Elephant': [("Sérum de Día C-Firma", 2, 75990), ("Crema Lala Retro Whipped", 2, 59990)],
    'Estée Lauder': [("Base Double Wear", 1, 42990), ("Sérum Advanced Night Repair", 2, 85990)],
    'Glossier': [("Gel de Cejas Boy Brow", 5, 16990), ("Rubor en Crema Cloud Paint", 1, 18990)],
    'Kiehl\'s': [("Contorno de Ojos de Aguacate", 2, 29990), ("Limpiador Ultra Facial", 2, 19990)],
    'MAC Cosmetics': [("Labial Retro Matte Ruby Woo", 6, 18990), ("Fijador Fix+", 3, 22990)],
    'Supergoop!': [("Protector Solar Unseen SPF 40", 2, 34990), ("Glowscreen SPF 40", 2, 35990)],
    'Tarte': [("Corrector Shape Tape", 1, 26990), ("Paleta de Sombras Tartelette", 5, 39990)],
    'Urban Decay': [("Paleta de Sombras Naked", 5, 45990), ("Fijador de Maquillaje All Nighter", 3, 28990)]
}

def calcular_dv(rut_sin_dv):
    rut_reverso = str(rut_sin_dv)[::-1]
    multiplicador = 2
    suma = 0
    for digito in rut_reverso:
        suma += int(digito) * multiplicador
        multiplicador += 1
        if multiplicador == 8:
            multiplicador = 2
    resto = suma % 11
    dv = 11 - resto
    if dv == 11:
        return '0'
    elif dv == 10:
        return 'K'
    else:
        return str(dv)

def generar_sql():
    ruts_usados = set()
    
    with open('poblar_BD.sql', 'w', encoding='utf-8') as f:
        print("Iniciando la generación del archivo poblar_BD.sql...")
        f.write("-- Script de Poblado para Base de Datos Blush Bar\n")
        f.write("-- Generado automáticamente por script de Python\n\n")
        f.write("SET FOREIGN_KEY_CHECKS=0;\nTRUNCATE TABLE venta_promocion;\nTRUNCATE TABLE detalle_venta;\nTRUNCATE TABLE venta;\nTRUNCATE TABLE cliente;\nTRUNCATE TABLE producto;\nTRUNCATE TABLE marca;\nTRUNCATE TABLE categoria;\nTRUNCATE TABLE metodo_pago;\nTRUNCATE TABLE tipo_cliente;\nTRUNCATE TABLE comuna;\nTRUNCATE TABLE genero;\nTRUNCATE TABLE promocion;\nSET FOREIGN_KEY_CHECKS=1;\n\nSTART TRANSACTION;\n\n")

        # --- Tablas de catálogo estáticas ---
        f.write("-- genero\n")
        for g in generos: f.write(f"INSERT INTO `genero` (`id_genero`, `descripcion`) VALUES ({g[0]}, '{g[1]}');\n")
        
        f.write("\n-- comuna\n")
        for c in comunas: f.write(f"INSERT INTO `comuna` (`id_comuna`, `descripcion`) VALUES ({c[0]}, '{c[1]}');\n")

        f.write("\n-- tipo_cliente\n")
        for tc in tipos_cliente: f.write(f"INSERT INTO `tipo_cliente` (`id_tipo_cliente`, `descripcion`, `porc_desc`) VALUES ({tc[0]}, '{tc[1]}', {tc[2]});\n")

        f.write("\n-- metodo_pago\n")
        for mp in metodos_pago: f.write(f"INSERT INTO `metodo_pago` (`id_metodo_pago`, `descripcion`) VALUES ({mp[0]}, '{mp[1]}');\n")
        
        f.write("\n-- categoria\n")
        for cat in categorias: f.write(f"INSERT INTO `categoria` (`id_categoria`, `descripcion`) VALUES ({cat[0]}, '{cat[1]}');\n")

        f.write("\n-- marca\n")
        marcas_map = {}
        for i, marca_nombre in enumerate(MARCAS_BLUSH_BAR, 1):
            f.write(f"INSERT INTO `marca` (`id_marca`, `descripcion`) VALUES ({i}, '{marca_nombre}');\n")
            marcas_map[marca_nombre] = i
        
        f.write("\n-- promocion\n")
        for p in promociones: f.write(f"INSERT INTO `promocion` (`id_promocion`, `nombre`, `porc_desc`, `fecha_inicio`, `fecha_fin`, `activa`) VALUES ({p[0]}, '{p[1]}', {p[2]}, '{p[3]}', '{p[4]}', TRUE);\n")
        
        # --- Generación de Productos ---
        print(f"Generando {NUM_PRODUCTOS} productos...")
        f.write("\n-- producto\n")
        productos_generados = []
        for i in range(NUM_PRODUCTOS):
            id_producto = 101 + i
            marca_nombre = random.choice(list(plantillas_productos.keys()))
            id_marca = marcas_map[marca_nombre]
            plantilla = random.choice(plantillas_productos[marca_nombre])
            nombre_producto = f"{plantilla[0]} {marca_nombre}"
            id_categoria = plantilla[1]
            precio = plantilla[2] + random.randint(-2000, 2000)
            stock = random.randint(20, 200)
            
            producto = {'id_producto': id_producto, 'nombre': nombre_producto.replace("'", "''"), 'precio': precio}
            productos_generados.append(producto)
            
            f.write(f"INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `stock`, `id_categoria`, `id_marca`) VALUES ({id_producto}, '{producto['nombre']}', 'Descripción de {producto['nombre']}', {precio}, {stock}, {id_categoria}, {id_marca});\n")

        # --- Generación de Clientes ---
        print(f"Generando {NUM_CLIENTES} clientes...")
        f.write("\n-- cliente\n")
        clientes_generados = []
        for i in range(NUM_CLIENTES):
            while True:
                numrun = random.randint(RUT_MIN, RUT_MAX)
                if numrun not in ruts_usados:
                    ruts_usados.add(numrun)
                    break
            
            dv_run = calcular_dv(numrun)
            
            if random.random() < 0.75:
                id_genero, pnombre, snombre = 1, random.choice(NOMBRES_FEMENINOS), random.choice(NOMBRES_FEMENINOS)
            else:
                id_genero, pnombre, snombre = 2, random.choice(NOMBRES_MASCULINOS), random.choice(NOMBRES_MASCULINOS)
            
            papellido, mapellido = random.choice(APELLIDOS), random.choice(APELLIDOS)
            hoy = datetime.now()
            fec_nac = hoy - timedelta(days=random.randint(18*365, 65*365))
            id_comuna, id_tipo_cliente = random.choice(comunas)[0], random.choice(tipos_cliente)[0]
            
            clientes_generados.append({'numrun': numrun, 'id_tipo_cliente': id_tipo_cliente})
            f.write(f"INSERT INTO `cliente` (`numrun`, `dv_run`, `pnombre`, `snombre`, `papellido`, `mapellido`, `fec_nac`, `id_genero`, `id_comuna`, `id_tipo_cliente`) VALUES ({numrun}, '{dv_run}', '{pnombre}', '{snombre}', '{papellido}', '{mapellido}', '{fec_nac.strftime('%Y-%m-%d')}', {id_genero}, {id_comuna}, {id_tipo_cliente});\n")

        # --- Generación de Ventas ---
        print(f"Generando {NUM_VENTAS} ventas...")
        f.write("\n-- venta\n-- detalle_venta\n-- venta_promocion\n")
        tipos_cliente_map = {tc[0]: tc[2] for tc in tipos_cliente}
        
        for id_venta in range(1, NUM_VENTAS + 1):
            cliente_venta, id_metodo_pago = random.choice(clientes_generados), random.choice(metodos_pago)[0]
            fecha_venta = datetime.now() - timedelta(days=random.randint(1, 730), hours=random.randint(0,23), minutes=random.randint(0,59))
            
            monto_subtotal = 0
            detalles_venta = []
            for _ in range(random.randint(1, 4)):
                producto = random.choice(productos_generados)
                cantidad = random.randint(1, 2)
                monto_subtotal += cantidad * producto['precio']
                detalles_venta.append({'id_producto': producto['id_producto'], 'cantidad': cantidad, 'precio_unitario': producto['precio']})
            
            descuento_cliente = tipos_cliente_map.get(cliente_venta['id_tipo_cliente'], 0)
            monto_descuentos = monto_subtotal * (descuento_cliente / 100)
            
            promo_aplicada = None
            if random.random() < 0.25:
                promociones_activas = [p for p in promociones if datetime.strptime(p[3], '%Y-%m-%d').date() <= fecha_venta.date() <= datetime.strptime(p[4], '%Y-%m-%d').date()]
                if promociones_activas:
                    promo_aplicada = random.choice(promociones_activas)
                    monto_descuentos += monto_subtotal * (promo_aplicada[2] / 100)
            
            monto_final = max(0, round(monto_subtotal - monto_descuentos, 2))
            
            f.write(f"\nINSERT INTO `venta` (`id_venta`, `numrun`, `id_metodo_pago`, `fecha_venta`, `monto_subtotal`, `monto_descuentos`, `monto_final`) VALUES ({id_venta}, {cliente_venta['numrun']}, {id_metodo_pago}, '{fecha_venta.strftime('%Y-%m-%d %H:%M:%S')}', {monto_subtotal:.2f}, {round(monto_descuentos, 2):.2f}, {monto_final:.2f});\n")
            for detalle in detalles_venta:
                f.write(f"INSERT INTO `detalle_venta` (`id_venta`, `id_producto`, `cantidad`, `precio_unitario`) VALUES ({id_venta}, {detalle['id_producto']}, {detalle['cantidad']}, {detalle['precio_unitario']:.2f});\n")
            if promo_aplicada:
                f.write(f"INSERT INTO `venta_promocion` (`id_venta`, `id_promocion`) VALUES ({id_venta}, {promo_aplicada[0]});\n")
        
        f.write("\nCOMMIT;\nSET FOREIGN_KEY_CHECKS=1;\n")
        print("Archivo 'poblar_BD.sql' generado exitosamente.")

if __name__ == "__main__":
    generar_sql()