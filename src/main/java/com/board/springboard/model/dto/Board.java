package com.board.springboard.model.dto;

/*
import = pom.xml이나 build.gradle 또는 자바 라이브러리에 저장되어 있는 기능을 가져와서 사용한다

lombok = 특정 부서나 회사에서 만든 모듈
       = 모두다 현재 자바 class 파일에서 사용하겠다.
       = all
 */
import lombok.*;

import java.time.LocalDateTime;

@Getter @Setter @NoArgsConstructor @AllArgsConstructor @ToString
public class Board {

    private Integer board_no;
    private String title;
    private String content;
    private String writer;
    private LocalDateTime created_at;
    private int view_count;
    /*
    primary key 에 해당하는 컬럼은 Integer 나 Long 인 데이터 공간으로 설정
    이외는 String float int ... 개발자가 만든 자료형 형태로   공간    설정

    Integer board_no
      ===> 현재 DB에는 게시물이 0~10 개까지 존재한다면
           인터넷주소 : https://www.인터넷.com/게시물/1번게시물
           ... 어떤 사용자가 30번 게시물 접속한다면
           SQL 에는 30번 게시물이 존재하지 않기 때문에 null 뜨는 것이 당연하며,
           null 데이터인 상세페이지를 개발자가 Exception 이나 try-catch로 처리해야 한다.

    int view_count = 게시물 조회수
      ===> 0부터 게시물을 조회하는 대로 숫자가 +1씩 알아서 자동증가 하도록
            개발자가 세팅
            null 데이터가 들어가서는 안되며 반드시 0 부터 1씩 순차적으로 조회수 증가해야하는 변수 데이터
     */
}
