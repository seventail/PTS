<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<!--
Fly_m at 2009-10-31
-->
<html>
<head>
	<title>修改密码</title>
	<%@ include file="../../support/include/header.jsp" %>
	<script type="text/javascript">
		$(function() {
			$("#changeSelfPasswordForm").submit(function() {
				var self = $(this);
				return (self.validate().form());
			});
		});
	</script>
</head>
<body>
<form action="${pageContext.request.contextPath}/admin/platform/rbac/user/do/changeSelfPassword.q" id="changeSelfPasswordForm" title="修改密码">
	<label>旧密码:</label><input type="password" name="oldPassword" class="required"><br/>
	<label>新密码:</label><input type="password" name="user.password" id="passwordChange" class="required" maxlength="20"
							  minlength=6 tip="至少六位"><br/>
	<label>确认密码:</label><input type="password" name="repassword" id="user.password" equalTo="#passwordChange"
							   class="required" maxlength="20" minlength=6 tip="至少六位"><br/>
	<input type="submit" value="修改">
</form>
</body>
</html>