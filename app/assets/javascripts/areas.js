var poly, map;
var options = {};
var lineCounter_ = 0;
var shapeCounter_ = 0;
var markerCounter_ = 0;
var colorIndex_ = 0;
var featureTable_;

var marker_icon = 'static/marker.png';
var poly_array = [];
var currently_edited_poly;
  var markers = [];
  var bermudaTriangle;
  var path = new google.maps.MVCArray;
  var colorIndex_ = 0;

  var COLORS = [["red", "#ff0000"], ["orange", "#ff8800"], ["green","#008000"],
              ["blue", "#000080"], ["purple", "#800080"]];
    
  var json_data =  [{  "data" : "Sidney", 
                      "metadata" : { "lat":24.88 , "lon":-70.26 },
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
		
	   for (area_index=0; area_index < json_data[0].children.length; area_index ++)  
      {
	    	var mypath=[];
	    	for (point_index = 0; point_index < json_data[0].children[area_index].metadata.p.length;  point_index++)
	    	{
	    		mypath.push(new google.maps.LatLng(json_data[0].children[area_index].metadata.p[point_index].lat, json_data[0].children[area_index].metadata.p[point_index].lon));
	    	}
	    	var new_poly = new google.maps.Polygon({
            paths: mypath,
            strokeColor: '#FF0000', 
            strokeOpacity: 0.8,
            strokeWeight: 3,
            fillColor: '#FF0000',
            fillOpacity: 0.35,
				indexID: area_index
        });
    	
	     //poly_array [json_data[0].children[area_index].attr.id] =  new_poly ;
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
     }
}
function area_initialize()
{
    var city_senter = new google.maps.LatLng(json_data[0].metadata.lat , json_data[0].metadata.lon);
    
    map = new google.maps.Map(document.getElementById("map"), {
      zoom: 5,
      center: city_senter,
      mapTypeId: google.maps.MapTypeId.SATELLITE
    });

   init_tree();
    
  	refresh_polygones();

   google.maps.event.addListener(map, 'click', addPoint);
  
 }

$(document).ready(function(){
   area_initialize();
});

function addPoint(event) 
{
		if (currently_edited_poly)
		{ 
			currently_edited_poly.setEditable(false);
			currently_edited_poly.setOptions({ strokeWeight: 3});
		}
}

    
    function init_tree()
    {
         jQuery("#areasTree").jstree(
  	 {
			"plugins" : ["themes","json_data","ui","crrm","dnd","search","types","hotkeys","contextmenu"],
         "json_data" : {"data" : json_data},
			//"json_data" : { "data" : json_data},
			//"html_data" : { "data" : html_data},
			"core" : { "initially_open" : [ "1" ] },	
		   "contextmenu": {
		        "items": function ($node) {
		            return {
		                "Create": {
		                    "label": "Create",
		                    "action": function (obj) {

		                        var new_id =  json_data[0].children.length;
										$("#areasTree").jstree("create", null, "last", {attr: {id: new_id}, data: "New Area"} ,null, true);
										//obj.attr("id",  new_id);
		                        //this.create(obj);
		                        rnd_pos = Math.random()*3;
		                        // TODO: LIOR add default polygone + update JSON
		                        var city_center = json_data[0].metadata;
										new_child = {
                               "data" :"New Area", 
                               "metadata" : {p : 
                                       [
                                           {"lat":city_center.lat-1 +  rnd_pos, "lon":city_center.lon-1 + rnd_pos}, 
                                           {"lat":city_center.lat-1 +  rnd_pos, "lon":city_center.lon+1 + rnd_pos}, 
                                           {"lat":city_center.lat+1 +  rnd_pos, "lon":city_center.lon+1 + rnd_pos},
                                           {"lat":city_center.lat+1 +  rnd_pos, "lon":city_center.lon-1 + rnd_pos}
                                       ]  },
                               "attr" : { "id" : new_id  }
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
		                },
		                "Delete": {
		                    "label": "Delete"	,
		                    "action": function (obj) {
		                        this.remove(obj);
		                        poly_id = obj[0].id - 1;
   									json_data[0].children.splice(poly_id , 1);
										
										refresh_polygones();

		                    }
		                },		                
		                "Edit": {
		                    "label": "Edit",
		                    "action": function (obj) {
		                    		console.log(obj);
		                    		poly_id = obj[0].id;
		                    		var poly = poly_array [json_data[0].children[poly_id-1].attr.id];
										poly.setOptions({ strokeWeight: 5});
              						poly.setEditable(true);
 										currently_edited_poly = poly;
										
		                    }
		                }
		            };
		        }
		    } ,        
			"types" : {
				// I set both options to -2, as I do not need depth and children count checking
				// Those two checks may slow jstree a lot, so use only when needed
				"max_depth" : 2,
				"max_children" : 15,
				// I want only `drive` nodes to be root nodes 
				// This will prevent moving or creating any other type as a root node
				"valid_children" : [ "drive" ],
				"types" : {
					// The default type
					"default" : {
						// I want this type to have no children (so only leaf nodes)
						// In my case - those are files
						"valid_children" : "folder",
						// If we specify an icon for the default type it WILL OVERRIDE the theme icons
						"icon" : {
							"image" : "static/map.png"
						}
					},
					// The `folder` type
					"folder" : {
						// can have files and other folders inside of it, but NOT `drive` nodes
						"valid_children" : [ "default", "folder" ],
						"icon" : {
							"image" : "static/map.png"
						}
					},
					// The `drive` nodes 
					"drive" : {
						// can have files and folders inside, but NOT other `drive` nodes
						"valid_children" : [ "default", "folder" ],
						"icon" : {
							"image" : "static/tag.png"
						},
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
    
	// EVENTS
	// each instance triggers its own events - to process those listen on the container
	// all events are in the `.jstree` namespace
	// so listen for `function_name`.`jstree` - you can function names from the docs

	$("#areasTree").bind("loaded.jstree", function (event, data) {
	    // you get two params - event & data - check the core docs for a detailed description
	    //console.log(event,data);
	});

	//setTimeout(function () { $("#areasTree").jstree("set_focus"); }, 500);

	$("#areasTree").bind("open_node.jstree", function (e, data)	{
	    // data.inst is the instance which triggered this event
	    //data.inst.select_node("#phtml_2", true);
	    //console.log(e, data);
	});

	$("#areasTree").bind("select_node.jstree", function (event, data) 
	{
	    // `data.rslt.obj` is the jquery extended node that was clicked
	    // console.log(event, data);
	    console.log("Selected: id  " + data.rslt.obj[0].id);
		if (data.rslt.obj[0].id != "") // "" is returned on the root (the city name))
		{
			if (currently_edited_poly)
			{
				currently_edited_poly.setOptions({ strokeWeight: 3});
	  			currently_edited_poly.setEditable(false);
			}
			
			poly_array[data.rslt.obj[0].id].setOptions({ strokeWeight: 5});
	  		poly_array[data.rslt.obj[0].id].setEditable(true);
	 		currently_edited_poly = poly_array[data.rslt.obj[0].id];
		}

       //console.log("polygon points " + data.rslt.obj.data("p"));
	    //alert(data.rslt.obj.attr("id"));
	});

	$("#areasTree").bind("loaded.jstree", function (event, data) {
	   // console.log(event, data);
	});

	$("#areasTree").bind("before.jstree", function (event, data) {
	    //console.log(event, data);
	});
    }
    
/*
 function startDrawing(poly, name, onUpdate, color) {
 
   poly.setMap(map);
 	google.maps.event.addListener(poly, 'mouseover', function() {
              this.setOptions({fillOpacity: 1});
              this.setEditable(true);
            });
	google.maps.event.addListener(poly, 'mouseout', function() {
              this.setOptions({fillOpacity: 1});
              this.setEditable(false);
            });
  
   google.maps.event.addListener(poly, "endline", function() {
    //select("hand_b");
    var cells = addFeatureEntry(name, color);
    google.maps.event.event.bind(poly, "lineupdated", cells.desc, onUpdate);
    google.maps.event.addListener(poly, "click", function(latlng, index) {
      if (typeof index == "number") {
        poly.deleteVertex(index);
      } else {
        var newColor = getColor(false);
        cells.color.style.backgroundColor = newColor
        poly.setStrokeStyle({color: newColor, weight: 4});
      }
    });
  });
}
 */
/*
function startShape() {
   var color = getColor(false);
  var polygon = new google.maps.Polygon([], color, 2, 0.7, color, 0.2);
  startDrawing(polygon, "Shape " + (++shapeCounter_), function() {
    var cell = this;
    var area = polygon.getArea();
    cell.innerHTML = (Math.round(area / 10000) / 100) + "km<sup>2</sup>";
  }, color);
}
*/
    function save()
    {
/*        data = $("#areasTree").jstree("get_json", -1);
        console.log(JSON.stringify(data));
        console.log(data);
        data = $("#areasTree").jstree("parse_json",data);
*/
			// OFER: send this to server
        console.log(json_data);
        delete_polygones();
    }