# 📦 Blush Bar - Base de Datos

Este repositorio contiene el script de montaje de la base de datos **Blush Bar**, orientada a la gestión de clientes, productos, ventas y promociones en una tienda de cosmética.

## 🗃️ Estructura de la Base de Datos

La base de datos está diseñada con enfoque relacional y contiene las siguientes entidades principales:

### 🔹 Tablas de Referencia

- **`genero`**: Define los géneros posibles para los clientes.
- **`comuna`**: Lista de comunas asociadas a los clientes.
- **`tipo_cliente`**: Define categorías de cliente con sus respectivos descuentos.
- **`categoria`**: Categorías de productos (ej. maquillaje, skincare).
- **`marca`**: Marcas de los productos.
- **`metodo_pago`**: Métodos aceptados para realizar compras.
- **`promocion`**: Promociones activas con fecha y porcentaje de descuento.

### 🔹 Tablas Principales

- **`cliente`**: Contiene información personal de los clientes, incluyendo RUN, nombre, edad y relaciones con otras tablas como `genero`, `comuna` y `tipo_cliente`.
- **`producto`**: Información detallada de los productos disponibles, como nombre, precio, stock, marca y categoría.
- **`venta`**: Registro de ventas realizadas, incluyendo cliente, método de pago, montos y fecha.
- **`detalle_venta`**: Detalle de cada producto vendido en una venta específica.
- **`venta_promocion`**: Relación N:N entre ventas y promociones aplicadas.

## 🔐 Integridad Referencial

Las relaciones entre las tablas se mantienen mediante claves foráneas, garantizando la integridad de los datos:
- `cliente` se relaciona con `genero`, `comuna` y `tipo_cliente`.
- `producto` se relaciona con `categoria` y `marca`.
- `venta` se relaciona con `cliente` y `metodo_pago`.
- `detalle_venta` se relaciona con `venta` y `producto`.
- `venta_promocion` se relaciona con `venta` y `promocion`.

## 🚀 Población de Datos

El script incluye una carga inicial con:
- Más de 10 **categorías y marcas** de productos.
- Amplia **variedad de productos** con precios y stock realista.
- Datos ficticios de **clientes** en distintas comunas y categorías.
- Promociones activas con lógica de fechas.
- **Métodos de pago** comunes como efectivo, débito, crédito y Mercado Pago.

## 🛠️ Uso

Para montar la base de datos en un motor MySQL:

1. Crear una base de datos vacía:
   ```sql
   CREATE DATABASE blush_bar;
   USE blush_bar;
