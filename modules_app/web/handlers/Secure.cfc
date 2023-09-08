/**
 * The main module handler
 */
component secured {

	/**
	 * Module EntryPoint
	 */
	function index( event, rc, prc ){
		event.setView( "secure/index" );
	}

}
