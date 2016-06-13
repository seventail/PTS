<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<!DOCTYPE html>
<html>
<%-- Created by flym at 2010-9-12 --%>
<head><title>基础信息添加</title>
	<%@ include file="../../support/include/header.jsp" %>
</head>
<body>
<form id="addForm" action="">
	<s:iterator value="addedPropertyMapList" var="p">
		<g:generated param="#p"/>
	</s:iterator>
	<input type="hidden" name="clazz" value="<s:property value="clazz.name"/>">
</form>
</body>
</html>