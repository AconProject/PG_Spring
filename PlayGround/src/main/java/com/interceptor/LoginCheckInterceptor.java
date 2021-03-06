package com.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.plugin.InterceptorChain;
import org.aspectj.lang.annotation.Before;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter{
@Override
public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
		throws Exception {
	HttpSession session = request.getSession();
	if(session.getAttribute("login") == null) {   //로그인 안된 경우
		response.sendRedirect("../LoginForm");//servlet-context.xml 
		//<mvc:view-controller path="/loginForm" view-name="loginForm"/><!-- loginForm .jsp-->
		return false;  //주의
	}else {   //로그인 된 경우 
		System.out.println("로그인이 확인되었습니다.");
		return true; //주의
	}
}
@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	//System.out.println("postHandle");
		
	}
@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	//System.out.println("afterCompletion");
	}

}
