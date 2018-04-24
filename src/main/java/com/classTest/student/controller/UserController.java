package com.classTest.student.controller;

import com.classTest.student.service.UserService;
import com.classTest.util.Const;
import com.classTest.webSocket.controller.BaseController;
import com.classTest.webSocket.ws.MyWebSocketHandler;
import com.google.gson.GsonBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.socket.TextMessage;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.*;

/**
 * Created by cyx  on 2018/3/26
 */
@Controller
@RequestMapping("/user")
public class UserController extends BaseController {
    Logger logger = LoggerFactory.getLogger(UserController.class);
    @Autowired
    @Qualifier("com.classTest.student.service.impl.UserService")
    UserService useService;
    @Resource
    MyWebSocketHandler handler;

    @RequestMapping(value = "/initTest")
    public ModelAndView initTest(HttpServletRequest request) {
        ModelAndView model = new ModelAndView();
        model.setViewName("login");
        return model;
    }

    @RequestMapping(value = "/testAppLogin")
    public ModelAndView testAppLogin(HttpServletRequest request) {
        ModelAndView model = new ModelAndView();
        model.setViewName("testAppLogin");
        return model;
    }

    /**
     * 个人主页
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/homePage")
    public ModelAndView getInfo(HttpServletRequest request) {
        ModelAndView model = new ModelAndView();
        Map<String, Object> map = this.getUserInfo();
        HttpSession session = request.getSession();
        if ("1".equals(session.getAttribute(Const.SESSION_USER_CONST_TYPE))) {
            //1 为学生类型
            //2.获取当前未过期的测试 点击进入考试。
            List<Map<String, Object>> list_test = useService.queryTest();
            model.addObject("list_test", list_test);
        } else {
            //老师类型
            //1统计当前 到课情况 最新的测试
            Map<String, Object> tj = useService.tj(map.get("classId"), map.get("id"));
            Map<String, Object> taskTest = useService.getZxTest();
            model.addObject("tj", tj);
            model.addObject("taskTest", taskTest);
        }

        model.setViewName("homePage");
        return model;
    }

    /**
     * 签到
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/signed")
    @ResponseBody
    public String signed(HttpServletRequest request) {
        Map<String, Object> map = this.getUserInfo();
        String flag = "ok";
        try {
            Long count = useService.isnotSign(map.get("id").toString());
            if (count > 0) {

            } else {
                useService.signed(map.get("id").toString());
            }

        } catch (Exception e) {
            flag = "error";
        }
        return flag;

    }

    /**
     * 终止考试
     *
     * @param request
     * @return
     */
    public String stopTest(HttpServletRequest request) {
        Map<String, Object> mapMessage = new HashMap<String, Object>();
        String flag = "ok";
        Map<String, Object> map = this.getUserInfo();
        mapMessage.put("date", new Date());
        mapMessage.put("from", map.get("id"));
        mapMessage.put("from", map.get("username"));
        mapMessage.put("to", 0L);
        mapMessage.put("title", "stop");
        try {
            handler.broadcast(new TextMessage(new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create().toJson(mapMessage)));

        } catch (IOException e) {
            flag = "error";
            e.printStackTrace();
        }
        return flag;
    }

