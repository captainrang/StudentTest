<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/26
  Time: 23:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="${ctx}/resources/lib/socketjs/sockjs.min.js"></script>
</head>
<script type="text/javascript">
    var  ws;
    window.onload=connect;
    function connect(){
        var ws;
        if ('WebSocket' in window) {
            ws = new WebSocket("ws://192.168.1.117:8080/xf_oa_new/webSocketServer");
        } else if ('MozWebSocket' in window) {
            ws = new MozWebSocket("ws://192.168.1.117:8080/xf_oa_new/webSocketServer");
        } else {
            //如果是低版本的浏览器，则用SockJS这个对象，对应了后台“sockjs/webSocketServer”这个注册器，
            //它就是用来兼容低版本浏览器的
            ws = new SockJS("http://192.168.1.117:8080/xf_oa_new/sockjs/webSocketServer");
        }
        ws.onopen = function (evnt) {

        };
        ws.onmessage = function (evnt) {
            eval("var dataObj="+event.data);
            if(dataObj != undefined){
                $(dataObj.data).each(function(i,o){
                    $("#msgName").text(o.msgName);
                    $("#amount").text(o.amount);
                    $("#msg a:first").attr("_href",core.getRootPath()+o.toUrl).text(o.taskName);
                    $("#msgId").val(o.id);
                    setTimeout("tips_pop()",1000);
                });
            }

        };
        ws.onerror = function (evnt) {
        };
        ws.onclose = function (evnt) {
        }
    }

    function  send(){
        var value= $("#msg").val();
        ws.send(value);
    }
</script>
<body>

</body>
</html>
