component extends="coldbox.system.EventHandler" {

	function index( event, rc, prc ) {
		prc.internalModules = getSetting( "Modules" ).filter( function( moduleName, moduleSettings ) {
			return listFirst( moduleSettings.invocationPath, "." ) == "modules_app";
		} );
		event.setView( "about/index" );
	}

}