    /**
     * 发布测试
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/fbTest")
    public ModelAndView fbTest(HttpServletRequest request) {
        ModelAndView model = new ModelAndView();
        model.setViewName("fbTest");
        return model;
    }

    /**
     * 添加新测试
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/addNewTest")
    @ResponseBody
    public String addNewTest(HttpServletRequest request) {
        String flag = "ok";
        String testName = request.getParameter("testName");
        String testTime = request.getParameter("testTime");
        Map<String, Object> map = this.getUserInfo();
        try {
            Map<String, Object> param = new HashMap<String, Object>();
            param.put("testName", testName);
            param.put("testTime", testTime);
            param.put("id", map.get("id"));
            useService.addNewTest(param);
            flag = param.get("id").toString();
        } catch (Exception e) {
            flag = "error";
            return flag;
        }
        return flag;

    }

    /**
     * 新增问题
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/addQuestion")
    @ResponseBody
    public String addQuestion(HttpServletRequest request) {
        String title = request.getParameter("title"); //题目
        String add_questionType = request.getParameter("add_questionType");
        String newTestId = request.getParameter("newTestId");
        String sort = request.getParameter("sort");
        String flag = "ok";
        Map<String, Object> param = new HashMap<String, Object>();
        param.put("title", title);
        param.put("add_questionType", add_questionType);
        param.put("sort", sort);
        param.put("newTestId", newTestId);
        try {
            useService.addNewQuestion1(param);
            String id = StringUtils.isEmpty(param.get("id")) ? "" : param.get("id").toString();

            if ("4".equals(add_questionType) || "5".equals(add_questionType)) {
                String add_remarks = request.getParameter("add_remarks");
                param.put("add_remarks", add_remarks);
                useService.addOption1(param);
            } else {
                String[] add_questionOption = request.getParameterValues("add_questionOption");
                param.put("add_questionOption", add_questionOption);
                useService.addOption1(param);
            }
        } catch (Exception e) {
            flag = "error";
            e.printStackTrace();
            return flag;
        }

        return flag;

    }

    /**
     * 创建测试
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/createTestPaper")
    public ModelAndView createTestPaper(HttpServletRequest request) {
        ModelAndView model = new ModelAndView();
        String newTestId = request.getParameter("newTestId");
        Map<String, Object> mapSurvey = useService.getTestBaseInfo(newTestId);
        Map<String, Object> userMap = this.getUserInfo();
        model.setViewName("testPaper");
        Map<String, Object> paraMap = new HashMap<String, Object>();
        paraMap.put("logUserId", userMap.get("id"));
        // 查询该调查包含的所有题目
        List<Map<String, Object>> list = useService.getTest(newTestId);
        List<Map<String, Object>> listResult = new ArrayList<Map<String, Object>>();
        if (list.size() > 0) {
            // 遍历题目
            for (Map<String, Object> question : list) {
                if (question.get("type").equals(1) || question.get("type").equals(2)) {
                    String questionIdStr = question.get("id").toString();
                    if (null != questionIdStr && !questionIdStr.equals("")) {
                        long questionId = Long.valueOf(questionIdStr).longValue();
                        List<Map<String, Object>> listOptions =
                                useService.getOptions(questionId);
                        // 查询单选答案
                        paraMap.put("questionId", questionId);
                        String answer = useService.getAnswers(paraMap);
                        // 查询多选答案
                        List<Map<String, Object>> che = useService.getCheckAnswers(paraMap);
                        boolean flag = false;
                        if (null != che) {
                            for (Map<String, Object> ch : che) {
                                for (Map<String, Object> opt : listOptions) {

                                    if ((ch.get("option_id").toString()).equals(opt.get("id").toString())) {
                                        flag = true;
                                        opt.put("flag", flag);

                                    } else {
                                        flag = false;
                                    }
                                }
                            }
                        }
                        question.put("listOptions", listOptions);
                        question.put("answer", answer);
                        listResult.add(question);
                    }
                } else if (question.get("type").equals(4) || question.get("type").equals(5)) {
                    // 查询填空答案
                    String questionIdStr = question.get("id").toString();
                    if (null != questionIdStr && !questionIdStr.equals("")) {
                        long questionId = Long.valueOf(questionIdStr).longValue();
                        paraMap.put("questionId", questionId);
                        Map<String, Object> inp = useService.getInpAnswers(paraMap);
                        if (inp != null) {
                            question.put("inp", inp.get("option_content"));
                            question.put("attachment", inp.get("attachment"));

                        }
                        listResult.add(question);

                    }
                } else {
                    listResult.add(question);
                }
            }
        }
        model.addObject("mapSurvey", mapSurvey);
        model.addObject("listSesult", listResult);
        model.addObject("newTestId", newTestId);
        model.addObject("listSize", listResult.size());

        return model;
    }

    /**
     * 新增问题的答案
     *
     * @param request
     * @return
     */
    // 填写问卷答案
    @RequestMapping(value = "/addSurveyAnswers", method = RequestMethod.POST)
    @ResponseBody
    public String addSurveyAnswers(HttpServletRequest request, @RequestParam("file") MultipartFile[] file) {
        Map<String, Object> writerUser = this.getUserInfo();
        String flag = "ok";
        Long userId = new Long(String.valueOf(writerUser.get("id")));
        String newTestId = request.getParameter("newTestId");
        // 先获取所有单选的name集合
        String radios[] = request.getParameterValues("radioValues");
        HttpSession session = request.getSession();
        long answer_type = 2;
        String userType = session.getAttribute(Const.SESSION_USER_CONST_TYPE).toString();
        if ("1".equals(session.getAttribute(Const.SESSION_USER_CONST_TYPE))) {
            answer_type = 1;
        }
        // 单选问题id集合
        String questionIds[] = request.getParameterValues("questionIds");
        Map<String, Object> map = new HashMap<String, Object>(); // 存放单选
        Map<String, Object> map1 = new HashMap<String, Object>();// 存放多选
        Map<String, Object> map2 = new HashMap<String, Object>();// 存放输入框
        Map<String, Object> map3 = new HashMap<String, Object>();// 存放文本框
        map.put("userId", userId);
        map.put("surveyId", newTestId);
        map.put("answer_type", answer_type);
        map1.put("userId", userId);
        map1.put("answer_type", answer_type);
        map1.put("surveyId", newTestId);
        map2.put("userId", userId);
        map2.put("surveyId", newTestId);
        map2.put("answer_type", answer_type);
        map3.put("userId", userId);
        map3.put("surveyId", newTestId);
        map3.put("answer_type", answer_type);

        try {
            // 遍历单选name
            if (null != radios) {

                for (int i = 0; i < radios.length; i++) {
                    // 取出每一道单选题的答案
                    String radioAnswer = request.getParameter(radios[i]);
                    map.put("optionId", radioAnswer);
                    if (null != questionIds) {
                        for (int j = 0; j < questionIds.length; j++) {
                            map.put("questionId", questionIds[i]);
                        }
                    }
                    // 保存单选答案的方法
                    useService.saveRadioAnswer(map);
                }

            }
            // 先获取所有多选的name集合
            String checkboxs[] = request.getParameterValues("checkboxValues");
            // 多选问题id集合
            String checkboxQuestionIds[] = request.getParameterValues("checkboxQuestionIds");
            // 遍历多选name
            if (null != checkboxs) {
                for (int m = 0; m < checkboxs.length; m++) {
                    // 取出每一道多选题的答案
                    String checkbox[] = request.getParameterValues(checkboxs[m]);

                    if (null != checkboxQuestionIds) {
                        map1.put("questionId", checkboxQuestionIds[m]);
                    }
                    // //拼接的多选答案是String类型，只能放在答案内容字段
                    map1.put("optionIds", checkbox);
                    // 保存答案的方法,
                    useService.saveCheckboxAnswer(map1);
                }
            }
            // 先获取所有输入框的name集合

            String input[] = request.getParameterValues("inputValues");
            // 输入框问题id集合
            String[] inputQuestionIds = request.getParameterValues("inputQuestionIds");
            if (null != inputQuestionIds) {
                for (int x = 0; x < inputQuestionIds.length; x++) {
                    map2.put("questionId", inputQuestionIds[x]);
                    for (int y = 0; y < input.length; y++) {
                        String inputValue = request.getParameter(input[y]);
                        map2.put("inputValue", inputValue);
                    }
                    useService.saveInputAnswer(map2);
                }
            }

            // 获取所有文本框的name集合
            String textValues[] = request.getParameterValues("textValues");
            // 输入框问题id集合
            String[] textQuestionIds = request.getParameterValues("textQuestionIds");
            String path = "E:/upload/";
            if (null != textQuestionIds) {
                for (int x = 0; x < textQuestionIds.length; x++) {
                    map3.put("questionId", textQuestionIds[x]);
                    if (null != textValues) {
                        for (int y = 0; y < textValues.length; y++) {
                            String textValue = request.getParameter(textValues[y]);
                            map3.put("inputValue", textValue);
                            String jdbcpath = "";
                            if (file != null && file.length > 0) {
                                MultipartFile files = file[y];
                                //保存文件
                                saveFile(files, path);
                                jdbcpath = path + files.getOriginalFilename();

                            }
                            map3.put("attachment", jdbcpath);
                        }
                    }
                    useService.saveInputAnswer(map3);
                }
            }
            //给所有上课的学生 发送考试试卷
            if ("1".equals(userType)) {
                // 查询当前登录 学生班级 所在的老师
                List<Map<String, Object>> TearcherList = useService.getTeacherByClassId(writerUser.get("classId").toString());
                //判断学生所在班级的老师 是否在线 如果在线 即为当前登录 发考试的老师
                Map<String, Object> mapMessage = new HashMap<String, Object>();
                for (int i = 0; i < TearcherList.size(); i++) {
                    if (handler.isIn((Long) TearcherList.get(i).get("id"))) {
                        mapMessage.put("date", new Date());
                        mapMessage.put("from", userId);
                        mapMessage.put("from", writerUser.get("username"));
                        mapMessage.put("to", 0L);
                        mapMessage.put("title", writerUser.get("username") + "的考试已上线");
                        mapMessage.put("newTestId", newTestId);
                        handler.sendMessageToUser((Long) TearcherList.get(i).get("id"), new TextMessage(new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create().toJson(mapMessage)));
                    }
                }

            } else {
                Map<String, Object> mapMessage = new HashMap<String, Object>();
                mapMessage.put("date", new Date());
                mapMessage.put("from", userId);
                mapMessage.put("from", writerUser.get("username"));
                mapMessage.put("to", 0L);
                mapMessage.put("title", useService.getTestBaseInfo(newTestId).get("title"));
                mapMessage.put("newTestId", newTestId);
                handler.broadcast(new TextMessage(new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create().toJson(mapMessage)));
            }

        } catch (Exception e) {
            e.printStackTrace();
            flag = "error";
            return flag;
        }


        return flag;
    }

