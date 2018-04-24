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
<div style="width:90%;margin:10px auto 0px;">
	<h3 align="center">新增测试</h3>
	<form role="form" action="" id="mform" method="post" enctype="multipart/form-data">
		<div class="row" style="margin-top: 5px" >
			<label for="cjr" class="col-sm-1" style="line-height: 30px;white-space: nowrap;padding-left: inherit;padding-right: inherit;text-align:right;" >创建人：</label>
			<div class="col-sm-3" >
				<input type="text" class="form-control" id="cjr" name="cjr" value="${SESSION_USER_CONST_TEACHER.realname}"  readonly/>
			</div>
			<label for="className" class="col-sm-1" style="line-height: 30px;white-space: nowrap;padding-left: inherit;padding-right: inherit;text-align:right;" >班级：</label>
			<div class="col-sm-3" >
				<input type="text" class="form-control" id="className" name="className" value="${SESSION_USER_CONST_TEACHER.className}"  readonly/>
			</div>
			<label for="applyTime" class="col-sm-1" style="line-height: 30px;white-space: nowrap;padding-right: inherit;padding-left: inherit;text-align:left" >&nbsp;创建日期：</label>
			<div class="col-sm-3">
				<input type="text" class="form-control" id="applyTime" name="applyTime" value="" readonly/>
				<script type="text/javascript">
                    $("#applyTime").val(new Date().Format("yyyy-MM-dd hh:mm:ss"));
				</script>
			</div>
		</div>

		<div class="row" style="margin-top: 5px">
			<label for="testTime" class="col-sm-1" style="line-height: 30px;white-space: nowrap;padding-right: inherit;padding-left: inherit;text-align:left" >&nbsp;考试时间(分钟)：</label>
			<div class="col-sm-3">
				<input type="text" class="form-control" id="testTime" name="testTime" value="" />
			</div>
			<label id="btn" class="col-sm-1" style="line-height: 30px;white-space: nowrap;padding-right: inherit;padding-left:inherit;text-align:right;margin-left: 0px" >
				考试名字：
			</label>
			<div class="col-sm-7" >
				<input type="text" class="form-control"  id="testName" name="testName"  value=""  />
			</div>
		</div>
		<input type="hidden" id="newTestId" value="" />
		<script type="text/javascript">
            function submitForm() {
                $.ajax({
                    type:'post',
                    data:$("#mform").serialize(),
                    url:contextpath+'/user/addNewTest.action',
                    success:function (json) {
                        if(json!='error'&&json.length>0){
                            $('#myModal').modal('show');
                            $("#newTestId").val(json);
                        }else{
                            alert('新增错误');
                        }
                    }
                })

            }
		</script>
		<div class="row" style="margin-top: 5px">
			<div class="col-sm-12" style="text-align: center" >
				<button type="button" class="btn btn-primary" onclick="submitForm()">
					新增考题</button>
				<button  type="button" class="btn btn-success" onclick="window.location.href='${ctx}/user/homePage.action'" style="margin-left: 10px">
					返回</button>
			</div>
		</div>
	</form>


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
				<form id='registerForm' role="form" class="form-horizontal" method="post" enctype="multipart/form-data">
					<div class="form-horizontal">
						<div class="form-group">
							<label for="title" class="col-sm-2 control-label"style="text-align: right;">题目:<font color="red" style="font-size:16px">*</font></label>
							<div class="col-sm-10">
								<input type="text" name="title" id="title"  class="form-control" oninput="if(value.length>10)value=value.slice(0,30)">
							</div>
						</div>
						<div class="form-group">
							<label for="title" class="col-sm-2 control-label"style="text-align: right;">序号:<font color="red" style="font-size:16px">*</font></label>
							<div class="col-sm-10">
								<input type="text" name="sort" id="sort"  class="form-control" >
							</div>
						</div>

						<div class="form-group">
							<label for="add_questionType" class="col-sm-2 control-label"style="text-align: right;">类型:<font color="red" style="font-size:16px">*</font></label>
							<div class="col-sm-10">
								<select id="add_questionType" name="add_questionType" class="selectpicker form-control" >
									<option value="1" >单选题</option>
									<option value="2">多选题</option>
									<option value="4">单行文本</option>
									<option value="5">多行文本</option>
								</select>
							</div>
						</div>
						<div class="form-group" id="fristOptions">
							<label for="add_questionOption1" class="col-sm-2 control-label"style="text-align: right;">选项:<font color="red" style="font-size:16px">*</font></label>
							<div class="col-sm-10 form-inline" >
								<input type="text" name="add_questionOption" id="add_questionOption1"  class="form-control" style="width: 70%">
							</div>
						</div>
						<div class="form-group" id="secondOptions">
							<div class="col-sm-10 form-inline" style="float:right;">
								<input type="text" name="add_questionOption" id="add_questionOption2"  class="form-control" style="width: 70%">
							</div>
						</div>
						<div class="form-group" id="btn_option">
							<label for="add_questionOption1" class="col-sm-2 control-label"style="text-align: right;">	<button type="button" id="btn_addoptions" class="btn btn-default" >
								<%--<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>--%>
								添加选项：
							</button></label>
							<div class="col-sm-10 form-inline" style="float:right;"></div>
						</div>
						<div class="form-group">
							<label for="add_remarks" class="col-sm-2 control-label"style="text-align: right;">备注:</label>
							<div class="col-sm-10">
								<input class="form-control" name="add_remarks" id="add_remarks"  rows="3" oninput="if(value.length>100)value=value.slice(0,50)"></input>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer" align="center">
				<button type="button" id="btn_close" class="btn btn-default" onclick="addQuestion()">
					<%--<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>--%>
					新增考题
				</button>
				<button type="button" id="btn_submit" class="btn btn-primary" onclick="bfSave()" disabled="disabled">
					<span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>
					生成试卷
				</button><span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
			</div>

		</div>

	</div>
