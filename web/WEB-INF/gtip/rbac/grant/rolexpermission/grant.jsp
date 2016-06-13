<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<!DOCTYPE html>
<!--
Fly_m at 2009-11-4
-->
<html>
<head>
	<title>角色权限分配</title>
	<%@ include file="../../../support/include/header.jsp" %>
	<script type="text/javascript" src="${pageContext.request.contextPath}/theme/tree.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/theme/ui.droppable.js"></script>
	<script type="text/javascript">
		$(function() {
			var optConfig = {
				checkbox:true,
				expand:true,
				licall:function(li) {
					li = $(li);
					li.children("input:checkbox").click(function() {
						var self = $(this);
						self.liCheckboxClick();
					});
				}
			};
			$("#permissionTree>ul:first").initTree(optConfig);
		});
	</script>
</head>
<body>
角色权限分配
<form action="" id="rolexpermissionForm">
	<div id="permissionTree">
		<ul>
			<g:tree nodeList="permissionList" expand="true"/>
		</ul>
	</div>
	<input type="hidden" name="idx" value="<s:property value="idx"/>">
	<%-- sysRole兼容 --%>
	<input type="hidden" name="adminId" value="<s:property value="adminId"/>">
</form>
</body>
</html>