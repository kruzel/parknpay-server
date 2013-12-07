var _serverApi = null;

$(document).ready(function() {

	_serverApi = new serverApi();

	$("#user_add").click(function() {
		var data = { user: { email: "ofer.k3@downloadius.com", password: "qwerasdf", password_confirmation: "qwerasdf", firstname: "ofer", lastname: "kruzel" }};
		
		_serverApi.sign_up({data: data,
		    success: function(response) {
                $("#result").text(response);
            },
            error: function(errorThrown) {
                $("#result").text(errorThrown);
            }
        });
	});
	
	$("#user_logout").click(function() {	
		_serverApi.sign_out({
		    success: function(response) {
                $("#result").text(response);
            },
            error: function(errorThrown) {
                $("#result").text(errorThrown);
            }
        });
	});
	
	$("#user_login").click(function() {
		var data = {user:{email:"ofer.k@downloadius.com", password:"qwerasdf"}}
		
		_serverApi.sign_in({data: data,
		    success: function(response) {
                $("#result").text(response);
            },
            error: function(errorThrown) {
                $("#result").text(errorThrown);
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
		_serverApi.get_rates({
		    success: function(response) {
                $("#result").text(response);
            },
            error: function(errorThrown) {
                $("#result").text(errorThrown);
            }
        });
	});
	
	$("#add_car").click(function() {
		var data = {car:{license_plate:"111112", car_description:"mazda 6"}};
		_serverApi.get_cars({data: data,
		    success: function(response) {
                $("#result").text(response);
            },
            error: function(errorThrown) {
                $("#result").text(errorThrown);
            }
        });
	});
	
	$("#get_cars").click(function() {
		_serverApi.get_cars({
		    success: function(response) {
                $("#result").text(response);
            },
            error: function(errorThrown) {
                $("#result").text(errorThrown);
            }
        });
	});

    $("#add_payment").click(function() {		
		var data = {payment:{area_id: 980190962, car_id: 980190962, start_time: "2013-9-3T1:11:25Z", user_id: 980190963, x_pos: 0, y_pos: 0}};
		
		_serverApi.add_payment({data: data,
		    success: function(response) {
                $("#result").text(response);
            },
            error: function(errorThrown) {
                $("#result").text(errorThrown);
            }
        });
    });

    $("#get_charge").click(function() {
        $.ajax({
            url: server_url + "/api/v1/payments/"+980190963+"/amount.json?auth_token=" + token,
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
	
	$("#get_area_by_street").click(function() {
		var city_name = "Haifa";
		var street_name = "Hazmaut";
		var data = { city_name: city_name, street_name: street_name };  
		
		_serverApi.find_by_street({data: data,
		    success: function(response) {
                $("#result").text(response);
            },
            error: function(errorThrown) {
                $("#result").text(errorThrown);
            }
        });
    });

    $("#get_free_spot").click(function() {
        var location = {lat: 32.790368, lon: 34.985574};
        var distance = 0.001;
        var time_delta = 120;
        var data = { location: location, distance: distance, time_delta: time_delta };

        _serverApi.get_free_spots({data: data,
            success: function(response) {
                $("#result").text(response);
            },
            error: function(errorThrown) {
                $("#result").text(errorThrown);
            }
        });
    });
});