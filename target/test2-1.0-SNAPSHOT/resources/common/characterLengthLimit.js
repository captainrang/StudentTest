/**
 * 输入长度限制校验，ml为最大字节长度
 * @param obj
 * @param ml
 */
function charLengthLimit(obj,ml){
	var va = obj.value;
	var vat = "";
	for ( var i = 1; i <= va.length; i++) {
		vat = va.substring(0,i);
		//把双字节的替换成两个单字节的然后再获得长度，与限制比较
		if (vat.replace(/[^\x00-\xff]/g,"aa").length <= ml) {
			maxStrlength=i;
		}else{
			
			break;
		}
	}
	obj.maxlength=maxStrlength;
	//把双字节的替换成两个单字节的然后再获得长度，与限制比较
	if (va.replace(/[^\x00-\xff]/g,"aa").length > ml) {
		obj.value=va.substring(0,maxStrlength);
		/*if ($("#"+obj.id+"-toolong").length == 0) {
			var tip= "<span id='"+obj.id+"-toolong' style='margin-left:5px;color:red;' display='none'>长度不能超过"+ml+"字节(中文占2字节)</span>";
			myAlert("长度不能超过"+ml+"字节");
		}*/
	}
}