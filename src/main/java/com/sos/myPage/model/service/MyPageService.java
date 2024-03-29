package com.sos.myPage.model.service;

import static com.sos.common.template.JDBCTemplate.close;
import static com.sos.common.template.JDBCTemplate.commit;
import static com.sos.common.template.JDBCTemplate.getConnection;
import static com.sos.common.template.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.sos.cart.model.vo.Order;
import com.sos.member.model.vo.Member;
import com.sos.myPage.model.dao.MyPageDao;
import com.sos.myPage.model.vo.Address;
import com.sos.myPage.model.vo.Liked;
import com.sos.product.model.vo.AttachmentProduct;
import com.sos.product.model.vo.Product;
import com.sos.product.model.vo.Qna;
import com.sos.recipe.model.vo.Recipe;

public class MyPageService {

	private MyPageDao mpDao = new MyPageDao();
	
	/**
	 * 마이페이지에서 사용자가 비밀번호변경 요청을 했을 경우 실행될 메소드
	 * 
	 * @param mem : 사용자의 수정비밀번호, 회원번호, 기존비밀번호 정보가 담긴객체
	 * @return : 비밀번호 수정요청 처리결과 행 수
	 */
	public int updateMemberPwd(HashMap<String, Object> mem) {
		
		Connection conn = getConnection();
		
		int result = mpDao.updateMemberPwd(conn, mem);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
		
		
	}
	
	/**
	 * 마이페이지에서 사용자가 회원정보 변경요청시 실행될 메소드
	 * 
	 * @param mem : 수정할 회원정보가 담긴 회원객체
	 * @return : 회원정보 변경요청 처리결과 행 수
	 */
	public int updateMemberInfo(Member mem) {
		
		Connection conn = getConnection();
		
		int result = mpDao.updateMemberInfo(conn, mem);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
		
	}
	
	/**
	 * 마이페이지에서 사용자가 회원탈퇴 요청시 실행될 메소드
	 * 
	 * @param userNo : 탈퇴할 회원번호
	 * @return : 회원탈퇴(USER_STATUS = 'N') 요청처리 결과 행 수
	 */
	public int deleteMember(int userNo) {
		
		Connection conn = getConnection();
		
		int result = mpDao.deleteMember(conn, userNo);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
		
	}
	
	/**
	 * 마이페이지에서 사용자가 배송지관리페이지 요청시 실행될 메소드 (배송지리스트 조회)
	 * 
	 * @param userNo : 서비스요청 사용자의 회원번호
	 * @return : 조회된 해당회원의 배송지객체 리스트 (null | 리스트)
	 */
	public List<Address> selectAddressList(int userNo){
		
		Connection conn = getConnection();
		
		List<Address> list = mpDao.selectAddressList(conn, userNo);
		
		close(conn);
		
		return list;
		
	}
	
	/**
	 * 기존배송지 정보조회 요청시 실행될 메소드
	 * 
	 * @param addressNo : 조회할 배송지의 배송지번호
	 * @return : 조회된 배송지정보를 담은 배송지객체
	 */
	public Address selectAddress(int addressNo) {
		
		Connection conn = getConnection();
		
		Address addr = mpDao.selectAddress(conn, addressNo);
		
		close(conn);
		
		return addr;
		
	}
	
	/**
	 * 배송지등록 | 배송지수정 요청시 해당 사용자의 기본배송지 유무조회시 실행될 메소드
	 * 
	 * @param conn
	 * @param userNo : 배송지 추가 | 수정 요청 사용자의 회원번호
	 * @return : 조회된 해당사용자의 기본배송지 갯수
	 */
	public int selectDefaultAddress(int userNo) {
		
		Connection conn = getConnection();
		
		int count = mpDao.selectDefaultAddress(conn, userNo);
		
		close(conn);
		
		return count;
		
	}
	
	/**
	 * 배송지등록 | 배송지수정시 새로운 배송지를 기본배송지로 지정할 경우 실행될 메소드 (기존 기본배송지 ADDRESS_TYPE = 'N')
	 * 
	 * @param conn
	 * @param userNo : 배송지등록 | 배송지수정 요청한 사용자의 회원번호
	 * @return : 배송지유형(ADDRESS_TYPE) 수정요청 처리결과 행 수
	 */
	public int updateAddressType(int userNo) {
		
		Connection conn = getConnection();
		
		int result = mpDao.updateAddressType(conn, userNo);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
		
	}
	
