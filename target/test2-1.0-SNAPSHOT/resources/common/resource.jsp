<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<!-- 公共CSS引入 -->
<link href="${ctx}/resources/vendor/bootstrap/css/bootstrap.css?verID=1.0.0.1" rel="stylesheet" type="text/css">
<link href="${ctx}/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet" type="text/css">
<link href="${ctx}/resources/dist/css/sb-admin-2.css" rel="stylesheet" type="text/css">
<link href="${ctx}/resources/vendor/morrisjs/morris.css" rel="stylesheet" type="text/css">
<link href="${ctx}/resources/vendor/bootstrap-dialog/css/bootstrap-dialog.min.css" rel="stylesheet" type="text/css">
<link href="${ctx}/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link href="${ctx}/resources/vendor/bootstrap-select-1.12.3/css/bootstrap-select.css" rel="stylesheet" type="text/css">
<link href="${ctx}/resources/vendor/bootstrap-table/css/bootstrap-table.css" rel="stylesheet" type="text/css">
<link href="${ctx}/resources/vendor/bootstrap-datetimepicker/css/bootstrap-datetimepicker.css" rel="stylesheet" type="text/css">
<link href="${ctx}/resources/vendor/ztree/css/metroStyle/metroStyle.css" rel="stylesheet" type="text/css">
<link href="${ctx}/resources/vendor/bootstrap-validator/css/bootstrapValidator.css" rel="stylesheet" type="text/css">
<link href="${ctx}/resources/vendor/bootstrap-fileinput/css/fileinput.css" rel="stylesheet" type="text/css">
<link href="${ctx}/resources/vendor/bootstrap3-editable/css/bootstrap-editable.css" rel="stylesheet" type="text/css">
<link href="${ctx}/resources/vendor/jqprint/css/jquery.jqprint-0.3.css?ver=1.0.0.1" rel="stylesheet" type="text/css">
<!-- 公共JavaScript导入 -->
<script src="${ctx}/resources/vendor/jquery/jquery.min.js" type="text/javascript"></script>
<script src="${ctx}/resources/vendor/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctx}/resources/vendor/metisMenu/metisMenu.min.js" type="text/javascript"></script>
<script src="${ctx}/resources/vendor/raphael/raphael.min.js" type="text/javascript"></script>
<script src="${ctx}/resources/vendor/morrisjs/morris.min.js" type="text/javascript"></script>
<script src="${ctx}/resources/data/morris-data.js" type="text/javascript"></script>
<script src="${ctx}/resources/dist/js/sb-admin-2.js" type="text/javascript"></script>
<script src="${ctx}/resources/vendor/bootstrap-dialog/js/bootstrap-dialog.min.js" type="text/javascript"></script>
<script src="${ctx}/resources/vendor/bootstrap-closable-tab/bootstrap-closable-tab.js" type="text/javascript"></script>
<script src="${ctx}/resources/vendor/json2/json2.js" type="text/javascript"></script>
<script src="${ctx}/resources/vendor/bootstrap-select-1.12.3/js/bootstrap-select.js" type="text/javascript"></script>
<script src="${ctx}/resources/vendor/bootstrap-table/js/bootstrap-table.js" type="text/javascript"></script>
<script src="${ctx}/resources/vendor/bootstrap-table/js/bootstrap-table-editable.js" type="text/javascript"></script>
<script src="${ctx}/resources/vendor/bootstrap-table/js/bootstrap-table-zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/resources/vendor/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/resources/vendor/bootstrap-datetimepicker/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/resources/vendor/ztree/js/jquery.ztree.all.js" type="text/javascript"></script>
<script src="${ctx}/resources/vendor/bootstrap-validator/js/bootstrapValidator.js" type="text/javascript"></script>
<script src="${ctx}/resources/vendor/bootstrap-validator/js/zh_CN.js" type="text/javascript"></script>
<script src="${ctx}/resources/vendor/bootstrap-fileinput/js/fileinput.js" type="text/javascript"></script>
<script src="${ctx}/resources/vendor/bootstrap-fileinput/js/zh.js" type="text/javascript"></script>
<script src="${ctx}/resources/vendor/bootstrap3-editable/js/bootstrap-editable.js" type="text/javascript"></script>
<script src="${ctx}/resources/vendor/underscore/underscore.js" type="text/javascript"></script>
<script src="${ctx}/resources/common/jsUtil.js" type="text/javascript"></script>
<!-- jquery打印插件js引入 -->
<script src="${ctx}/resources/vendor/jqprint/jquery.jqprint-0.3.js?ver=1.0.0.1" type="text/javascript"></script>
<!-- 输入长度限制校验，ml为最大字节长度 -->
<script src="${ctx}/resources/common/characterLengthLimit.js" type="text/javascript"></script>
<script src="${ctx}/resources/common/DataValidatorUtil.js"></script>
<script src="${ctx}/resources/common/QueryConditionReset.js"></script>
<script type="text/javascript">
    var contextpath = "${pageContext.request.contextPath}";
	var contxtpath = '<c:url value="/"/>';
	//通用方法(撤销流程)
	function cancelProcess(bussinessCode){
			var json={
				bussinessCode:bussinessCode	
			};
			$.ajax({
		        url : contxtpath + 'workflowtask/cancelProcess.action?t='+new Date().getTime(),
		        type : 'post',
		        data : json,
		        async:false,
		        dataType:'json',
		        success : function(json) {
		        	if(json.returncode=="OK"){
		        		canceltag="true";
		        	}else{
		        		$("#common_modal").modal('show');
			        	$("#common_info").text(json.returnmessage);
		        	}
		        	
		        },
		        error : function() {
		        	$("#common_modal").modal('show');
		        	$("#common_info").text('程序异常');
		        }
			});
			return canceltag;
		}
</script>
<!-- 通用提示框 -->
<div class="modal fade" id="common_modal" tabindex="-1" role="dialog"
	aria-labelledby="common_modal_label">
	<div class="modal-dialog modal-sm" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title" id="common_modal_label">提示</h4>
			</div>
			<div class="modal-body">
				<strong><p id="common_info"></p></strong>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-success" data-dismiss="modal"  onclick="refresh()">确定</button>
			</div>
		</div>
	</div>
</div>
<!-- 通用删除提示框 -->
<div class="modal fade" id="common_del" role="dialog"
	aria-labelledby="common_del_label">
	<div class="modal-dialog modal-sm" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title" id="common_del_label">提示</h4>
			</div>
			<div class="modal-body">
				<p>
					<strong>确定要删除吗?</strong>
				</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-white" data-dismiss="modal">取消</button>
				<button type="button" class="btn btn-success" data-dismiss="modal"
					id="btn-ok" onclick="common_del_function()">确定</button>
			</div>
		</div>
	</div>
</div>