﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="announcement.aspx.cs" Inherits="Auerfarm_Application.Admin.Application.announcement" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta charset="utf-8">
	<link href="/Content/bootstrap.min.css" rel="stylesheet">
	<link href="/Content/style.css" rel="stylesheet">
	<meta name="viewport" content="width=device-width, initial-scale=1">
</head>

<body>
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
				<h2>Announcements & News:</h2>
				<p>Here you can view, edit, or remove old announcements and calendar events by selecting "View / Edit / Remove Announcements".  You can also create new announcements and calendar events by selecting "Create New Announcement".</p>
			</div>
			<div class="col-md-2"></div>
		</div>
        <asp:Table ID="announcements" runat="server"></asp:Table>


		<hr />
		<div class="row nav-button-row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<a href="view-announcements.html">
					<button type="button" class="btn btn-default form-control" id="new-announcement">View / Edit / Remove Announcements</button>
				</a>
			</div>
			<div class="col-md-2"></div>
		</div>
		<div class="row nav-button-row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<a href="new-announcement.html">
					<button type="button" class="btn btn-default form-control" id="new-announcement">Create a New Announcement</button>
				</a>
			</div>
			<div class="col-md-2"></div>
		</div>
	</div>
</body>