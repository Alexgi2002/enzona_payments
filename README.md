Documentación API Enzona (Java)

- Crear instancia de Enzona, y pasarle el consumer key y consumer secret del comercio:
Enzona enzona = new Enzona(consumer_key, consumer_secret );

- Crear una reservación de pago para hacer que el usuario pague usando el siguiente método:
	public Payment createPayment(PaymentRequest paymentRequest);
	Que espera un objeto de tipo PaymentRequest con los siguientes campos:
		private String merchant_uuid; → id del mercado.
    		private String description; → descripción de la transacción.
    		private String return_url; → url de retorno cuando el user efectue el 		pago.
		
		private String cancel_url; → url de retorno cuando el user cancele el 		pago.		
		
		private String currency; → enum CUP o CUC.
		private ArrayList<Product> items; → lista de productos a pagar por el 		user.
			Product(
				double price; → precio del producto
    				String name; → nombre del producto
    				String description; → descripción del producto
			)

- Luego de crear el pago recibes un objeto Payment con los siguientes campos:
	String transaction_uuid; → campo importante que define el id de la 	transacción.
    	
	int status_code;
    	Currency currency; → enum CUP o CUC
    	String status_denom; → Tipos de estados que pueden ser según la API
		- Pendiente
    		- Fallida
    		- Confirmada
    		- Aceptada
    	
	String description;
    	String merchant_op_id; → id de la operación (sin uso)
    	double price_total; → precio total a pagar
    	ArrayList<Product> items; → lista de productos
    	ArrayList<Link> links; → lista de links para procedimientos

- Deberás usar el link con valor “rel” = “confirm”, que normalmente es el primero con aspecto similar a este:
	https://www.enzona.net/checkout/01b5aebd41d1ec436ca92bb707fe8d009e/login

- Esto redirige al usuario a la plataforma de Enzona a proceder al pago.
- Una vez en esta dirección si el usuario cancela el pago la plataforma redirige hacia la url que se haya puesto en “cancel_url”, de lo contrario si el usuario realiza bien el pago redirige a la url con el valor en “return_url” (ya queda por parte de la app mostrar un webview y capturar los redirect o mostrar una url válida en caso de disponer de ella). 
- Luego puede hacer uso de el método
	public Payment getPayment(String transaction_uuid)
	*para comprobar el estado de el pago, devolviendo el objeto Payment antes descrito.

- Luego de que se realice el pago debe usar el método
    public boolean completePayment(String transaction_uuid)
	*para completar y cerrar la transacción

- Puede hacer uso del método cancelPayment para cerrar cualquier transacción que el usuario decida no hacer y no haya cancelado desde la plataforma
    public boolean cancelPayment(String transaction_uuid)
    