    @RequestMapping(value = "/showTaskTest", method = RequestMethod.GET)
    @ResponseBody
    public ModelAndView showTaskTest(HttpServletRequest request) {
        ModelAndView model = new ModelAndView();
        String newTestId = request.getParameter("taskId");
        model.addObject("taskId", newTestId);
        model.setViewName("/showTaskTest");
        return model;
    }

    @RequestMapping(value = "/getUserTestInfo")
    @ResponseBody
    public List<Map<String, Object>> getUserTestInfo(HttpServletRequest request) {
        String testId = request.getParameter("taskId");
        return useService.getUserTestInfo(testId);
    }

    @RequestMapping(value = "/shenyue")
    @ResponseBody
    public ModelAndView shenyue(HttpServletRequest request) {
        ModelAndView model = new ModelAndView();
        model.setViewName("shenyue");
        String newTestId = request.getParameter("testId");
        String stuId = request.getParameter("stuId");
        Map<String, Object> mapSurvey = useService.getTestBaseInfo(newTestId);
        Map<String, Object> paraMap = new HashMap<String, Object>();
        paraMap.put("logUserId", stuId);
        // 查询该调查包含的所有题目
        List<Map<String, Object>> list = useService.getTest(newTestId);
        List<Map<String, Object>> listResult = new ArrayList<Map<String, Object>>();
        if (list.size() > 0) {
            // 遍历题目
            for (Map<String, Object> question : list) {
                if (question.get("type").equals(1) || question.get("type").equals(2)) {
                    String questionIdStr = question.get("id").toString();
                    if (null != questionIdStr && !questionIdStr.equals("")) {
                        long questionId = Long.valueOf(questionIdStr).longValue();
                        List<Map<String, Object>> listOptions =
                                useService.getOptions(questionId);
                        // 查询单选答案
                        paraMap.put("questionId", questionId);
                        String answer = useService.getAnswers(paraMap);
                        // 查询多选答案
                        List<Map<String, Object>> che = useService.getCheckAnswers(paraMap);
                        boolean flag = false;
                        if (null != che) {
                            for (Map<String, Object> ch : che) {
                                for (Map<String, Object> opt : listOptions) {

                                    if ((ch.get("option_id").toString()).equals(opt.get("id").toString())) {
                                        flag = true;
                                        opt.put("flag", flag);

                                    } else {
                                        flag = false;
                                    }
                                }
                            }
                        }
                        question.put("listOptions", listOptions);
                        question.put("answer", answer);
                        listResult.add(question);
                    }
                } else if (question.get("type").equals(4) || question.get("type").equals(5)) {
                    // 查询填空答案
                    String questionIdStr = question.get("id").toString();
                    if (null != questionIdStr && !questionIdStr.equals("")) {
                        long questionId = Long.valueOf(questionIdStr).longValue();
                        paraMap.put("questionId", questionId);
                        Map<String, Object> inp = useService.getInpAnswers(paraMap);
                        if (inp != null) {
                            question.put("inp", inp.get("option_content"));
                            question.put("attachment", inp.get("attachment"));

                        }
                        listResult.add(question);

                    }
                } else {
                    listResult.add(question);
                }
            }
        }
        model.addObject("mapSurvey", mapSurvey);
        model.addObject("listSesult", listResult);
        model.addObject("newTestId", newTestId);
        model.addObject("stuId", stuId);
        model.addObject("listSize", listResult.size());
        return model;
    }

