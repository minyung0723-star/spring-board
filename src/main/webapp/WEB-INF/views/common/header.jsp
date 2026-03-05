<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Spring Board</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .hero {
            background-color: #ffffff;
            border-bottom: 1px solid #e9ecef;
            padding: 80px 0;
        }

        .card {
            border: none;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
            transition: transform;
        }

        .card:hover {
            transform: translateY(-4px);
        }
    </style>
</head>
<body>

<ul class="navbar-nav ms-auto">
    <li class="nav-item">
        <a class="nav-link" href="/board/list">게시판</a>
    </li>

    <c:if test="${empty sessionScope.loginUser}">
        <li class="nav-item">
            <a class="nav-link" href="/user/register">회원가입</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/user/login">로그인</a>
        </li>
    </c:if>

    <c:if test="${not empty sessionScope.loginUser}">

        <%-- 출력 형식 : "홍길동님 환영해요!" --%>
        <li class="nav-item">
            <span class="nav-link">${sessionScope.loginUser.name}님 환영해요!</span>
        </li>

        <li class="nav-item">
            <a class="nav-link" href="/user/logout">로그아웃</a>
        </li>
    </c:if>

</ul>