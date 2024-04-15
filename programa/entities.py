

class User:
    def __init__(self, username, password, role):
        self.username = username
        self.password = password
        self.role = role

class Product:
    def __init__(self, id, name, price, description):
        self.id = id
        self.name = name
        self.price = price
        self.description = description

    def __str__(self):
        return f"{self.id} - {self.name} - {self.price} - {self.description}"

class Account:
    def __init__(self, id, table, open, close, status):
        self.id = id
        self.table_id = table
        self.open_datetime = open
        self.close_datetime = close
        self.status = status

class Detalle:
    def __init__(self, id, product_id, quantity):
        self.id = id
        self.product_id = product_id
        self.quantity = quantity