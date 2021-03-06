<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>UsaProxy session report - ${session.timestamp?datetime} - ${session.id}</title>

		<!-- Augmentations and utils -->        
        <script src="js/utils.js" type="text/javascript"></script>
        
        <!-- jQuery UI CSS -->
        <link type="text/css" href="js/jquery-ui-1.8.20.custom/css/sunny/jquery-ui-1.8.20.custom.css" rel="Stylesheet" />
        
        <!-- Our very own CSS -->
		<link type="text/css" href="css/session-report.css" rel="Stylesheet" />
		
		<!-- jQuery and jQuery UI -->
        <script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
        <script src="js/jquery-ui-1.8.20.custom/js/jquery-ui-1.8.20.custom.min.js" type="text/javascript"></script>
        
        <!-- Flot and flot plugins -->
        <script src="js/flot-0.7/jquery.flot.min.js" type="text/javascript"></script>
        <script src="js/flot-0.7/jquery.flot.fillbetween.custom.js" type="text/javascript"></script>
        <script src="js/flot-0.7/jquery.mousewheel.min.js" type="text/javascript"></script>
        <script src="js/flot-0.7/jquery.flot.navigate.js" type="text/javascript"></script>
        
        <!-- UsaProxy session data from the log file -->
        <script type="text/javascript">
        	var USAPROXYREPORT = {};
        	USAPROXYREPORT.session = ${session.data};
        </script>
        
        <!-- Our very own JS -->
        <script src="js/main.js" type="text/javascript"></script>
    </head>
    <body>
    	<div id="outerMask">
			<div id="outerContainer">
				<div id="leftBar">
					<div id="header">
						<h1>UsaProxy session report</h1>
						<ul id="header-list" class="ui-corner-right">
							<li>
								<span class="list-title">Started at</span>
								<span class="list-content">${session.timestamp?datetime}</span>
							</li>
							<li>
								<span class="list-title">Session ID</span>
								<span class="list-content">${session.id}</span>
							</li>
							<li>
								<span class="list-title">IP address</span>
								<span class="list-content">${session.ip}</span>
							</li>
						</ul>
					</div>
					<div id="httpTraffic">
						<h2>HTTP traffic</h2>
						<ul id="httpTraffic-list" class="ui-corner-right">
							<#list session.httpTraffics as httpTraffic>
								<li class="trafficlistitem" id="${httpTrafficListIdPrefix}${httpTraffic.sessionID?string("0")}">
									<span class="list-content">${(httpTraffic.entry.timestamp?datetime)!"N/A"}</span>
									<span class="list-sub-content">${httpTraffic.url}</span>
								</li>
								<script type="text/javascript">
									$( document ).ready( function()
									{
										$( "#${httpTrafficListIdPrefix}${httpTraffic.sessionID?string("0")}" )
											.one( 'click', function()
											{
												$( '#${placeholderIdPrefix}${httpTraffic.sessionID?string("0")}' ).show();
												$( document ).trigger( 'init-plot', 
													[ ${httpTraffic.sessionID?string("0")}, 
													document.getElementById('${placeholderIdPrefix}${httpTraffic.sessionID?string("0")}') ] );
												USAPROXYREPORT.visiblePlot = ${httpTraffic.sessionID?string("0")};
											} )
											.click( function()
											{
												$( '.placeholder' ).hide();
												$( '#${placeholderIdPrefix}${httpTraffic.sessionID?string("0")}' ).show();
												$( '.trafficlistitem' ).removeClass( 'selected' );
												$( this ).addClass( 'selected' );
												USAPROXYREPORT.visiblePlot = ${httpTraffic.sessionID?string("0")};
											} )
											.css( {
	                            				cursor: 'pointer'
	                        				} )
	                        				.hover( function()
	                        				{
	                        					$( this ).toggleClass( 'hilight' );
	                        				} );
									} );
								</script>
							</#list>
						</ul>
					</div>
				</div>
				<div id="rightContentMask">
					<div id="rightContent">
						<div id="controls">
							<span id="toolbar" class="ui-corner-all">
								<button id="filters" title="Manage element filters">Filters</button>
								<button id="reset" title="Reset the plot">Reset</button>
								<button id="headers" title="Show HTTP headers">HTTP headers</button>
								<input type="checkbox" id="autoload" /><label for="autoload">Auto-load images</label>
							</span>
						</div>
						<div id="placeholders">
							<#list session.httpTraffics as httpTraffic>
								<div class="placeholder" id="${placeholderIdPrefix}${httpTraffic.sessionID?string("0")}"></div>
							</#list>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>