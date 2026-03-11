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
public class ProductController {

    private final ProductService productService;

    /**
     * @RequestMapping 이 존재할 경우 아래에 작성한 모든 매핑 앞에는
     * /product 주소가 자동으로 붙는다
     * @GetMapping("/list") 작성하더라도 주소창에서는 /product/list 형태로 들어가야지 제품 목록들을 확인할 수 있다.
     *
     *
     * @param model jsp 로 sql에서 가져온 데이터를 전달해주기위한 운반 수단
     * @return 클라이언트가 /product/list 주소로 접속했을 경우 보여질 jsp 파일 선택하여 보여주겠다.
     */
    @GetMapping("/list")
    public String 제품목록(Model model) {
        List<Product> productsData = productService.전체제품목록();
        model.addAttribute("products", productsData);
        return "product/product_list";
    }

    /**
     * GET /product/add 주소로 클라이언트가 접속하게 되면
     * 제품추가
     * @return webapp/WEB-INF/views/product/addForm.jsp 페이지를 반환처리한다.
     */
    @GetMapping("/add")
    public String 제품추가폼() {
        return "product/addForm";
    }

    @PostMapping("/add")
    public String 제품추가처리(@ModelAttribute Product product,
                         RedirectAttributes redirectAttributes) {
        productService.제품추가(product);
        redirectAttributes.addFlashAttribute("msg", "제품이 등록되었습니다.");
        return "redirect:/product/list";
    }

    // 조건 : @RequestParam 으로 id 받기
    @GetMapping("/edit") /* 주소에서 ? 로 시작하는  경로는 Mapping 내에 작성하지 않는다. */
    public String 제품수정폼(@RequestParam int id, Model model) {
        Product productData = productService.제품단건(id);
        model.addAttribute("product", productData);
        return "product/editForm";
    }

    @PutMapping("/edit")
    @ResponseBody
    public Product 제품수정처리(@ModelAttribute Product product,
                         RedirectAttributes redirectAttributes) {
        productService.제품수정(product);
        redirectAttributes.addFlashAttribute("msg", "제품이 수정되었습니다.");
        return product;
    }

    @DeleteMapping("/delete")
    @ResponseBody
    public String 제품삭제처리(@RequestParam int id,
                         RedirectAttributes redirectAttributes) {
        productService.제품삭제(id);
        redirectAttributes.addFlashAttribute("msg", "제품이 삭제되었습니다.");
        // 제품 리스트로 돌아가서 제품이 삭제되었다는 메세지를 잠깐 보기위해 redirectAttributes 로 가져온다.
        return "ok";
    }
/*
    @GetMapping("/delete")
    public String 제품삭제처리(@RequestParam int id,
                         RedirectAttributes redirectAttributes) {
        productService.제품삭제(id);
        redirectAttributes.addFlashAttribute("msg", "제품이 삭제되었습니다.");
        // 제품 리스트로 돌아가서 제품이 삭제되었다는 메세지를 잠깐 보기위해 redirectAttributes 로 가져온다.
        return "redirect:/product/list";
    }

 */
}
