package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.DAOAccounts;

import model.Account;
import model.Encode;

@WebServlet("/anime-main/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Encode encrypt = new Encode();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		String userName = request.getParameter("loginName");
		String passWord = request.getParameter("loginPassword");
		HttpSession session = request.getSession();
		String error = String.valueOf(session.getAttribute("countError"));

		String encryptPass = encrypt.toSHA1(passWord);
		Account user = null;
		String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
		boolean verify = model.VerifyRecaptcha.verify(gRecaptchaResponse);
		DAOAccounts daoAccount = new DAOAccounts();
		String ipClient =request.getRemoteAddr();
		String path = getServletContext().getRealPath("/");
		try {
		
				user = daoAccount.baseLogin(userName, encryptPass,ipClient,path);
				
				if (verify) {
					if (user != null) {
						if (user.getIsActive() == 1) {
							session.setAttribute("user", user);
							session.setAttribute("isAdmin", user.isAdmin());

							session.removeAttribute("countError");
							request.getRequestDispatcher("/index.jsp").forward(request, response);
						} else {
							request.setAttribute("errorLogin",
									"Tài khoản của bạn đã bị khóa do nhập sai quá nhiều lần, vui lòng liên hệ quản trị viên để mở khóa");
							request.getRequestDispatcher("/login.jsp").forward(request, response);
						}
					} else {
						int idUser = daoAccount.findIdByUserName(userName);
						int countError = 1;
						if (idUser != -1) {
							String oldUserName = (String) session.getAttribute("oldUserName");
							request.setAttribute("errorLogin", "Sai mật khảu");
							if (!error.equals("null")) {
								if (userName.equalsIgnoreCase(oldUserName)) {
									countError = Integer.parseInt(error) + 1;
								} else {
									session.setAttribute("oldUserName", userName);
								}

							}
							session.setAttribute("countError", countError);

							if (countError >= 5) {

								daoAccount.blockAccount(idUser);
								request.setAttribute("errorLogin",
										"Tài khoản của bạn đã bị khóa do nhập sai quá nhiều lần, vui lòng liên hệ quản trị viên để mở khóa");

							}
							request.getRequestDispatcher("/login.jsp").forward(request, response);

						} else {
							request.setAttribute("errorLogin", "Sai thông tin tài khoản");
							request.getRequestDispatcher("/login.jsp").forward(request, response);
						}
					}
				} else {
					request.setAttribute("errorLogin", "Lỗi captcha");
					request.getRequestDispatcher("/login.jsp").forward(request, response);
				}
			
		} catch (SQLException e) {
			e.printStackTrace();
			response.getWriter().println("<img class=\"rsImg\" src=\"/AnimeWeb/error.png" + "\">");
		}


//		if ("signup".equals(query)) {
//			String email = request.getParameter("email");
//			// validation
//			boolean error = false;
//			if (userName.length() > 25 || userName.length() < 6 || passWord.length() < 6 || passWord.length() > 100) {
//				error = true;
//			}
//
//			if (error == false) {
//				Register register = new Register();
//				try {
//					boolean check = listAccount.checkRegister(userName);
//					if (check) {
//						session.setAttribute("errorSignup", "");
//						session.setAttribute("mailOld", "");
//						session.setAttribute("nameOld", "");
//						session.setAttribute("passOld", "");
//						register.createAccount(userName, pass, email);
//						getServletContext().setAttribute("listUser", new ListAccount(new DAOAccounts().getConnection()));
//						url = getServletContext().getContextPath() + "/anime-main/index.jsp";
//					} else {
//						session.setAttribute("errorSignup", "Tên tài khoản đã tồn tại");
//						session.setAttribute("mailOld", email);
//						session.setAttribute("nameOld", userName);
//						session.setAttribute("passOld", passWord);
//						url = getServletContext().getContextPath() + "/anime-main/signup.jsp" + sessionId;
//					}
//
//				} catch (ClassNotFoundException | SQLException e) {
//
//					response.getWriter().println("<img class=\"rsImg\" src=\"/AnimeWeb/error.png"+"\">");
//				}
//			} else {
//				session.setAttribute("errorSignup", "Đăng ký không thành công do lỗi dữ liệu");
//				session.setAttribute("mailOld", email);
//				session.setAttribute("nameOld", userName);
//				session.setAttribute("passOld", passWord);
//				url = getServletContext().getContextPath() + "/anime-main/signup.jsp" + sessionId;
//			}
//
//		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
