<%@ page import="com.greejoy.gtip.component.ApplicationContextManager" %>
<%@ page import="com.greejoy.gtip.component.authorize.AuthBody" %>
<%@ page import="java.util.Date" %>
<%@ page import="org.apache.commons.lang.time.DateFormatUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	if(!ApplicationContextManager.isApplicationContextInjected()) {
		//准备弹出授权对话框
		String s = (String) request.getAttribute("error");
		AuthBody authBody = AuthBody.get();
%>
<!DOCTYPE HTML>
<html>
<head>
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
		margin-top: 8px;
		margin-right: 20px;
		display: block;
		float: right;
	}
</style>
</head>
<body>
<form action="${pageContext.request.contextPath}/ac" method="post">
	<div class="quan">
		<h4>
			<%
				if(authBody != null) {
					out.println("本系统授权给" + authBody.getAuthBody());
				}
			%>
		</h4>
		<%
			if(authBody != null && authBody.getValidDate() != null) {
				Date date = authBody.getValidDate();
		%>
		<div>使用期限截止到<%=DateFormatUtils.format(date, "<span>yyyy</span>年<span>MM</span>月<span>dd</span>日")%>
		</div>
		<%
		} else {
		%>
		<div>&nbsp;</div>
		<%
			}

		%>
		<div>请填写授权码：</div>
		<div><input type="text" name="accode" value="" class="kuang"/></div>
		<div class="error">
			<%
				if(authBody != null && authBody.getErrorMessage() != null)
					out.println(authBody.getErrorMessage());
			%>
		</div>
		<div class="quan_anniu"><input type="submit" value="确定"/>
			<a href="${pageContext.request.contextPath}/indexc.jsp">申请授权</a>
		</div>
	</div>
</form>
</body>
</html>
<%
		return;
	}
%>
<script type="text/javascript">
	window.top.location.href = "${pageContext.request.contextPath}/login.jsp";
</script>

