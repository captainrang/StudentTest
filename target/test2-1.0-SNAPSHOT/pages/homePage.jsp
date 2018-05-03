
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
        var contextpath =' ${pageContext.request.contextPath}';
    </script>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>主页</title>
    <script type="text/javascript" src="${ctx}/resources/lib/jquery.js"></script>
    <script type="text/javascript" src="${ctx}/resources/homePage.js"></script>
    <meta name="description" content="主页">
    <meta name="keywords" content="主页">

    <link href="" rel="stylesheet">
    <style>
        body, p, div, ul, li, h1, h2, h3, h4, h5, h6 {
            margin: 0;
            padding: 0;
            font-size: 14px;
        }

        body {
            background: #E9E9E9;
        }

        #login {
            width: 450px;
            height: 250px;
            background: #FFF;
            margin: 200px auto;
            position: relative;
            padding: 10px;
            padding-left: 30px;
        }

        #login h1 {
            text-align: center;
            position: absolute;
            left: 140px;
            top: -40px;
            font-size: 21px;
        }

        #login  p {
            /*text-align: center;*/    font-size: 20px;
            line-height: 40px;

        }

        .btm-tips {
            position: fixed;
            bottom: -200px;
            right: 10px;
            max-width: 600px;
            min-width: 300px;
            min-height: 200px;
            line-height: 40px;
            margin-left: -150px;
            z-index: 19999;
            background-color: #fff;
            overflow-y: scroll;
        }

        .btm-text {
            min-width: 150px;
            height: 20px;
            font-size: 14px;
            padding: 0 8px;
            background: #fff;
            box-shadow: 2px 2px 2px rgba(0, 0, 0, .08);
            border-bottom: 1px solid #e1e1e1;
            border-right: 1px solid #e1e1e1;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .btnSubmit{
            width: 74px;
            height: 24px;
            background-color: #70bcc3;
            border-radius: 2px;
            text-align: center;
            color:white;
            padding-bottom: 1px;
            padding:5px;
            margin-left:5px;
        }
        .td1{
            min-width: 200px;
        }





    </style>
    <script>
        var path = '<%=basePath%>';
        <%--var uid=${uid eq null?-1:uid};--%>
        <%--if(uid==-1){--%>
            <%--location.href="<%=basePath2%>";--%>
        <%--}--%>
        <%--var from=uid;--%>
        <%--var fromName='${name}';--%>
        <%--var to=uid==1?2:1;--%>
        var uid= '${uid}';
        var userType = '${SESSION_USER_CONST_TYPE}';

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
        websocket.onmessage = function(event) {
            var data=JSON.parse(event.data);
            console.log("WebSocket:收到一条消息",data);
            var html = '';
            if(userType==1){
                html = "  <a class=\"btm-text\" href=\"#\" onclick=\"location.href='"+contextpath+"/user/createTestPaper.action?newTestId="+data.newTestId+"'\">"+data.title+"</a>";

            }else{
                html = ' <p><span class="td1">:</span>&nbsp;&nbsp;<a href="${ctx}/user/showTaskTest.action?taskId='+data.newTestId+'">'+data.title+'</a></p>\n';
            }
            $(".btm-tips").append(html);
            recevice();

        };
        websocket.onerror = function(event) {
            console.log("WebSocket:发生错误 ");
            console.log(event);
        };
        websocket.onclose = function(event) {
            console.log("WebSocket:已关闭");
            console.log(event);
        }



    </script>
</head>
<body>
<div id="login">
    <h1>个人主页</h1>
    <c:choose>
        <c:when test="${ SESSION_USER_CONST_TYPE==1}">
        <p><span class="td1">当前登录人:</span>&nbsp;&nbsp;<span>${SESSION_USER_STUDENT.realname}</span></p>
        <p><span class="td1">所属班级:</span>&nbsp;&nbsp;<span>${SESSION_USER_STUDENT.className}</span></p>
        <p><span class="td1">学号:</span>&nbsp;&nbsp;<span>${SESSION_USER_STUDENT.sno}</span></p>
        <p><span class="td1">操作:</span>&nbsp;&nbsp;<a class="btnSubmit" id="sign" onclick="sign()">签到</a></p>
                <div class="btm-tips">

                    <%--<c:forEach var="item" items="${list_test}">--%>
                        <%--<a class="btm-text" href="#" onclick="location.href='${ctx}/user/taskTest.action?taskId=${item.id}'">${item.title}</a><br/>--%>
                    <%--</c:forEach>--%>
                </div>
        </c:when>
        <c:otherwise>
            <p><span class="td1">当前到课情况:</span>&nbsp;&nbsp;<span >应到${tj.targetReach}人&nbsp;&nbsp;实到${tj.reached}人 </span><span class="td1">到课率为：</span><span>${tj.reachpercent}</span></p>
            <p><span class="td1">当前登录人:</span>&nbsp;&nbsp;<span >${SESSION_USER_CONST_TEACHER.realname}</span></p>
            <p><span class="td1">当前所在班级:</span>&nbsp;&nbsp;<span>${SESSION_USER_CONST_TEACHER.className}</span></p>
            <p><span class="td1">操作:</span >&nbsp;&nbsp;
                <a  class="btnSubmit" id="btnSubmit" onclick="fbTest()">发布测试</a>
                <a  class="btnSubmit" id="stopTest" onclick="stopTest()">停止测试</a>
                <a  class="btnSubmit" id="newUser" onclick="newUser()">新增用户</a>
            </p>
            <div class="btm-tips">
            </div>
            <%--<c:if test="${IS_READED>0}">--%>
                <%--<div class="btm-tips">--%>
                    <%--<c:forEach var="item" items="list_read_test">--%>
                        <%--<a class="btm-text" href="#" onclick="location.href='${ctx}${item.url_test}'">${item.name}的试卷待批阅</a>--%>
                    <%--</c:forEach>--%>
                <%--</div>--%>
            <%--</c:if>--%>
        </c:otherwise>
    </c:choose>
</div>



</body>
</html>