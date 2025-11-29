Feature: Menú de Navegación en SauceDemo
Como un usuario de SauceDemo
Quiero interactuar con el menú lateral
Para poder acceder a todas las opciones: Todos los Items, About, Logout y Reset App State

PRECONDICIÓN: Se asume que el usuario ya ha iniciado sesión

Background: Configuración inicial
Given estoy en la página de productos

Scenario: Visualización del botón de cerrar menú
When hago clic en el botón de menú
Then debo ver el botón de cerrar menú

@smoke
Scenario: Visualización de todos los ítems del menú disponibles
When hago clic en el botón de menú
Then debo ver los siguientes ítems del menú:
| All Items |
| About           |
| Logout          |
| Reset App State |

@smoke
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