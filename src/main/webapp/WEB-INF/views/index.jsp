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

<section class="hero text-center">
    <div class="container">
        <h1>Spring 게시판에 오신 것을 환영합니다.</h1>
        <p class="mt-3">봄같은 게시판 입니다.</p>
        <a href="/board/list" class="btn btn-dark mt-3 px-4">게시판 바로가기</a>
    </div>
</section>


<section class="py-5">
    <div class="container">
        <div class="row g-4 justify-content-center">
            <div class="col-md-4">
                <div class="card p-4 text-center h-100">
                    <div class="fs-1">📝</div>
                    <h5 class="mt-3 fw-bold">게시물 작성</h5>
                    <p class="text-muted">새로운 게시물을 작성해보세요.</p>
                    <a href="/board/write" class="btn btn-outline-dark mt-auto">작성하기</a>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card p-4 text-center h-100">
                    <div class="fs-1">📜</div>
                    <h5 class="mt-3 fw-bold">게시물 목록</h5>
                    <p class="text-muted">등록된 게시물을 확인세요.</p>
                    <a href="/board/list" class="btn btn-outline-dark mt-auto">목록보기</a>
                </div>
            </div>

        </div>
    </div>
</section>

<footer class="text-center py-4 mt-5">
    <div class="container">
        <small>&copy; 2026 SpringBoard. All rights reserved.</small>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
</body>
</html>