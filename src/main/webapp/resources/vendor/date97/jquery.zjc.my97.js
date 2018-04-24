$.extend($.fn.datagrid.defaults.editors, {
    my97 : {
        init : function(container, options) {
            var input = $('<input class="Wdate" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd HH:mm:ss\',readOnly:true});"  />').appendTo(container);
            return input;
        },
        getValue : function(target) {
            return $(target).val();
        },
        setValue : function(target, value) {
            $(target).val(value);
        },
        resize : function(target, width) {
            var input = $(target);
            if ($.boxModel == true) {
                input.width(width - (input.outerWidth() - input.width()));
            } else {
                input.width(width);
            }
        }
    }
});