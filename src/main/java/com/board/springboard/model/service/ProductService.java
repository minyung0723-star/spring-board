package com.board.springboard.model.service;

import com.board.springboard.model.dto.Product;
import com.board.springboard.model.mapper.ProductMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductMapper productMapper;

    public List<Product> 전체제품목록() {
        return productMapper.전체제품목록();
    }

    public Product 제품단건(int id) {
        return productMapper.제품단건(id);
    }

    public void 제품추가(Product product) {
        productMapper.제품추가(product);
    }

    public void 제품수정(Product product) {
        productMapper.제품수정(product);
    }

    public void 제품삭제(int id) {
        productMapper.제품삭제(id);
    }
}