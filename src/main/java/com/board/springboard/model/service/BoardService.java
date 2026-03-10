package com.board.springboard.model.service;


import com.board.springboard.model.dto.Board;
import com.board.springboard.model.dto.BoardImage;
import com.board.springboard.model.mapper.BoardImageMapper;
import com.board.springboard.model.mapper.BoardMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor // new 자바객체파일() 생략
public class BoardService {
    // 보드 매퍼 에 작성된 기능을 활용하겠다.
    // 보드 매퍼 는 xml에서 가져온 SQL 기능을 보유하고 있는 명칭들의 집합소!
    private final BoardMapper boardMapper;
    private final BoardImageMapper boardImageMapper;

    @Value("${file.upload.board-path}")
    private String boardUploadPath; // application.yml -> config.yml 에서 가져오는 경로

    // 전체게시물 조회
    public List<Board> findAllBoard() {
        return boardMapper.전체게시물();
    }

    // 게시물 하나 조회 + 조회수 증가 추가
    public Board boardDetail(int board_no) {
        // 게시물을 불러오기 전에 조회수증가된 것을 수정하고
        boardMapper.조회수수정(board_no);
        // 소비자에게 소비자가 클릭한 게시물 데이터를 SQL 가져와서 화면에 전달한다.
        return boardMapper.단일게시물(board_no);
    }

    /**
     * 게시물 작성 + 다중 이미지 저장
     *
     * @param board      게시물 데이터 (title, writer, content)
     * @param imageFiles 첨부 이미지 목록 (최대 5장, 이미지 생략 해도 됨)
     * @throws IOException 데이터 가져오고 저장할 때 발생하는 모~든 문제에 대하여 예외처리
     *                     나중에 개발자는 예외 처리에 대하여 기획자가 기획한 방침에 따라
     *                     예외 처리 코딩을 진행해야 한다.
     */
    public void writeBoard(Board board, List<MultipartFile> imageFiles) throws IOException {
        // 1. 게시물을 먼저 DB에 저장한다. 저장한다음 board_no 게시물 번호를 자동으로 생성하게 한다.
        // 그리고   useGeneratedKeys="true" keyProperty="board_no" 를 이용해서
        //         키번호는 자동으로 생성좀 하고, 키 속성은 자바에서 가지고 있을게
        // board_no 로 생성된 현재 게시물의 번호를 자바에서 실시간으로 가져와 활용한다.
        boardMapper.게시물추가(board);
        // 2. 만약에 이미지 파일이 없으면 게시물 추가만하고, 종료
        if (imageFiles == null & imageFiles.isEmpty()) return;

        // 3. 이미지가 존재한다면 저장 폴더 자동 생성
        File folder = new File(boardUploadPath);
        if (!folder.exists()) folder.mkdirs();
        // 4. 최대 5장 제한하며 반복 저장
        // 현재 이미지를 저장하고 있는 이미지 번호
        int count = 0;
        for (MultipartFile 이미지한장 : imageFiles) {
            // 만약에 이미지가 총 5장중 3장이거나 이미지가 없는 파일은 건너뛰기
            if (이미지한장 == null || 이미지한장.isEmpty()) continue; // 지금 파일은 넘어가고 다음 파일 저장 시작

            // 이미지 최대 5장 초과 시 저장 중단
            if (count >= 5) break; // 0 번 ~ 4번 까지가 총 5장이기 때문에 5장 이상부터는 저장 멈춤!!!
            // UUID + 확장자로 파일명 생성
            String 원본파일이름 = 이미지한장.getOriginalFilename();
            String 확장자 = 원본파일이름.substring(원본파일이름.lastIndexOf("."));
            String 저장할파일 = UUID.randomUUID().toString() + 확장자;

            // 회사 컴퓨터 개발자 컴퓨터에 진짜 이미지 파일 저장
            File 파일저장 = new File(boardUploadPath + "/" + 저장할파일);
            이미지한장.transferTo(파일저장);

            // board_images 테이블에 이미지 경로 저장 회사 컴퓨터 개발자 컴퓨터 경로와 다르게 훼이크 경로 저장
            String 웹에서_접근할_경로 = "/board/" + 저장할파일;

            BoardImage 다중이미지저장테이블 = new BoardImage();
            다중이미지저장테이블.setBoard_no(board.getBoard_no()); // 방금 저장된 게시물 번호
            다중이미지저장테이블.setImg_path(웹에서_접근할_경로);
            //  board.setAttach_img(웹에서_접근할_경로);
            boardImageMapper.이미지저장(다중이미지저장테이블);

            count++;
        }
        //boardMapper.게시물추가(board);
    }

    /*
    단일 이미지 추가 게시물 저장
    public void writeBoard(Board board, MultipartFile imageFile) throws IOException {
      // TODO 1 : 만약 이미지 파일이 있을 경우에만 컬럼 데이터 업로드
        if(imageFile != null & !imageFile.isEmpty()) {
        // TODO 2 : 회사컴퓨터 or 개발자컴퓨터에 저장 폴더 없으면 자동 생성
            File folder = new File(boardUploadPath);
            if (!folder.exists()) folder.mkdirs();

        // TODO 3 : UUID + 원본 확장자로 파일명 생성 (중복파일명 충돌 방지)
            String 원본파일이름 = imageFile.getOriginalFilename();
            String 확장자 = 원본파일이름.substring(원본파일이름.lastIndexOf("."));
            String 저장할파일 = UUID.randomUUID().toString()+확장자;

        // TODO 4 : 회사컴퓨터 or 개발자컴퓨터에 실제 클라이언트가 전달한 파일 저장
            File 파일저장 = new File(boardUploadPath + "/" + 저장할파일);
            imageFile.transferTo(파일저장);

        // TODO 5 : DB에 저장할 웹 접근 경로를 Board 객체 세팅
            String 웹에서_접근할_경로 = "/board/" + 저장할파일;
            // String 웹에서_접근할_경로 = "/board" + 저장할파일;
            // board파일이름랜덤.png 로 board가 파일이름 앞에 붙는 신세가 된다.
            board.setAttach_img(웹에서_접근할_경로);
        }
        // TODO 6 : DB에 게시물 저장 (이미지 없으면 attach_img = null 로 저장되며, 수정할 일 없음)
        boardMapper.게시물추가(board);

    }


    */
    // 게시물 수정 유무 나중에 확인
    public void updateBoard(Board board) {
        boardMapper.게시물수정(board);
    }

    // 게시물 삭제 유무 나중에 확인
    public void deleteBoard(int board_no) {
        boardMapper.게시물삭제(board_no);
    }
}