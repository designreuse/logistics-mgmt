﻿<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"
%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}" />

<meta name="_csrf_header" content="${_csrf.headerName}" />
<title>Dane Pojazdu ${vehicle.brand} ${vehicle.model}(${vehicle.VIN})</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

<script src="/js/utils.js"></script>
<script src="/js/vehicle.js"></script>
<script src="/js/maps.js"></script>

<link rel='stylesheet' href='//cdnjs.cloudflare.com/ajax/libs/fullcalendar/2.6.1/fullcalendar.css' />
<script src='//cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js'></script>
<script src='//cdnjs.cloudflare.com/ajax/libs/fullcalendar/2.6.1/fullcalendar.min.js'></script>

<script src="http://maps.googleapis.com/maps/api/js?key=${api_key}"></script>
<link rel="stylesheet" type="text/css" href="/css/map.css">

<script>
$(document).ready(function() {

    $('#calendar').fullCalendar({
        events: '/api/vehicles/${vehicle.id}/schedule'

    });
    var initialLocation = new google.maps.LatLng(52, 21);
    var map = initializeMap(initialLocation);
    var marker = initializeMarker(map, initialLocation);
    setInterval(function(){
    pollForLocation('vehicle', ${vehicle.id}, map, marker);
    }, 5000);

});
</script>
</head>

<body>

<!-- Static navbar -->
      	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#navbar" aria-expanded="false"
					aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="/index">logistics_mgmt</a>
			</div>
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li class="inactive"><a href="/drivers">Kierowcy</a></li>
					<li class="active"><a href="/vehicles">Pojazdy</a></li>
					<li class="inactive"><a href="/clients">Klienci</a></li>
					<li class="inactive"><a href="/transports">Transporty</a></li>
					<li class="inactive"><a href="/addresses">Baza adresów</a></li>

				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li class="inactive"><a href="/users/">Panel
							Administracyjny</a></li>
					<li class="dropdown"><a href="/" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">Zaloguj/Wyloguj <span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="/login">Zaloguj</a></li>
							<li><a href="/logout">Wyloguj</a></li>
						</ul></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
		<!--/.container-fluid -->
	</nav>

<div class="container">
  <div class="row">
    <div class="col-md-4">
      <form name="vehicle_disabled_form" id="vehicle_disabled_form" data-toggle="validator" onsubmit="return editVehicle();">
          <input type="hidden" value="${vehicle.id}" path="id" id="id" name="id"/>
          <div class="form-group">
            <label for="brand">Marka:</label>
            <input type="text" value="${vehicle.brand}" class="form-control" name="brand"  path="brand" id="brand" disabled />
          </div>
          <div class="form-group">
            <label for="model">Model:</label>
            <input type="text" value="${vehicle.model}" class="form-control" id="model"  path="model" name="model" disabled />
          </div>
          <div class="form-group">
            <label for="model">Ładowność:</label>
            <input type="text" value="${vehicle.maxPayload}" class="form-control" id="maxPayload"  path="maxPayload" name="maxPayload" disabled />
          </div>
          <div class="form-group">
            <label for="engine">Silnik:</label>
            <input type="text" value="${vehicle.engine}" class="form-control" id="engine"  path="engine" name="engine" disabled />
          </div>
          <div class="form-group">
            <label for="vin">VIN:</label>
            <input type="text" value="${vehicle.VIN}" class="form-control" id="vin" name="vin" path="vin" disabled />
           </div>
          <div class="form-group">
            <label for="mileage">Przebieg:</label>
            <input type="text" value="${vehicle.mileage}" class="form-control" id="mileage" name="mileage" path="mileage" disabled />
          </div>
          <div class="form-group">
            <label for="horsepower">KM:</label>
            <input type="text" value="${vehicle.horsepower}" class="form-control" id="horsepower" name="horsepower"
             path="horsepower" disabled />
          </div>
          <div class="form-group">
            <label for="productionDate">Data produkcji:</label>
            <input type="text" value="${vehicle.productionDate}" class="form-control" id="productionDate"
             name="productionDate" path="productionDate" disabled/>
          </div>
          <div class="checkbox">
            <label><input type="checkbox" checked="checked"  path="available" id="available" name="available" disabled/>Dostepny</label>
          </div>

            <a class="btn btn-success" href="/vehicles">Powrót do listy pojazdów</a>
      </form>
    </div>
    <div class="col-md-4">
          <c:choose>
                <c:when test="${on_road == true}">
                 <span class="label label-success">
                     <span class="glyphicon glyphicon-road" aria-hidden="true"></span> W trasie
                 </span>
                </c:when>
                <c:otherwise>
                    <span class="label label-default">
                      <span class="glyphicon glyphicon-road" aria-hidden="true"></span> Nieaktywny
                    </span>
                </c:otherwise>
          </c:choose>
          <c:choose>
                  <c:when test="${vehicle.latitude != null && vehicle.longitude != null}">
                   <div id="map-canvas" class="map-canvas"></div>
                  </c:when>
                  <c:otherwise>
                      <p>Brak danych o ostatniej lokalizacji.</p>
                  </c:otherwise>
            </c:choose>
          </div>
    <div class="col-md-4" id="calendar">
      </div>
  </div>
</div>
</body>
</html>
