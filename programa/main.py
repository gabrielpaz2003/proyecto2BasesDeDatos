# Universidad del Valle de Guatemala
# CC3082 - Bases de datos 1
# Proyecto No. 2
#
# Joaquín Puente - 22296
# Nelson García - 22434
# Gabriel Paz - 221087
from entities import User

import enquiries
import functions as f


loginOptions: list[str] = ["Iniciar sesión", "Registrar", "Salir"]
roles: list[str] = ['mesero', 'administrador', 'chef', 'barista']

if __name__ == "__main__":
    running: bool = True
    #Clear console
    while running:
        print("\033c")
        choice = enquiries.choose('Choose one of these options: ', loginOptions)
        if choice == "Iniciar sesión":
            username: str = input("Usuario: ")
            password: str = input("Contraseña: ")
            userInstance: User = f.loginUser(username=username, password=password)

            if userInstance:
                print("\033c")
                print("Inicio de sesión exitoso")
                f.mainMenu(userInstance)

            else:
                print("\033c")
                print("Iniciar sesión fallido")
        elif choice == "Registrar":
            username: str = input("Usuario: ")
            password: str = input("Contraseña: ")

            rol: str = enquiries.choose('Seleccione un rol: ', roles)

            f.registerUser(username=username, password=password, rol=rol)
        elif choice == "Salir":
            exit(0)


