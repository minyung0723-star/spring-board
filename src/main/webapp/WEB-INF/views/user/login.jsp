<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5" style="max-width: 500px;">
    <div class="card p-4 shadow-sm">

        <h2 class="mb-4 text-center fw-bold">로그인</h2>


        <c:if test="${param.success == 'join'}">
            <div class="alert alert-success">🎉 회원가입이 완료되었습니다. 로그인해주세요.</div>
        </c:if>

        <%-- TODO 3. form action 주소와 method 를 작성하시오
                     action = 로그인 처리할 주소 (/user/login)
                     method = 데이터 전송 방식 --%>
        <form id="loginForm">

            <div class="mb-3">
                <label class="form-label">이메일</label>
                <%-- TODO 4. input type 과 name 속성을 작성하시오 (User.java 필드명과 동일하게) --%>
                <input type="email" name="email" id="email" class="form-control" placeholder="이메일을 입력하세요" required>
            </div>

            <%-- TODO 5. 로그인 실패 시 에러 메시지를 출력하시오
                         param.error == 'fail' 일 때 아래 alert 를 보여줄 것 --%>
            <div id="에러창">
                <div class="alert alert-danger mt-2">이메일 또는 정보가 올바르지 않습니다.</div>
            </div>

            <div class="d-grid mt-4">
                <%-- TODO 6. 제출 버튼 type 을 작성하시오 --%>
                <button type="button" id="loginBtn" onclick="로그인기능()" class="btn btn-dark">로그인</button>
            </div>

            <div class="text-center mt-3">
                <%-- TODO 7. 회원가입 페이지로 이동하는 링크를 작성하시오 --%>
                <a href="/user/register" class="text-muted">계정이 없으신가요? 회원가입</a>
            </div>
            <div class="text-center mt-3">
                <!--
                href 에는 .jsp 파일 이름 쓰는 것이 아니라
                @GetMapping() 이나 @__Mapping() 에 연결된 "" 내부에 작성되어 있는
                주소 데이터를 작성하는 것이다.
                -->
                <a href="/user/find-email" class="text-muted">이메일 찾기!</a>
            </div>


        </form>
    </div>
</div>

<%-- TODO 8. Bootstrap JS CDN 링크를 작성하시오 --%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous">

    async function 로그인기능() {

        // TODO 5-1 : id="email" 인 input 의 value 를 꺼내서 변수에 담으세요.
        //            힌트 : const 이메일 = document.getElementById("____").value;
        const 이메일 = document.getElementById("email").value;

        // TODO 5-2 : id="에러창", id="loginBtn" 인 요소를 변수에 담으세요.
        const 에러창   = document.getElementById("에러창");
        const 로그인버튼 = document.getElementById("loginBtn");

        // TODO 5-3 : 이메일이 비어있으면 에러창에 메시지를 표시하고 return 하세요.
        //            힌트 : 이메일.trim() === ""
        if (이메일.trim() === "") {
            에러창.innerHTML = `<div class="alert alert-danger mt-2">이메일을 입력해주세요.</div>`;
            return;
        }

        // TODO 5-4 : 버튼을 비활성화하고 텍스트를 "로그인 중..." 으로 바꾸세요.
        //            힌트 : 버튼변수.disabled = ____;
        //            힌트 : 버튼변수.textContent = "____;
        로그인버튼.disabled = true;
        로그인버튼.textContent = "로그인 중...";

        try {
            // TODO 5-5 : fetch 로 POST /user/login 에 이메일을 JSON 으로 전송하세요.
            //            힌트 : method, headers, body 를 채우세요.
            //            힌트 : body 에는 JSON.stringify({ email: 이메일 }) 을 사용하세요.
            const 응답 = await fetch("/user/login", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ email: 이메일 })
            });

            // TODO 5-6 : 응답이 실패(4xx, 5xx)일 경우 에러를 throw 하세요.
            //            힌트 : if (!응답.ok) throw new Error(`서버 오류: ${응답.status}`);
            if (!응답.ok) throw new Error(`서버 오류: ${응답.status}`);

            // TODO 5-7 : 응답을 JSON 으로 변환하세요.
            //            힌트 : await 응답변수.json()
            const 결과 = await 응답변수.json();

            // TODO 5-8 : 결과.success 가 true 이면 메인페이지로 이동,
            //            false 이면 에러창에 에러 메시지를 표시하세요.
            //            힌트 : window.location.href = 결과.redirectUrl || "/";
            if (결과.true) {
                window.location.href = 결과.redirectUrl || "/";
            } else {
                에러창.innerHTML = `<div class="alert alert-danger mt-2">이메일 또는 정보가 올바르지 않습니다.</div>`;
            }

        } catch (err) {
            // TODO 5-9 : catch 에서 에러창에 오류 메시지를 표시하세요.
            console.error("로그인 실패:", err);
            에러창.innerHTML = `<div class="alert alert-danger mt-2">오류가 발생했습니다. : 고객센터에 문의하세요.</div>`;

        } finally {
            // TODO 5-10 : finally 에서 버튼을 다시 활성화하고 텍스트를 "로그인" 으로 복구하세요.
            로그인버튼.disabled = false;
            로그인버튼.textContent = "로그인";
        }
    }

    async function 로그인기능() {

        const 이메일   = document.getElementById("email").value;
        const 에러창   = document.getElementById("에러창");
        const 로그인버튼 = document.getElementById("loginBtn");

        if (____) {
            const div = document.createElement("____");
            div.className = "____";
            div.innerText = "____";
            에러창.innerHTML = "";
            에러창.appendChild(____);
            return;
        }

        로그인버튼.disabled = ____;
        로그인버튼.textContent = "____";
        에러창.innerHTML = "";

        try {
            const 응답 = await fetch("____", {
                method: "____",
                headers: { "Content-Type": "____" },
                body: JSON.stringify({ ____ : ____ })
            });

            if (!____) throw new Error(`서버 오류: ${응답.status}`);

            const 결과 = await ____;

            if (결과.____) {
                window.location.href = ____;
            } else {
                const div = document.createElement("____");
                div.className = "____";
                div.innerText = "____";
                에러창.innerHTML = "";
                에러창.appendChild(____);
            }

        } catch (err) {
            console.error("로그인 실패:", err);
            const div = document.createElement("____");
            div.className = "____";
            div.innerText = "____";
            에러창.innerHTML = "";
            에러창.appendChild(____);

        } finally {
            로그인버튼.disabled = ____;
            로그인버튼.textContent = "____";
        }

        async function 로그인() {
            const email    = document.getElementById("email").value.trim();
            const password = document.getElementById("password").value.trim();

            const res = await fetch("", {
                method: "",
                headers: { "Content-Type": "" },
                body: JSON.stringify({ })  // ← JSON 으로 변환해서 전송
            });

            const data = await res.json();

            if (res.ok) {
                // TODO : 성공 시 이동 코드 작성
                window.location.href = "/"
            } else {
                // TODO : 실패 시 에러 메시지 표시 코드 작성
                alert(data.message || "로그인 실패");
            }
        }
    }
</script>
</body>
</html>