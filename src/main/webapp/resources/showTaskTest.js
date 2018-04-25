
function LoadinDataTable() {
    $("#studentTestInfoTable").bootstrapTable({
        method: 'post',
        contentType: "application/x-www-form-urlencoded",
        url: contextpath + '/user/getUserTestInfo.action',
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
                field: 'className',
                title: '班级'
            }, {
                field: 'testName',
                title: '测试名字'
            }, {
                title: '操作',
                formatter: function (value, row, index) {
                    var n = '<a href="#" onclick="shenyue('+row.stuId+')">审阅</a>';
                    return n;
                }
            }]
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
function shenyue(stuId){
    var testId = $("#taskId").val();
    window.location.href = contextpath+"/user/shenyue.action?testId="+testId+"&stuId="+stuId;

}

//查看排名 有两点 一：考试 是否已经结束，二：老师是否已经批阅成功。
//排名有两点 一：学生的成绩和排名，考试名字 考试完成率，
function paiming() {
    $.ajax({
        url:contextpath+'/user/paiming.action?testId='+$("#taskId").val(),
        type:'get',
        success:function (json) {
            if(json=='1'){
                alert('考试未结束');
            }else if(json=='2'){
                alert('老师还未审阅完');
            }else {
                window.location.href = contextpath+"/user/queryPaiMing.action?testId="+$("#taskId").val();
            }

    }
})

}
