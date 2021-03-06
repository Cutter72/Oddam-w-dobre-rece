<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="pl-PL">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Oddam w dobre ręce</title>
    <link rel="stylesheet" href="css/style.css" />
</head>
<body>
<header class="header--main-page">
    <nav class="container container--70">
        <c:choose>
            <c:when test="${isLogged}">
                <ul class="nav--actions">
                    <li class="logged-user">
                        Witaj ${user.firstName}
                        <ul class="dropdown">
                            <li><a href="<jsp:include page="../links/hrefUserProfile.jsp"/>">Profil</a></li>
                            <li><a href="<jsp:include page="../links/hrefUserSettings.jsp"/>">Ustawienia</a></li>
                            <li><a href="<jsp:include page="../links/hrefUserGifts.jsp"/>">Moje dary</a></li>
                            <c:if test="${isAdmin}"><li><a href="<jsp:include page="../links/hrefAdmin.jsp"/>">Panel Admina</a></li></c:if>
                            <li>
                                <form action="/logout" method="post">
                                    <input class="btn--small" type="submit" value="Wyloguj">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                </form>
                            </li>
                        </ul>
                    </li>
                </ul>
            </c:when>
            <c:otherwise>
                <ul class="nav--actions">
                    <li><a href="<jsp:include page="../links/hrefLogin.jsp"/>" class="btn btn--small btn--without-border">Zaloguj</a></li>
                    <li><a href="<jsp:include page="../links/hrefRegister.jsp"/>" class="btn btn--small btn--highlighted">Załóż konto</a></li>
                    <li><a href="<jsp:include page="../links/hrefUserCheck.jsp"/>" class="btn btn--small btn--without-border">Moje konto</a></li>
                </ul>
            </c:otherwise>
        </c:choose>

        <ul>
            <li><a href="/" class="btn btn--without-border active">Start</a></li>
            <li><a href="<jsp:include page="../links/hrefWhat.jsp"/>" class="btn btn--without-border">O co chodzi?</a></li>
            <li><a href="<jsp:include page="../links/hrefAbout.jsp"/>" class="btn btn--without-border">O nas</a></li>
            <li><a href="<jsp:include page="../links/hrefOrganizations.jsp"/>" class="btn btn--without-border">Fundacje i organizacje</a></li>
            <li><a href="<jsp:include page="../links/hrefContact.jsp"/>" class="btn btn--without-border">Kontakt</a></li>
        </ul>
    </nav>

    <div class="slogan container container--90">
        <div class="slogan--item">
            <h1>
                Zacznij pomagać!<br />
                Oddaj niechciane rzeczy w zaufane ręce*
            </h1>

            <ul class="slogan--buttons">
                <li style="justify-content: center;"><a href="/user#Form" class="btn btn--large">Oddaj rzeczy</a></li>
            </ul>
        </div>
    </div>
</header>

<section class="stats">
    <div class="container container--85">
        <div class="stats--item">
            <em>${bagsCount}</em>
            <h3>Oddanych worków</h3>
            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Eius est beatae, quod accusamus illum tempora!</p>
        </div>

        <div class="stats--item">
            <em>${supportedOrganizations}</em>
            <h3>Wspartych organizacji</h3>
            <p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Laboriosam magnam, sint nihil cupiditate quas quam.</p>
        </div>

        <div class="stats--item">
            <em>${giftsCount}</em>
            <h3>Zorganizowanych zbiórek</h3>
            <p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Quos dolores commodi error. Natus, officiis vitae?</p>
        </div>
    </div>
</section>

<a name="What"></a>
<section class="steps">
    <h2>Wystarczą 4 proste kroki</h2>

    <div class="steps--container">
        <div class="steps--item">
            <span class="icon icon--hands"></span>
            <h3>Wybierz rzeczy</h3>
            <p>ubrania, zabawki, sprzęt i inne</p>
        </div>
        <div class="steps--item">
            <span class="icon icon--arrow"></span>
            <h3>Spakuj je</h3>
            <p>skorzystaj z worków na śmieci</p>
        </div>
        <div class="steps--item">
            <span class="icon icon--glasses"></span>
            <h3>Zdecyduj komu chcesz pomóc</h3>
            <p>wybierz zaufane miejsce</p>
        </div>
        <div class="steps--item">
            <span class="icon icon--courier"></span>
            <h3>Zamów kuriera</h3>
            <p>kurier przyjedzie w dogodnym terminie</p>
        </div>
    </div>

    <a href="<jsp:include page="../links/hrefRegister.jsp"/>" class="btn btn--large">Załóż konto</a>
</section>

<a name="About"></a>
<section class="about-us">
    <div class="about-us--text">
        <h2>O nas</h2>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptas vitae animi rem pariatur incidunt libero optio esse quisquam illo omnis.</p>
        <img src="images/signature.svg" class="about-us--text-signature" alt="Signature" />
    </div>
    <div class="about-us--image"><img src="images/about-us.jpg" alt="People in circle" /></div>
</section>

