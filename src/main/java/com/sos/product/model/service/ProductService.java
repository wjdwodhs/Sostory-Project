package com.sos.product.model.service;

import static com.sos.common.template.JDBCTemplate.close;
import static com.sos.common.template.JDBCTemplate.commit;
import static com.sos.common.template.JDBCTemplate.getConnection;
import static com.sos.common.template.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import com.sos.common.model.vo.PageInfo;
import com.sos.member.model.vo.Member;
import com.sos.product.model.dao.ProductDao;
import com.sos.product.model.vo.AttachmentProduct;
import com.sos.product.model.vo.Product;
import com.sos.product.model.vo.ProductRecipe;
import com.sos.product.model.vo.ProductReview;
import com.sos.product.model.vo.Qna;

public class ProductService {
	
	private ProductDao pDao = new ProductDao();
	
	public List<Product> selectProductList(PageInfo pi){
		Connection conn = getConnection();
		
		List<Product> list = pDao.selectProductList(conn, pi);
		
		close(conn);
		
		return list;	
	}
	
	public int selectListCount() {
		Connection conn = getConnection();
		int count = pDao.selectListCount(conn);
		close(conn);
		return count;
	}
	
	public Product selectProduct(int productNo) {
		Connection conn = getConnection();
		Product pro = pDao.selectProduct(conn, productNo);
		close(conn);
		return pro;
	}
	
	public List<Member> selectPaymentUser() {
		Connection conn = getConnection();
		List<Member> list = pDao.selectPaymentUser(conn);
		close(conn);
		return list;
	}
	
	public int selectQnaCount(int productNo) {
		Connection conn = getConnection();
		int countList = pDao.selectQnaCount(conn, productNo);
		close(conn);
		return countList;
	}
	
	public List<Qna> selectQnaList(int productNo, PageInfo pi){
		Connection conn = getConnection();
		List<Qna> list = pDao.selectQnaList(conn, productNo, pi);
		close(conn);
		return list;
	}
	
	public List<ProductRecipe> selectRecipeList(int productNo){
		Connection conn = getConnection();
		List<ProductRecipe> rlist = pDao.selectRecipeList(conn, productNo);
		close(conn);
		return rlist;
	}
	
	public int selectReviewCount() {
		Connection conn = getConnection();
		int count = pDao.selectReviewCount(conn);
		close(conn);
		return count;
	}
	
	public List<ProductReview> selectReviewList(int productNo, PageInfo pi){
		Connection conn = getConnection();
		List<ProductReview> list = pDao.selectReviewList(conn, productNo, pi);
		close(conn);
		return list;
	}
	
	public int insertReview(ProductReview pr) {
		Connection conn = getConnection();
		int result = pDao.insertReview(conn, pr);
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		return result;
	}
	
	public int searchCountList(String search) {
		Connection conn = getConnection();
		int count = pDao.searchCountList(conn, search);
		close(conn);
		return count;
	}
	
	public List<Product> selectSearchList(String search, PageInfo pi){
		Connection conn = getConnection();
		List<Product> list = pDao.selectSearchList(conn, search, pi);
		close(conn);
		return list;
	}
	
	public int insertQna(String title, String content, int productNo, int userNo, AttachmentProduct ap) {
		Connection conn = getConnection();
		int result1 = pDao.insertQna(conn, title, content, productNo, userNo);
		int result2 = 1;
		if(ap !=null) {
			result2 = pDao.insertQnaFiles(conn, ap, productNo);			
		}
		if(result1 > 0 && result2 > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		close(conn);
		
		return result1 * result2;
	}
	
	public int selectJangListCount() {
		Connection conn = getConnection();
		int count = pDao.selectJangListCount(conn);
		close(conn);
		return count;
	}
	
	public List<Product> selectProductJang(PageInfo pi){
		Connection conn = getConnection();
		List<Product> list = pDao.selectProductJang(conn, pi);
		close(conn);
		return list;
	}
	

}
