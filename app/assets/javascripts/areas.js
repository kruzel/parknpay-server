var city_id = null;
var city_name = null;
var poly, map;
var options = {};
var lineCounter_ = 0;
var shapeCounter_ = 0;
var markerCounter_ = 0;
var colorIndex_ = 0;
var featureTable_;
var city_center = null;

var marker_icon = 'static/marker.png';
var poly_array = [];
var currently_edited_poly;
  var markers = [];
  var bermudaTriangle;
  var path = new google.maps.MVCArray;
  var colorIndex_ = 0;

  var COLORS = [["red", "#ff0000"], ["orange", "#ff8800"], ["green","#008000"],
              ["blue", "#000080"], ["purple", "#800080"]];
    
  var json_data = null;
                    /*[{  "data" : "Sidney",
                      "metadata" : { "lat":24.88 , "lon":-70.26 },
                      "attr" : { "id" : "0"},
                       "children" : 
                       [ 
                            {
                               "data" :"Beach Area", 
                               "metadata" : { p : 
                                       [
                                           {"lat":25.774252, "lon":-80.190262}, 
                                           {"lat":18.464652, "lon":-66.118292}, 
                                           {"lat":32.321384, "lon":-64.75737}
                                       ]  },
                               "attr" : { "id" : "0"}
                           },
                           {
                               "data" :"Opera", 
                               "metadata" : {p : 
                                       [
                                           {"lat":26.774252, "lon":-82.190262}, 
                                           {"lat":17.4664652, "lon":-61.118292}, 
                                           {"lat":30.321384, "lon":-62.75737}
                                       ]  },
                               "attr" : { "id" : "1"  }
                           }
                       ] 
                    }];
*/

function set_city(new_city_id,new_city_name) {
    city_id = new_city_id;
    city_name = new_city_name;
}


$(document).ready(function(){
    initPage();

});

function initPage() {
    $.ajax({
        url: "/cities/"+city_id+"/areas.json",
        dataType: "json",
        type: "get",
        cache: false,
        success: function(response, textStatus, jqXHR)
        {
            json_data = server_jason_to_data_json(response);
            area_initialize();
        },
        error: function(jqXHR, textStatus, errorThrown)
        {
            console.log(jqXHR, textStatus, errorThrown);
            alert('failed loading areas data');
        }
    });
}
 
function getColor(named) 
{
  return COLORS[(colorIndex_++) % COLORS.length][named ? 0 : 1];
}

function updateMarker(marker, cells, opt_changeColor) 
{
  if (opt_changeColor) 
  {
    var color = getColor(true);
    marker.setImage(getIcon(color).image);
    cells.color.style.backgroundColor = color;
  }
  var latlng = marker.getPoint();
  cells.desc.innerHTML = "(" + Math.round(latlng.y * 100) / 100 + ", " +
  Math.round(latlng.x * 100) / 100 + ")";
}

//called with every property and it's value


function refresh_polygones()
{
    for (i=0;i<poly_array.length;i++)
    {
        poly_array[i].setMap(null);
    }
    poly_array = [];

    $.each(json_data[0].children, function(area_index, area_value) //for (area_index=0; area_index < json_data[0].children.length; area_index ++)
    {
        var mypath=[];
        $.each(area_value.metadata.p, function(point_index, point_value)  //for (point_index = 0; point_index < value.metadata.p.length;  point_index++)
        {
            mypath.push(new google.maps.LatLng(point_value.lat, point_value.lon));
        });
        var new_poly = new google.maps.Polygon({
            paths: mypath,
            strokeColor: '#FF0000',
            strokeOpacity: 0.8,
            strokeWeight: 3,
            fillColor: '#FF0000',
            fillOpacity: 0.35,
            indexID: area_index
        });

        poly_array [area_index] =  new_poly ;

        new_poly.setMap(map);

        google.maps.event.addListener(new_poly, 'click', function()
        {
                     console.log(" area " + this.indexID);
                     $.jstree._reference(areasTree).deselect_all();
                     $.jstree._reference(areasTree).select_node("#"+(this.indexID),false,true);
          });
        google.maps.event.addListener(new_poly, 'mouseup', function()
        {

                     console.log(" dragend " + (this.indexID));
                      var vertices = poly_array [this.indexID].getPath();
                      // Iterate over the vertices.
                      var contentString="\n";
                      var p = [];
                      for (var i =0; i < vertices.getLength(); i++)
                      {
                        var xy = vertices.getAt(i);
                        contentString += 'Coordinate ' + i + ' : ' + xy.lat() + ',' +  xy.lng() + "\n";
                        p.push({"lat":xy.lat(), "lon": xy.lng()});
                      }
                      json_data[0].children[this.indexID].metadata.p = p;

                      console.log(contentString);
          });
    });
}
function area_initialize()
{
    geocoder = new google.maps.Geocoder();
    geocoder.geocode( { 'address': city_name}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            var city_center_google = results[0].geometry.location;
           city_center = {lat:city_center_google.ob, lon:city_center_google.pb};
            map = new google.maps.Map(document.getElementById("map"), {
                zoom: 13,
                center: city_center_google,
                mapTypeId: google.maps.MapTypeId.MAP
            });

            init_tree();
            refresh_polygones();
            google.maps.event.addListener(map, 'click', addPoint);

        } else {
            alert("Geocode was not successful for the following reason: " + status);
        }
    });
  
 }

