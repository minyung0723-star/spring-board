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

        <div class="mb-3">
            <label class="form-label">이름</label>
            <input type="text" id="name" class="form-control" placeholder="이름을 입력하세요">
        </div>
        <div class="d-grid">
            <button type="button" class="btn btn-dark" onclick="이메일찾기기능()">검색</button>
        </div>
        <div id="결과창" class="mt-3"></div>
    </div>
</div>

<script>
    function 이메일찾기기능() {
        const 이름 = document.getElementById("name").value;  // 힌트: input id 값

        if (이름.trim() === "") {
            alert("이름을 입력해주세요.");
            return;
        }

        fetch("/user/find-email", {
            method: POST,  // 힌트: POST
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify({ name: 이름 })  // 힌트: 이름 변수 넣기
        })
            .then(res => res.json())
            .then(결과 => {
                const 결과창 = document.getElementById("결과창");
                if (결과.email) {
                    // Todo 12: 이메일이 있을 때 결과창에 표시하는 HTML 작성
                    결과창.innerHTML = <div class="alert alert-success"> 이메일: ${결과.email} </div>;
                    // 힌트: <div class="alert alert-success"> 이메일: ${결과.email} </div>
                } else {
                    // Todo 13: 에러일 때 결과창에 표시하는 HTML 작성
                    결과창.innerHTML = <div className="alert alert-danger"> 에러 메세지 표시 </div>;
                    // 힌트: <div class="alert alert-danger"> 에러 메세지 표시 </div>
                }
            })
            .catch(err => console.log("요청 실패:", err));
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>