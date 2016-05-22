$(document).ready(function){
	
	('.carousel slide').carousel({

		interval:3000;
	});
}

dispatcher.on_open = function(data) {  
  console.log('Connection has been established: ', data);
  dispatcher.trigger('hello', 'Hello, there!');
}

var channel = dispatcher.subscribe('updates');  
channel.bind('update', function(count) {  
  $('#count').text(count);
});
