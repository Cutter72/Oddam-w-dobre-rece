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
    <title>Formularz</title>
    <link rel="stylesheet" href="/css/style.css"/>
</head>
<body>
<header class="header--form-page" style="background-image: none; height: 120px">
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
            <li><a href="<jsp:include page="../../links/hrefWhat.jsp"/>" class="btn btn--without-border">O co
                chodzi?</a>
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

</header>

<a name="Form" id="form-place"></a>
<section class="form--steps">
    <div class="form--steps-instructions">
        <div class="form--steps-container">
            <h3>Ważne!</h3>
            <p data-step="4">
                Na podstawie Twoich kryteriów oraz rzeczy, które masz do oddania
                wybraliśmy organizacje, którym możesz pomóc. Wybierz jedną, do
                której trafi Twoja przesyłka.
            </p>
            <p data-step="5">Podaj adres oraz termin odbioru rzeczy.</p>
        </div>
    </div>

    <div class="form--steps-container">
        <div class="form--steps-counter">Krok <span>4</span>/5</div>

        <form:form modelAttribute="gift" method="post">
            <!-- STEP 4 -->
            <div data-step="4">
                <h3>Wybierz organizacje, której chcesz pomóc:</h3>
                <h4 style="color: #b92c28">${noOrganizationFound}</h4>

                <c:forEach items="${organizationList}" var="organization">
                    <div class="form-group form-group--checkbox">
                        <label>
                            <form:radiobutton path="organization" name="organization" cssClass="organization" value="${organization.id}"/>
                            <span class="checkbox radio"></span>
                            <span class="description">
                  <div class="title organizationInput">${organization.type.name} “${organization.name}” - ${organization.city.name}</div>
                  <div class="subtitle">
                    Cel i misja: ${organization.mission}
                  </div>
                </span>
                        </label>
                    </div>
                </c:forEach>

                <div class="form-group form-group--buttons">
                    <a href="/user#Form" style="margin-right: 30px"><button type="button" class="btn">Wstecz</button></a>
                    <button type="button" class="btn next-step">Dalej</button>
                </div>
            </div>

            <!-- STEP 5 -->
            <div data-step="5">
                <h3>Podaj adres oraz termin odbioru rzecz przez kuriera:</h3>

                <div class="form-section form-section--columns">
                    <div class="form-section--column">
                        * - pola oznaczone gwiazdka muszą być wypełnione
                        <br/>
                        <h4>Adres odbioru</h4>
                        <div class="form-group form-group--inline">
                            <label> Ulica* <form:input path="street" name="address" required="required" class="required streetInput"/> </label>
                        </div>

                        <div class="form-group form-group--inline">
                            <label> Miasto* <form:input path="city" name="city" required="required" class="required cityInput"/> </label>
                        </div>

                        <div class="form-group form-group--inline">
                            <label>
                                Kod pocztowy* <form:input path="postCode" name="postcode" required="required" class="required postCodeInput"/>
                            </label>
                        </div>

                        <div class="form-group form-group--inline">
                            <label>
                                Numer telefonu* <form:input path="callNumber" name="phone" required="required" class="required callNumberInput"/>
                            </label>
                        </div>
                    </div>

                    <div class="form-section--column">
                        <h4>Termin odbioru (opcjonalnie)</h4>
                        <div class="form-group form-group--inline">
                            <label> Data <input type="date" name="date" class="dateInput"/> </label>
                        </div>

                        <div class="form-group form-group--inline">
                            <label> Godzina <input type="time" name="time" class="timeInput"/> </label>
                        </div>

                        <div class="form-group form-group--inline">
                            <label>
                                Uwagi dla kuriera
                                <form:textarea path="courierNote" name="more_info" rows="5" class="courierNoteInput"></form:textarea>
                            </label>
                        </div>
                    </div>
                </div>
                <div class="form-group form-group--buttons">
                    <button type="button" class="btn prev-step">Wstecz</button>
                    <button type="button" class="btn next-step">Dalej</button>
                </div>
            </div>

            <!-- STEP 6 -->
            <div data-step="6">
                <h3>Podsumowanie Twojej darowizny</h3>

                <div class="summary">
                    <div class="form-section">
                        <h4>Oddajesz:</h4>
                        <ul>
                            <li>
                                <span class="icon icon-bag"></span>
                                <span class="summary--text">Worków: ${bags}, <br/>
                                    Zawartość: <c:forEach items="${selectedNeedsToGive}" var="need">${need.name}, </c:forEach>
                                </span>
                            </li>

                            <li>
                                <span class="icon icon-hand"></span>
                                <span class="summary--text organizationAndCitySummary">
                                    Dla organizacji "Mam marzenie" w Warszawie
                                </span>
                            </li>
                        </ul>
                    </div>

                    <div class="form-section form-section--columns">
                        <div class="form-section--column">
                            <h4>Adres odbioru:</h4>
                            <ul>
                                <li class="streetSummary">Prosta 51</li>
                                <li class="citySummary">Warszawa</li>
                                <li class="postCodeSummary">99-098</li>
                                <li class="callNumberSummary">123 456 789</li>
                            </ul>
                        </div>

                        <div class="form-section--column">
                            <h4>Termin odbioru:</h4>
                            <ul>
                                <li class="dateSummary">13/12/2018</li>
                                <li class="timeSummary">15:40</li>
                                <li class="courierNoteSummary">Brak uwag</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="form-group form-group--buttons">
                    <button type="button" class="btn prev-step">Wstecz</button>
                    <button type="submit" class="btn">Potwierdzam</button>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <input type="hidden" name="step" value="4"/>
                </div>
            </div>

            <!-- STEP 7 -->
            <div data-step="7">
                <h2>
                    Dziękujemy za przesłanie formularza Na maila prześlemy wszelkie
                    informacje o odbiorze.
                </h2>
            </div>
        </form:form>
    </div>
</section>

<jsp:include page="../../components/footer.jsp"/>

<script src="/js/appStep4.js"></script>
</body>
</html>
