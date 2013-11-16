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
      zoom: 9,
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

   function customMenu(node)
   {
 			var items;
 			
 			if ($(node).hasClass("jstree-leaf") )
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
                     poly_id = obj[0].id - 1;
							json_data[0].children.splice(poly_id , 1);
							
							refresh_polygones();

                 }
             },	
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
			$("#areasTree").bind("loaded.jstree", function (event, data) {
			});
		
			//setTimeout(function () { $("#areasTree").jstree("set_focus"); }, 500);
		
			$("#areasTree").bind("open_node.jstree", function (e, data)	{
			});
		
			$("#areasTree").bind("select_node.jstree", function (event, data) 
			{
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
			// OFER: send this to server
        console.log(json_data);
    }