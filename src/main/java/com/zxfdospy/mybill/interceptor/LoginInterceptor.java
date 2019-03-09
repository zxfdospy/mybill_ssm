package com.zxfdospy.mybill.interceptor;

import com.zxfdospy.mybill.pojo.User;
import com.zxfdospy.mybill.service.CategoryService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Arrays;

public class LoginInterceptor extends HandlerInterceptorAdapter {


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        String contextPath = session.getServletContext().getContextPath();
        String uri = request.getRequestURI();
        uri = StringUtils.remove(uri, contextPath);
        System.out.println(uri);
        String[] noNeedAuthPage = new String[]{
                "LoginAjax",
                "RegisterUser",};

        if (uri.startsWith("/bill")) {
            String method = StringUtils.substringAfterLast(uri, "/bill");
            if (!Arrays.asList(noNeedAuthPage).contains(method)) {
                User user = (User) session.getAttribute("user");
                if (null == user) {
                    response.sendRedirect("remind");
                    return false;
                }
            }
        }
        return true;
    }
}
