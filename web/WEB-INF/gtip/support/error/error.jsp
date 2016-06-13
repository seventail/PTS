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
	已经发生错误了!错误信息如下:
</div>
<div style="color:red;">
	<s:property value="%{exceptionStack.replaceAll('[\\t\\n]++','<br/>')}" escape="false"/>
</div>
</body>
</html>