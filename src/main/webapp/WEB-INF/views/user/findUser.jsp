<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>유저 찾기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5" style="max-width: 500px;">
    <div class="card p-4 shadow-sm">
        <h2 class="mb-4 text-center fw-bold">이메일로 유저 찾기</h2>

        <form action="/user/find" method="post">
            <div class="mb-3">
                <label class="form-label">이메일</label>
                <input type="email" name="email" class="form-control" placeholder="이메일을 입력하세요" required>
            </div>
            <div class="d-grid">
                <button type="submit" class="btn btn-dark">검색</button>
            </div>
        </form>


        <c:if test="${user != null}">
            <hr class="mt-4">
            <h5 class="mt-3 fw-bold">조회 결과</h5>
            <table class="table mt-3">
                <tr>
                    <th>이름</th>
                    <td>${user.name}</td>
                </tr>
                <tr>
                    <th>이메일</th>
                    <td>${user.email}</td>
                </tr>
                <tr>
                    <th>가입일</th>
                    <td>${user.create_at}</td>
                </tr>
            </table>
        </c:if>

        <c:if test="${param.error == 'notfound'}">
            <div class="alert alert-danger mt-4">존재하지 않는 이메일입니다.</div>
        </c:if>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>