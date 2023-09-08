component {

	/**
	 * Module events handler
	 */
	function invalidAuthenticationEvent( event, rc, prc ){
		event.setView( "main/invalidAuthenticationEvent" );
	}

	function invalidAuthorizationEvent( event, rc, prc ){
		event.setView( "main/invalidAuthorizationEvent" );
	}

}
