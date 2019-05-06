Feature: Proceso de aumento de cupo tarjeta de crédito
Como Falabella Servicios Financieros
Quiero comprobar las funcionalidades criticas de aumento de cupo en tarjetas de credito vía web 
Para evitar aumentos invalidos segun las politicas corporativas

Background:
	Given  Autenticarse con credenciales Falabella Financiero con usuario <usuario> y <contraseña> de prueba en portal
	And Ir a la opcion Tarjetas/Aumento de Cupo del Portal

Scenario outline: Cliente registra deuda en tarjeta de credito al solicitar aumento
	Given <rut> registra deuda en tarjeta N° <tarjeta>
	When cliente <rut> solicita un aumento de cupo en su N° de tarjeta <tarjeta> al clickear en botón Aumentar Cupo . 
	Then No debe permitir avanzar en el proceso de aumento de tarjeta de credito y se despliega pop up "No es posible realizar operacion ya que su tarjeta registra deudas impagas".

Scenario outline: Cliente no registra movimientos en tarjeta de credito al solicitar aumento
	Given cliente <rut> consultado no registra movimientos en su tarjeta N° <tarjeta> desde <diasInactividad> días.
	When cliente <rut> solicita un aumento de cupo en su N° de tarjeta <tarjeta> al clickear en botón Aumentar Cupo. 
	Then No debe permitir avanzar en el proceso de aumento de tarjeta de credito y se despliega pop up "Su tarjeta se encuentra inactiva, favor dirigirse a la sucursal mas cercana".

Scenario outline: Cliente ha solicitado un aumento previamente al solicitar aumento
	Given cliente <rut> ha solicitado previamente un aumento de cupo en  N° <tarjeta>
	When al ingresar a la opcion Tarjetas/Aumento de Cupo se despliega pop up indicando que existe una solicitud de aumento realizada previamente
	Then Se debe cancelar la solicitud realizada previamente para poder solicitar nuevamente el aumento de cupo

Scenario outline: Cliente tiene un aumento de cupo pre aprobado al solicitar aumento
	Given cliente <rut> no ha aprobado aumento de cupo en  N° <tarjeta>
	When al ingresar a la opcion Tarjetas/Aumento de Cupo 
	Then Se debe rechazar o aceptar el aumento, sino, no debe permitir solicitud de aumento
    	And Se despliega pop up indicando que existe un aumento pre aprobado

Scenario outline: Cliente tiene tarjeta de crédito desactivada al solicitar aumento
	Given cliente <rut> tiene la tarjeta desactivada
    When al ingresar a la opcion Tarjetas/Aumento de Cupo 
    Then No es posible realizar solicitud de aumento de cupo

Scenario outline: Cliente tiene tarjeta de crédito bloqueada al solicitar aumento
	Given cliente <rut> tiene la tarjeta bloqueada
    When al ingresar a la opcion Tarjetas/Aumento de Cupo 
    Then No es posible realizar solicitud de aumento de cupo. 
    
Examples:
	|nombre|rut|tarjeta|
	|Usuario Test	|	173180160	|	3000857472  |
	
Examples:   
    |diasInactividad|
    |356|
    
Examples:
	|usuario|contraseña|
    |usertest	|	test123	|
    

    