</div>
<script >
    $('#myModal').modal('hide');
    $('#add_remarks').parent().parent().hide();
    var i = 2;
    $("#btn_addoptions").click(function () {
        i=i++;
		var str = '<div class="form-group"> <div class="col-sm-10 form-inline" style="float:right;">\n' +
            '<input type="text" name="add_questionOption" id="add_questionOption"'+i+'  class="form-control" style="width: 70%"> &nbsp;<a href="#" onclick="deleteOptions(this)">删除选项</a>\n' +
            '\t\t\t\t\t\t\t</div>\n' +
            '\t\t\t\t\t\t</div>';
		$("#secondOptions").after(str);
    })
    function deleteOptions(a){
        var self = $(a);
        self.parent().parent().remove();
	}

    $('#add_questionType').change(function(){
        var value = $('#add_questionType').val();
        if(value=='4'||value=='5'){
            $('#add_remarks').parent().parent().show();
            $("[id^=add_questionOption]").parent().parent().hide();
            $("#btn_addoptions").parent().parent().hide();
		}else{
            $('#add_remarks').parent().parent().hide();
            $("[id^=add_questionOption]").parent().parent().show();
            $("#btn_addoptions").parent().parent().show();
		}
	});
    function addQuestion(){
		$.ajax({
            type:'post',
            data:$("#registerForm").serialize(),
            url:contextpath+'/user/addQuestion.action?newTestId='+$("#newTestId").val(),
            success:function (json) {
                if(json=='ok'){
                    alert('新增成功');
                    $("#btn_submit").attr("disabled",false);
                    $('#registerForm')[0].reset();
				}else{
                    alert("新增失败");
				}

			}
		})
	}

	function bfSave(){
        window.location.href=contextpath+"/user/createTestPaper.action?newTestId="+$("#newTestId").val();
	}
</script>
</body>

</html>
