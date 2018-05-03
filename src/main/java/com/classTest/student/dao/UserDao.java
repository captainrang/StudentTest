package com.classTest.student.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
/**
 * Created by cyx  on 2018/3/26
 */
@Repository
public interface UserDao {
    /**
     * 获取学生信息
     * @param map
     * @return
     */
    List<Map<String,Object>> getUserInfo(Map<String, String> map);

    Map<String,Object> getLoginUserInfo(@Param("username") String username,@Param("usertype")  String usertype,@Param("password") String password);

    List<Map<String,Object>> queryTest();

    Map<String,Object> tj(@Param("classId") String classId, @Param("id")String id);

    Map<String,Object> getZxTest();

    void signed(@Param("id") String id);

    void addNewTest( Map<String,Object> param);

    void addNewQuestion1( Map<String,Object> param);

    void addOption1(Map<String, Object> param);

    Map<String,Object> getTestBaseInfo(@Param("newTestId") String newTestId);

    List<Map<String,Object>> getTest(@Param("newTestId") String newTestId);

    List<Map<String,Object>> getOptions(@Param("questionId")long questionId);

    String getAnswers(Map<String, Object> paraMap);

    List<Map<String,Object>> getCheckAnswers(Map<String, Object> paraMap);

    Map<String,Object> getInpAnswers(Map<String, Object> paraMap);

    void saveRadioAnswer(Map<String, Object> map);

    void saveCheckboxAnswer(Map<String, Object> map1);

    void saveInputAnswer(Map<String, Object> map2);

    Long isnotSign(@Param("id") String id);

    List<Map<String,Object>> getTeacherByClassId(@Param("classId") String classId);

    List<Map<String,Object>> queryPaiMingTail(Map<String,Object> map);

    int queryPaiMingTailCount(Map<String,Object> map);

    List<Map<String,Object>> getUserTestInfo(Map<String,Object> map);

    boolean testNotEnd(@Param("testId") String testId);

    boolean testNotShenYue(@Param("testId") String testId);
    //答题率
    Map<String,Object> getDTL(@Param("testId") String testId,@Param("userId") String userId);
    //正确率
    Map<String,Object> getZQL(@Param("testId") String testId,@Param("userId") String userId);

    Long getQuestionGrade(Map<String, Object> paraMap);

    void insertGrade(Map<String, Object> paraMap);

    /**
     *
     * @param testId
     * @return
     */
    int getUserTestInfoCount(Map<String,Object> map);

    List<Map<String,Object>> getClassList();

    List<Map<String,Object>> showUser();

    void addUserOpt(Map<String, Object> param);

    void insertUserClass(Map<String, Object> param);
}