function isNumber(n) {
  return !isNaN(parseFloat(n)) && isFinite(n);
}
function addPoint(event) 
{
		if (currently_edited_poly)
		{ 
			currently_edited_poly.setEditable(false);
			currently_edited_poly.setOptions({ strokeWeight: 3});
		}
}

function customMenu(node)
{
        var items;

       // if ($(node).hasClass("jstree-leaf") )
        if (node[0].id != "root")
        {
            items =
            {

         "Rename": {
             "label": "Rename",
             "action": function (obj) {
                 this.rename(obj);
                        //json_data[0].children[].
             }
         },
         "Delete": {
             "label": "Delete"	,
             "action": function (obj) {
                 this.remove(obj);
                 poly_id = obj[0].id;
                        json_data[0].children.splice(poly_id , 1);

                        refresh_polygones();

             }
         }
      }
    }
        else
        {
            items =
            {
             "Create": {
             "label": "Create",
             "action": function (obj) {

                 var new_id =  json_data[0].children.length;
							$("#areasTree").jstree("create", $("#root"), "last", {"attr": {id: new_id}, data: "New Area"} ,null, true);
                        //obj.attr("id",  new_id);
                 //this.create(obj);
                 rnd_pos = Math.random()*0.01;
                 // TODO: LIOR add default polygone + update JSON

                        new_child = {
                  "data" :"New Area",
                  "metadata" : {p :
                          [
                              {"lat":city_center.lat-0.01 +  rnd_pos, "lon":city_center.lon-0.01 + rnd_pos},
                              {"lat":city_center.lat-0.01 +  rnd_pos, "lon":city_center.lon+0.01 + rnd_pos},
                              {"lat":city_center.lat+0.01 +  rnd_pos, "lon":city_center.lon+0.01 + rnd_pos},
                              {"lat":city_center.lat+0.01 +  rnd_pos, "lon":city_center.lon-0.01 + rnd_pos}
                          ]  },
                  "attr" : { "id" : new_id  },
                  "server_area_id": -1
                }
                json_data[0].children.push(new_child);
                refresh_polygones();
             }
         },
         "Rename": {
             "label": "Rename",
             "action": function (obj) {
                 this.rename(obj);
                        //json_data[0].children[].
             }
         }
      }
    }
    return items;
};
function init_tree()
{
      jQuery("#areasTree").jstree(
         {
                "plugins" : ["themes","json_data","ui","crrm","dnd","search","types","hotkeys","contextmenu"],
             "json_data" : {"data" : json_data},
                //"json_data" : { "data" : json_data},
                //"html_data" : { "data" : html_data},
                "core" : { "initially_open" : [ "1" ] },
               "contextmenu": {  "items": customMenu  }, // custom context menu according to https://learntech.imsu.ox.ac.uk/blog/?p=364
                "types" : {
                    "max_depth" : 2,
                    "max_children" : 15,
                    "valid_children" : [ "drive" ],
                    "types" : {
                        // The default type
                        "default" : {
                            "valid_children" : "folder",
                            "icon" : {
                                "image" : "/jstree/map.png"
                            }
                        },
                        "folder" : {
                            // can have files and other folders inside of it, but NOT `drive` nodes
                            "valid_children" : [ "default", "folder" ],
                            "icon" : {
                                "image" : "/jstree/map.png"
                            }
                        },
                        // The `drive` nodes
                        "drive" : {
                            // can have files and folders inside, but NOT other `drive` nodes
                            "valid_children" : [ "default", "folder" ],
                            "icon" : {
                                "image" : "/jstree/tag.png"
                            }
                            // those prevent the functions with the same name to be used on `drive` nodes
                            // internally the `before` event is used

                            //"start_drag" : false,
                            //"move_node" : false,
                            //"delete_node" : false,
                            //"remove" : false

                        }
                    }
                },
                "ui" : {
                    // this makes the node with ID node_4 selected onload
                    "initially_select" : [ "1" ]
                },
                // the core plugin - not many options here
                "core" : {
                    // just open those two nodes up
                    // as this is an AJAX enabled tree, both will be downloaded from the server
                    "initially_open" : [ "node_2" , "node_3" ]
                }
           });
        $("#areasTree").bind("loaded.jstree", function (event, data) {
        });

        //setTimeout(function () { $("#areasTree").jstree("set_focus"); }, 500);

        $("#areasTree").bind("open_node.jstree", function (e, data)	{
        });

        $("#areasTree").bind("select_node.jstree", function (event, data)
        {
            console.log("Selected: id  " + data.rslt.obj[0].id);
				if (isNumber(data.rslt.obj[0].id)) // "root" is returned on the root (the city name) - all other id's a re numbers
            {
                if (currently_edited_poly)
                {
                    currently_edited_poly.setOptions({ strokeWeight: 3});
                    currently_edited_poly.setEditable(false);
                }
                if(poly_array[data.rslt.obj[0].id]) {
                    poly_array[data.rslt.obj[0].id].setOptions({ strokeWeight: 5});
                    poly_array[data.rslt.obj[0].id].setEditable(true);
                    currently_edited_poly = poly_array[data.rslt.obj[0].id];
                }

                showRates(298486374, 298486374);
            }
        });

        $("#areasTree").bind("loaded.jstree", function (event, data) {
           // console.log(event, data);
        });

        $("#areasTree").bind("before.jstree", function (event, data) {
            //console.log(event, data);
        });
      $("#areasTree").bind("rename_node.jstree", function (event, data) {
                // console.log(event, data);

                var poly_id = data.rslt.obj[0].id;
                var new_name = data.args[1];
                if (poly_id != "") // i.e. it's a leaf
                {
                    json_data[0].children[poly_id].data =  new_name;
                }
                else // it's root
                {
                    json_data[0].data =  new_name;
                }
        });
}

