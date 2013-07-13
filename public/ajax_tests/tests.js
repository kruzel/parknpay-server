$(document).ready(function() {

	var token = null;
	var user_id = null;

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
			data: {user:{email:"ee@ee.com", password:"qwerasdf"}},
			success: function(data, textStatus, jqXHR) {
                $("#result").text(data.session.auth_token);
				
				token = data.session.auth_token;
			},
			error: function(jqXHR, textStatus, errorThrown) {
				console.log(jqXHR, textStatus, errorThrown);
				$("#result").text(jQuery.parseJSON(jqXHR.responseText));
		   }
		});
	});
	
	$("#cities_index").click(function() {
		$.ajax({
			url: "http://ozpark.com.au/api/v1/cities.json?auth_token=" + token,
			dataType: "json",
			type: "get",
			cache: false,
			success: function(data, textStatus, jqXHR) {
                $("#result").text(data);
			},
			error: function(jqXHR, textStatus, errorThrown) {
				$("#result").text(textStatus+" "+jQuery.parseJSON(jqXHR.responseText));
		   }
		});
	});
	
	$("#cities_rates").click(function() {
		$.ajax({
			url: "http://ozpark.com.au/api/v1/cities/get_rates.json?auth_token=" + token,
			dataType: "json",
			type: "get",
			cache: false,
			success: function(data, textStatus, jqXHR) {
                $("#result").text(data);
			},
			error: function(jqXHR, textStatus, errorThrown) {
				$("#result").text(textStatus+" "+jQuery.parseJSON(jqXHR.responseText));
		   }
		});
	});
});