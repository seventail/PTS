<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<!DOCTYPE html
PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
Fly_m at 2009-9-7
-->
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh-CN">
<head>
	<title>操作失败</title>
</head>
<body>
<g:ajaxResult>
	<div style="color:blue;font:bold 20px;text-align:center;">
		操作失败:
	</div>
	<div style="color:red;text-align:center;">
		<%@ include file="../include/actionerror.jsp" %>
	</div>
</g:ajaxResult>
</body>
</html>