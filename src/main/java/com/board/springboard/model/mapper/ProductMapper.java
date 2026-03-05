package com.board.springboard.model.mapper;

import com.board.springboard.model.dto.Product;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 전체 목록 반환타입 List<개발자가 만든 class 문서 파일 명칭> 기능명칭(대부분 매개변수 존재하지 않음);
 *      단건 반환타입 개발자가 만든 class 문서 파일 명칭       기능명칭(primary key 명칭);
 *      추가 반환타입 int       or      void                 기능명칭(개발자가_만든_class_문서_파일명칭_자료형 매개변수명칭);
 *      수정 반환타입 int       or      void                 기능명칭(개발자가_만든_class_문서_파일명칭_자료형 매개변수명칭);
 *      삭제 반환타입 int       or      void                 기능명칭(대부분 매개변수로 primary key명칭);
 *
 * 제품 추가 수정 삭제의 경우 1건 에 대하여 작업을 하거나, 작업에 대한 결과 유무만 확인할 경우 void 사용
 *                                                      작업에 대하여 rows 여러 건에 대하여 처리할 경우 int 사용
 *                                                      몇개가 추가되었고, 수정되었고, 삭제되었는지 확인 후
 *                                                      추가 작업을 진행해야할 경우 사용
 *
 * 검색 결과 반환타입 List<개발자가 만든 class 문서 파일 명칭>   기능명칭(String keyword);
 * 검색 키워트를 SQL로 전달하고, 검색에 대한 결과가 0건부터 n건 이기 때문에 목록형태로하여 데이터를 전달받음
 */

@Mapper
public interface ProductMapper {
    //제품 전체 목록 조회
    List<Product> 전체제품목록();
    //제품 단건 조회
    Product 제품단건(int id);
    //제품 추가
    void 제품추가(Product product);

    //제품 수정
    void 제품수정(Product product);

    //제품 삭제
    void 제품삭제(int id);
}
