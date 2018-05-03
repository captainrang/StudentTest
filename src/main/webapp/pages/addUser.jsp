<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>新增测试</title>
	<%@include file="/resources/common/resource.jsp"%>
	<script type="text/javascript" src="${ctx}/resources/addUser.js"></script>
</head>

<body>
<div style="width:90%;margin:10px auto 0px;">
	<h3 align="center">用户列表</h3>
		<div class="row" style="margin-top: 5px">
			<div class="col-sm-12" style="text-align: right" >
				<button type="button" class="btn btn-primary" onclick="addUser()">
					新增用户</button>
				<button  type="button" class="btn btn-success" onclick="window.location.href='${ctx}/user/homePage.action'" style="margin-left: 10px">
					返回</button>
			</div>
		</div>
	<div style="padding-top:15px;padding-left: 20px;">
		<table id="userInfoTable"></table>
	</div>
</div>


<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog modal-lg" role="document" >

		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title" id="myModalLabel"></h4>
			</div>

			<div class="modal-body">
				<form id='registerForm' role="form" class="form-horizontal" method="post" enctype="multipart/form-data" >
					<div class="form-horizontal">
						<div class="form-group">
							<label for="add_username" class="col-sm-2 control-label"style="text-align: right;">用户名:<font color="red" style="font-size:16px">*</font></label>
							<div class="col-sm-10">
								<input type="text" name="add_username" id="add_username"  class="form-control" oninput="if(value.length>10)value=value.slice(0,30)">
							</div>
						</div>
						<div class="form-group">
							<label for="add_password" class="col-sm-2 control-label"style="text-align: right;">密码:<font color="red" style="font-size:16px">*</font></label>
							<div class="col-sm-10">
								<input type="password" name="add_password" id="add_password"  class="form-control" oninput="if(value.length>10)value=value.slice(0,30)">
							</div>
						</div>
						<div class="form-group">
							<label for="add_realname" class="col-sm-2 control-label"style="text-align: right;">真实姓名:<font color="red" style="font-size:16px">*</font></label>
							<div class="col-sm-10">
								<input type="text" name="add_realname" id="add_realname"  class="form-control" oninput="if(value.length>10)value=value.slice(0,30)">
							</div>
						</div>
						<div class="form-group">
							<label for="add_sno" class="col-sm-2 control-label"style="text-align: right;">工号/学号:<font color="red" style="font-size:16px">*</font></label>
							<div class="col-sm-10">
								<input type="text" name="add_sno" id="add_sno"  class="form-control" oninput="if(value.length>10)value=value.slice(0,30)">
							</div>
						</div>

						<div class="form-group">
							<label for="add_userType" class="col-sm-2 control-label"style="text-align: right;">用户类型:<font color="red" style="font-size:16px">*</font></label>
							<div class="col-sm-10">
								<select id="add_userType" name="add_userType" class="selectpicker form-control" >
									<option value="1" >学生</option>
									<option value="2">老师</option>

								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="add_sex" class="col-sm-2 control-label"style="text-align: right;">用户性别:<font color="red" style="font-size:16px">*</font></label>
							<div class="col-sm-10">
								<select id="add_sex" name="add_sex" class="selectpicker form-control" >
									<option value="0" >男</option>
									<option value="1">女</option>

								</select>
							</div>
						</div>

						<div class="form-group">
							<label for="add_class" class="col-sm-2 control-label"style="text-align: right;">班级:<font color="red" style="font-size:16px">*</font></label>
							<div class="col-sm-10">
								<select id="add_class" name="add_class" class="selectpicker form-control" >
									<c:forEach items="${classList}" var="item">
										<option value="${item.id}" >${item.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer" align="center">
				<button type="button" id="btn_close" class="btn btn-default" type="submit" onclick="addUserOpt()">
					<%--<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>--%>
					确定
				</button>
				<button type="button" id="btn_submit" class="btn btn-primary"  data-dismiss="modal">
					<span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>
					返回
				</button><span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
			</div>

		</div>

	</div>
</div>

</body>

</html>
