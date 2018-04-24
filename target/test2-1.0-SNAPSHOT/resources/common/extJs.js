//通用JS,后期基于JS进行扩展
$(function(){
	//是否加载树
	if(!Empty($("#"+treename))){
		$.fn.zTree.init($("#"+treename), setting);
	}
});
var setting={
		async : {
			enable : true,//设置ztree是否进行异步加载
			url : contxtpath+treecontroller+'tree.action',
			autoParam:["id=treeid"],//树异步加载时自动提交父节点属性
			
		},
		callback : {
			beforeClick : beforeClick,
			onClick : onClick,
			beforeAsync : beforeAsync,
			onAsyncSuccess : onAsyncSuccess,
			beforeCollapse : beforeCollapse,
			beforeExpand : beforeExpand,
			onCollapse : onCollapse,
			onExpand : onExpand,
			onAsyncError : onAsyncError,
		},
		view : {
			selectedMulti : false,//是否允许多选
			dblClickExpand: false,//双击与单击冲突
			nameIsHTML : true,//设置name是否支持HTML脚本
			addDiyDom : addDiyDom,//在节点上显示用户自定义图标
		}
};
//单击前事件
function beforeClick(treeId,treeNode){
	var zTree = $.fn.zTree.getZTreeObj(treeId);
	if (treeNode.isParent) {
		zTree.expandNode(treeNode,true);//去掉true就可以点击展开与收缩
	}
	return true;
}
//树节点单击事件
function onClick(event, treeId, treeNode){
	treeNodeClick(treeNode.id);
}
//异步加载前事件
function beforeAsync(treeId, treeNode){
	return true;
}
//异步加载完成后事件
function onAsyncSuccess(event, treeId, treeNode, msg){
	if(Empty(treeNode)){
		var ztree = $.fn.zTree.getZTreeObj(treeId);
		var nodes = zTree.getNodes();
		zTree.expandNode(nodes[0], true);
		zTree.selectNode(nodes[0]);
	}else{
		alert("错误信息");
	}
}
//父节点折叠之前的事件
function beforeCollapse(treeId, treeNode){
	return (treeNode.collapse == true);
}
//父节点展开前事件
function beforeExpand(treeId, treeNode){
	return (treeNode.expand == false);
}
//节点被折叠的事件
function onCollapse(event, treeId, treeNode){
	
}
//节点被展开事件
function onExpand(event, treeId, treeNode){
	
}
//异步加载出现异常错误的事件
function onAsyncError(vent, treeId, treeNode, XMLHttpRequest, textStatus, errorThrown){
	
}
//树节点被单击时，通过单击的树节点进行表格的查询
function treeNodeClick(treeid){
	
}


