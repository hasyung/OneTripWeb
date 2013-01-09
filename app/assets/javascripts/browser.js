(function(){
	jQuery.fn.checkbrowser = function(){
		this.each(function(){ 
			var deviceAgent = navigator.userAgent.toLowerCase();	
			var agentID = deviceAgent.match(/(iphone|ipad|android|windows nt|mac)/);
			var js1 = document.createElement("script");
					js1.src = "/Js/jplayer.playlist.min.js";
					js1.type = "text/javascript";
					
			var js2 = document.createElement("script");
					js2.src = "/Js/jplayer.playlist.js";
					js2.type = "text/javascript";
					
			if(agentID != null) {
				if(agentID.indexOf("iphone") >= 0 | agentID.indexOf("mac") >= 0 | agentID.indexOf("ipad") >= 0){  
					var css = document.createElement("link");
					css.href = "/Css/iphone.css";
					css.rel = "stylesheet";
					css.type = "text/css";
					$("head").append(css);
					
					$("head").append(js1);
				}
				else if(agentID.indexOf("android") >= 0){
					$("head").append(js2);
				}else if(agentID.indexOf("windows nt") >= 0){
					$("head").append(js1);
				}
			}
			else{
				$("head").append(js1);
			}
		});		
	};
})(jQuery);