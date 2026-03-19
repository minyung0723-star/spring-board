<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<nav  class="navbar navbar-expand-lg navbar-dark bg-dark">
<div class="container">

    <%-- 브랜드명 --%>
    <a class="navbar-brand" href="/">SpringBoard</a>

    <button class="navbar-toggler" type="button"
            data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
    </button>


    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ms-auto">

            <li class="nav-item">
                <a class="nav-link" href="/board/list">게시판</a>
            </li>

                <li class="nav-item">
                    <a class="nav-link" href="/product/list">제품목록</a>
                </li>
            <%--
            세션 방식 삭제
            JWT 방식을 서버가 세션을 안 만들기 때문에 sessionScope.loginUser 가 항상 비어있다.
            항상 비로그인으로 보임
            <c:if test="${empty sessionScope.loginUser}">
                <li class="nav-item">
                    <a class="nav-link" href="/user/register">회원가입</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/user/login">로그인</a>
                </li>
            </c:if>


            <c:if test="${not empty sessionScope.loginUser}">
                <li class="nav-item">

                    <a class="nav-link" href="/user/profile">
                            ${sessionScope.loginUser.name}님 환영해요!
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/user/logout">로그아웃</a>
                </li>
            </c:if>
            --%>

                <li class="nav-item" id="메뉴_회원가입">
                    <a class="nav-link" href="/user/register">회원가입</a>
                </li>
                <li class="nav-item" id="메뉴_로그인">
                    <a class="nav-link" href="/user/login">로그인</a>
                </li>

                <li class="nav-item d-none" id="메뉴_프로필">
                    <a class="nav-link" href="/user/profile">
                            <span id="유저이름"></span> 님 환영해요!
                    </a>
                </li>
                <li class="nav-item d-none" id="메뉴_로그아웃">
                    <a class="nav-link" href="#" onclick="로그아웃()">로그아웃</a>
                </li>

        </ul>
    </div>
</div>
</nav>

<script>
    //async 비동기
    async function 로그인상태확인(){
        try{
             const res = await fetch("/user/profile-info", {method:"GET"})
            if (res.ok){
                const data = await res.json();
                document.getElementById("메뉴_회원가입").classList.add("d-none");
                document.getElementById("메뉴_로그인").classList.add("d-none");
                document.getElementById("메뉴_프로필").classList.remove("d-none");
                document.getElementById("메뉴_로그아웃").classList.remove("d-none");
                document.getElementById("유저이름").textContent = data.name;
            }
        } catch (e) {
            console.log(e)
        }
    }

    async function 로그아웃(){
        await fetch("/user/logout",{method: "POST"});
        window.location.href = "/";
    }
    로그인상태확인();

</script>