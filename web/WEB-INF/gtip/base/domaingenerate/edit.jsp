<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<!DOCTYPE html>
<html>
<%-- Created by flym at 2010-9-12 --%>
<head><title>基础信息修改</title>
	<%@ include file="../../support/include/header.jsp" %>
</head>
<body>
<form id="editForm" action="">
	<s:iterator value="updatedPropertyMapList" var="p">
		<g:generated param="#p" entity="e"/>
	</s:iterator>
	<input type="hidden" name="clazz" value="<s:property value="clazz.name"/>">
	<input type="hidden" name="idx" value="<s:property value="idx"/>">
</form>
</body>
</html>