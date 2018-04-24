var DataValidatorUtil=function (){
	return {
		/*
		 * 是否是数字型字符串
		 */
		isNumber:function(str){
			if( str != null && str.length>0 && isNaN(str) == false){
		            return true;
	        }else{
	            return false;
	        }
		},
		/*
	     * 判断是否是纯中文
	     * @param str
	     * @returns {Boolean}
	     */
	    isChine:function(str){
	        var reg = /^([u4E00-u9FA5]|[uFE30-uFFA0])*$/;
	        if(reg.test(str)){
	            return false;
	        }
	        return true;
	    },
		/*
	     * 判断字符串是否为空
	     * @param str 传入的字符串
	     * @returns {}
	     */
	    isEmpty:function(str){
	        if(str != null && str.length > 0){
	            return true;
	        }else{
	            return false;
	        }
	    },
	    /*
	     *是否邮箱字符串 
	     */
	    isEmail:function(str){
	        if(str==null||str=="") return false;
	        var result=str.match(/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/);
	        if(result==null)return false;
	        return true;
	    },
	    /*
	     * 是否金额字符串
	     */
	   isMoney: function(str){
	        if(str==null||str=="") return false;
	        var result=str.match(/^(([1-9]\d*)|(([0-9]{1}|[1-9]+)\.[0-9]{1,2}))$/);
	        if(result==null)return false;
	        return true;
	    },
	    /*
	     * 是否为手机号字符串
	     */
	    isMobile:function(str){
	        if(str==null||str=="") return false;
	        var result=str.match(/^1[34578]\d{9}$/);
	        if(result==null)return false;
	        return true;
	    } ,
	    /*
	     * 是否全英文
	     */
	    isEnglish:function(str){
	        if(str==null||str=="") return false;
	        var result=str.match(/^[A-Za-z]+$/);
	        if(result==null)return false;
	        return true;
	    },
	    /*
	     * 是否邮政编码格式
	     */
	    isZipCode:function(str){
	        if(str==null||str=="") return false;
	        var result=str.match(/^[0-9]{6}$/);
	        if(result==null)return false;
	        return true;
	    }
	}
}();