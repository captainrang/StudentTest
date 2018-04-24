package com.classTest.student.service.impl;

import com.classTest.student.dao.UserDao;
import com.classTest.student.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by cyx  on 2018/3/26
 */
@Service("com.classTest.student.service.impl.UserService")
public class UserServiceImpl implements UserService {

    @Autowired
    UserDao userDao;
    @Override
    public List<Map<String, Object>> getUserInfo(Map<String,String>  map) {
        return userDao.getUserInfo(map);
    }

    @Override
    public Map<String, Object> getUserInfo(String username, String usertype, String password) {
        return userDao.getLoginUserInfo(username,usertype,password);
    }

    @Override
    public List<Map<String, Object>> queryTest() {
        return userDao.queryTest();
    }

    @Override
    public Map<String, Object> tj(Object classId, Object id) {
        return userDao.tj(classId.toString(),id.toString());
    }

    @Override
    public Map<String, Object> getZxTest() {
        return userDao.getZxTest();
    }

    @Override
    public void signed(String id) {
        userDao.signed(id);
    }

    @Override
    public void addNewTest(Map<String,Object> param) {
        userDao.addNewTest(param);
    }

    @Override
    public void addNewQuestion1(Map<String,Object> param) {

        userDao.addNewQuestion1(param);
    }

    @Override
    public void addOption1(Map<String, Object> param) {
        userDao.addOption1(param);
    }

    @Override
    public Map<String, Object> getTestBaseInfo(String newTestId) {
        return userDao.getTestBaseInfo(newTestId);
    }

    @Override
    public List<Map<String, Object>> getTest(String newTestId) {
        return  userDao.getTest(newTestId);
    }

    @Override
    public List<Map<String, Object>> getOptions(long questionId) {
        return userDao.getOptions(questionId);
    }

    @Override
    public String getAnswers(Map<String, Object> paraMap) {
        return userDao.getAnswers(paraMap);
    }

    @Override
    public List<Map<String, Object>> getCheckAnswers(Map<String, Object> paraMap) {
        return userDao.getCheckAnswers(paraMap);
    }

    @Override
    public  Map<String,Object> getInpAnswers(Map<String, Object> paraMap) {
        return userDao.getInpAnswers(paraMap);
    }

    @Override
    public void saveRadioAnswer(Map<String, Object> map) {
        userDao.saveRadioAnswer(map);
    }

    @Override
    public void saveCheckboxAnswer(Map<String, Object> map1) {
        userDao.saveCheckboxAnswer(map1);
    }

    @Override
    public void saveInputAnswer(Map<String, Object> map2) {
        userDao.saveInputAnswer(map2);
    }

    @Override
    public Long isnotSign(String id) {
        return userDao.isnotSign(id);
    }

    @Override
    public List<Map<String, Object>> getTeacherByClassId(String classId) {
        return userDao.getTeacherByClassId(classId);
    }

    @Override
    public List<Map<String, Object>> queryPaiMingTail(String testId) {
        return userDao.queryPaiMingTail(testId);
    }

    @Override
    public List<Map<String, Object>> getUserTestInfo(String testId) {
        return userDao.getUserTestInfo(testId);
    }

    @Override
    public boolean testNotEnd(String testId) {
        return userDao.testNotEnd(testId);
    }

    @Override
    public boolean testNotShenYue(String testId) {
        return userDao.testNotShenYue(testId);
    }

    @Override
    public Map<String, Object> getDTL(String testId,String userId) {
        return userDao.getDTL(testId,userId);
    }

    @Override
    public Map<String, Object> getZQL(String testId,String userId) {
        return userDao.getZQL(testId,userId);
    }

    @Override
    public Long getQuestionGrade(Map<String, Object> paraMap) {
        return userDao.getQuestionGrade(paraMap);
    }

    @Override
    public void insertGrade(Map<String, Object> paraMap) {
        userDao.insertGrade(paraMap);
    }
}
