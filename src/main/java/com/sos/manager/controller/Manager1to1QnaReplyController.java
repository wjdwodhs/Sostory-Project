package com.sos.manager.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sos.manager.model2.service2.ManagerService2;
import com.sos.product.model.vo.AttachmentProduct;
import com.sos.product.model.vo.ProductQnaReply;

/**
 * Servlet implementation class Manager1to1QnaReplyController
 */
@WebServlet("/mselect.ma")
public class Manager1to1QnaReplyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Manager1to1QnaReplyController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int answerNo = Integer.parseInt(request.getParameter("answerNo"));
		ProductQnaReply pq = new ManagerService2().managerQnaReply(answerNo);
		AttachmentProduct ap = new ManagerService2().managerQnaReplyFile(answerNo);
		request.setAttribute("pq", pq);
		request.setAttribute("ap", ap);
	
		request.getRequestDispatcher("/views/manager/qnaPersonalAnswer.jsp").forward(request, response);
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
