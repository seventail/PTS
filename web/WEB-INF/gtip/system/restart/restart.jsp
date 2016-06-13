<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<!DOCTYPE html>
<html>
<head>
	<title>重启tomcat</title>
	<%@ include file="/WEB-INF/gtip/support/include/header.jsp" %>
	<script type="text/javascript">
		function restart() {
			window.self.location.href = "<%=request.getContextPath()%>/admin/platform/system/restart/do/restart.q";
		}
	</script>
</head>
<body>
<div id="toolbar">
	<a onclick="restart();">重启tomcat</a>
</div>
</body>
</html>