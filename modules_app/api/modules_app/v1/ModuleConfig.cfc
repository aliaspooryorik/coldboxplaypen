/**
Module Directives as public properties
this.title              				= "Title of the module";
this.author             			= "Author of the module";
this.webURL             			= "Web URL for docs purposes";
this.description        		= "Module description";
this.version            			= "Module Version";
this.viewParentLookup     = (true) [boolean] (Optional) // If true, checks for views in the parent first, then it the module.If false, then modules first, then parent.
this.layoutParentLookup = (true) [boolean] (Optional) // If true, checks for layouts in the parent first, then it the module.If false, then modules first, then parent.
this.entryPoint          		= "" (Optional) // If set, this is the default event (ex:forgebox:manager.index) or default route (/forgebox) the framework
									       will use to create an entry link to the module. Similar to a default event.
this.cfmapping     			= "The CF mapping to create";
this.modelNamespace		= "The namespace to use for registered models, if blank it uses the name of the module."
this.dependencies   		= "The array of dependencies for this module"

structures to create for configuration
- parentSettings : struct (will append and override parent)
- settings : struct
- interceptorSettings : struct of the following keys ATM
	- customInterceptionPoints : string list of custom interception points
- interceptors : array
- layoutSettings : struct (will allow to define a defaultLayout for the module)
- routes : array Allowed keys are same as the addRoute() method of the SES interceptor.
- wirebox : The wirebox DSL to load and use

Available objects in variable scope
- controller
- appMapping (application mapping)
- moduleMapping (include,cf path)
- modulePath (absolute path)
- log (A pre-configured logBox logger object for this object)
- binder (The wirebox configuration binder)
- wirebox (The wirebox injector)

Required Methods
- configure() : The method ColdBox calls to configure the module.

Optional Methods
- onLoad() 		: If found, it is fired once the module is fully loaded
- onUnload() 	: If found, it is fired once the module is unloaded

*/
component {

	// Module Properties
	this.title              = "v1";
	this.author             = "";
	this.webURL             = "";
	this.description        = "";
	this.version            = "1.0.0";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup   = true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint         = "v1";
	// Inherit entry point from parent, so this will be /api/v1
	this.inheritEntryPoint  = true;
	// Model Namespace
	this.modelNamespace     = "v1";
	// CF Mapping
	this.cfmapping          = "v1";
	// Auto-map models
	this.autoMapModels      = true;
	// Module Dependencies
	this.dependencies       = [];

	function configure(){
		// parent settings
		parentSettings = {};

		// module settings - stored in modules.name.settings
		settings = {
			// CB Security Module Settings
			cbsecurity : {
				firewall : {
					// Module Relocation when an invalid access is detected, instead of each rule declaring one.
					"invalidAuthenticationEvent"  : "v1:Auth.notauthenticated",
					// Default Auhtentication Action: override or redirect when a user has not logged in
					"defaultAuthenticationAction" : "override",
					// Module override event when an invalid access is detected, instead of each rule declaring one.
					"invalidAuthorizationEvent"   : "api:Auth.notauthorised",
					// Default invalid action: override or redirect when an invalid access is detected, default is to redirect
					"defaultAuthorizationAction"  : "override",
					// The validator to use for this module
					"validator"                   : "JwtAuthValidator@cbsecurity",
					// Inline rules
					// "rules"                       : [ { "secureList" : "api:Secure\.*" } ],
					// Full rules
					// or a simple array of inline rules
					// "rules"                       : {
					// 	// Use regular expression matching on the rule match types
					// 	"useRegex" : true,
					// 	// Force SSL for all relocations
					// 	"useSSL"   : false,
					// 	// A collection of default name-value pairs to add to ALL rules
					// 	// This way you can add global roles, permissions, redirects, etc
					// 	"defaults" : {},
					// 	// You can store all your rules in this inline array
					// 	"inline"   : [],
					// 	// If you don't store the rules inline, then you can use a provider to load the rules
					// 	// The source can be a json file, an xml file, model, db
					// 	// Each provider can have it's appropriate properties as well. Please see the documentation for each provider.
					// 	"provider" : { "source" : "", "properties" : {} }
					// }
				}
			}
		};

		// Layout Settings
		layoutSettings = { defaultLayout : "" };

		// SES Routes: config/Router.cfc

		// Custom Declared Points
		interceptorSettings = { customInterceptionPoints : "" };

		// Custom Declared Interceptors
		interceptors = [];

		// Binder Mappings
		// binder.map("Alias").to("#moduleMapping#.model.MyService");
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
