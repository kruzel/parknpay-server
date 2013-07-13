$(document).ready(function() {

	var server_url = "http://ozpark.com.au";
    //var server_url = "http://localhost:3000";
	var token = null;
	var user_id = null;

	$("#user_add").click(function() {
		$.ajax({
			url: server_url + "/users.json",
			dataType: "json",
			type: "post",
			cache: false,
			data: { user: { email: "ee1@ee1.com", password: "qwerasdf", password_confirmation: "qwerasdf", firstname: "ee1", lastname: "ee1" }},
			success: function( response, textStatus, jqXHR ) {
                $("#result").text(textStatus);
			},
			error: function(jqXHR, textStatus, errorThrown) {
				$("#result").text("error");
		   }
		});
	});
	
	$("#user_logout").click(function() {
		$.ajax({
			url: server_url + "/users/sign_out.json/"+token,
			dataType: "json",
			type: "delete	",
			cache: false,
		   success: function(response, textStatus, jqXHR) {
				$("#result").text(textStatus);
			},
			error: function(jqXHR, textStatus, errorThrown) {
				$("#result").text(textStatus);
		   }
		});
	});
	
	$("#user_login").click(function() {
		$.ajax({
			url: server_url + "/users/sign_in.json",
			dataType: "json",
			type: "post",
			cache: false,
			data: {user:{email:"ee@ee.com", password:"qwerasdf"}},
			success: function(response, textStatus, jqXHR) {
                $("#result").text(response.session.auth_token);
				
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
			url: server_url + "/api/v1/cities.json?auth_token=" + token,
			dataType: "json",
			type: "get",
			cache: false,
			success: function(response, textStatus, jqXHR) {
                $("#result").text(response);
			},
			error: function(jqXHR, textStatus, errorThrown) {
				$("#result").text(textStatus+" "+jQuery.parseJSON(jqXHR.responseText));
		   }
		});
	});
	
	$("#cities_rates").click(function() {
		$.ajax({
			url: server_url + "/api/v1/cities/get_rates.json?auth_token=" + token,
			dataType: "json",
			type: "get",
			cache: false,
			success: function(response, textStatus, jqXHR) {
                $("#result").text(response);
			},
			error: function(jqXHR, textStatus, errorThrown) {
				$("#result").text(textStatus+" "+jQuery.parseJSON(jqXHR.responseText));
		   }
		});
	});
	
	$("#add_car").click(function() {
		$.ajax({
			url: server_url + "/api/v1/users/0/cars.json?auth_token=" + token,
			dataType: "json",
			type: "post",
			data: {car:{license_plate:"111111", car_description:"mazda 6"}},
			cache: false,
			success: function(response, textStatus, jqXHR) {
                $("#result").text(response);
			},
			error: function(jqXHR, textStatus, errorThrown) {
				$("#result").text(textStatus+" "+jQuery.parseJSON(jqXHR.responseText));
		   }
		});
	});
	
	$("#get_cars").click(function() {
		$.ajax({
			url: server_url + "/api/v1/users/0/cars.json?auth_token=" + token,
			dataType: "json",
			type: "get",
			cache: false,
			success: function(response, textStatus, jqXHR) {
                $("#result").text(response);
			},
			error: function(jqXHR, textStatus, errorThrown) {
				$("#result").text(textStatus+" "+jQuery.parseJSON(jqXHR.responseText));
		   }
		});
	});
});