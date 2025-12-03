Feature: Visualización de Productos

  Como un usuario de SauceDemo
  Quiero visualizar de manera correcta todos los usuarios 
  Para validar la pagina correctamente

  Background: Login exitoso
    Given estoy en la página de inicio de sesión
    When ingreso el nombre de usuario "standard_user"
    And ingreso la contraseña "secret_sauce"
    And hago click en el botón "Login"
    Then soy redirigido a la página de productos

  @products_count @smoke
  Scenario: Validar que se muestren exactamente 6 productos
    Then debo ver un total de 6 productos en la página

  Scenario: Validar detalles de productos con tabla de datos
    Then veo los siguientes productos con sus detalles:
      | nombre                  | precio | descripcion_parcial |
      | Sauce Labs Backpack     | $29.99 | carry.allTheThings  |
      | Sauce Labs Bike Light   | $9.99  | red light           |
      | Sauce Labs Bolt T-Shirt | $15.99 | superhero           |

  Scenario: Validar que las imágenes de los productos se carguen correctamente
    Then todas las imágenes de los productos deben ser visibles

  Scenario: Navegar al detalle del producto y volver
    When hago click en el nombre del producto "Sauce Labs Bolt T-Shirt"
    Then deberia estar en la página de detalles del producto "Sauce Labs Bolt T-Shirt"
    When hago click en el botón para volver a productos
    Then soy redirigido a la página de productos