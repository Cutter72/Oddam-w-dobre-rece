<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title>Zmiana danych osobowych</title>
    <link rel="stylesheet" href="<c:url value="../../../css/style.css"/>"/>
</head>
<body>
<header class="header--form-page">
    <nav class="container container--70">
        <ul class="nav--actions">
            <li class="logged-user">
                Witaj ${user.firstName}
                <ul class="dropdown">
                    <li><a href="<jsp:include page="../../links/hrefUserProfile.jsp"/>">Profil</a></li>
                    <li><a href="<jsp:include page="../../links/hrefUserSettings.jsp"/>">Ustawienia</a></li>
                    <li><a href="<jsp:include page="../../links/hrefUserGifts.jsp"/>">Moje dary</a></li>
                    <c:if test="${isAdmin}"><li><a href="<jsp:include page="../../links/hrefAdmin.jsp"/>">Panel Admina</a></li></c:if>
                    <li>
                        <form action="/logout" method="post">
                            <input class="btn--small" type="submit" value="Wyloguj">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </form>
                    </li>
                </ul>
            </li>
        </ul>

        <ul>
            <li><a href="/" class="btn btn--without-border active">Start</a></li>
            <li><a href="<jsp:include page="../../links/hrefWhat.jsp"/>" class="btn btn--without-border">O co chodzi?</a>
            </li>
            <li><a href="<jsp:include page="../../links/hrefAbout.jsp"/>" class="btn btn--without-border">O nas</a></li>
            <li>
                <a href="<jsp:include page="../../links/hrefOrganizations.jsp"/>" class="btn btn--without-border"
                >Fundacje i organizacje</a
                >
            </li>
            <li><a href="<jsp:include page="../../links/hrefContact.jsp"/>" class="btn btn--without-border">Kontakt</a>
            </li>
        </ul>
    </nav>
<section class="login-page">
    <div class="slogan--item" style="text-align: center">
        <h2>
            <span class="uppercase">Zmień swoje dane osobowe</span>
        </h2>
        <section class="login-page" style="text-align: center">
            <form:form method="post" modelAttribute="user">
                <div class="form-group">
                    <span class="slogan--steps-title">Imię: </span><form:input path="firstName" name="firstName" placeholder="${user.firstName}" />
                    <form:errors path="firstName" name="firstName" placeholder="Imię" />
                </div>
                <div class="form-group">
                    <span class="slogan--steps-title">Nazwisko: </span><form:input path="lastName" name="lastName" placeholder="${user.lastName}" />
                    <form:errors path="lastName" name="lastName" placeholder="Nazwisko" />
                </div>
                <div class="form-group form-group--buttons">
                    <a href="/user/profile" class="btn btn--without-border">Anuluj</a>
                    <button class="btn" type="submit">Zmień</button>
                </div>
            </form:form>
        </section>
    </div>
</section>
</header>

<jsp:include page="../../components/footer.jsp"/>

</body>
</html>
