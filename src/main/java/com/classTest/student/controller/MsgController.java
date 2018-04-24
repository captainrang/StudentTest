package com.classTest.student.controller;

import com.classTest.student.service.UserService;
import com.classTest.webSocket.entity.Message;
import com.classTest.webSocket.entity.User;
import com.classTest.webSocket.ws.MyWebSocketHandler;
import com.google.gson.GsonBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.socket.TextMessage;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import com.classTest.util.Const;

@Controller
@RequestMapping("/msg")
public class MsgController {

	@Resource
	MyWebSocketHandler handler;

	Logger logger = LoggerFactory.getLogger(UserController.class);
	@Autowired
	@Qualifier("com.classTest.student.service.impl.UserService")
	UserService userService;

//	Map<Long, User> users = new HashMap<Long, User>();
//
//	// 模拟一些数据
//	@ModelAttribute
//	public void setReqAndRes() {
//		User u1 = new User();
//		u1.setId(1L);
//		u1.setRealname("张三");
//		users.put(u1.getId(), u1);
//
//		User u2 = new User();
//		u2.setId(2L);
//		u2.setRealname("李四");
//		users.put(u2.getId(), u2);
//
//	}

	// 用户登录
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public void doLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String username = request.getParameter("username");
		String usertype = request.getParameter("usertype");
		String password = request.getParameter("password");
		Map<String, Object> user = userService.getUserInfo(username, usertype,password);
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/pages/login.jsp?" + "&msg=username is not exist");
			return;
		}

		request.getSession().setAttribute("uid", user.get("id"));
		request.getSession().setAttribute("name", user.get("username").toString());
		if ("1".equals(usertype)) {
			request.getSession().setAttribute(com.classTest.util.Const.SESSION_USER_STUDENT, user);
			request.getSession().setAttribute(com.classTest.util.Const.SESSION_USER_CONST_TYPE, "1");
		} else if ("2".equals(usertype)) {
			request.getSession().setAttribute(com.classTest.util.Const.SESSION_USER_CONST_TEACHER, user);
			request.getSession().setAttribute(com.classTest.util.Const.SESSION_USER_CONST_TYPE, "2");
		}
		response.sendRedirect(request.getContextPath() + "/user/homePage.action");
	}

	// 用户app登录
	@RequestMapping(value = "applogin", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> doAppLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String username = request.getParameter("username");
		String usertype = request.getParameter("usertype");
		String password = request.getParameter("password");
		Map<String, Object> user = userService.getUserInfo(username, usertype,password);
		Map<String,Object> map = new HashMap<String,Object>();
		if (user == null) {
			map.put("msg", "username is not exist");
			return map;
		}
		request.getSession().setAttribute("uid", user.get("id").toString());
		request.getSession().setAttribute("name", user.get("username").toString());
		if ("1".equals(usertype)) {
			request.getSession().setAttribute(com.classTest.util.Const.SESSION_USER_STUDENT, user);
			request.getSession().setAttribute(com.classTest.util.Const.SESSION_USER_CONST_TYPE, "1");
			map.put(com.classTest.util.Const.SESSION_USER_STUDENT,user);
			map.put(com.classTest.util.Const.SESSION_USER_CONST_TYPE, "1");
		} else if ("2".equals(usertype)) {
			request.getSession().setAttribute(com.classTest.util.Const.SESSION_USER_CONST_TEACHER, user);
			request.getSession().setAttribute(com.classTest.util.Const.SESSION_USER_CONST_TYPE, "2");
			map.put(com.classTest.util.Const.SESSION_USER_STUDENT,user);
			map.put(com.classTest.util.Const.SESSION_USER_CONST_TYPE, "2");
		}

		return map;

	}

	// 跳转到交谈聊天页面
	@RequestMapping(value = "talk", method = RequestMethod.GET)
	public ModelAndView talk() {
		return new ModelAndView("talk");
	}

	// 跳转到发布广播页面
	@RequestMapping(value = "broadcast", method = RequestMethod.GET)
	public ModelAndView broadcast() {
		return new ModelAndView("broadcast");
	}

	// 发布系统广播（群发）
	@ResponseBody
	@RequestMapping(value = "broadcast", method = RequestMethod.POST)
	public void broadcast(String text) throws IOException {
		Message msg = new Message();
		msg.setDate(new Date());
		msg.setFrom(-1L);
		msg.setFromName("系统广播");
		msg.setTo(0L);
		msg.setText(text);
		handler.broadcast(new TextMessage(new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create().toJson(msg)));
	}

}