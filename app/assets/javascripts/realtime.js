window.easyDesign = {
	connect: function(){
		window.easyDesign.socket = io.connect('http://localhost:5000');
		window.easyDesign.socket.on('rt-change',function(data){
			console.log(data)
			//if(data.resource == "posts"){
				$.tmpl("templates/posts", data).prependTo('#actividades');	
			//}
			
		});
	}
}