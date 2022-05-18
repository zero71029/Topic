package com.jetec.topic.security;

import java.io.IOException;

import javax.persistence.Access;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.jetec.topic.model.MemberBean;
import com.jetec.topic.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;


//登入錯誤 才會進來 反回訊息
@Component
public class AppsAuthenticationFailureHandler implements AuthenticationFailureHandler {
	
@Autowired
	MemberRepository mr;


	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		System.out.println("登入失敗");
	
		String username = request.getParameter("username"); // 取得登入帳號
		String password = request.getParameter("password");
		System.out.println(username);
		System.out.println(password);
		MemberBean memberBean =  mr.findByEmail(username);
		String error = "Login failed";
		if(memberBean == null ) {
			System.out.println("找不到使用者");
			error = "User not found";
		}else if(!memberBean.getPassword().equals(password)){
			System.out.println("密碼錯誤");
			error ="Wrong Password";
		}
		request.setCharacterEncoding("UTF-8");		
		response.sendRedirect("/CRM/time.jsp?error="+ error);

		                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
		
		
	}

}
