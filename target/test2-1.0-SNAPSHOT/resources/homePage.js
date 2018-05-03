$(function() {
    //渐入渐出
    //recevice();




})

function fbTest() {
    window.location.href = contextpath + "/user/fbTest.action";
}
function recevice(){
    setTimeout(function(){
        $(".btm-tips").animate({bottom: '20px', opacity: 1}, 280, 'linear', function () {
            //驻留时间设为10s
            var self = this;
            var tempTimer = setTimeout(function () {
                $(".btm-tips").animate({bottom: '-200px', opacity: 0}, 'fast', function () {
                    self.remove();
                });
                clearTimeout(tempTimer);
            }, 3600000)
        });
    },2000);
}
//停止考试 给所有的在线的考生发送消息 终止考试
function stopTest(){
    $.ajax({
        url: contextpath + "/user/stopTest.action",
        type:"get",
        success: function (json) {
            if (json == "ok") {
                alert("已终止考试");
            }else{
                alert("终止失败");
            }
        }
    })

}

function newUser() {
    window.location.href = contextpath+"/user/addUser.action"
}
function sign() {
    $.ajax({
        url: contextpath + "/user/signed.action",
        type:"get",

        success: function (json) {
            if (json == "ok") {
                $("#sign").attr("disabled", true);
                $("#sign").attr("onclick", "");
                $("#sign").css({"background-color":"#f2f2f2"});
                alert("签到成功");
            } else if(json=="error") {
                alert("签到失败");
            }else{
                alert("今日已完成签到");
            }

        }

    })
}
/*
 * 判断变量是否空值
 * undefined, null, '', false, 0, [], {} 均返回true，否则返回false
 */
function Empty(v) {
    switch (typeof v) {
        case 'undefined':
            return true;
            break;
        case 'string':
            if (v.length == 0)
                return true;
            break;
        case 'boolean':
            if (!v)
                return true;
            break;
        case 'number':
            if (0 === v)
                return true;
            break;
        case 'object':
            if (null == v)
                return true;
            if (undefined !== v.length && v.length == 0)
                return true;
            for (var k in v) {
                return false;
            }
            return false;
            break;
    }
    return false;
}
