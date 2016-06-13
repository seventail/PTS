<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<g:ajaxResult>
	<tr id="<s:property value="permission.id"/>">
		<td><s:property value="permission.code"/></td>
		<td><s:property value="permission.className"/></td>
		<td><s:property value="permission.method"/></td>
		<td><s:property value="permission.name"/></td>
		<td><s:property value="permission.supportedPermission.name"/></td>
	</tr>
</g:ajaxResult>
