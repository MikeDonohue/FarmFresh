﻿var gMapsLoaded = false;

$(document).ready(function () {
    /****************************************************************************************
    GOOGLE MAPS SCRIPTS
    ****************************************************************************************/
    window.gMapsCallback = function () {
        gMapsLoaded = true;
        $(window).trigger('gMapsLoaded');
    }

    window.loadGoogleMaps = function () {
        if (gMapsLoaded) { return window.gMapsCallback(); }
        var script_tag = document.createElement('script');
        script_tag.setAttribute("type", "text/javascript");
        script_tag.setAttribute("src", "http://maps.google.com/maps/api/js?key=AIzaSyBEIKQKPXffQ-lVn4p5FjI9sBjsb4GAGWQ&sensor=false&callback=gMapsCallback");
        (document.getElementsByTagName("head")[0] || document.documentElement).appendChild(script_tag);
    }

    function initialize() {
        var auerfarm = { lat: 41.811224, lng: -72.774158 };
        var mapOptions = {
            center: auerfarm,
            zoom: 18,
            mapTypeId: 'satellite'
        };
        map = new google.maps.Map(document.getElementById('map'), mapOptions);
        var iconBase = "/Content/";
        var icons = {
            animal: {
                icon: iconBase + "animal.png"
            },
            building: {
                icon: iconBase + "building.png"
            },
            office: {
                icon: iconBase + "office.png"
            },
            plant: {
                icon: iconBase + "plant.png"
            },
            other: {
                icon: iconBase + "other.png"
            }
        };
        var lat = parseFloat(document.getElementById("Hidden1").value);
        var lng = parseFloat(document.getElementById("Hidden2").value);
        var latlng = { lat: lat, lng: lng }
        var marker = new google.maps.Marker({
            position: latlng,
            icon: icons[document.getElementById('object_type_select').value].icon,
            map: map,
            draggable: true
        });
        google.maps.event.addListener(marker, 'dragend', function (event) {
            var point = marker.getPosition();
            var x = point.lat();
            var y = point.lng();
            document.getElementById("Hidden1").value = x;
            document.getElementById("Hidden2").value = y;
        });
    }

    /****************************************************************************************
    MENU SCRIPTS
    ****************************************************************************************/
    function CollapseMenu() {
        $(".menu-container").animate({ width: "0px" }, 800, function () {
            $(".menu-container").addClass("no-disp");
        });
    }

    function LoadNews(menu) {
        $.ajax({
            type: "GET",
            url: "Home/LoadNews",
            success: function (response) {
                $(".selected-op").removeClass("selected-op");
                $("#content").html(response);
                $("#news-op").toggleClass("selected-op");
            }
        }).done(function () { if (menu) { CollapseMenu() } });
    }

    $(document).on("click", "#news-op", function (event) {
        event.preventDefault();
        LoadNews(false);
    });

    $(document).on("click", "#menu-op-news", function (event) {
        event.preventDefault();
        LoadNews(true);
    });

    function LoadCalendar(menu) {
        $.ajax({
            type: "GET",
            url: "Home/LoadCalendar",
            success: function (response) {
                $(".selected-op").removeClass("selected-op");
                $("#content").html(response);
                $("#calendar-op").toggleClass("selected-op");
            }
        }).done(function () {if (menu) { CollapseMenu(); } });
    }

    $(document).on("click", "#calendar-op", function (event) {
        event.preventDefault();
        LoadCalendar(false);
    });

    $(document).on("click", "#menu-op-calendar", function (event) {
        event.preventDefault();
        LoadCalendar(true);
    });

    function LoadMap(menu) {
        $.ajax({
            type: "GET",
            url: "Home/LoadMap",
            success: function (response) {
                $(".selected-op").removeClass("selected-op");
                $("#content").html(response);
                $("#map-op").toggleClass("selected-op");
                $(window).bind('gMapsLoaded', initialize); window.loadGoogleMaps();
            }
        }).done(function () { if (menu) { CollapseMenu() } });
    }

    $(document).on("click", "#map-op", function (event) {
        event.preventDefault();
        LoadMap(false);
    });

    $(document).on("click", "#menu-op-map", function (event) {
        event.preventDefault();
        LoadMap(true);
    });

    function LoadShop(menu) {
        $.ajax({
            type: "GET",
            url: "Home/LoadShop",
            success: function (response) {
                $(".selected-op").removeClass("selected-op");
                $("#content").html(response);
                $("#shop-op").toggleClass("selected-op");
            }
        }).done(function () { if (menu) { CollapseMenu() } });
    }

    $(document).on("click", "#shop-op", function (event) {
        event.preventDefault();
        LoadShop(false);
    });

    $(document).on("click", "#menu-op-shop", function (event) {
        event.preventDefault();
        LoadShop(true);
    });

    $(document).on("click", ".nav-image img", function () {
        $(".menu-container").removeClass("no-disp");
        $(".menu-container").animate({ width: "100vw" }, 800, function () { $("#content").html(null); });
    });

    /****************************************************************************************
    NEWS/Calendar SCRIPTS
    ****************************************************************************************/
    //Add new item div when user clicks new-news-item
    $(document).on("click", "#new-info-item", function (event) {
        event.preventDefault();
        $(".item-list").prepend('<div class="info-item-container container-fluid new-item" ><div class="row"><div class="col-xs-2"><div class="info-item-image"><img src="~/Content/rafi-filler-pic.jpg" alt="placeholder-pic" /></div></div><div class="col-xs-10 @*beside-img*@"><div class="split-content"><div class="left-content"><div class="ti-label inline-block"><h6>Title:</h6></div><input type="text" class="inline-block form-control" id="item-title"></div><div class="right-content"><div class="ti-label inline-block"><h6>Date:</h6></div><input type="text" class="inline-block form-control" id="item-date"></div></div><div class="ti-label inline-block"><h6>Description:</h6></div><textarea class="inline-block form-control" id="item-desc"></textarea><div class="split-content"><div class="left-content"><div class="ti-label inline-block"><h6>Post Date:  </h6></div><input type="text" class="form-control  inline-block" id="item-post-date"></div><div class="right-content"><div class="ti-label inline-block"><h6>Hide Date:  </h6></div><input type="text" class="form-control inline-block" id="item-remove-date"></div></div></div></div><button type="button" class="form-control" id="submit-new-item">Save Item</button></div>');
    });

    function AddInfoItem(farmInfoItem) {
        var page = farmInfoItem.Type;
        $.ajax({
            type: "POST",
            url: "../../FarmInfo/AddInfoItem",
            data: farmInfoItem,
            success: function (response) {
                console.log(response);
            }
        }).done(function () { if (page == "news") { LoadNews(false); } else { LoadCalendar(false); } });
    }

    $(document).on("click", "#submit-new-item", function (event) {
        event.preventDefault();
        var FarmInfoItem = {
            Id: null,
            Type: $("input[name=item-type]").val(),
            Title: $(".new-item #item-title").val(),
            Description: $(".new-item #item-desc").val(),
            Date: $(".new-item #item-date").val(),
            StartDate: $(".new-item #item-post-date").val(),
            EndDate: $(".new-item #item-remove-date").val(),
        }
        AddInfoItem(FarmInfoItem);
    });

    function UpdateInfoItem(farmInfoItem) {
        $.ajax({
            type: "POST",
            url: "../../FarmInfo/UpdateInfoItem",
            data: farmInfoItem,
            success: function (response) {
                console.log(response);
            }
        });
    }

    $(document).on("click", ".update-item", function (event) {
        event.preventDefault();
        var item = "#" + $(this).attr("id");
        var FarmInfoItem = {
            Id: $(this).attr("id"),
            Type: $("input[name=item-type]").val(),
            Title: $(item + " #item-title").val(),
            Description: $(item + " #item-desc").val(),
            Date: $(item + " #item-date").val(),
            StartDate: $(item + " #item-post-date").val(),
            EndDate: $(item + " #item-remove-date").val(),
        }
        UpdateInfoItem(FarmInfoItem);
    });
});