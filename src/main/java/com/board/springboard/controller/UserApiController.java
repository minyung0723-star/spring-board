package com.board.springboard.controller;

import com.board.springboard.common.CookieUtil;
import com.board.springboard.model.dto.User;
import com.board.springboard.model.service.UserService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequiredArgsConstructor
public class UserApiController {

    private final UserService userService;
    private final CookieUtil cookieUtil;
    @Value("${file.upload.path}") // org.springframework.beans.factory.annotation.Value;
    private String uploadPath;

    @PostMapping("/user/check-email")
    public ResponseEntity<?> 이메일중복확인(@RequestBody Map<String, String> body) {
        boolean 중복 = userService.이메일중복체크기능(body.get("email"));
        return ResponseEntity.ok(Map.of("duplicate", 중복)); //이메일 중복했는데 중복이 맞다면 duplicate - 중복 전달
    }

    @PostMapping("/user/send-code)
    public ResponseEntity<?> 인증번호발송(@RequestBody Map<String, String> body) {
        userService.인증번호발송(body.get("email"));
        return ResponseEntity.ok(Map.of("message", "인증번호가 발송되었습니다."));
    }

    @PostMapping("/user/check-email")
    public ResponseEntity<?> 인증번호확인(@RequestBody Map<String, String> body) {
        boolean 성공 = userService.인증번호검증(body.get("email"), body.get("code"));
        if (!성공) return ResponseEntity.badRequest().body(Map.of("message", "인증번호가 올바르지 않습니다."));
        return ResponseEntity.ok(Map.of("message", "인증 성공"));
    }

    @PostMapping("/user/register")
    public ResponseEntity<?> 회원가입(@RequestBody User user) {
        boolean 성공 = userService.회원가입(user);
        if (!성공) return ResponseEntity.badRequest().body(Map.of("message", "이미 사용중인 이메일입니다."));
        return ResponseEntity.ok(Map.of("message", "회원가입 완료"));
    }

    @PostMapping("/user/login")
    public ResponseEntity<?> 로그인(@RequestBody Map<String, String> body,
                                 HttpServletResponse response) {
        Map<String, String> 토큰들 = userService.로그인(body.get("email"), body.get("password"));
        if (토큰들==null) return ResponseEntity.badRequest().body(Map.of("message", "이메일 또는 비밀번호가 올바르지 않습니다."));
        cookieUtil.추가(response, "access_token", 토큰들.get("accessToken"), 60 * 30);
        cookieUtil.추가(response, "refresh_token", 토큰들.get("refreshToken"), 60 * 30 * 24 * 14);
        return ResponseEntity.ok(Map.of("message", "로그인 성공"));
    }

    @PostMapping("/user/find-email")
    public Map<String, String> findEmail(@RequestBody Map<String, String> requestData) {
        User 유저데이터 = userService.이메일로유저찾기(requestData.get("email"));
        if (유저데이터 != null) {
            return Map.of("email", 유저데이터.getEmail());
        } else {
            return Map.of("error", "해당 이름으로 가입된 이메일이 없습니다.");
        }
    }

    // Todo 10 : 유저 정보 수정 (fetch() 로 요청 → JSON 응답)
    // POST /user/profile/edit
    // profile.jsp 의 버튼 onclick → fetch() → JSON 받아서 성공 메세지 표시
    @PostMapping("/user/profile/edit")
    public Map<String, String> 유저정보수정(@RequestBody User user, HttpSession session) {

        User 로그인유저 = (User) session.getAttribute("loginUser");
        if (로그인유저 == null) return Map.of("error", "로그인이 필요합니다.");
        user.setId(로그인유저.getId());
        userService.유저정보수정(user);
        User 최신유저 = userService.유저단건조회(로그인유저.getId());
        session.setAttribute("loginUser", 최신유저);
        return Map.of("msg", "정보가 수정되었습니다.");  // 힌트: 성공 메세지 작성
    }
}