<%@ page import="com.greejoy.gtip.component.ApplicationContextManager" %>
<%@ page import="com.greejoy.gtip.component.authorize.AuthBody" %>
<%@ page import="java.util.Date" %>
<%@ page import="org.apache.commons.lang.time.DateFormatUtils" %>
<%@ page import="com.greejoy.gtip.component.authorize.AuthorizerHelper" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<title>系统授权说明</title>
	<style type="text/css">
		h4, div, input, span {
			padding: 0;
			margin: 0;
		}

		body {
			background: #fff;
			color: #000;
			font-size: 13px;
			font-family: "macrosoft Yahei", Arial, Helvetica, san-serif, serif;
		}

		.quan {
			background: url(${pageContext.request.contextPath}/theme/images/quan_bg.png) no-repeat;
			width: 491px;
			height: 299px;
			margin: 0 auto;
			margin-top: 150px;
		}

		h4 {
			padding: 70px 0 20px 160px;
			font-size: 16px;
		}

		.quan div {
			padding-left: 100px;
			margin: 10px 0;
		}

		.quan span {
			color: red;
			font-weight: bold;
			padding: 0 5px;
		}

		.quan .kuang {
			dispaly: block;
			height: 30px;
			width: 345px;
			padding-left: 5px;
			border: 1px solid #ccc;
			line-height: 30px;
			color: #000;
		}

		.quan .kuang:focus {
			border: 1px solid #0f73c7;
		}

		.error {
			color: red;
			font-size: 11px;
		}

		.quan_anniu {
			text-align: right;
			padding-right: 38px;
		}

		.quan_anniu input {
			border: none;
			background: url(${pageContext.request.contextPath}/theme/images/quan_anniu.png) no-repeat;
			display: block;
			width: 82px;
			height: 32px;
			float: right;
		}

		.quan_anniu a {
			margin-right: 20px;
			display: block;
			float: right;
		}

		.quan .name {
			padding-top: 110px;
		}
	</style>
</head>
<body>
<div class="quan">
	<div class="name">授权名称：<input type="text" value="" class="kuang"/></div>
	<div>项目信息：<input type="text" value="<%=AuthorizerHelper.generateProjectAuthorizeInfor()%>" disabled="disabled" readonly="readonly" class="kuang"/></div>
	<div class="error">请将以上信息提交给相关人员进行审核。</div>
	<div class="quan_anniu"><a href="${pageContext.request.contextPath}/index.jsp">返回</a></div>
</div>

</body>
</html>
