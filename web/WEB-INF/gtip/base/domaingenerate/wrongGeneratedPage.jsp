<%@ page import="com.greejoy.gtip.module.base.annotation.Generated" %>
<%@ page import="org.apache.struts2.ServletActionContext" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html
PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
Fly_m at 2009-9-7
-->
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh-CN">
<head>
	<title>错误信息</title>
</head>
<body>
<div style="color:blue;font:bold 20px;text-align:center;">
	错误的自定义界面:<%=ServletActionContext.getContext().getActionInvocation().getResultCode()
	.substring(Generated.GENERATED_PAGE.length())%>
</div>
</body>
</html>