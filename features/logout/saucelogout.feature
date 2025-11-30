Feature: Logout en SauceDemo
  Como un usuario de SauceDemo
  Quiero cerrar sesión de forma segura
  Para proteger mi cuenta

@logout
Scenario: Logout exitoso después de la autenticación
  Given estoy en la página de inicio de sesión
  When ingreso el nombre de usuario "<username>"
  And ingreso la contraseña "secret_sauce"
  And hago click en el botón "Login"
  Then soy redirigido a la página de productos
  
  When hago click en el botón de menú
  And hago click en el enlace "Logout"
  Then soy redirigido a la página de inicio de sesión
  
   Examples:
    | username                 |
    | standard_user            |
    | problem_user             |
    | performance_glitch_user  |