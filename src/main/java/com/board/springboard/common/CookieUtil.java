package com.board.springboard.common;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;

import java.util.Arrays;

/**
 * 쿠기 관련 기능 모음집
 *
 * 쿠키 추가 삭제 꺼내기
 * 어느 컨트롤러에서든 주입받아 사용 가능
 */
@Component
public class CookieUtil {
    /** 쿠키 추가(HttpOnly = JS 접근 불가, 보안상 안전) */
    public void 추가(HttpServletResponse res, String 이름, String 값, int 유지시간초){
        Cookie cookie = new Cookie(이름, 값);
        cookie.setHttpOnly(true);
        cookie.setPath("/");
        cookie.setMaxAge(유지시간초);
        res.addCookie(cookie);
    }
    /** 쿠키 삭제 (유지시간을 0으로 설정하면 브라우저가 즉시 삭제*/
    public void 삭제(HttpServletResponse res, String 이름){
        Cookie cookie = new Cookie(이름, "");
        cookie.setMaxAge(0); // 쿠키가 존재할 수 있는 시간 없애기
        cookie.setPath("/"); // 어디서든 로그아웃 14일 30분이 지난 쿠키 데이터 삭제 가능하게 ok
        res.addCookie(cookie);
    }

    /** 요청 쿠키에서 툭정 이름의 꺼내기 (없으면 null 반환) JwtUtil 에 작성한 가져오기 가져와서 정리 */
    public String 가져오기(HttpServletRequest req, String 이름){
        Cookie[] 쿠키목록 = req.getCookies(); //요청에 담긴 모든 쿠키 가져오기
        if(쿠키목록 == null) return null; // 쿠키 자체가 없으면 null 반환

        // 쿠키 목록들을 스트림으로 변환
        return Arrays.stream(쿠키목록)
                //.filter(c-> "access_token".equals(c.getName())) // access_token 이름인 쿠키만 통과
                .filter(c-> 이름.equals(c.getName())) // access_token 이름인 쿠키만 통과
                .map(Cookie::getValue) // 쿠키 객체에서 값(토큰 문자열) 만 꺼내기
                .findFirst() // 첫 번째 결과 가져오기
                .orElse(null);// 없으면 null 반환
    }


}
