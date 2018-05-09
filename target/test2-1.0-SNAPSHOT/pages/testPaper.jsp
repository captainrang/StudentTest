
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.classTest.util.Const" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String basePath2 = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

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
            cursor: pointer;
            margin-left: 530px;
            width: 140px;
            height: 28px;
            background-color: #6FBCC2;
            border-radius: 4px;

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
    <script>
        var path = '<%=basePath%>';
        var uid='${uid}';
        var websocket;
        if ('WebSocket' in window) {
            websocket = new WebSocket("ws://" + path + "/ws.action?uid="+uid);
        } else if ('MozWebSocket' in window) {
            websocket = new MozWebSocket("ws://" + path + "/ws.action?uid="+uid);
        } else {
            websocket = new SockJS("http://" + path + "/ws/sockjs.action?uid="+uid);
        }
        websocket.onopen = function(event) {
            console.log("WebSocket:已连接");
            console.log(event);
        };
        websocket.onerror = function(event) {
            console.log("WebSocket:发生错误 ");
            console.log(event);
        };
        websocket.onclose = function(event) {
            console.log("WebSocket:已关闭");
            console.log(event);
        }

        websocket.onmessage = function(event) {
            var data=JSON.parse(event.data);
            console.log("WebSocket:收到一条消息",data);
            if(data.title=='stop'){

                alert("时间到，结束,5s后自动跳转主页!"+data.title);
                $(".submitFont").hide();
                setTimeout(function(){
                        toList();
                    }
                ,5000)
            }
           // recevice();

        };
        var userType = '${ SESSION_USER_CONST_TYPE}';
        if(userType==1){
            var timeM = '${mapSurvey.testTime}';
            var maxtime = parseInt(timeM) * 60; //一个小时，按秒计算，自己调整!
            function CountDown() {
                if (maxtime >= 0) {
                    minutes = Math.floor(maxtime / 60);
                    seconds = Math.floor(maxtime % 60);
                    msg = "距离结束还有" + minutes + "分" + seconds + "秒";
                    document.all["timer"].innerHTML = msg;
                    if (maxtime == 5 * 60)alert("还剩5分钟");
                    --maxtime;
                } else{
                    clearInterval(timer);
                    alert("时间到，结束,5s后自动跳转主页!");
                    $(".submitFont").hide();
                    setTimeout(function(){
                            toList();
                        }
                        ,5000)
                }
            }
            timer = setInterval("CountDown()", 1000);
        }


    </script>


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
                <c:if test="${ SESSION_USER_CONST_TYPE==1}" >
                    <div class="tipDiv">

                        <%--<div id="warring" style="color:red"></div>--%>
                        <span class="tipFont">本次考试结束时间为${mapSurvey.end_date},请各位同学注意时间</span>
                    </div>
                </c:if>

                <form id="contentForm" enctype='multipart/form-data' method="post" action="${ctx}/user/addSurveyAnswers.action" >
                    <div class="questions">
                        <input type="hidden" name="newTestId" value="${newTestId}">
                        <c:choose>
                            <c:when test="${listSize>0 }">
                                <c:forEach items="${listSesult}" var="question" varStatus="code">
                                    <c:if test="${question.type==1 }">
                                        <div class="oneQuestion q1" >
                                            <p>Q${code.index+1} : ${question.title}</p>
                                            <div style="padding-left: 22px">
                                                <c:forEach items="${question.listOptions }" var="option">
                                                    <div style="height: 40px">
                                                        <c:choose>
                                                            <c:when test="${(question.answer) ==(option.id)}">
                                                                <div style="float: left"><input type="radio"  name="radio_${code.index+1}" value="${option.id}" checked="checked"  disabled="disabled"></div>
                                                                <div  style="float: left;marging-top: 10px;margin-left: 5px"><label>${option.option_content }</label></div><br/>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div style="float: left"><input type="radio" name="radio_${code.index+1}" value="${option.id}"/></div>
                                                                <div  style="float: left;marging-top: 10px;margin-left: 5px"><label>${option.option_content }</label></div><br/>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </c:forEach>
                                                <input type="hidden" name="radioValues" value="radio_${code.index+1}">
                                                <input type="hidden" name="questionIds" value="${question.id}">
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${question.type==2}">
                                        <div class="oneQuestion q2">
                                            <p>Q${code.index+1} : ${question.title}</p>
                                            <div style="padding-left: 22px" id="type">
                                                <c:forEach items="${question.listOptions }" var="option">
                                                    <div style="height: 40px">
                                                        <c:choose>
                                                            <c:when test="${(option.flag)==true}">
                                                                <input type='checkbox'  name='checkbox_${code.index+1}' value="${option.id}" checked="checked"  disabled="disabled">
                                                                <label>${option.option_content }</label>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <input   type='checkbox' name='checkbox_${code.index+1}' value="${option.id}" >
                                                                <label>${option.option_content }</label>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </c:forEach>
                                                <input type="hidden" name="checkboxValues" value="checkbox_${code.index+1}">
                                                <input type="hidden" name="checkboxQuestionIds" value="${question.id}">
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${question.type==4}">
                                        <div class="oneQuestion q4">
                                            <p>Q${code.index+1} : ${question.title}</p>
                                            <div style="padding-left: 22px">
                                                <input id="${question.id}" name="input_${code.index+1}" class="inputStyle"  maxlength="190"  value="${question.inp }"  >
                                            </div>
                                            <input type="hidden" name="inputValues" value="input_${code.index+1}">
                                            <input type="hidden" name="inputQuestionIds" value="${question.id}">
                                        </div>
                                    </c:if>
                                    <c:if test="${question.type==5}">
                                        <div class="oneQuestion q5">
                                            <p>Q${code.index+1} : ${question.title}&nbsp;
                                                <c:if test="${SESSION_USER_CONST_TYPE==1 }">
                                                <div class="sxy-div-content upload-image">
                                            <%--<span>上传:</span>--%>
                                                <div class="fileinfo"><input type="file" name="file"></div>
                                            </div>
                                            </c:if>
                                            </p>
                                            <div style="padding-left: 22px">
                                                <textarea id="${question.id}" name="input_${code.index+1}" class="textAreaStyle" maxlength="190" >${question.inp }</textarea>
                                            </div>
                                            <input type="hidden" name="textValues" value="input_${code.index+1}">
                                            <input type="hidden" name="textQuestionIds" value="${question.id}">
                                            <div class="bookmistake" id="bookmistake"> <image id="img" src="${ctx}/${question.attachment }" /></div>
                                        </div>
                                    </c:if>
                                </c:forEach>

                            </c:when>
                        </c:choose>
                    </div>
                    <div style="width: 100%;height:50px;padding-top: 60px;"> <%--onclick="submit1('${ SESSION_USER_CONST_TYPE}')"--%>
                        <button type=""  class="buttonDiv submitFont">
                            ${ SESSION_USER_CONST_TYPE==1?'提交试卷':'发布试卷'}
                        </button>
                    </div>
                </form>
            </div>





        </div>
        <div class="emptyDiv"></div>
    </div>
