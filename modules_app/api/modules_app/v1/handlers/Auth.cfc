/**
 * Authentication Handler
 */
component extends="coldbox.system.RestHandler" {

	// Injection
	property name="userService" inject="UserService";

	/**
	 * Login a user into the application
	 *
	 * @x-route          (POST) /api/v1/login
	 * @requestBody      ~api/v1/auth/login/requestBody.json
	 * @response-default ~api/v1/auth/login/responses.json##200
	 * @response-401     ~api/v1/auth/login/responses.json##401
	 */
	function login( event, rc, prc ){
		param rc.username = "";
		param rc.password = "";

		// This can throw a InvalidCredentials exception which is picked up by the REST handler
		var token = jwtAuth().attempt( rc.username, rc.password );

		event
			.getResponse()
			.setData( token )
			.addMessage(
				"Bearer token created and it expires in #jwtAuth().getSettings().jwt.expiration# minutes"
			);
	}

	/**
	 * Register a new user in the system
	 *
	 * @x-route          (POST) /api/v1/register
	 * @requestBody      ~api/v1/auth/register/requestBody.json
	 * @response-default ~api/v1/auth/register/responses.json##200
	 * @response-400     ~api/v1/auth/register/responses.json##400
	 */
	function register( event, rc, prc ){
		param rc.firstName = "";
		param rc.lastName  = "";
		param rc.username  = "";
		param rc.password  = "";

		// Populate, Validate, Create a new user
		prc.oUser = userService.create( populateModel( "User" ).validateOrFail() );

		// Log them in if it was created!
		event
			.getResponse()
			.setData( {
				"token" : jwtAuth().fromuser( prc.oUser ),
				"user"  : prc.oUser.getMemento()
			} )
			.addMessage(
				"User registered correctly and Bearer token created and it expires in #jwtAuth().getSettings().jwt.expiration# minutes"
			);
	}

	/**
	 * Logout a user
	 *
	 * @x-route          (POST) /api/v1/logout
	 * @security         bearerAuth,ApiKeyAuth
	 * @response-default ~api/v1/auth/logout/responses.json##200
	 * @response-500     ~api/v1/auth/logout/responses.json##500
	 */
	function logout( event, rc, prc ){
		jwtAuth().logout();
		event.getResponse().addMessage( "Successfully logged out" )
	}

	/**
	 * Logout a user
	 *
	 * @x-route          (GET) /api/v1/auth/notauthorised
	 * @security         bearerAuth,ApiKeyAuth
	 * @response-default ~api/v1/auth/logout/responses.json##200
	 * @response-500     ~api/v1/auth/logout/responses.json##500
	 */
	function notauthorised( event, rc, prc ){
		event.getResponse()
			.setData( { "resource": prc.currentRoutedURL } )
			.setStatusCode( 403 )
			.addMessage( "You are not authorised to access the resource" );
	}

	/**
	 * Logout a user
	 *
	 * @x-route          (GET) /api/v1/auth/notauthenicated
	 * @security         bearerAuth,ApiKeyAuth
	 * @response-default ~api/v1/auth/logout/responses.json##200
	 * @response-500     ~api/v1/auth/logout/responses.json##500
	 */
	function notauthenicated( event, rc, prc ){
		event.getResponse()
			.setData( { "resource": prc.currentRoutedURL } )
			.setStatusCode( 403 )
			.addMessage( "You are not authenticated to access the resource" );
	}

}
