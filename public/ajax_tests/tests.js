$(document).ready(function() {

	var token = null;

	$("#user_add").click(function() {
		$.ajax({
			url: "http://localhost:3000/users/add.json",
			dataType: "json",
			type: "post",
			cache: false,
			data: {user: { email: "a@a.com", password: "qwerasdf", phone_number: "0541111111", group_id: "1" }},
			success: function(response) {
                console.log(response);
                $("#result").text(response);
			},
			error: function(jqXHR, textStatus, errorThrown) {
				console.log(jqXHR, textStatus, errorThrown);
				$("#result").text("error");
		   }
		});
	});
	
	$("#user_logout").click(function() {
		$.ajax({
			url: "http://localhost:3000/users/sign_out.json"+token,
			dataType: "json",
			type: "delete	",
			cache: false,
		   success: function(response) {
				console.log(response);
				$("#result").text(response);
			},
			error: function(jqXHR, textStatus, errorThrown) {
				console.log(jqXHR, textStatus, errorThrown);
				$("#result").text("error");
		   }
		});
	});
	
	$("#user_login").click(function() {
		$.ajax({
			url: "http://localhost:3000/users/sign_in.json",
			dataType: "json",
			type: "post",
			cache: false,
			data: {user:{email:"a@a.com", password:"qwerasdf"}},
			success: function(response) {
                console.log(response.session);
                $("#result").text(response.session.auth_token);
				
				token = response.session.auth_token;
			},
			error: function(jqXHR, textStatus, errorThrown) {
				console.log(jqXHR, textStatus, errorThrown);
				//console.log("error json: ",  jQuery.parseJSON(jqXHR.responseText));
				$("#result").text("error");
		   }
		});
	});
	
	$("#cities_index").click(function() {
		$.ajax({
			url: "http://localhost:3000/api/v1/cities.json",
			dataType: "json",
			type: "get",
			cache: false,
			data: { "auth_token": token },
			success: function(response) {
                console.log(response);
                $("#result").text(response);
			},
			error: function(jqXHR, textStatus, errorThrown) {
				console.log(jqXHR, textStatus, errorThrown);
				$("#result").text("error");
		   }
		});
	});
});