function save()
{
    console.log(json_data);
    $.ajax({
        url: "/cities/"+ city_id +"/areas/update_areas.json",
        dataType: "json",
        type: "put",
        beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        data: data_json_to_server_jason(json_data),
        //processData: false,
        cache: false,
        success: function(response, textStatus, jqXHR) {
            alert("Changes saved");
            initPage();
        },
        error: function(jqXHR, textStatus, errorThrown) {
            alert("Save failed");
        }
    });
}

function data_json_to_server_jason(json_data)
{
   // I will send the server the following json format
    // {"id":980190962,"name":"Haifa","areas":[{"id":980190962,"name":"downtown","polygon":"[{lat:26.774252, lon:-82.190262},{lat:17.4664652, lon:-61.118292},{lat:30.321384, lon:-62.75737}]"}]}
    var areas = [];
    for (var i = 0; i < json_data[0].children.length; i++)
    {
        var area;
        var poly = [];
        for (var j=0; j < json_data[0].children[i].metadata.p.length; j++)
        {
            poly.push({lat: json_data[0].children[i].metadata.p[j].lat, lon:json_data[0].children[i].metadata.p[j].lon});
        }
        area = {id:json_data[0].children[i].server_area_id,name:json_data[0].children[i].data,polygon:poly};
    areas.push(area);
    }
    var server_json = JSON.stringify(areas);
    return server_json;
}
function server_jason_to_data_json(server_json)
{
    var json_data= [];
    var areas = [];
    if(server_json.areas) {
        for (i = 0; i < server_json.areas.length; i++)
        {
            var area;
            var server_polygon = [];
            var json_parsed = null;
            if(server_json.areas[i].polygon) {
                json_parsed = JSON.parse(server_json.areas[i].polygon);
            }
            if(json_parsed) {
                $.each(json_parsed, function(index,value) { server_polygon.push({lat: value.lat, lon: value.lon}); })
            }
            area = {"attr":{id:i},data:server_json.areas[i].name, metadata:{p:server_polygon}, server_area_id:server_json.areas[i].id};
            areas.push(area);
        }
    }

    json_data[0] = {data:server_json.name,metadata: city_center, "attr": { id: "root" }, children:areas};

    return  json_data;
    // console.log(json_data);
}