<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<!DOCTYPE html>
<!--
Fly_m at 2009-11-4
-->
<html>
<head>
	<title>用户角色分配</title>
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
						var checked = self.attr("checked");
						self.parents("ul.tree").find("input:checkbox[checked=true]").attr("checked", false).attr("name", "ids");
						checked && self.attr("name", "roleId").parents("li").children("input:checkbox").attr("checked", true);
					});
				}
			};
			$("#roleTree>ul:first").initTree(optConfig);
		});
	</script>
</head>
<body>
用户角色分配
<form action="" id="userxroleForm">
	<div id="roleTree">
		<ul>
			<g:tree nodeList="roleList" expand="true"/>
		</ul>
	</div>
	<input type="hidden" name="idx" value="<s:property value="idx"/>">
</form>
</body>
</html>