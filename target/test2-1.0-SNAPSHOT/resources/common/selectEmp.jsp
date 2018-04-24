<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>人员选择</title>
</head>
<body style="width: 100%; height:100%;overflow:auto;">
    <div data-options="region:'south',split:false" style="height: 10%;">
	    <div style="text-align:center;padding: 6px;" borderStyle="border-left:0;border-bottom:0;border-right:0;">
	        <a class="easyui-linkbutton" iconCls="icon-ok" onclick="onConfirm()">确定</a>
	        <a class="easyui-linkbutton" iconCls="icon-cancel" onclick="onCancel()">取消</a>
	    </div>
    </div>   
    <div data-options="region:'center'" style="padding:5px;" style="overflow:auto;height: 90%;">
    	<div class="easyui-layout" data-options="fit:true">   
		    <div data-options="region:'center'" style="overflow:auto;">
		    	<input id="searchbox"></input> 
				<div id="option">
					<div data-options="name:'queryParameter[\'fullName\']'">用户名称</div>
				</div>
		    	<table id="list" cellspacing="0" cellpadding="0"></table>
		    </div>
		</div>
    </div>
    <script src="${ pageContext.request.contextPath }/zrpage/framework/js/org/selectPerson.js" type="text/javascript"></script>
</body>
</html>