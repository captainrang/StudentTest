package com.classTest.student.service;

import com.classTest.util.PageResultForBootstrap;

import java.util.List;
import java.util.Map;

/**
 * Created by cyx  on 2018/3/26
 */
public interface UserService {
    /**
     * 获取学生信息
     * @return
     */
    List<Map<String,Object>> getUserInfo(Map<String,String> map);

    Map<String,Object> getUserInfo(String username, String usertype, String password);

    List<Map<String,Object>> queryTest();

    Map<String,Object> tj(Object classId, Object id);

    Map<String,Object> getZxTest();

    void signed(String id);

    void addNewTest(Map<String,Object> param);

    void addNewQuestion1(Map<String,Object> param);

    void addOption1(Map<String, Object> param);

    Map<String,Object> getTestBaseInfo(String newTestId);

    List<Map<String,Object>> getTest(String newTestId);

    List<Map<String,Object>> getOptions(long questionId);

    String getAnswers(Map<String, Object> paraMap);

    List<Map<String,Object>> getCheckAnswers(Map<String, Object> paraMap);

    Map<String,Object> getInpAnswers(Map<String, Object> paraMap);

    void saveRadioAnswer(Map<String, Object> map);

    void saveCheckboxAnswer(Map<String, Object> map1);

    void saveInputAnswer(Map<String, Object> map2);

    Long isnotSign(String id);

    List<Map<String,Object>> getTeacherByClassId(String classId);

    PageResultForBootstrap<Map<String,Object>> queryPaiMingTail(Map<String, Object> paraMap);

    PageResultForBootstrap<Map<String,Object>> getUserTestInfo(Map<String,Object> param);

    boolean testNotEnd(String testId);

    boolean testNotShenYue(String testId);

    Map<String,Object> getDTL(String testId,String userId);

    Map<String,Object> getZQL(String testId,String userId);

    Long getQuestionGrade(Map<String, Object> paraMap);

    void insertGrade(Map<String, Object> paraMap);

    List<Map<String,Object>> getClassList();

    PageResultForBootstrap<Map<String,Object>> showUser();

    void addUserOpt(Map<String, Object> param);

    void insertUserClass(Map<String, Object> param);
}
