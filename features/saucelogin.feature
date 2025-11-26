Feature: Login en SauceDemo
  Como un usuario de SauceDemo
  Quiero iniciar sesión
  Para poder ver el catálogo de productos

@login_valido
Scenario: Inicio de sesión exitoso
  Given estoy en la página de inicio de sesión
  When ingreso el nombre de usuario "standard_user"
  And ingreso la contraseña "secret_sauce"
  And hago click en el botón "Login"
  Then soy redirigido a la página de productos

  @logout
Scenario: Logout exitoso después de la autenticación
  Given estoy en la página de inicio de sesión
  When ingreso el nombre de usuario "standard_user"
  And ingreso la contraseña "secret_sauce"
  And hago click en el botón "Login"
  Then soy redirigido a la página de productos
  # Pasos nuevos para el logout
  When hago click en el botón de menú
  And hago click en el enlace "Logout"
  Then soy redirigido a la página de inicio de sesión