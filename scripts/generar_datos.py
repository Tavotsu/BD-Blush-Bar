import random
from datetime import datetime, timedelta

# Lists of names for generating realistic data
NOMBRES_FEMENINOS = ['María', 'Ana', 'Carolina', 'Andrea', 'Valentina', 'Camila', 'Javiera', 'Francisca', 
                    'Catalina', 'Victoria', 'Daniela', 'Fernanda', 'Gabriela', 'Isabel', 'Patricia']
NOMBRES_MASCULINOS = ['Juan', 'José', 'Carlos', 'Diego', 'Felipe', 'Andrés', 'Gabriel', 'Sebastián', 
                     'Nicolás', 'Alberto', 'Ricardo', 'Miguel', 'Eduardo', 'Francisco', 'Antonio']
APELLIDOS = ['González', 'Muñoz', 'Rojas', 'Díaz', 'Pérez', 'Soto', 'Contreras', 'Silva', 'Martínez', 
            'Sepúlveda', 'Morales', 'Rodríguez', 'López', 'Fuentes', 'Torres', 'Araya', 'Flores', 
            'Espinoza', 'Valenzuela', 'Castillo']

def generate_rut():
    """Generate a valid Chilean RUT"""
    num = random.randint(15000000, 25000000)
    return num

def generate_dv(rut):
    """Generate verification digit for Chilean RUT"""
    reversed_digits = map(int, reversed(str(rut)))
    factors = (2, 3, 4, 5, 6, 7)
    s = sum(d * f for d, f in zip(reversed_digits, (factors * 5)[:len(str(rut))]))
    dv = (-s) % 11
    return {10: 'K', 11: '0'}.get(dv, str(dv))

def generate_client():
    """Generate a client record"""
    rut = generate_rut()
    gender_id = random.choices([1, 2, 3], weights=[60, 35, 5])[0]
    
    # Generate name based on gender
    if gender_id == 1:  # Female
        first_name = random.choice(NOMBRES_FEMENINOS)
        second_name = random.choice([''] * 3 + NOMBRES_FEMENINOS)  # 75% chance of no second name
    elif gender_id == 2:  # Male
        first_name = random.choice(NOMBRES_MASCULINOS)
        second_name = random.choice([''] * 3 + NOMBRES_MASCULINOS)  # 75% chance of no second name
    else:  # Other
        first_name = random.choice(NOMBRES_FEMENINOS + NOMBRES_MASCULINOS)
        second_name = ''
    
    last_name1 = random.choice(APELLIDOS)
    last_name2 = random.choice(APELLIDOS)
    
    return f"({rut}, '{generate_dv(rut)}', '{first_name}', '{second_name}', '{last_name1}', '{last_name2}', " + \
           f"{random.randint(15, 70)}, {gender_id}, {random.randint(1, 13)}, {random.randint(1, 4)})"

def generate_sale(client_ruts, num_products):
    """Generate a sale record"""
    date = datetime.now() - timedelta(days=random.randint(0, 730))
    client_rut = random.choice(client_ruts)
    payment_method = random.randint(1, 4)
    
    # Generate random products and quantities
    products = random.sample(range(1, num_products + 1), random.randint(1, 5))
    quantities = [random.randint(1, 3) for _ in products]
    
    subtotal = sum(product_prices[p-1] * q for p, q in zip(products, quantities))
    discount = random.choice([0, 0, 0, 0.05, 0.1, 0.15, 0.2]) * subtotal
    final = subtotal - discount
    
    return {
        'sale': f"({client_rut}, {payment_method}, '{date.strftime('%Y-%m-%d %H:%M:%S')}', " + \
                f"{subtotal:.2f}, {discount:.2f}, {final:.2f})",
        'products': list(zip(products, quantities))
    }

# Product prices (corresponding to the products in poblar_DB_Blush_bar.sql)
product_prices = [18990, 12990, 9990, 15990, 22990, 89990, 95990, 25990, 35990, 11990]

# Generate 500 clients
clients = [generate_client() for _ in range(500)]
client_ruts = [int(c.split(',')[0][1:]) for c in clients]

# Generate 350 sales
sales = [generate_sale(client_ruts, len(product_prices)) for _ in range(350)]

# Write SQL file
with open('poblar_DB_Blush_bar.sql', 'r', encoding='utf-8') as f:
    template = f.read()

# Find the client placeholder and replace with generated clients
client_data = ',\n'.join(clients)
template = template.replace(
    "(15234567, '1', 'María', 'José', 'González', 'Pérez', 25, 1, 1, 1),\n(16345678, '2', 'Juan', 'Pablo', 'Martínez', 'Silva', 30, 2, 2, 2),\n(17456789, '3', 'Ana', 'María', 'López', 'Rojas', 28, 1, 3, 3)",
    client_data
)

# Generate sales and details data
sales_data = []
details_data = []
promo_data = []

for i, sale in enumerate(sales, 1):
    sales_data.append(sale['sale'])
    
    # Generate details for each product in the sale
    for prod, qty in sale['products']:
        details_data.append(
            f"({i}, {prod}, {qty}, {product_prices[prod-1]:.2f})"
        )
    
    # 30% chance of having a promotion
    if random.random() < 0.3:
        promo_data.append(f"({i}, {random.randint(1, 4)})")

# Replace sales placeholder
template = template.replace(
    "(15234567, 1, '2023-10-15 10:30:00', 35990, 0.00, 35990),\n(16345678, 2, '2023-10-15 11:45:00', 89990, 13498.50, 76491.50),\n(17456789, 3, '2023-10-15 14:20:00', 48980, 4898.00, 44082.00)",
    ',\n'.join(sales_data)
)

# Replace details placeholder
template = template.replace(
    "(1, 9, 1, 35990),\n(2, 6, 1, 89990),\n(3, 1, 1, 18990),\n(3, 2, 1, 29990)",
    ',\n'.join(details_data)
)

# Replace promotions placeholder
template = template.replace(
    "(2, 1),\n(3, 4)",
    ',\n'.join(promo_data)
)

# Write final SQL file
with open('poblar_DB_Blush_bar.sql', 'w', encoding='utf-8') as f:
    f.write(template)

print("Generated SQL file with:")
print(f"- {len(clients)} clients")
print(f"- {len(sales)} sales")
print(f"- {len(details_data)} sale details")
print(f"- {len(promo_data)} promotion uses")
