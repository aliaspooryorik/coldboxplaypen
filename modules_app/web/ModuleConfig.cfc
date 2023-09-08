/**
 * Module Directives as public properties
 *
 * this.title 				= "Title of the module";
 * this.author 			= "Author of the module";
 * this.webURL 			= "Web URL for docs purposes";
 * this.description 		= "Module description";
 * this.version 			= "Module Version";
 * this.viewParentLookup   = (true) [boolean] (Optional) // If true, checks for views in the parent first, then it the module.If false, then modules first, then parent.
 * this.layoutParentLookup = (true) [boolean] (Optional) // If true, checks for layouts in the parent first, then it the module.If false, then modules first, then parent.
 * this.entryPoint  		= "" (Optional) // If set, this is the default event (ex:forgebox:manager.index) or default route (/forgebox) the framework will use to create an entry link to the module. Similar to a default event.
 * this.cfmapping			= "The CF mapping to create";
 * this.modelNamespace		= "The namespace to use for registered models, if blank it uses the name of the module."
 * this.dependencies 		= "The array of dependencies for this module"
 *
 * structures to create for configuration
 * - parentSettings : struct (will append and override parent)
 * - settings : struct
 * - interceptorSettings : struct of the following keys ATM
 * 	- customInterceptionPoints : string list of custom interception points
 * - interceptors : array
 * - layoutSettings : struct (will allow to define a defaultLayout for the module)
 * - wirebox : The wirebox DSL to load and use
 *
 * Available objects in variable scope
 * - controller
 * - appMapping (application mapping)
 * - moduleMapping (include,cf path)
 * - modulePath (absolute path)
 * - log (A pre-configured logBox logger object for this object)
 * - binder (The wirebox configuration binder)
 * - wirebox (The wirebox injector)
 *
 * Required Methods
 * - configure() : The method ColdBox calls to configure the module.
 *
 * Optional Methods
 * - onLoad() 		: If found, it is fired once the module is fully loaded
 * - onUnload() 	: If found, it is fired once the module is unloaded
 **/
