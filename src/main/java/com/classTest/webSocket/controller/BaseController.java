package com.classTest.webSocket.controller;

import com.classTest.util.Const;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * 控制层基类
 * @author zhuqiang
 * @date 2016/8/11
 */
public class BaseController {
    public static final String CHARSET_UTF8_JSON = "application/json;charset=utf-8";

    protected Map<String, Object> getUserInfo() {
        HttpServletRequest request =
                ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        HttpSession session = request.getSession();
        if ("1".equals(session.getAttribute(Const.SESSION_USER_CONST_TYPE))) {
            return (Map<String, Object>) session.getAttribute(Const.SESSION_USER_STUDENT);
        } else if ("2".equals(session.getAttribute(Const.SESSION_USER_CONST_TYPE))) {
            return (Map<String, Object>) session.getAttribute(Const.SESSION_USER_CONST_TEACHER);
        }
        return null;
    }
}
