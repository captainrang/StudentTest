
function LoadinDataTable() {
    $("#userInfoTable").bootstrapTable({
        method: 'post',
        contentType: "application/x-www-form-urlencoded",
        url: contextpath + '/user/showUser.action',
        queryParams: queryParams,//请求服务器时所传的参数
        pageNumber: 1, //初始化加载第一页，默认第一页
        dataType: 'json',
        pagination: true,//是否分页
        sidePagination: 'server',//指定服务器端分页
        pageSize: 100,//初始化单页记录数
        pageList: [100, 200, 300, 400, 500],//分页步进值
        singleSelect: false,
        showRefresh: false,//是否显示刷新按钮
        queryParamsType: 'limit',//查询参数组织方式
        //rownumbers:true,
        columns: [
            {
                field: 'numrow',
                title: '序号',
                formatter: function (value, row, index) {
                    var page = $("#userInfoTable").bootstrapTable("getPage");
                    return page.pageSize * (page.pageNumber - 1) + index + 1;
                }
            }, {
                field: 'username',
                title: '账号'
            }, {
                field: 'realname',
                title: '姓名'
            }, {
                field: 'classname',
                title: '班级'
            }, {
                field: 'classType',
                title: '用户类型'
            }]
    });
}
function queryParams(param){
    var parms={
        pageSize : param.limit, //每一页的数据行数，默认是上面设置的10(pageSize)
        curPage : param.offset/param.limit+1 //当前页面,默认是上面设置的1(pageNumber)
    };
    return parms;
}
function addUser(){
    $('#myModal').modal('show');
}
function addUserOpt(){

            $.ajax({
                type:'post',
                url:contextpath+'/user/addUserOpt.action',
                data : $("#registerForm").serialize(),
               /* dataType:'json',*/
                async:false,
                success:function(json){
                    //console.log(json);
                    if(json=="OK"){
                        //$("form").reset();
                        $('#myModal').modal('hide');
                        clearCondition();
                        $('#userInfoTable').bootstrapTable('refreshOptions',{pageNumber:1});
                        $('#userInfoTable').bootstrapTable('refresh', {
                            query:{
                                curPage :1 //当前页面,默认是上面设置的1(pageNumber)
                            }
                        });
                    }
                },
                error: function(xhr,textStatus, errorThrown) {
                    alert("错误信息"+errorThrown);
                }
            });

}
$(function() {
    $('#myModal').modal('hide');
    LoadinDataTable();


});
