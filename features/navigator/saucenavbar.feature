Feature: Menú de Navegación en SauceDemo
Como un usuario de SauceDemo
Quiero interactuar con el menú lateral
Para poder acceder a todas las opciones: Todos los Items, About, Logout y Reset App State


Background: Login y Precondición
Given estoy en la página de inicio de sesión
And ingreso el nombre de usuario "standard_user"
And ingreso la contraseña "secret_sauce"
And hago click en el botón "Login"

@smoke
Scenario: Visualización de todos los ítems del menú disponibles
When hago clic en el botón de menú
Then debo ver los siguientes ítems del menú:
| All Items       |
| About           |
| Logout          |
| Reset App State |

Scenario: Redirección al hacer clic en Logout
When hago clic en el botón de menú
And hago clic en el botón de "Logout"
Then debo ser redirigido a la página de inicio de sesión

Scenario: Redirección al hacer clic en About
When hago clic en el botón de menú
And hago clic en el botón de "About"
Then debo ser redirigido al sitio web de Sauce Labs

Scenario: Reinicio del estado de la aplicación
When hago clic en el botón de menú
And hago clic en el botón de "Reset App State"
Then el carrito de compras debe estar vacío