component {

	// Module Properties
	this.title              = "web";
	this.author             = "";
	this.webURL             = "";
	this.description        = "";
	this.version            = "1.0.0";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup   = true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint         = "web";
	// Inherit Entry Point
	this.inheritEntryPoint  = false;
	// Model Namespace
	this.modelNamespace     = "web";
	// CF Mapping
	this.cfmapping          = "";
	// Auto-map models
	this.autoMapModels      = true;
	// Module Dependencies
	this.dependencies       = [ "cbauth", "cbsecurity" ];

	/**
	 * Configure the module
	 */
	function configure(){
		// parent settings
		parentSettings = {};

		// module settings - stored in modules.name.settings
		settings = {
			/**
			 * --------------------------------------------------------------------------
			 * Authentication Services
			 * --------------------------------------------------------------------------
			 * https://coldbox-security.ortusbooks.com/getting-started/configuration/authentication
			 *
			 * Here you will configure which service is in charge of providing authentication for your application.
			 * By default we leverage the cbauth module which expects you to connect it to a database via your own User Service.
			 *
			 * Available authentication providers:
			 * - cbauth : Leverages your own UserService that determines authentication and user retrieval
			 * - basicAuth : Leverages basic authentication and basic in-memory user registration in our configuration
			 * - custom : Any other service that adheres to our IAuthService interface
			 */
			authentication : {
				// The WireBox ID of the auth service to use which must adhere to the cbsecurity.interfaces.IAuthService interface.
				"provider"        : "authenticationService@cbauth",
				// The name of the variable to use to store an authenticated user in prc scope on all incoming authenticated requests
				"prcUserVariable" : "oCurrentUser"
			},
			/**
			 * --------------------------------------------------------------------------
			 * Basic Auth
			 * --------------------------------------------------------------------------
			 * https://coldbox-security.ortusbooks.com/getting-started/configuration/basic-auth
			 *
			 * If you are using the basicAuth authentication provider, then you can configure it here, else ignore or remove.
			 */
			basicAuth : {
				// Hashing algorithm to use
				hashAlgorithm  : "SHA-512",
				// Iterates the number of times the hash is computed to create a more computationally intensive hash.
				hashIterations : 5,
				// User storage: The `key` is the username. The value is the user credentials that can include
				// { roles: "", permissions : "", firstName : "", lastName : "", password : "" }
				users          : {}
			},
			/**
			 * --------------------------------------------------------------------------
			 * Firewall Settings
			 * --------------------------------------------------------------------------
			 * https://coldbox-security.ortusbooks.com/getting-started/configuration/firewall
			 *
			 * The firewall is used to block/check access on incoming requests via security rules or via annotation on handler actions.
			 * Here you can configure the operation of the firewall and especially what Validator will be in charge of verifying authentication/authorization
			 * during a matched request.
			 */
			firewall : {
				// The Global validator is an object that will validate the firewall rules and annotations and provide feedback on either authentication or authorization issues.
				"validator"                   : "JwtAuthValidator@cbsecurity",
				// The global invalid authentication event or URI or URL to go if an invalid authentication occurs
				"invalidAuthenticationEvent"  : "web:Main.onAuthenticationFailure",
				// The global invalid authorization event or URI or URL to go if an invalid authorization occurs
				"invalidAuthorizationEvent"   : "web:Main.onAuthorizationFailure"
			},
			/**
			 * --------------------------------------------------------------------------
			 * Security Headers
			 * --------------------------------------------------------------------------
			 * https://coldbox-security.ortusbooks.com/getting-started/configuration/security-headers
			 *
			 * This section is the way to configure cbsecurity for header detection, inspection and setting for common
			 * security exploits like XSS, ClickJacking, Host Spoofing, IP Spoofing, Non SSL usage, HSTS and much more.
			 */
			securityHeaders : {
				// If you trust the upstream then we will check the upstream first for specific headers
				"trustUpstream"         : false,
				// Content Security Policy
				// Content Security Policy (CSP) is an added layer of security that helps to detect and mitigate certain types of attacks,
				// including Cross-Site Scripting (XSS) and data injection attacks. These attacks are used for everything from data theft, to
				// site defacement, to malware distribution.
				// https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP
				"contentSecurityPolicy" : {
					// Disabled by defautl as it is totally customizable
					"enabled" : false,
					// The custom policy to use, by default we don't include any
					"policy"  : ""
				},
				// The X-Content-Type-Options response HTTP header is a marker used by the server to indicate that the MIME types advertised in
				// the Content-Type headers should be followed and not be changed => X-Content-Type-Options: nosniff
				// https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Content-Type-Options
				"contentTypeOptions" : { "enabled" : true },
				"customHeaders"      : {
					 // Name : value pairs as you see fit.
				},
				// Disable Click jacking: X-Frame-Options: DENY OR SAMEORIGIN
				// https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options
				"frameOptions" : { "enabled" : true, "value" : "SAMEORIGIN" },
				// HTTP Strict Transport Security (HSTS)
				// The HTTP Strict-Transport-Security response header (often abbreviated as HSTS)
				// informs browsers that the site should only be accessed using HTTPS, and that any future attempts to access it
				// using HTTP should automatically be converted to HTTPS.
				// https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Strict-Transport-Security,
				"hsts"         : {
					"enabled"           : true,
					// The time, in seconds, that the browser should remember that a site is only to be accessed using HTTPS, 1 year is the default
					"max-age"           : "31536000",
					// See Preloading Strict Transport Security for details. Not part of the specification.
					"preload"           : false,
					// If this optional parameter is specified, this rule applies to all of the site's subdomains as well.
					"includeSubDomains" : false
				},
				// Validates the host or x-forwarded-host to an allowed list of valid hosts
				"hostHeaderValidation" : {
					"enabled"      : false,
					// Allowed hosts list
					"allowedHosts" : ""
				},
				// Validates the ip address of the incoming request
				"ipValidation" : {
					"enabled"    : false,
					// Allowed IP list
					"allowedIPs" : ""
				},
				// The Referrer-Policy HTTP header controls how much referrer information (sent with the Referer header) should be included with requests.
				// Aside from the HTTP header, you can set this policy in HTML.
				// https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Referrer-Policy
				"referrerPolicy"     : { "enabled" : true, "policy" : "same-origin" },
				// Detect if the incoming requests are NON-SSL and if enabled, redirect with SSL
				"secureSSLRedirects" : { "enabled" : false },
				// Some browsers have built in support for filtering out reflected XSS attacks. Not foolproof, but it assists in XSS protection.
				// https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-XSS-Protection,
				// X-XSS-Protection: 1; mode=block
				"xssProtection"      : { "enabled" : true, "mode" : "block" }
			},
			/**
			 * --------------------------------------------------------------------------
			 * Cross Site Request Forgery (CSRF)
			 * --------------------------------------------------------------------------
			 * https://coldbox-security.ortusbooks.com/getting-started/configuration/csrf
			 *
			 * This section is the way to configure cbsecurity for CSRF detection and mitigation.
			 */
			csrf : {
				// By default we load up an interceptor that verifies all non-GET incoming requests against the token validations
				enableAutoVerifier     : false,
				// A list of events to exclude from csrf verification, regex allowed: e.g. stripe\..*
				verifyExcludes         : [],
				// By default, all csrf tokens have a life-span of 30 minutes. After 30 minutes, they expire and we aut-generate new ones.
				// If you do not want expiring tokens, then set this value to 0
				rotationTimeout        : 30,
				// Enable the /cbcsrf/generate endpoint to generate cbcsrf tokens for secured users.
				enableEndpoint         : false,
				// The WireBox mapping to use for the CacheStorage
				cacheStorage           : "CacheStorage@cbstorages",
				// Enable/Disable the cbAuth login/logout listener in order to rotate keys
				enableAuthTokenRotator : true
			}
		};

		// Layout Settings
		layoutSettings = { defaultLayout : "" };

		// Custom Declared Points
		interceptorSettings = { customInterceptionPoints : [] };

		// Custom Declared Interceptors
		interceptors = [];

		// Binder Mappings
		// binder.map("Alias").to("#moduleMapping#.models.MyService");
	}

	/**
	 * Fired when the module is registered and activated.
	 */
	function onLoad(){
	}

	/**
	 * Fired when the module is unregistered and unloaded
	 */
	function onUnload(){
	}

}
