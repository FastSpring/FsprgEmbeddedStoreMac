$(function() {
	$("h1").each(function(i) {
		if(i == 0) return; // summary
		
		$(this).prepend("<a name='header_"+i+"'></a>");
		$("#summary").append("<a href='#header_"+i+"'>"+$(this).text()+"</a>");
		$("#summary").append($(this).next().text()+"<br/>");
	});
});