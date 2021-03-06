<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}" />

<meta name="_csrf_header" content="${_csrf.headerName}" />
<title>Kierowcy</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

<!-- bootbox.js at 4.4.0 -->
<script
	src="https://rawgit.com/makeusabrew/bootbox/f3a04a57877cab071738de558581fbc91812dce9/bootbox.js"></script>

<script src="/js/utils.js"></script>
<script src="/js/address.js"></script>
<script src="/js/driver.js"></script>
<script src="/js/token.js"></script>

<script type="text/javascript">
	$(function() {
		$(".delete-driver-button").button().on(
				"click",
				function() {
					var $this = $(this).closest('tr').children();
					var driverFirstName = $this.eq(1).text();
					var driverLastName = $this.eq(2).text();
					var driverPesel = $this.eq(3).text();
					driverId = $this.eq(0).text();
					console.log("deleting");
					bootbox.confirm("Usunąć kierowcę " + driverFirstName + " "
							+ driverLastName + "(" + driverPesel + ")?",
							function(result) {
								if (result == true)
									deleteDriver(driverId);
							});
				});
	});
</script>

</head>

<body>

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
					<li class="active"><a href="/drivers">Kierowcy</a></li>
					<li class="inactive"><a href="/vehicles">Pojazdy</a></li>
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

	<a href="/drivers/add" class="btn btn-success">Dodaj kierowcę</a>

	<table class="table table-hover" id="drivers_table">
		<thead>
			<tr>
				<td>ID</td>
				<td>Imie</td>
				<td>Nazwisko</td>
				<td>PESEL</td>
				<td>Pensja</td>
				<td>Premia</td>
				<td>Adres</td>
				<td>Szczegóły</td>
				<td>Edycja</td>
				<td>Usuwanie</td>
			</tr>
		</thead>

		<c:forEach var="driver" items="${drivers}">
			<tr>
				<td>${driver.id}</td>
				<td>${driver.firstName}</td>
				<td>${driver.lastName}</td>
				<td>${driver.PESEL}</td>
				<td>${driver.salary}</td>
				<td>${driver.salaryBonus}</td>
				<td style="display: none;">${driver.address.id}</td>
				<td>${driver.address}</td>
				<td><a class="btn btn-default details-driver-button"
					href="drivers/${driver.id}"><span
						class="glyphicon glyphicon-user" aria-hidden="true"></span>
						</button></td>
				<td><a class="btn btn-primary edit-driver-button"
					href="/drivers/edit/${driver.id}">Edytuj</a></td>
				<td><button class="btn btn-danger delete-driver-button"
						id="delete-button-${driver.id}">Usuń</button></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>