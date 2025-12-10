@filter
Feature: Filtro y Ordenamiento de Productos
  Como usuario autenticado
  Quiero ordenar el catálogo de productos
  Para encontrar artículos por precio o nombre más fácilmente

  Background:
    Given estoy en la página de inicio de sesión
    And ingreso el nombre de usuario "standard_user"
    And ingreso la contraseña "secret_sauce"
    And hago click en el botón "Login"

  Scenario Outline: Ordenar productos según diferentes criterios
    Given estoy en la página de inventario
    When selecciono la opción de ordenar por "<opcion_filtro>"
    Then los productos deberían ordenarse por "<criterio_esperado>"

    Examples:
      | opcion_filtro       | criterio_esperado |
      | Name (A to Z)       | nombre_asc        |
      | Name (Z to A)       | nombre_desc       |
      | Price (low to high) | precio_asc        |
      | Price (high to low) | precio_desc       |