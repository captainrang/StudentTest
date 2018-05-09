
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.classTest.util.Const" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <script>
        var contextpath ='${pageContext.request.contextPath}';
    </script>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>主页</title>
    <script type="text/javascript" src="${ctx}/resources/lib/jquery.js"></script>
    <script type="text/javascript" src="${ctx}/resources/testPaper.js"></script>
    <script src="${ctx}/resources/layer/layer.js"></script>
    <meta name="description" content="主页">
    <meta name="keywords" content="主页">

    <link href="" rel="stylesheet">
    <style>
        input[type=radio],input[type=checkbox]  {
            display: inline-block;
            vertical-align: middle;
            width: 20px;
            height: 20px;
            margin-left: 5px;
            -webkit-appearance: none;
            background-color: transparent;
            border: 0;
            outline: 0 !important;
            line-height: 20px;
            color: #d8d8d8;
        }
        input[type=radio]:after  {
            content: "";
            display:block;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            text-align: center;
            line-height: 15px;
            font-size: 15px;
            color: #fff;
            border: 2px solid #ddd;
            background-color: #fff;
            box-sizing:border-box;
        }

        input[type=checkbox]:after  {
            content: "";
            display:block;
            width: 20px;
            height: 20px;
            text-align: center;
            line-height: 14px;
            font-size: 16px;
            color: #fff;
            border: 2px solid #ddd;
            background-color: #fff;
            box-sizing:border-box;
        }
        input[type=checkbox]:checked:after  {
            border: 4px solid #ddd;
            background-color: #37AF6E;
        }

        input[type=radio]:checked:after  {
            content: "L";
            transform:matrix(-0.766044,-0.642788,-0.642788,0.766044,0,0);
            -webkit-transform:matrix(-0.766044,-0.642788,-0.642788,0.766044,0,0);
            border-color: #37AF6E;
            background-color: #37AF6E;
        }

        .emptyDiv{
            height: 60px;
            width: 100%
        }

        .whiteDiv{
            width:1200px;
            height:auto;
            background-color: white
        }

        .titleDiv{
            padding-top: 60px;
            width: 100%;
            text-align: center
        }

        .titleFont{
            font-size: x-large;
            color: #757575;
        }

        .bigContent{
            width: 1200px;
            height: auto;
            padding-top: 60px;
            padding-bottom: 60px
        }

        .tipDiv{
            width: 1120px;
            height: auto;
            margin-left: 80px
        }

        .tipFont{
            color: #757575;
            font-size: 16px
        }

        .questions{
            width: 1120px;
            height:auto;
            margin-left: 80px;
            color: #757575;
            font-size: 16px
        }

        .oneQuestion{
            width: 100%;
            height: auto
        }

        .inputStyle{
            width: 900px;
            height:20px;
            border-style:none;
            border-bottom: dashed 2px #d8d8d8;
        }

        .textAreaStyle{
            width: 900px;
            height:80px;
            border: solid 1px #d8d8d8
        }
        .buttonDiv{
            cursor:pointer;
            margin-left:530px;
            width: 140px;
            height: 28px;
            background-color: #6FBCC2;
            border-radius:4px;
            padding-top: 4px;

        }

        .submitFont{
            color: white;
            font-size:18px;
            /*margin-left: 52px*/
        }

        .bookmistake {
            width: 310px;
             height: 209px;
            background-color: #FFFFFF;
            display: none;
            padding: 15px 20px;
            /* position: fixed;*/
            /*  left: 35%;
              top: 30%;
              box-shadow: 0px 0px 5px #888888;
              border-radius: 5px;
             z-index: 999;*/
        }
    </style>


</head>
<body>
<div class="body" >
    <div class="content-wrapper">
        <c:if test="${ SESSION_USER_CONST_TYPE==1}" >
        <div id="timer" style="color:red"></div>
        </c:if>
        <div class="emptyDiv"></div>
        <div class="whiteDiv">
            <div class="titleDiv">
                <span class="titleFont">${mapSurvey.title}</span>
            </div>
            <div class="bigContent">


                <form id="contentForm">
                    <div class="questions">
                        <input type="hidden" name="newTestId" value="${newTestId}" id="newTestId">
                        <input type="hidden" name="stuId" value="${stuId}" id="stuId">
                        <c:choose>
                            <c:when test="${listSize>0 }">
                                <c:forEach items="${listSesult}" var="question" varStatus="code">


                                    <c:if test="${question.type==5}">
                                        <div class="oneQuestion q5">
                                            <p>Q${code.index+1} : ${question.title}&nbsp; <span onclick="showImage()">查看:</span>
                                            </p>
                                            <div style="padding-left: 22px">
                                                <textarea id="${question.id}" name="input_${code.index+1}" class="textAreaStyle" maxlength="190" >${question.inp }</textarea><br/>
                                                <input type="text" placeholder="请输入分数" name="input_soce_${code.index+1}">
                                            </div>

                                            <input type="hidden" name="textValues" value="input_${code.index+1}">
                                            <input type="hidden" name="textsocreValues" value="input_soce_${code.index+1}">
                                            <input type="hidden" name="textQuestionIds" value="${question.id}">
                                            <div class="bookmistake" id="bookmistake"> <image id="img" src="${ctx}/${question.attachment }" /></div>
                                        </div>
                                    </c:if>
                                </c:forEach>

                            </c:when>
                        </c:choose>
                    </div>
                </form>
            </div>


                    <div style="text-align: center;width: 100%;height:50px;">
                        <div onclick="submit1()" class="buttonDiv">
                            <span type="submit" class="submitFont">提交</span>
                        </div>
                    </div>


        </div>
        <div class="emptyDiv"></div>
    </div>
</div>
<script>
    function showImage(){
       $("#bookmistake").css({"display":"block"})
    }
    function toList(){
        window.location.href=contextpath+"/user/homePage.action";
    }
    function submit1() {
        var params = $('#contentForm').serializeArray();
        $.ajax({
            url:contextpath+"/user/testResult.action",
            async: false,
            data:params,
            type:'post',
            success:function(json){
                if(json=='ok'){
                    alert("结果已入库");
                    setTimeout(function(){
                            window.location.go(-1);
                        }
                        ,5000)
                }else{
                    alert("新增失败");
                }
            }
        })

    }






</script>


</body>
</html>