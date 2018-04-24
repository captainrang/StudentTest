<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/16
  Time: 11:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/lib/jquery.js"></script>
<html>
<head>
    <title>测试登录</title>
</head>
<body>
<div id="app"></div>
</body>
<script>
    function test(){
        $.ajax({
            url:'${pageContext.request.contextPath}/msg/applogin.action',
            type:'post',
            data:{username:'test1',usertype:'1',password:'123'},
            success:function (json) {
                $('#app').val(json)
            }
        })
    }
    test();


</script>
</html>
