package com.board.springboard.controller;

import com.board.springboard.model.dto.Board;
import com.board.springboard.model.service.BoardService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController // @Controller + @ResponseBody
@RequiredArgsConstructor
public class BoardApiController {
    private final BoardService boardService;

    @PostMapping("/board/write")
    public Board writeBoard(Board board, @RequestParam(required = false)List<MultipartFile> imageFiles) throws Exception{
        boardService.writeBoard(board, imageFiles);
        //return "redirect:/board/list"; //jsp 로 이동하는게 아니라 화면에 redirect:/board/list 글자가 찍힐 것
        //return "ok"; //ok 글자가 화면으로 전달
        return board; //board 데이터가 화면으로 전달되거나 보통 성공 실
    }

    @PutMapping("/board/edit")
    public Board editBoard(@RequestBody Board board){
        boardService.updateBoard(board);
        return board;
    }
}
