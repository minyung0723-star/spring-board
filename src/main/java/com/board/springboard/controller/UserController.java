package com.board.springboard.controller;

import com.board.springboard.model.dto.User;
import com.board.springboard.model.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    /**
     * 회원가입 페이지 이동
     *
     * @return user/register.jsp
     */
    @GetMapping("/user/register")
    public String registerView() {
        return "user/register";
    }

    /**
     * 회원가입 처리 (DB 저장)
     * 성공 시 로그인 페이지로 이동
     * 실패(이메일 중복) 시 회원가입 페이지로 이동
     *
     * @param user 작성된 회원 데이터
     * @return 성공 → 로그인 페이지 / 실패 → 회원가입 페이지
     */
    @PostMapping("/user/register")
    public String register(User user) {
        /*
        UserService 의 회원가입 기능을 실행한다.
        클라이언트가 입력한 회원 정보(user)를 전달하며,
        회원가입 처리 결과(성공 = true, 실패 = false)를
        result 에 담아 결과에 따라 클라이언트를 다른 페이지로 안내한다.
         */
        boolean result = userService.회원가입(user);
        if (result) { // 회원가입을 성공했을 경우 로그인을 위하여
            // 개발자가 로그인페이지로 클라이언트를 이동처리
            return "redirect:/user/login";
        } else { // result 가 false 일 경우
            return "redirect:/user/resister";
        }
    }

    /**
     * 로그인 페이지 이동
     *
     * @return user/login.jsp
     */
    @GetMapping("/user/login")
    public String loginView() {
        return "user/login";
    }


    @PostMapping("/user/login")
    public String login(@RequestParam String email, HttpSession session) {
        /*
        email로 userService.로그인 기능을 작동한 결과는 User 객체 타입으로 데이터가 존재하며,
        SQL 결과를 로그인한유저데이터 라는 변수 명칭의 공간에 잠시 담아둘 것
        로그인기능이 User 라는 타입으로 전달할 예정이기 때문에 로그인한유저데이터 라는 공간 또한
        User 형태로 생성하여 메모리에 존재하도록 설정
         */
        User 로그인한유저데이터 = userService.로그인(email);

        if (로그인한유저데이터 != null) { // 로그인한 유저 정보가 존재하는게 사실일경우
            // 로그인성공 -> 세션에 유저 정보 저장
            session.setAttribute("loginUser", 로그인한유저데이터);
            return "redirect:/";
        } else { // 로그인실패할 경우 에러 파라미터와 함께 로그인 페이지로 이동
            return "redirect:/user/login?error=fail";
        }
    }

    /**
     * 로그아웃 처리
     * 세션을 초기화하고 메인페이지로 이동
     *
     * @param session 현재 로그인된 세션
     * @return 메인페이지로 redirect
     */
    @GetMapping("/user/logout")
    public String 로그아웃(HttpSession session) {
        session.invalidate(); // 세션 전체 초기화
        return "redirect:/";
    }

    @GetMapping("/user/find-email")
   public String findEmailView(){
        return "user/findUser";

    }

    @PostMapping("/user/find-email")
    public String findEmail(@RequestParam String name, Model model){
        User 유저데이터 = userService.이메일로유저찾기(name);

        if(유저데이터 != null){
            model.addAttribute("email", 유저데이터.getEmail());
        } else{
            model.addAttribute("error", "해당 이름으로 가입된 이메일이 없습니다");
        }
        return "user/findUser";
    }

    /*
    //미완성된 기능
    접근제어자 반환타입 기능명칭(매개변수자리);

    //완성된 기능 {}내부에 기능이 작성되지 않더라도 {} 존재 자체만으로 완성된 기능
    접근제어자 반환타입 기능명칭(매개변수자리){기능자리}
     */
}