	/**
	 * 마이페이지에서 배송지관리페이지에서 배송지등록 요청시 실행될 메소드
	 * 
	 * @param addr : 등록할 배송지정보가 담긴 배송지객체
	 * @return : 신규 배송지등록 처리결과 행 수
	 */
	public int insertAddress(Address addr) {
		
		Connection conn = getConnection();
		
		int resultAddr = mpDao.insertAddress(conn, addr);	// 신규배송지 추가등록 처리결과
		
		int resultMem = 0;		// 회원정보 수정요청 처리결과를 담을 변수
		
		if(resultAddr > 0) {
			
			// 신규배송지 추가성공시 : 회원정보 수정일(MODIFY_DATE) 수정요청
			resultMem = mpDao.updateMemberModifyDate(conn, addr.getAddressWriter());
			
			if(resultMem > 0) { // 회원정보 수정일(MODIFY_DATE) 수정성공시
				commit(conn);				
			}
		}else {
			rollback(conn);
		}
		
		close (conn);
		
		return resultAddr * resultMem;
		
	}
	
	/**
	 * 마이페이지에서 사용자가 배송지수정 요청시 실행될 메소드
	 * 
	 * @param conn
	 * @param addr : 수정할 배송지정보가 담긴 배송지객체
	 * @return : 배송지수정 처리결과 행 수
	 */
	public int updateAddress(Address addr) {
		
		Connection conn = getConnection();
		
		int resultAddr = mpDao.updateAddress(conn, addr);	// 배송지 수정요청 처리결과
		
		int resultMem = 0;		// 회원정보 수정일(MODIFY_DATE) 수정요청 처리결과를 담을 변수
		
		if(resultAddr > 0) {
			
			// 배송지 수정성공시 : 회원정보 수정일(MODICY_DATE) 수정요청
			resultMem = mpDao.updateMemberModifyDate(conn, addr.getAddressWriter());
			
			if(resultMem > 0) { // 회원정보 수정일(MODIFY_DATE) 수정성공시
				commit(conn);				
			}
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return resultAddr * resultMem;
	}
	
	/**
	 * 사용자가 마이페이지에서 배송지 삭제요청시 실행될 메소드
	 * 
	 * @param addr : 삭제할 배송지번호, 회원번호 정보가 담긴 배송지객체
	 * @return : 배송지 삭제요청 처리결과 행 수
	 */
	public int deleteAddress(Address addr) {
		
		Connection conn = getConnection();
		
		int resultAddr = mpDao.deleteAddress(conn, addr.getAddressNo());	// 배송지 삭제요청 처리결과
		
		int resultMem = 0;		// 회원정보 수정일(MODIFY_DATE) 수정요청 처리결과를 담을 변수
		
		if(resultAddr > 0) { // 배송지 수정요청 처리성공
			// 회원정보 수정일(MODIFY_DATE) 수정요청
			resultMem = mpDao.updateMemberModifyDate(conn, addr.getAddressWriter());
			
			if(resultMem > 0) { // 회원정보 수정일 수정성공
				commit(conn);
			}
		}else { // 배송지 수정요청 처리실패
			rollback(conn);
		}
		
		close(conn);
		
		return resultAddr * resultMem;
	}
	
	/**
	 * 사용자가 지정한 상품 or 1:1문의 총문의수 조회요청시 실행될 메소드
	 * 
	 * case 01) 1:1문의 총문의수 조회요청 ==> ANSWER_TYPE = "2"
	 *          case 01-1)  전체 1:1문의수 조회 ==> ANSWER_STATUS = "전체" 
	 *          case 01-2) 처리된 1:1문의수 조회 ==> ANSWER_STATUS = "처리"
	 *          case 01-3) 미처리 1:1문의수 조회 ==> ANSWER_STATUS = "미처리"
	 *          
	 * case 02) 상품문의 총문의수 조회요청 : ANSWER_TYPE ="1"
	 *          case 02-1)  전체 상품문의수 조회 ==> ANSWER_STATUS = "전체"
	 *          case 02-2) 처리된 상품문의수 조회 ==> ANSWER_STATUS = "처리"
	 *          case 02-3) 미처리 상품문의수 조회 ==> ANSWER_STATUS = "미처리"
	 * 
	 * @param q : 문의유형(상품 | 1:1), 문의진행상태(처리 | 미처리) 정보가담긴 문의객체
	 * @return : 조회된 해당조건의 총문의수
	 */
	public int totalQna(Qna q) {
		
		Connection conn = getConnection();
		
		int total = mpDao.totalQna(conn, q);
		
		close(conn);
		
		return total;
		
	}
	
	/**
	 * 마이페이지에서 사용자가 1:1문의 or 상품문의 목록페이지 요청시 실행될 메소드
	 * 
	 * @param conn
	 * @param info : 페이징바객체(페이징정보), 문의객체(회원번호, 문의유형, 문의상태) 정보가 담긴 객체
	 * @return : 조회된 문의객체 리스트
	 */
	public List<Qna> selectQnaList(HashMap<String, Object> info){
		
		Connection conn = getConnection();
		
		String status = ((Qna)info.get("qna")).getAnswerStatus();

		/* 
		 * case 01)  "전체" : 전체문의 조회 (처리 + 미처리)
		 * case 02)  "처리" : 처리문의 조회
		 * case 02) "미처리" : 미처리문의 조회
		 * 
		 */
		List<Qna> list = new ArrayList<>();
		
		if(status.equals("전체")) {
			list = mpDao.selectAllQnaList(conn, info);
		}else {
			list = mpDao.selectQnaList(conn, info);
		}
		
		close(conn);
		
		return list;
		
	}
	
	/**
	 * 사용자가 마이페이지에서 특정 1:1문의 상세조회 요청시 실행될 메소드
	 * 
	 * case 01) 첨부파일이 있는 1:1문의 조회요청시
	 *          (1) 1:1문의 조회요청 (필수)
	 *          (2) 첨부파일 조회요청 (선택)
	 *          
	 * case 02) 첨부파일이 없는 1:1문의 조회요청시
	 * 			(1) 1:1문의 조회요청 (필수)
	 * 
	 * @param answerNo : 조회할 1:1문의번호
	 * @return : 조회된 문의정보를 담은 문의객체 및 해당 문의의 첨부파일정보가 담긴 첨부파일객체를 담은 객체
	 */
	public HashMap<String, Object> selectQna(String answerNo){
		
		Connection conn = getConnection();
		
		// 1:1문의 정보조회 결과변수 (필수)
		Qna q = mpDao.selectQna(conn, answerNo);
		
		// 첨부파일 정보조회 결과변수 (선택)
		AttachmentProduct ap = null;
		
		// 첨부파일 유무확인 (해당 문의의 첨부파일이 존재할경우)
		if(mpDao.attachmentYn(conn, Integer.parseInt(answerNo)) != null) {
			ap = mpDao.selectAttachment(conn, answerNo);
		}
		
		// 조회결과 객체(Qna, AttachmentProduct)를 담을 HashMap객체
		HashMap<String, Object> info = new HashMap<>();
		info.put("qna", q);
		info.put("file", ap);
		
		close(conn);
		
		return info;
		
	}
	
	/**
	 * 사용자가 마이페이지에서 1:1문의 등록요청시 실행될 메소드
	 * 
	 * case 01) 첨부파일이 있는 1:1문의글
	 *          (1) 1:1문의글 등록요청 (부모, 참조되는 컬럼있음)
	 * 			(2) 첨부파일 등록요청 (자식, 참조하는 컬럼있음)
	 * 
	 * case 02) 첨부파일이 없는 1:1문의글
	 *          (1) 1:1문의글 등록요청
	 * 
	 * @param q : 등록할 1:1문의글 정보가 담긴 문의객체
	 * @param ap : 등록할 문의글 첨부파일 정보가 담긴 첨부파일객체 (null | 파일정보)
	 * @return : 1:1문의 & 첨부파일 등록요청 처리결과 행 수
	 */
	public int insertQna(Qna q, AttachmentProduct ap) {
		
		Connection conn = getConnection();
		
		// (1) 문의글 등록요청
		int result= mpDao.insertQna(conn, q);
		
		if(result > 0) {
			// (2) 첨부파일 등록요청 (첨부파일이 있는 게시글일 경우)
			if(ap != null) {
				result = mpDao.insertAttachment(conn, ap);
			}
		}
		
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
		
		
	}
	
	/**
	 * 사용자가 마이페이지에서 문의삭제 요청시 실행될 메소드
	 * 
	 * case 01) 첨부파일이 존재하는 문의글일 경우
	 *          (1) 첨부파일 삭제 (문의글을 참조하는 == 자식)
	 *          (2)  문의글 삭제 (첨부파일에 참조되는 == 부모)
	 *          
	 * case 02) 첨부파일이 존재하지 않는 문의글일 경우
	 *          (1) 문의글 삭제
	 * 
	 * @param answerNo : 삭제할 문의번호
	 * @return : 해당번호 문의삭제 요청처리 결과, 삭제할 첨부파일 수정파일명 정보를 담은 객체
	 */
	public HashMap<String, Object> deleteQna(int answerNo) {
		
		Connection conn = getConnection();
		
		// 1. 문의글 첨부파일 유무조회 (1 == 첨부파일이 있는 문의글 | 0 == 첨부파일이 없는 문의글)
		String file = mpDao.attachmentYn(conn, answerNo);
	
		int resultAtt = 1;		// 첨부파일 삭제처리 결과를 담을변수 초기화
		int resultQna = 1;		//  문의글 삭제처리 결과를 담을변수 초기화
		
		// 2. 문의글 & 첨부파일 삭제요청
		if(file != null) { // 1-1. 첨부파일이 있는 문의글
			// (1) 첨부파일 삭제요청
			resultAtt = mpDao.deleteAttachment(conn, answerNo);
			
			if(resultAtt > 0) { // 첨부파일 삭제성공
				// (2) 문의글 삭제요청
				resultQna = mpDao.deleteQna(conn, answerNo);
			}
			
		}else { // 1-2. 첨부파일이 없는 문의글
			resultQna = mpDao.deleteQna(conn, answerNo);
		}
		
		// 3. 트랜잭션처리
		if(resultAtt * resultQna > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		// 처리결과, 삭제할파일(저장경로+수정명) 정보를 담을 객체
		HashMap<String, Object> result = new HashMap<>();
		result.put("result", resultAtt * resultQna);
		result.put("file", file);
		
		return result;
		
	}
	
	/**
	 * 사용자가 찜목록 조회요청시 찜한상품 or 찜한레시피 갯수조회시 실행될 메소드
	 * 
	 * @param info : 찜유형(상품|레시피), 서비스요청 회원번호 정보가 담긴 객체
	 * case 01) 찜한상품 갯수조회
	 *            "type" == "p"
	 *          "userNo" == xx
	 * 
	 * case 02) 찜한레시피 갯수조회
	 *            "type" == "r"
	 *          "userNo" == xx
	 * 
	 * @return : 조회된 찜한상품 or 찜한레시피 총수
	 */
	public int selectTotalLiked(HashMap<String, Object> info) {
		
		Connection conn = getConnection();
		
		int total = mpDao.selectTotalLiked(conn, info);
		
		close(conn);
		
		return total;
		
	}
	
	/**
	 * 사용자가 마이페이지에서 찜목록 조회요청시 찜한상품 or 찜한레시피 목록조회 요청시 실행될 메소드
	 * 
	 * @param info : 찜유형(상품|레시피), 서비스요청 회원번호, 페이징바 정보가 담긴 객체
	 * case 01) 찜한상품 갯수조회
	 *              "type" == "p"
	 *            "userNo" == xx
	 *          "pageInfo" == pi
	 * 
	 * case 02) 찜한레시피 갯수조회
	 *              "type" == "r"
	 *            "userNo" == xx
	 *          "pageInfo" == pi
	 * 
	 * @return : 조회된 찜한상품 or 찜한레시피 찜객체 리스트
	 */
	public List<Liked> selectLikedList(HashMap<String, Object> info){
		
		Connection conn = getConnection();
		
		List<Liked> list = mpDao.selectLikedList(conn, info);
		
		close(conn);
		
		return list;
		
		
	}
	
	/**
	 * 사용자의 총주문 횟수조회시 실행될 메소드
	 * 
	 * @param info : 쿼리실행시 필요한 데이터가 담긴객체 (회원번호, 조회시작날짜, 조회끝날짜)                  
	 * @return : 조회된 해당회원의 총주문 횟수
	 */
	public int totalOrders(HashMap<String, Object> info) {
		
		Connection conn = getConnection();
		
		int total = mpDao.totalOrders(conn, info);
		
		close(conn);
		
		return total;
		
	}
	
	/**
	 * 마이페이지에서 사용자가 주문목록 조회요청시 실행될 메소드
	 * 
	 * @param info : 회원번호, 조회시작날짜, 조회마지막날짜, 페이징객체 데이터가 담긴객체 
	 * @return : 조회된 해당사용자의 주문객체 리스트
	 */
	public List<Order> selectOrderList(HashMap<String, Object> info){
		
		Connection conn = getConnection();
		
		List<Order> list = mpDao.selectOrderList(conn, info);
		
		close(conn);
		
		return list;
		
	}
	
	/**
	 * 마이페이지에서 사용자가 주문내역 삭제요청시 실행될 메소드
	 * 
	 * @param orderNo : 삭제할 주문 주문번호
	 * @return : 주문내역 삭제요청 처리결과 행 수
	 */
	public int deleteOrder(int orderNo) {
		
		Connection conn = getConnection();
		
		int result = mpDao.deleteOrder(conn, orderNo);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
		
	}
	
	/**
	 * 마이페이지에서 사용자가 주문상세조회 요청시 실행될 메소드
	 * (1) 주문정보 상세조회 요청 ==> Order 객체로 반환
	 * (2) 주문상품 상세조회 요청 ==> List<Product>로 반환
	 * 
	 * @param conn
	 * @param orderNo : 상세조회 요청한 주문번호
	 * @return : 조회된 주문상세정보 객체(Order객체, List<Product>)
	 */
	public HashMap<String, Object> selectOrder(int orderNo){
		
		Connection conn = getConnection();
		
		// (1) 주문정보 상세조회 요청
		Order orderInfo = mpDao.selectOrderInfo(conn, orderNo);
		
		// (2) 주문상품 상세조회 요청
		List<Product> productList = new ArrayList<>();
		if(orderInfo != null) {
			productList = mpDao.selectOrderProducts(conn, orderNo);
		}
		
		// 결과전달용 HashMap객체
		HashMap<String, Object> result = new HashMap<>();
		result.put("orderInfo", orderInfo);
		result.put("productList", productList);
		
		close(conn);
		
		return result;
		
	}
	
	/**
	 * 마이페이지에서 사용자가 작성한레시피 총갯수 조회시 실행될 메소드
	 * 
	 * @param userNo : 서비스요청 회원번호
	 * @return : 조회된 총작성레시피수
	 */
	public int totalRecipe(int userNo) {
		
		Connection conn = getConnection();
		
		int total = mpDao.totalRecipe(conn, userNo);
		
		close(conn);
		
		return total;

	}
	
	/**
	 * 마이페이지에서 사용자가 작성한 레시피목록 조회요청시 실행될 메소드
	 * 
	 * @param info : 레시피목록조회시 필요한데이터가 담긴 객체(회원번호, 페이징바)
	 * @return : 조회된 레시피객체 리스트객체
	 */
	public List<Recipe> selectRecipeList(HashMap<String, Object> info){
		
		Connection conn = getConnection();
		
		List<Recipe> list = mpDao.selectRecipeList(conn, info);
		
		close(conn);
		
		return list;
		
	}
	
	/**
	 * 마이페이지에서 사용자가 작성한레시피 삭제요청시 실행될 메소드
	 * 
	 * @param recipeNo : 삭제할 레시피번호
	 * @return : 레시피 삭제요청 처리결과 행 수
	 */
	public int deleteRecipe(int recipeNo) {
		
		Connection conn = getConnection();
		
		int result = mpDao.deleteRecipe(conn, recipeNo);
		
		if(result > 0) {
			commit(conn);
		}else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
		
	}
	
	/**
	 * 마이페이지에서 사용자가 작성한레시피 삭제요청시 실행될 메소드
	 * 
	 * @param recipeNo : 삭제할 레시피번호
	 * @return : 레시피 삭제요청 처리결과 행 수
	 */
	public HashMap<String, Integer> selectMyPageMainInfo(int userNo){
		
		Connection conn = getConnection();
		
		HashMap<String, Integer> me = mpDao.selectMyPageMainInfo(conn, userNo);
		
		close(conn);
		
		return me;
		
	}
}
