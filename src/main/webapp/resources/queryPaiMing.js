
function LoadinDataTable() {
    $("#studentTestInfoTable").bootstrapTable({
        method: 'post',
        contentType: "application/x-www-form-urlencoded",
        url: contextpath + '/user/queryPaiMingTail.action',
        queryParams: queryParams,//请求服务器时所传的参数
        pageNumber: 1, //初始化加载第一页，默认第一页
        dataType: 'json',
        pagination: true,//是否分页
        sidePagination: 'server',//指定服务器端分页
        pageSize: 5,//初始化单页记录数
        pageList: [5, 10, 15, 20, 25],//分页步进值
        singleSelect: false,
        showRefresh: false,//是否显示刷新按钮
        queryParamsType: 'limit',//查询参数组织方式
        //rownumbers:true,
        columns: [
            {
                field: 'numrow',
                title: '序号',
                formatter: function (value, row, index) {
                    var page = $("#studentTestInfoTable").bootstrapTable("getPage");
                    return page.pageSize * (page.pageNumber - 1) + index + 1;
                }
            }, {
                field: 'studentName',
                title: '学生姓名'
            }, {
                field: 'testName',
                title: '测试名字'
            },{
                field: 'grade',
                title: '分数'
            } ]
    });
}
function queryParams(param){
    var parms={
        pageSize : param.limit, //每一页的数据行数，默认是上面设置的10(pageSize)
        curPage : param.offset/param.limit+1, //当前页面,默认是上面设置的1(pageNumber)
        taskId:$("#taskId").val()
    };
    return parms;
}
$(function() {

    LoadinDataTable();


});


