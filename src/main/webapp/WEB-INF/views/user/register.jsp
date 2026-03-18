<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

</head>
<body class="bg-light">

<div class="container mt-5" style="max-width: 500px;">
    <div class="card p-4 shadow-sm">
        <h2 class="mb-4 text-center fw-bold">회원가입</h2>
        <div id="에러창">
            <div class="alert alert-danger">이미 사용중인 이메일입니다.</div>
        </div>
        <form id="registerForm">

            <div class="mb-3">
                <label class="form-label">이름</label>
                <input type="text" name="name" id="name" class="form-control" placeholder="이름을 입력하세요" required>
            </div>

            <div class="mb-3">
                <label class="form-label">이메일</label>
                <input type="email" name="email" id="email" class="form-control" placeholder="이메일을 입력하세요" required>
            </div>
            <!--
            type="email" @ .이 존재하게끔 클라이언트는 작성했는지 체크
            name="email" jsp -> java -> sql로 전달할 때 데이터가 들어있는 운반상자 명칭

            type="email"  = 클라이언트가 이메일을 작성할 때 @ . 를 작성했는지 확인하는 타입
            name="email"  = model.dto.User.java 파일에서 private String email로
                            데이터를 SQL에 운반할동안 잠시 담아두는 명칭으로 사용되고 있다.
                            그리고 그명칭을 프론트엔드 에서도 똑같이 맞춰서 email로 사용할 것이다.
            -->
            <div class="d-grid mt-4">
                <button type="button" id="registerBtn" onclick="회원가입기능()" class="btn btn-dark">가입하기</button>
            </div>

            <div class="text-center mt-3">
                <a href="/user/login" class="text-muted">이미 계정이 있으신가요? 로그인</a>
            </div>

        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous">

    async function 회원가입기능() {

        const 이름   = document.getElementById("name").value.trim();
        const 이메일  = document.getElementById("email").value.trim();
        const 에러창  = document.getElementById("애러창");
        const 가입버튼 = document.getElementById("registerBtn");

        if (!이름) {
            const div = document.createElement("name");
            div.className = "alert alert-danger";
            div.innerText = "이름을 입력해주세요.";
            에러창.innerHTML = "";
            에러창.appendChild(div);
            return;
        }

        if (!이메일) {
            const div = document.createElement("email");
            div.className = "alert alert-danger";
            div.innerText = "이메일을 입력해주세요";
            에러창.innerHTML = "";
            에러창.appendChild(div);
            return;
        }

        가입버튼.disabled = true;
        가입버튼.textContent = "가입이 완료되었습니다.";
        에러창.innerHTML = "";

        try {
            const 응답 = await fetch("/user/register", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ name : 이름, email : 이메일 })
            });

            if (!응답.ok) throw new Error(`서버 오류: ${응답.status}`);

            const 결과 = await 응답.json();

            if (결과.success) {
                window.location.href = "____";
            } else if (결과.error === "email") {
                const div = document.createElement("email");
                div.className = "alert alert-danger";
                div.innerText = "이미 사용중인 이메일입니다.";
                에러창.innerHTML = "";
                에러창.appendChild(div);
            } else {
                const div = document.createElement("email");
                div.className = "alert alert-danger";
                div.innerText = "____";
                에러창.innerHTML = "";
                에러창.appendChild(div);
            }

        } catch (err) {
            const div = document.createElement("____");
            div.className = "alert alert-danger";
            div.innerText = "회원가입에 실패하였습니다.";
            에러창.innerHTML = "";
            에러창.appendChild(div);

        } finally {
            가입버튼.disabled = false;
            가입버튼.textContent = "____";
        }

        let 이메일인증완료 = false;  // 인증 완료 여부 저장 변수

        async function 인증번호발송() {
            const email = document.getElementById("email").value.trim();

            const res = await fetch("", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({email: email})
            });

            if (res.ok) {
                document.getElementById("code-area").style.display = "block";
                alert("인증번호가 발송되었습니다.")
                // TODO : 인증번호 입력란 노출 코드 작성
            }
        }

        async function 인증번호확인() {
            const email = document.getElementById("email").value.trim();
            const code  = document.getElementById("code").value.trim();

            const res = await fetch("", {
                method: "",
                headers: { "Content-Type": "" },
                body: JSON.stringify({  })
            });

            if (res.ok) {
                이메일인증완료 = true;
                // TODO : 성공 메시지 표시 + 입력란 비활성화 코드 작성
            } else {
                // TODO : 실패 메시지 표시 코드 작성
            }
        }

        async function 회원가입() {
            if (!이메일인증완료) {
                // TODO : 인증 미완료 안내 코드 작성
                return;
            }

            const name     = document.getElementById("name").value.trim();
            const email    = document.getElementById("email").value.trim();
            const password = document.getElementById("password").value.trim();

            const res = await fetch("", {
                method: "",
                headers: { "Content-Type": "" },
                body: JSON.stringify({  })
            });

            if (res.ok) {
                // TODO : 성공 시 이동 코드 작성
            } else {
                // TODO : 실패 시 에러 메시지 표시 코드 작성
            }
        }
    }
</script>
</body>
</html>