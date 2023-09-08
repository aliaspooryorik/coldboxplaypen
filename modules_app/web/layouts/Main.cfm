<cfoutput>
<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Bootstrap demo</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	</head>
	<body>
		<div class="container">
			<!-- Content here -->
			<nav class="navbar navbar-expand-lg bg-body-tertiary">
				<div class="container-fluid">
				  <a class="navbar-brand" href="#event.buildLink( "" )#">Home</a>
				  <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="##navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				  </button>
				  <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
					<div class="navbar-nav">
					  <a class="nav-link" href="#event.buildLink( "web:secure" )#">Secure</a>
					  <a class="nav-link" href="#event.buildLink( "api:v1" )#">API v1</a>

					  <li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="##" role="button" data-bs-toggle="dropdown" aria-expanded="false">
						  Dev tools
						</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="#event.buildLink( "route-visualizer" )#">route visualizer</a></li>
							<li><a class="dropdown-item" href="#event.buildLink( "cbdebugger" )#">cbdebugger</a></li>
							<li><a class="dropdown-item" href="#event.buildLink( "cbswagger" )#">cbswagger</a></li>
						</ul>
					  </li>

					</div>
				  </div>
				</div>
			  </nav>

			<h1>Hello from web module layout!</h1>
			#view()#
		</div>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
	</body>
</html>
</cfoutput>