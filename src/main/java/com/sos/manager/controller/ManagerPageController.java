package com.sos.manager.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sos.common.model.vo.PageInfo;
import com.sos.manager.model.service.ManagerService;
import com.sos.product.model.service.ProductService;
import com.sos.product.model.vo.Product;
import com.sos.product.model.vo.Qna;

/**
 * Servlet implementation class ManagerPageController
 */
@WebServlet("/manager.ma")
public class ManagerPageController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ManagerPageController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int qnaCount = new ManagerService().selectQnaCount();
		List<Qna> pList = new ManagerService().selectProductQnaList();
		List<Qna> oneList = new ManagerService().selectOneQnaList();

		request.setAttribute("qnaCount", qnaCount);
		request.setAttribute("pList", pList);
		request.setAttribute("oneList", oneList);

		request.getRequestDispatcher("/views/manager/managerMain.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
