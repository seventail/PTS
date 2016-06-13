<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html
PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
Fly_m at 2009-9-24
-->
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh-CN">
<head>
	<title>查看错误日志</title>
</head>
<body>
操作人员:<s:property value="exceptionLog.username"/><br/>
出错类型:<s:property value="exceptionLog.className"/><br/>
出错信息:<s:property value="exceptionLog.infor"/><br/>
详细出错信息:<s:property value="exceptionLog.data" escape="false"/><br/>
出错时间:<s:date name="exceptionLog.date" format="yyyy-MM-dd HH:mm:ss"/>
</body>
</html>