    private boolean saveFile(MultipartFile file, String path) {
        // 判断文件是否为空
        if (!file.isEmpty()) {
            try {
                File filepath = new File(path);
                if (!filepath.exists())
                    filepath.mkdirs();
                // 文件保存路径
                String savePath = path + file.getOriginalFilename();
                // 转存文件
                file.transferTo(new File(savePath));
                return true;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    @RequestMapping(value = "/paiming")
    @ResponseBody
    public String paiming(HttpServletRequest request) {
        String flag = "3";
        String testId = request.getParameter("testId");
        if (useService.testNotEnd(testId)) { //考试未结束
            flag = "1";
        }
        if (useService.testNotShenYue(testId)) {
            flag = "2";
        }

        return flag;
    }

    @RequestMapping(value = "/queryPaiMing")
    @ResponseBody
    public ModelAndView queryPaiMing(HttpServletRequest request) {
        ModelAndView model = new ModelAndView();
        model.setViewName("/queryPaiMing");
        String testId = request.getParameter("testId");
        model.addObject("taskId", testId);
        Map<String, Object> userMap = this.getUserInfo();
        // 获取当前考试的正确率，答题率，
        Map<String, Object> map = useService.getDTL(testId, userMap.get("id").toString());
        // Map<String,Object> map2 = useService.getZQL(testId,userMap.get("id").toString());

        model.addObject("dtl", map.get("dtl"));
        model.addObject("zql", "");//map2.get("zql") 暂时无法计算正确率。计算题 如果给的不是全分，这题算对还是错呢，这里有疑问。


        return model;
    }

    @RequestMapping(value = "/queryPaiMingTail")
    @ResponseBody
    public List<Map<String, Object>> queryPaiMingTail(HttpServletRequest request) {
        String testId = request.getParameter("testId");
        return useService.queryPaiMingTail(testId);
    }

    /**
     * 添加分数
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/testResult")
    @ResponseBody
    public String testResult(HttpServletRequest request) {
        String flag = "ok";
        String newTestId = request.getParameter("testId");
        String stuId = request.getParameter("stuId");
        Map<String, Object> paraMap = new HashMap<String, Object>();
        Map<String,Object> map = this.getUserInfo();
        paraMap.put("teacherId", map.get("id"));
        paraMap.put("stuId",stuId);
        paraMap.put("testId",newTestId);
        String[] grades = request.getParameterValues("textsocreValues");
        Long gradeTotal = Long.valueOf(0);//统计分数
        for(int i =0;i<grades.length;i++){
            String grade1 = request.getParameter(grades[i]);
            gradeTotal += Long.parseLong(grade1);
        }

        Long questionGrade = useService.getQuestionGrade(paraMap);
        gradeTotal +=questionGrade;
        paraMap.put("grade",gradeTotal);
        try {
            useService.insertGrade(paraMap);
        }catch (Exception e){
            e.printStackTrace();
            flag = "error";
        }
        return flag;
    }
}