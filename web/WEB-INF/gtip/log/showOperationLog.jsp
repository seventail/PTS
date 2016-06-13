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
	<title>查看操作日志</title>
</head>
<body>
操作人员:<s:property value="operationLog.username"/><br/>
操作类型:<s:property value="operationLog.categoryName"/><br/>
操作信息:<s:property value="operationLog.infor"/><br/>
详细操作信息:<s:property value="operationLog.data" escape="false"/><br/>
操作时间:<s:date name="operationLog.date" format="yyyy-MM-dd HH:mm:ss"/>
</body>
</html>