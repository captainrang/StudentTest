<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String path = request.getContextPath();
    String basePath = request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>学生考试打分</title>
    <c:set var="ctx" value="${pageContext.request.contextPath}"/>
    <%@include file="/resources/common/resource.jsp"%>
    <script type="text/javascript" src="${ctx}/resources/queryPaiMing.js"></script>
</head>
<script>
    var contextpath =' ${pageContext.request.contextPath}';
    Date.prototype.Format = function (fmt) { //author: meizz
        var o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "h+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }

</script>
<body>
<input type="hidden" value="${taskId}" id="taskId">
<div style="margin-top: 20px;width:97%">
    <div class="form-horizontal">
        <div class="form-group">
            <label for="zql" class="col-sm-1" style="line-height: 30px;white-space: nowrap;padding-left: inherit;padding-right: inherit;text-align:right;" >正确率：</label>
            <div class="col-sm-3" >
                <input type="text" class="form-control" id="zql" name="z" value="${zql}"  readonly/>
            </div>
            <label for="dtl" class="col-sm-1" style="line-height: 30px;white-space: nowrap;padding-left: inherit;padding-right: inherit;text-align:right;" >答题率：</label>
            <div class="col-sm-3" >
                <input type="text" class="form-control" id="dtl" name="z" value="${dtl}"  readonly/>
            </div>

        </div>
    </div>
</div>
<div style="padding-top:15px;padding-left: 20px;">
    <table id="studentTestInfoTable">
    </table>
</div>
<script >

</script>

</body>

</html>
