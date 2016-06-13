<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<g:ajaxResult>
	<form action="" id="editPermissionNodeForm">
		<label>名称：</label><input type="text" name="permissionNode.name" maxlength="50"
								  value="<s:property value="permissionNode.name"/>"><br>
		<input type="hidden" name="idx" value="<s:property value="permissionNode.id"/>">
	</form>
</g:ajaxResult>