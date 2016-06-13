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
	<script type="text/javascript">
		$(function() {
			$('#clazzSelect').change(function() {
				var self = $(this);
				var value = self.val();
				if(!value)
					return;
				//允许多选
				var multiple = $("option:selected", self).attr("multiple");
				$("#idsSelect").invoke("${pageContext.request.contextPath}/admin/platform/rbac/grant/userxresource/do/listResource", {clazz:value}, function(re) {
					Gtip.util.fillSelect(this[0], re, "id", "name");
					multiple == "true" && this.attr("multiple", true) || this.attr("multiple", false);
				});
			});
		});
	</script>
</head>
<body>
用户资源分配
<form action="" id="userxresourceForm">
	<label>资源类型:</label>
	<select size="1" name="clazz" id="clazzSelect">
		<option value="">请选择</option>
		<s:iterator value="resourceDefinitionList">
			<option value="<s:property value="type.name"/>" multiple="<s:property value="multiple"/>"><s:property
					value="name"/></option>
		</s:iterator>
	</select><br/>
	<label>资源:</label>
	<select size="5" name="ids" id="idsSelect">
		<option value="0">请选择</option>
	</select>
	<input type="hidden" name="idx" value="<s:property value="idx"/>">
</form>
</body>
</html>