<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<g:ajaxResult>
	<form id="editPermissionForm" action="" title="修改权限">
		<label>权限名称：</label><input type="text" name="permission.name" value="<s:property value="permission.name"/>" class="required" maxlength="50"><br>
		<input type="hidden" value="<s:property value="permission.id"/>" name="idx">
	</form>
</g:ajaxResult>
