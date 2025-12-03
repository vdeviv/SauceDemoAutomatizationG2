@maximize
Feature: Gestión del Carrito de Compras
  Como usuario autenticado (standard_user)
  Quiero visualizar y gestionar los productos en mi carrito
  Para verificar que mi orden de compra sea correcta antes de pagar

  Background:
    Given estoy en la página de inicio de sesión
    And ingreso el nombre de usuario "standard_user"
    And ingreso la contraseña "secret_sauce"
    And hago click en el botón "Login"

  # 1. Validación rigurosa de datos usando Tablas (Requiremento: Tablas)
  Scenario: Verificar que los detalles del producto en el carrito sean correctos
    Given agrego el producto "Sauce Labs Backpack" al carrito
    And agrego el producto "Sauce Labs Bolt T-Shirt" al carrito
    And agrego el producto "Sauce Labs Onesie" al carrito
    When hago click en el icono del carrito
    Then veo los siguientes items en la lista del carrito:
      | cantidad | nombre                  | precio | descripcion_parcial                                       |
      | 1        | Sauce Labs Backpack     | $29.99 | carry.allTheThings() with the sleek, streamlined Sly Pack |
      | 1        | Sauce Labs Bolt T-Shirt | $15.99 | Get your testing superhero on                             |
      | 1        | Sauce Labs Onesie       | $7.99  | Rib snap infant onesie for the junior automation engineer |

  # 2. Flujo de eliminación y validación de contador (Requisito: Validaciones Rigurosas)
  Scenario: Eliminar items dentro del carrito actualiza el contador
    Given agrego el producto "Sauce Labs Backpack" al carrito
    And agrego el producto "Sauce Labs Bike Light" al carrito
    And el icono del carrito muestra "2"
    When hago click en el icono del carrito
    And hago click en el botón "Remove" del producto "Sauce Labs Backpack"
    Then el producto "Sauce Labs Backpack" no debería aparecer en la lista
    But el producto "Sauce Labs Bike Light" debería seguir en la lista
    And el icono del carrito muestra "1"

  # 3. Navegación (Requisito: Escenarios Expresivos)
  Scenario Outline: Navegación desde el carrito de compras
    Given agrego el producto "Sauce Labs Fleece Jacket" al carrito
    And hago click en el icono del carrito
    When hago click en el botón "<boton>"
    Then debería ser redirigido a la página "<pagina_esperada>"

    Examples:
      | boton             | pagina_esperada |
      | Continue Shopping | Inventory       |
      | Checkout          | Checkout Step One |

  # 4. Caso Borde / Estado Vacío
  Scenario: Validación visual de un carrito vacío
    When hago click en el icono del carrito
    Then la lista de items del carrito debería estar vacía
    And el icono del carrito no debería mostrar ningún número
