package com.board.springboard.controller;

import com.board.springboard.model.dto.Product;
import com.board.springboard.model.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/product")
@RequiredArgsConstructor
public class ProductViewController {

    private final ProductService productService;

    // Todo 1 : 제품 목록 페이지 반환
    // GET /product/list → "product/product_list" JSP 반환
    @GetMapping("/list")
    public String 제품목록(Model model) {
        List<Product> products = productService.전체제품목록();
        model.addAttribute("products",products);
        // ??? products 라는 이름으로 JSP 에 데이터 전달하기
        return "product/product_list";
    }

    // Todo 2 : 제품 추가 폼 페이지 반환
    // GET /product/add → "product/addForm" JSP 반환
    @GetMapping("/add")
    public String 제품추가폼() {
        return "product/addForm";
    }

    // Todo 3 : 제품 추가 처리 후 목록으로 이동
    // POST /product/add → redirect:/product/list
    @PostMapping("/add")
    public String 제품추가처리(@ModelAttribute Product product,
                         RedirectAttributes redirectAttributes) {
        productService.제품추가(product);
        redirectAttributes.addFlashAttribute("msg", "제품이 등록되었습니다");  // 힌트: "제품이 등록되었습니다."
        return "redirect:/product/list";  // 힌트: redirect 로 목록 페이지로 보내기
    }

    // Todo 4 : 제품 수정 폼 페이지 반환
    // GET /product/edit?id=1 → "product/editForm" JSP 반환
    @GetMapping("/edit")
    public String 제품수정폼(@RequestParam int id, Model model) {
        Product productData = productService.제품단건(id);  // 힌트: id 로 단건 조회
        model.addAttribute("product", productData);  // 힌트: JSP 에서 product 라는 이름으로 사용 중
        return "product/editForm";
    }
}
