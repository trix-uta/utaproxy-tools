;(function( UsaProxy, document, window, $, undefined ) {
	
	var className = 'usaproxy-highlight-plugin-highlight';
	
	UsaProxy.plugins.highlight = {
		setup : function() {},
		events : [ {
		          bindTo : function() { 
		        	  return $( UsaProxy.pluginConfigurations.highlight.selector ).get(); },
		          events : function() { 
		        	  return [ 'click' ]; },
		          onTrigger : function( event ) {
		        	  var element = event.target;
		        	  var jqElement = $( element );
		        	  jqElement.toggleClass( className );
		        	  return {
		        		  highlight: jqElement.hasClass( className ) ? 'on' : 'off',
		        		  highlightId : element.id,
		        		  highlightBottom : parseInt( jqElement.offset().top ) + 
		        		  jqElement.innerHeight(),
		        		  highlightTop : parseInt( jqElement.offset().top ),
		        		  highlightContents : element.innerHTML
		        	  }; }
		}
		]	
	};
} )( UsaProxy, document, window, UsaProxy.jQuery );