<a name="Organizations"></a>
<section class="help">
    <h2>Komu pomagamy?</h2>

    <ul class="help--buttons">
        <li data-id="1"><a href="#" class="btn btn--without-border active">Fundacjom</a></li>
        <li data-id="2"><a href="#" class="btn btn--without-border">Organizacjom pozarządowym</a></li>
        <li data-id="3"><a href="#" class="btn btn--without-border">Lokalnym zbiórkom</a></li>
    </ul>

    <!-- SLIDE 1 -->
    <div class="help--slides active" data-id="1">
        <p>W naszej bazie znajdziesz listę zweryfikowanych Fundacji, z którymi współpracujemy. Możesz sprawdzić czym się zajmują, komu pomagają i czego potrzebują.</p>

        <ul class="help--slides-items">
            <li>
                <div class="col">
                    <div class="title">Fundacja "Dbam o Zdrowie"</div>
                    <div class="subtitle">Cel i misja: Pomoc dzieciom z ubogich rodzin.</div>
                </div>

                <div class="col"><div class="text">ubrania, jedzenie, sprzęt AGD, meble, zabawki</div></div>
            </li>

            <li>
                <div class="col">
                    <div class="title">Fundacja “Dla dzieci"</div>
                    <div class="subtitle">Cel i misja: Pomoc osobom znajdującym się w trudnej sytuacji życiowej.</div>
                </div>

                <div class="col"><div class="text">ubrania, meble, zabawki</div></div>
            </li>

            <li>
                <div class="col">
                    <div class="title">Fundacja “Bez domu”</div>
                    <div class="subtitle">Cel i misja: Pomoc dla osób nie posiadających miejsca zamieszkania</div>
                </div>

                <div class="col"><div class="text">ubrania, jedzenie, ciepłe koce</div></div>
            </li>
        </ul>

        <ul class="help--slides-pagination">
            <li><a href="#" class="btn btn--small btn--without-border active" data-page="1">1</a></li>
            <li><a href="#" class="btn btn--small btn--without-border" data-page="2">2</a></li>
            <li><a href="#" class="btn btn--small btn--without-border" data-page="3">3</a></li>
        </ul>
    </div>

    <!-- SLIDE 2 -->
    <div class="help--slides" data-id="2">
        <p>
            Lorem ipsum dolor, sit amet consectetur adipisicing elit. Hic officiis mollitia dolor, neque aspernatur accusamus debitis. Ducimus, officia. Quia, sunt illum! Non iste placeat ab ipsum alias
            quos suscipit corporis!
        </p>
        <ul class="help--slides-items">
            <li>
                <div class="col">
                    <div class="title">Organizacja 1</div>
                    <div class="subtitle">Lorem ipsum dolor sit amet consectetur.</div>
                </div>

                <div class="col"><div class="text">Lorem ipsum dolor sit amet consectetur adipisicing elit.</div></div>
            </li>

            <li>
                <div class="col">
                    <div class="title">Organizacja 2</div>
                    <div class="subtitle">Lorem ipsum dolor sit amet consectetur.</div>
                </div>

                <div class="col"><div class="text">Lorem ipsum dolor sit amet consectetur adipisicing elit.</div></div>
            </li>

            <li>
                <div class="col">
                    <div class="title">Organizacja 3</div>
                    <div class="subtitle">Lorem ipsum dolor sit amet consectetur.</div>
                </div>

                <div class="col"><div class="text">Lorem ipsum dolor sit amet consectetur adipisicing elit.</div></div>
            </li>

            <li>
                <div class="col">
                    <div class="title">Organizacja 4</div>
                    <div class="subtitle">Lorem ipsum dolor sit amet consectetur.</div>
                </div>

                <div class="col"><div class="text">Lorem ipsum dolor sit amet consectetur adipisicing elit.</div></div>
            </li>
        </ul>

        <ul class="help--slides-pagination">
            <li><a href="#" class="btn btn--small btn--without-border active" data-page="1">1</a></li>
            <li><a href="#" class="btn btn--small btn--without-border" data-page="2">2</a></li>
            <li><a href="#" class="btn btn--small btn--without-border" data-page="3">3</a></li>
            <li><a href="#" class="btn btn--small btn--without-border" data-page="4">4</a></li>
            <li><a href="#" class="btn btn--small btn--without-border" data-page="5">5</a></li>
        </ul>
    </div>

    <!-- SLIDE 3 -->
    <div class="help--slides" data-id="3">
        <p>Lorem ipsum dolor sit amet, his ocurreret persequeris ea, ad utinam laudem duo. Verterem adipisci partiendo eos ne, ea his reque quaeque recteque, ne quo lobortis intellegam.</p>
        <ul class="help--slides-items">
            <li>
                <div class="col">
                    <div class="title">Lokalna zbiórka 1</div>
                    <div class="subtitle">Lorem ipsum dolor sit amet consectetur.</div>
                </div>

                <div class="col"><div class="text">Lorem ipsum dolor sit amet consectetur adipisicing elit.</div></div>
            </li>

            <li>
                <div class="col">
                    <div class="title">Lokalna zbiórka 2</div>
                    <div class="subtitle">Lorem ipsum dolor sit amet consectetur.</div>
                </div>

                <div class="col"><div class="text">Lorem ipsum dolor sit amet consectetur adipisicing elit.</div></div>
            </li>
        </ul>

        <ul class="help--slides-pagination">
            <li><a href="#" class="btn btn--small btn--without-border active" data-page="1">1</a></li>
            <li><a href="#" class="btn btn--small btn--without-border" data-page="2">2</a></li>
        </ul>
    </div>
</section>


<a name="Contact"></a>
<jsp:include page="../components/footer.jsp"/>
<script src="js/app.js"></script>
</body>
</html>