</div>
<script>

    //提交之前 需要老师给出答案 才能发布
    function submit1(){
        var params = $('#contentForm').serializeArray();
        if(validate()){
            $(".buttonDiv").attr("onclick","");
            $.ajax({
                type: "POST",
                url:contextpath+'/user/addSurveyAnswers.action',
                data:params,
                async: false,
//                dataType:"json",
                success: function(code) {
                    if(code=='ok'){

                        alert("提交成功");
                        setTimeout("toList()",1000);
                    }else{
                        $(".buttonDiv").attr("onclick","submit1()");
                       alert("提交失败");
                    }
                },
                error:function(){
                    $(".buttonDiv").attr("onclick","submit1()");
                }
            });
        }else{
            alert("您有问题没有填!");
        }

    }

    function toList(){
        window.location.href=contextpath+"/user/homePage.action";
    }
    function validate(){
        var flag = true;

        $(".oneQuestion.q1").each(function () {
            var val= $(this).find('input:radio:checked');
            if(val.length<=0){
                flag = false;
            }
        });
        $(".oneQuestion.q2").each(function () {
            var val=$(this).find("input:checkbox:checked")
            if(val.length<=0){
                flag = false;
            }
        })

        $(".inputStyle").each(function(i) {
            var val= $(this).val();
            val = $.trim(val);
            if(val.length<=0){
                flag = false;
                //alert(flag);
            }
        })
        $(".textAreaStyle").each(function(i) {
            var val= $(this).val();
            val = $.trim(val);
            if(val.length<=0){
                flag = false;
                //alert(flag);
            }
        })

        return flag;

    }





</script>


</body>
</html>