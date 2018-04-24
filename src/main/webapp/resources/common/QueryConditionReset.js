/**
 * 查询条件清空：
 * 清空页面中class属性中带有resetable类标记的input。
 * 刷新页面中class属性中带有resetable类标记的select。
 * 使用时，在jsp中增加
 * <button type="button" onclick="QueryConditionReset('research()')" class="btn btn-default">重置</button>
 * 给需要清空的类
 *  resetable
 *  research()为查询按钮绑定的查询方法，清空后再执行一次查询，请改为你的查询方法，并用引号包围
 */ 

function QueryConditionReset(research){
		
		var $clear=$("input.resetable");
		$clear.val(null);
		/*$clear.datetimepicker('setStartDate', null);
		$clear.datetimepicker('setEndDate', null);*/
		var $selects = $('select.resetable');
		$selects.each(function(){
			$(this).children("option").removeAttr("selected");
			$(this).children("option").first().attr("selected","selected");
		});
		$selects.selectpicker("val","");
		$selects.selectpicker('refresh');
		
		var $datetimepickerClear = $("input.datetimepickerClear");
		$datetimepickerClear.each(function(){
			$(this).datetimepicker('setStartDate', null);
			$(this).datetimepicker('setEndDate', null);
			$(this).datetimepicker('clearDates');
		});
		
		
		eval(research);
}

function disableTargetClass(tagetClass,callback){
	$("."+tagetClass).attr("disabled",true);
	setTimeout(callback(), 800);
	
}


function enableTargetClass(tagetClass){
	$("."+tagetClass).attr("disabled",false);
	
}