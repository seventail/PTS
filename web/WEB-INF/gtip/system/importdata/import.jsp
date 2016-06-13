<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
	<title>导入数据</title>
	<%@ include file="/WEB-INF/gtip/support/include/header.jsp" %>
</head>
<body>
<div id="importDiv">
	<form action="${pageContext.request.contextPath}/admin/platform/system/dataimport/do/importData.q" method="post" enctype="multipart/form-data">
		请选择数据文件：<input type="file" name="file">
		<input type="submit" class="button" value="执行"/>
	</form>
</div>
</body>
</html>