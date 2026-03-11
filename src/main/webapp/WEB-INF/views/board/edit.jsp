<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>${board.title} - 수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5" style="max-width: 100%">
    <div class="fw-bold mb-4">게시물 수정</div>
    <form> <!-- action="/board/edit" method="post" -->
        <input name="board_no" value="${board.board_no}">

        <div class="mb-3">
            <label for="title" class="form-label fw-semibold">제목</label>
            <input type="text" id="title" name="title" class="form-control" value="${board.title}">
        </div>

        <div class="mb-3">
            <label for="content" class="form-label fw-semibold">내용</label>
            <input type="text" id="content" name="content" class="form-control" rows="10" value="${board.content}">
        </div>

        <div class="text-end">
            <a href="/board/detail?no=${board.board_no}" class="btn btn-outline-secondary">취소</a>
            <button type="button" class="btn btn-warning" onclick="수정완료버튼기능()">수정완료</button>
        </div>
    </form>
</div>
<script>
    /*
    기능작성시작   기능의명칭(매개변수자리){기능세부작동내용}
    function       수정완료버튼기능()   {}
    */
    function 수정완료버튼기능(){

        const 제목 = document.getElementById("title");
        const 콘텐츠 = document.getElementById("content");

        if(제목.value.trim() === ""){
            alert("제목을 입력해주세요.");
            제목.focus();
        }

        if(내용.value.trim() === ""){
            alert("내용을 입력해주세요.");
            콘텐츠.focus();
        }

        const 백엔드로_전달할_데이터들 = {
            board_no : document.getElementById("board_no").value,
            title    : 제목,
            content  : 콘텐츠
        };
        fetch("/board/edit", {
            method: 'PUT',
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify(백엔드로_전달할_데이터들)
        })
            .then(res => res.json())
            .then(결과 => {
                location.href="/board/detail?no="+결과.board_no;
            })
            .catch(err => console.log("백엔드 전송을 실패했다면 왜 실패 했나요?! :", err));
    }
</script>
</body>
</html>