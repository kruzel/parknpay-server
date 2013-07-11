$(document).ready(function() {

	var token = null;

	$("#user_add").click(function() {
		$.ajax({
			url: "http://ozpark.com.au/users.json",
			dataType: "json",
			type: "post",
			cache: false,
			data: { user: { email: "lyi@au.au", password: "qwerasdf", password_confirmation: "qwerasdf", firstname: "aa", lastname: "aa" }},
			success: function( data, textStatus, jqXHR ) {
                $("#result").text(textStatus);
			},
			error: function(jqXHR, textStatus, errorThrown) {
				$("#result").text("error");
		   }
		});
	});
	
	$("#user_logout").click(function() {
		$.ajax({
			url: "http://ozpark.com.au/users/sign_out.json/"+token,
			dataType: "json",
			type: "delete	",
			cache: false,
		   success: function(data, textStatus, jqXHR) {
				$("#result").text(textStatus);
			},
			error: function(jqXHR, textStatus, errorThrown) {
				$("#result").text(textStatus);
		   }
		});
	});
	
	$("#user_login").click(function() {
		$.ajax({
			url: "http://ozpark.com.au/users/sign_in.json",
			dataType: "json",
			type: "post",
			cache: false,
			data: {user:{email:"lior@au.au", password:"qwerasdf"}},
			success: function(data, textStatus, jqXHR) {
                $("#result").text(data.session.auth_token);
				
				token = response.session.auth_token;
			},
			error: function(jqXHR, textStatus, errorThrown) {
				console.log(jqXHR, textStatus, errorThrown);
				$("#result").text(jQuery.parseJSON(jqXHR.responseText));
		   }
		});
	});
	
	$("#cities_index").click(function() {
		$.ajax({
			url: "http://ozpark.com.au/api/v1/cities.json",
			dataType: "json",
			type: "get",
			cache: false,
			data: { "auth_token": token },
			success: function(data, textStatus, jqXHR) {
                $("#result").text(textStatus);
			},
			error: function(jqXHR, textStatus, errorThrown) {
				$("#result").text(textStatus+" "+jQuery.parseJSON(jqXHR.responseText));
		   }
		});
	});
});