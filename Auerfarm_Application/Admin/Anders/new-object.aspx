﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="new-object.aspx.cs" Inherits="Auerfarm_Application.Admin.Anders.new_object" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8"/>
	<link href="/Content/bootstrap.min.css" rel="stylesheet"/>
	<link href="/Content/style.css" rel="stylesheet"/>
	<meta name="viewport" content="width=device-width, initial-scale=1"/>
    <style>
    #map {
    height: 400px;
    width: 60%;
    align-content: center;
    margin-left: auto;
    margin-right: auto;
    }
    </style>
</head>
<body>
    <form id="form1" runat="server">
<nav class="navbar navbar-inverse navbar-fixed-top">
 			<div class="nav-image navbar-left">
 				<a href="index.html"><img src="/Content/auerfarm-logo.jpeg" alt="Auerfarm Logo"></a>
 			</div>
   			<div class="nav-options navbar-left">
   			 	<ul class="nav navbar-nav">
 	     			<li><a class="hyper-nav" href="announcements.html">Announcements & News</a></li>
 	     			<li><a  class="hyper-nav" href="map-objects.aspx">Interactive Map</a></li>
    			</ul>
    		</div>
    		<div class="nav-welcome navbar-right">
   			 	<h3>Welcome Admin!</h3>
    		</div>
	</nav>

	<div class="container-fluid page-content">
		<div class="row page-title">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<h2>Create Map Object:</h2>
			</div>
			<div class="col-md-2"></div>
		</div>
		<div class="row input-row">
			<div class="col-md-2"></div>
			<div class="col-md-2">
				<h5 class="input-label">Marker Type</h5>
			</div>
			<div class="col-md-6">
				<select class="selectpicker form-control" id="object_type_select" runat="server" required>
					<option value="" disabled selected>...</option>
					<option value="animal">Animal</option>
					<option value="plant">Plant</option>
					<option value="landmark">Landmark</option>
					<option value="building">Building</option>
					<option value="equipment">Equipment</option>
					<option value="other">Other</option>
				</select>
			</div>
           
			<div class="col-md-2"></div>
		</div>
        <br /><br />
        <div id="map"></div>
        <script>
      var map;
      function initMap() {
          var auerfarm = { lat: 41.811224, lng: -72.774158 };
          map = new google.maps.Map(document.getElementById('map'), {
              center: auerfarm,
              zoom: 18,
              mapTypeId: 'satellite'
          });

          var drawingManager = new google.maps.drawing.DrawingManager({
              drawingMode: google.maps.drawing.OverlayType.MARKER,
              drawingControl: true,
              drawingControlOptions: {
                  position: google.maps.ControlPosition.BOTTOM_CENTER,
                  drawingModes: ['marker']
              },
              markerOptions:
              {
                  draggable: true,
              },

          });
          drawingManager.setMap(map);

          google.maps.event.addListener(drawingManager, 'markercomplete',
              function (marker) {
                  drawingManager.setOptions({
                      drawingControlOptions: {
                          drawingModes: []
                      }
                  });


                  drawingManager.setDrawingMode(null);
                  var point = marker.getPosition();
                  var x = point.lat();
                  var y = point.lng();

                  $.ajax({
                      type: "POST",
                      url: "new-object.aspx/GetCoordinates",
                      data: { data1: x, data2: y },
                      contentType: "application/json; charset=utf-8",
                      dataType: "json"
                  });

                  google.maps.event.addListener(marker, 'dragend', function (event)
                  {
                      var point = marker.getPosition();
                      var x = point.lat();
                      var y = point.lng();

                      $.ajax({
                          type: "POST",
                          url: "new-object.aspx/getCoordinates",
                          data: { data1: x, data2: y },
                          contentType: "application/json; charset=utf-8",
                          dataType: "json"
                      });

                      
                  });

              });

          }
        </script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBEIKQKPXffQ-lVn4p5FjI9sBjsb4GAGWQ&libraries=drawing&callback=initMap"
                async defer></script>
        <br /><br />
		
		<hr />
		<div class="row input-row">
			<div class="col-md-2"></div>
			<div class="col-md-2">
				<h5 class="input-label" runat="server" id="image_label">Pop-up Image:</h5>
			</div>
			<div class="col-md-6 center-input">
				<input type="file" class="object-def-image" />
			</div>
			<div class="col-md-2"></div>
		</div>
		<div class="row input-row">
			<div class="col-md-2"></div>
			<div class="col-md-2">
				<h5 class="input-label">Map Label:</h5>
			</div>
			<div class="col-md-6">
				<input type="text" class="form-control object-name" runat="server" id="map_label" placeholder="" />
			</div>
			<div class="col-md-2"></div>
		</div>
		<div class="row input-row">
			<div class="col-md-2"></div>
			<div class="col-md-2">
				<h5 class="input-label">Object Description:</h5>
			</div>
			<div class="col-md-6">
				<input type="text" class="form-control object-description" runat="server" id="object_desc" />
			</div>
			<div class="col-md-2"></div>
		</div>
		<div class="row input-row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
                <a href ="map-objects.aspx" runat="server" onserverclick ="submit_new_object_clicked">
				<button type="button" class="btn btn-default">
                    Save and Create New Map Marker
				</button>
                </a>
			</div>
			<div class="col-md-2"></div>
		</div>
	</div>
        </form>
</body>
</html>
