
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
    <script>
        var uid='${uid}';
        var websocket;
        if ('WebSocket' in window) {
            websocket = new WebSocket("ws://" + contextpath + "/ws.action?uid="+uid);
        } else if ('MozWebSocket' in window) {
            websocket = new MozWebSocket("ws://" + contextpath + "/ws.action"+uid);
        } else {
            websocket = new SockJS("http://" + contextpath + "/ws/sockjs.action"+uid);
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
                alert("时间到，结束,5s后自动跳转主页!");
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
            var timeM = '${mapSurvey.end_date}';
            var maxtime = timeM * 60; //一个小时，按秒计算，自己调整!
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

        function toList(){
            window.location.href=contextpath+"/user/homePage.action";
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

                <form id="contentForm">
                    <div class="questions">
                        <input type="hidden" name="newTestId" value="${newTestId}" id="newTestId">
                        <input type="hidden" name="stuId" value="${stuId}" id="stuId">
                        <c:choose>
                            <c:when test="${listSize>0 }">
                                <c:forEach items="${listSesult}" var="question" varStatus="code">


                                    <c:if test="${question.type==5}">
                                        <div class="oneQuestion q5">
                                            <p>Q${code.index+1} : ${question.title}&nbsp; <span>上传:</span>
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
                            <input type="submit" class="submitFont">提交</input>
                        </div>
                    </div>


        </div>
        <div class="emptyDiv"></div>
    </div>
</div>
<script>
    function showImage(){
        if($("#img").complete){
            layer.open({
                type: 1,
                title: false,
                closeBtn: 1,
                area: '467px',
                skin: 'layui-layer-nobg', //没有背景色
                shadeClose: true,
                content: $("#bookmistake")
            });
        }
    }

    function submit1() {
        $.ajax({
            url:contextpath+"/user/testResult.aciotn?testId="+$("#newTestId").val(),
            type:'get',
            success:function(json){
                if(json=='ok'){
                    alert("结果已入库");
                    setTimeout(function(){
                            toList();
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