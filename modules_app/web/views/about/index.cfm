<cfoutput>
	<dl>
		<cfloop collection="#prc.internalModules#" item="moduleName">
			<cfset moduleSettings = prc.internalModules[ moduleName ] />
			<dt>#moduleSettings.title#</dt>
			<dd>#moduleSettings.description#</dd>
		</cfloop>
	</dl>
</cfoutput>