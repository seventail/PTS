<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<!--
Fly_m at 2009-10-31
-->
<html>
<head>
	<title>修改个人信息</title>
	<%@ include file="../../support/include/header.jsp" %>
</head>
<body>
<form action="${pageContext.request.contextPath}/admin/platform/rbac/user/do/updateSelf.q">
	<label>姓名:</label><input type="text" name="user.name" value="<s:property value="user.name"/>"><br/>
	<label>联系方式:</label><input type="text" name="user.linkInfor" value="<s:property value="user.linkInfor"/>"><br/>
	<input type="submit" value="修改">
</form>
</body>
</html>