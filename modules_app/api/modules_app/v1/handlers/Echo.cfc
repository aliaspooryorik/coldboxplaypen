/**
 * My RESTFul Event Handler
 */
component extends="coldbox.system.RestHandler" {

	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only      = "";
	this.prehandler_except    = "";
	this.posthandler_only     = "";
	this.posthandler_except   = "";
	this.aroundHandler_only   = "";
	this.aroundHandler_except = "";

	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};

	/**
	 * Say Hello
	 *
	 * @x        -route (GET) /api/v1/echo
	 * @response -default ~api/v1/echo/index/responses.json##200
	 */
	function index( event, rc, prc ){
		event.getResponse().setData( "Welcome to my ColdBox RESTFul Service" );
	}


	/**
	 * A secured route that shows you your information
	 *
	 * @route    (GET) /api/v1/whoami
	 * @security bearerAuth,ApiKeyAuth
	 * @response -default ~api/v1/echo/whoami/responses.json##200
	 * @response -401 ~api/v1/echo/whoami/responses.json##401
	 */
	function whoami( event, rc, prc ) secured{
		event.getResponse().setData( jwtAuth().getUser().getMemento() );
	}

}
