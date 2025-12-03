@maximize
Feature: Flujo de Compra (Checkout)
  Como usuario autenticado (standard_user)
  Quiero procesar el pago y envío de mis productos
  Para completar la adquisición de items seleccionados

  Background:
    Given estoy en la página de inicio de sesión
    And ingreso el nombre de usuario "standard_user"
    And ingreso la contraseña "secret_sauce"
    And hago click en el botón "Login"
    And agrego el producto "Sauce Labs Backpack" al carrito
    And agrego el producto "Sauce Labs Bike Light" al carrito
    And hago click en el icono del carrito
    And hago click en el botón "Checkout"

  @smoke
  Scenario: Flujo End-to-End con validación de envío y finalización
    When ingreso los datos de envío:
      | nombre | apellido | codigo_postal |
      | Juan   | Perez    | 12345         |
    And hago click en el botón "Continue"
    Then deberia ver la información de pago "SauceCard #31337"
    And deberia ver la información de envío "Free Pony Express Delivery!"
    When hago click en el botón "Finish"
    Then deberia ver el encabezado "Checkout: Complete!"
    And deberia ver el mensaje de agradecimiento "Thank you for your order!"
    And el botón visible deberia ser "Back Home"

  Scenario: Validación rigurosa de desglose financiero (Impuestos y Total)
    When ingreso los datos de envío:
      | nombre | apellido | codigo_postal |
      | Test   | User     | 55555         |
    And hago click en el botón "Continue"
    Then el subtotal ("Item total") deberia ser "$39.98"
    And el impuesto ("Tax") deberia ser "$3.20"
    And el monto total final ("Total") deberia ser "$43.18"

  Scenario Outline: Validar campos requeridos en 'Your Information'
    When ingreso los datos de envío:
      | nombre   | apellido   | codigo_postal   |
      | <nombre> | <apellido> | <codigo_postal> |
    And hago click en el botón "Continue"
    Then deberia ver el error de checkout "<error>"

    Examples:
      | nombre | apellido | codigo_postal | error                          |
      |        | Gomez    | 12345         | Error: First Name is required  |
      | Ana    |          | 12345         | Error: Last Name is required   |
      | Ana    | Gomez    |               | Error: Postal Code is required |

  Scenario: Verificación de botón 'Back Home' redirige a Inventario
    When ingreso los datos de envío:
      | nombre | apellido | codigo_postal |
      | Luis   | Martinez | 67890         |
    And hago click en el botón "Continue"
    And hago click en el botón "Finish"
    When hago click en el botón "Back Home"
    Then deberia ser redirigido a la página "Inventory"

#si bien la pagina deja hacer checkout con el carrito vacio, se agrega este escenario para validar el flujo completo y que no rompa nada
  Scenario: Realizar checkout con el carrito vacío
    Given hago click en el botón "Cancel"
    When elimino el producto "Sauce Labs Backpack" del carrito
    And elimino el producto "Sauce Labs Bike Light" del carrito
    Then el carrito deberia estar vacio
    When hago click en el botón "Checkout"
    And ingreso los datos de envío:
      | nombre | apellido | codigo_postal |
      | Test   | Vacio    | 00000         |
    And hago click en el botón "Continue"
    When hago click en el botón "Finish"
    Then deberia ver el mensaje de agradecimiento "Thank you for your order!"