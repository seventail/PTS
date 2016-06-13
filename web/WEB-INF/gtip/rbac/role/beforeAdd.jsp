<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<g:ajaxResult>
	<form action="" id="addRoleForm">
		<label>角色名称:</label><input type="text" name="role.name" class="required"><br/>
		<label>信息受限:</label><input type="checkbox" name="role.resourceLimited" value="true"
	<s:if test="role.resourceLimited">
								   checked="checked" disabled="disabled"
	</s:if>
			><br/>
		<s:if test="role == null || !role.resourceLimited">
			<select name="resourceTypes" size="5" multiple="multiple" style="width:100%">
			<option value="">请选择受限类型</option>
			<s:iterator value="resourceDefinitionList">
				<option value="<s:property value="type.name"/>"><s:property value="name"/></option>
			</s:iterator>
		</select>
		</s:if>
		<input type="hidden" name="role.parent.id" value="<s:property value="role.id"/>">
		<%-- sysRole兼容 --%>
		<input type="hidden" name="adminId" value="<s:property value="adminId"/>">
	</form>
</g:ajaxResult>