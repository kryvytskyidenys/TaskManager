<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <!-- Required meta tags -->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    <link rel="stylesheet" href="${contextPath}/resources/css/album.css"/>
    <title><spring:message code="titleMain"/></title>

</head>
<body>
<header>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse"
                data-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>


        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <a class="navbar-brand" href="${contextPath}/task-manager/tasks">Task manager</a>
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a href="${contextPath}/task-manager/tasks" class="nav-link">
                        <spring:message code="allTasks"/> </a>
                </li>
                <li class="nav-item">
                    <a href="${contextPath}/task-manager/new-task" class="nav-link">
                        <spring:message code="newTask"/></a>
                </li>
            </ul>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a href="?lang=en" class="nav-link">En</a>
                </li>
                <li class="nav-item">
                    <a href="?lang=ru" class="nav-link">Ру</a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link"> ${username}</a>
                </li>
                <li class="nav-item">
                    <a href="${contextPath}/task-manager/logout" class="nav-link">
                        <spring:message code="logout"/></a>
                </li>
            </ul>
        </div>
    </nav>
</header>

<main>
    <section class="jumbotron text-center">
        <div class="container">
            <h1 class="jumbotron-heading"><spring:message code="myTasks"/></h1>
        </div>
    </section>
    <div class="album py-5 bg-light">
        <div class="container">
            <div class="row">

                <c:forEach items="${tasks}" var="task">
                    <div class="col-md-4">
                        <div class="card mb-4 box-shadow">
                            <div class="card-body">
                                <h4 class="card-title">${task.name}</h4>
                                <p class="card-text">${task.description}</p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="btn-group">
                                        <a href="${contextPath}/task-manager/edit-task?id=${task.id}"
                                           type="button" class="btn btn-sm btn-outline-secondary">
                                            <spring:message code="taskEdit"/>
                                        </a>
                                        <a href="${contextPath}/task-manager/delete-task?id=${task.id}"
                                           type="button" class="btn btn-sm btn-outline-secondary">
                                            <spring:message code="taskDelete"/>
                                        </a>
                                    </div>
                                    <small class="text-muted">${task.dateCreated.toString()}</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</main>

<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
</body>
</html>
