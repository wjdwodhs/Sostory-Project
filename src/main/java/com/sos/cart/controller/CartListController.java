package com.sos.cart.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sos.cart.model.service.CartService;
import com.sos.cart.model.vo.Cart;
import com.sos.common.model.vo.PageInfo;
import com.sos.member.model.vo.Member;


/**
 * Servlet implementation class CartListController
 */
@WebServlet("/list.ca")
public class CartListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CartListController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Member loginUser = (Member)request.getSession().getAttribute("loginUser");
		int userNo = loginUser.getUserNo();
		
		
		// 회원번호, 상품번호, 상품이미지경로, 상품이름, 가격, 할인가격, 수량 ==> 장바구니 테이블에서 조회
		List<Cart> list =  new CartService().selectCart(userNo);
	
		
		// 장바구니 목록 리스트 페이지 요청
		if(list.isEmpty()) { // 장바구니에 상품이 없을 경우 : 장바구니 x 목록페이지으로 이동
		
			request.getRequestDispatcher("/views/cart/cartEmptyList.jsp").forward(request, response);
		
			
			
		}else { // 장바구니에 상품이 있을 경우 : 장바구니 목록페이지로 이동
			
			// list에 담겨있는 모든행들의 가격, 할인가격을 더한 값을 구해서 넘겨주기
//			int price =0; // 총 상품금액
//			int discountPrice = 0; // 상품 할인금액
//			
//			for(int i=0; i<list.size(); i++) {
//				price += list.get(i).getPrice();
//				discountPrice += list.get(i).getDiscountPrice();
//			}
			
			request.setAttribute("list", list);
//			request.setAttribute("price", price);
//			request.setAttribute("discountPrice", discountPrice);
			request.getRequestDispatcher("/views/cart/cartList.jsp").forward(request, response);
		}
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
