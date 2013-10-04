$(document).ready(function() {

	//var server_url = "http://ozpark.com.au";
    var server_url = "http://localhost:3000";
	var token = null;
	var user_id = null;

	$("#user_add").click(function() {
		$.ajax({
			url: server_url + "/users.json",
			dataType: "json",
			type: "post",
			cache: false,
			data: { user: { email: "okruzel@gmail.com", password: "qwerasdf", password_confirmation: "qwerasdf", firstname: "ofer", lastname: "kruzel" }},
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
			data: {user:{email:"okruzel@gmail.com", password:"qwerasdf"}},
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

    $("#add_payment").click(function() {
        $.ajax({
            url: server_url + "/api/v1/payments.json?auth_token=" + token,
            dataType: "json",
            type: "post",
            data: {payment:{area_id: 1000, rate_id:1, start_time: "2013-9-3T1:11:25Z", user_id: 7, x_pos: 0, y_pos: 0}},
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