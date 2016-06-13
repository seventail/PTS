/**
 * 公共组件库
 * powered by Fly_m
 * 成都捷众科技有限公司
 */
$()["ajaxStart"](function() {
	//	if (!$("#loading").length) {
	//		$.startLoad();
	//	}
});
$()["ajaxStop"](function() {
	//	$.endLoad();
});
$()["ajaxError"](function(e, xhr) {
	Gtip.exceptionHandle && Gtip.handleException(xhr);
});
$()["ajaxSuccess"](function(e, xhr) {
	Gtip.postDebug && alert(xhr.responseText);
});
$()["ajaxSend"](function(e, xhr, s) {
	Gtip.preDebug && alert(s.data);
});

var Gtip = {
	preDebug:false,
	postDebug:false,
	prefix:"",
	exceptionHandle :true,
	isArray: function(object) {
		return object && object.constructor === Array;
	},
	isFunction: function(object) {
		return typeof object == "function";
	},
	isString: function(object) {
		return typeof object == "string";
	},
	isNumber: function(object) {
		return typeof object == "number";
	},
	isUndefined: function(object) {
		return typeof object == "undefined";
	},
	handleException : function(exception) {
		var errorDivJquery = $("#_errorDiv");
		if(!errorDivJquery.length) {
			errorDivJquery = $("<div></div>").attr("id", "_errorDiv").css("position", "absolute").css("z-indx", 99999)
				.css("background", "#aaaaaa").css("top", "30px").css("width", "100%").css("height", "50%").css("left",
				"0").css("color", "#ffffff").click(
				function() {
					$(this).hide();
				}).appendTo("body");
		}
		errorDivJquery.html(exception.responseText).show();
	},
	invoke : function(actionName, param, callBack) {
		if(arguments.length < 3)
			return;
		if(!actionName || !$.trim(actionName))
			return;
		//action追加上下文
		actionName = Gtip.util.addContextPath(actionName);
		//处理回调函数,升级为数组解析,数组格式为[[successFun,successMessageFun],failFun]
		if(Gtip.isArray(callBack)) {
			if(!Gtip.isArray(callBack[0]))
				callBack[0] = [callBack[0]];
		} else {
			callBack = [
				[callBack]
			];
		}

		//追加其他的参数到回调函数中去
		var avg = [null];
		if(arguments.length > 3) {
			for(var i = 3; i < arguments.length; i++)
				avg.push(arguments[i]);
		}

		if(param == null)
			param = {};
		if(Gtip.isArray(param)) {
			param.push({name:"_random",value:Math.random()}, {name:"ajax",value:"fly_m-ajaxFlag"},
				{name:"ajax_mode",value:"object"});
		} else if(typeof param == "object") {
			param["_random"] = Math.random();
			param["ajax"] = "fly_m-ajaxFlag";
			param["ajax_mode"] = "object";
		}
		var action = actionName + "Ajax.q";
		if(Gtip.prefix)
			action = Gtip.prefix + action;
		$.post(action, param, function(data) {
			avg[0] = data;
			Gtip.ajax.callBack(callBack, avg);
		}, "json");
	},
	ajax : {
		callBack:function(callBack, avg) {
			var result = avg[0];
			if(result["bool"] === false) {
				callBack[1] ? callBack[1](result["message"]) : (alert(result["message"]));
				return;
			}
			callBack[0][1] && (callBack[0][1](result["message"]));
			//重新引用avg[0],将其直接赋值为re["result"]
			avg[0] = result["result"];
			callBack[0][0].apply(null, avg);
		}
	},
	util:{
		contextPathPattern:new RegExp("^/?" + window["contextPath"] + "/.*$"),
		addContextPath: function(action) {
			if(window["contextPath"] && !Gtip.util.contextPathPattern.test(action)) {
				return action.indexOf("/") == 0 ? window["contextPath"] + action : window["contextPath"] + "/" + action;
			}
			return action;
		},
		fillSelect : function(select, hash, valueKey, contentKey, initContent, reValue) {
			select = $(select)[0];
			select.options.length = 0;
			initContent = initContent || "请选择";
			var option = new Option(initContent, '');
			select.options.add(option);
			if(!hash)
				return;
			$.each(hash, function(i, v) {
				option = new Option(Gtip.util.getValue(v, contentKey), v[valueKey]);
				select.options.add(option);
				if(reValue && v[valueKey] == reValue)
					option.selected = true;
			});
		}
		,
		fillSelectWithArray : function(select, array, initContent, reValue, fun) {
			select = $(select)[0];
			select.options.length = 0;
			if(!initContent) {
				var option = new Option("请选择", "");
				select.options.add(option);
			} else {
				select.options.add(new Option(initContent, ''));
			}
			if(!array)
				return;
			$.each(array, function(i, v) {
				var text = fun && fun(v) || v;
				option = new Option(text, v);
				select.options.add(option);
			});
			reValue && Gtip.util.fixSelected(select, reValue);
		},
		fillSelectWithYear:function(select, initYear, count) {
			count = count || 0;
			initYear = initYear || 2009;
			var date = new Date();
			var year = date.getFullYear();
			var yearsArray = new Array();
			var index = 0;
			for(var i = initYear; i <= year + count; i++) {
				yearsArray[index++] = i;
			}
			Gtip.util.fillSelectWithArray(select, yearsArray, "年度", year);
		}
		,
		fixSelected : function(select, v) {
			select = $(select)[0];
			if(select.options.length == 0)
				return;
			if(!v) {
				select.options[0].selected = true;
				return;
			}
			for(var i = 0; i < select.options.length; i++)
				if(select.options[i].value == v) {
					select.options[i].selected = true;
					break;
				}
		}
		,
		changeNull : function(v) {
			return typeof v == "undefined" ? "" : !v ? "" : v;
		}
		,
		changeValue : function(v, k) {
			v = Gtip.util.changeNull(v);
			return !v && k || v;
		},
		getValue : function(v, key) {
			var i;
			while((i = key.indexOf(".")) != -1) {
				var k = key.substring(0, i);
				v = v[k];
				if(!v)
					break;
				key = key.substring(i + 1);
			}
			v && (v = v[key]);
			return Gtip.util.changeNull(v);
		},
		subEnd : function(v, end) {
			end = end || 10;
			v = Gtip.util.changeNull(v);
			return v.length > end ? v.substring(0, v.length - 3) + "..." : v;
		},
		checkAll:function(checkboxs, b) {
			if(!checkboxs)
				return;
			checkboxs = $(checkboxs)[0];
			b = !!b;
			if(!checkboxs.length) {
				checkboxs.checked = b;
				return;
			}
			for(var i = 0; i < checkboxs.length; i++)
				checkboxs[i].checked = b;
		},
		reverseCheck:function(checkboxs) {
			if(!checkboxs)
				return;
			checkboxs = $(checkboxs)[0];
			if(!checkboxs.length) {
				checkboxs.checked = !checkboxs.checked;
				return;
			}
			for(var i = 0; i < checkboxs.length; i++)
				checkboxs[i].checked = !checkboxs[i].checked;
		}
	},
	token:function() {
		Gtip.invoke("/token/generateToken", {}, function(re) {
			window["session-token"] = re;
		});
	}
};
//jquery load组件的改进版,将指定的值映射到指定的区域,并进行解析,将值写到指定的jquery结点中,并提供默认的操作.
(function($) {
	var jsonFormat = /^\s*\{[\s\S]*\}\s*$/m;
	$.fn.invoke = function(url, param, fun, config) {
		config = $.extend({}, $.fn.invoke.defaultConfig, config);
		param = param || {};
		//设置参数
		if(Gtip.isArray(param)) {
			param.push({name:"_random",value:Math.random()}, {name:"ajax",value:"fly_m-ajaxFlag"},
				{name:"ajax_mode",value:"html"});
		} else if(typeof param == "object") {
			param["_random"] = Math.random();
			param["ajax"] = "fly_m-ajaxFlag";
			param["ajax_mode"] = "html";
		} else if(Gtip.isString(param)) {
			if(param.length && param.charAt(param.length - 1) != '&')
				param += "&";
			param += "_random=" + Math.random() + "&ajax=fly_m-ajaxFlag&ajax_mode=html";
		}
		//url追加上下文
		url = Gtip.util.addContextPath(url);
		//如果原url中已经有类似.q?表示已经增加了相应后缀的情况下,则不再添加后缀
		if(url.indexOf(".q?") == -1 && url.lastIndexOf(".q") != url.length - 2)
			url += ".q";
		//处理回调函数,升级为数组解析,数组格式为[[successFun,successMessageFun],failFun]
		if(Gtip.isArray(fun)) {
			if(!Gtip.isArray(fun[0]))
				fun[0] = [fun[0]];
		} else {
			fun = [
				[fun]
			];
		}
		var self = this;
		$.ajax({
			url:url,
			type:config.type,
			dataType:config.dataType,
			data:param,
			complete:function(res, status) {
				if(status == "success" || status == "notmodified") {
					var responseText = res.responseText;
					//首先处理传统json格式
					if(jsonFormat.test(responseText)) {
						//这里直接调用相应处理api,为与下面的this引用相一致
						var re = eval("(" + responseText + ")");
						if(re["bool"] === false) {
							fun[1] ? fun[re["message"]] : (alert(re["message"]));
							return;
						}
						$.trim(re["message"]) && (fun[0][1] ? fun[0][1](re["message"]) : ($("#message")
							.html(re["message"])));
						Gtip.isString(fun[0][0]) ? self[fun[0][0]](re["result"]) : fun[0][0].apply(self,
							[re["result"]]);
						return;
					}
					var result = $("<div></div>").append(responseText.replace(/<script(.|\s)*?\/script>/g, ""))
						.find("#ajaxDiv");
					if(result.length) {
						var bool = $.trim(result.find("#ajaxBoolDiv").html());
						var message = result.find("#ajaxMessageDiv").html();
						if(bool == "true") {//返回正确
							//处理返回消息
							$.trim(message) && (fun[0][1] ? fun[0][1](message) : ($("#message").html(message)));
							//处理返回结构
							var html = result.find("#ajaxResultDiv").html();
							Gtip.isString(fun[0][0]) ? self[fun[0][0]](html) : fun[0][0].call(self, html);
						} else if(bool == "false") {//返回错误标记
							fun[1] ? fun[1](message) : alert(message);
						} else {//不可能发生
							$.handleError($.ajaxSettings, res);
						}
					} else {//未找到，被认为是错误
						$.handleError($.ajaxSettings, res);
					}
				}
			}
		});
		return this;
	};
	$.fn.invoke.defaultConfig = {type:"POST",dataType:"html"};
})(jQuery);