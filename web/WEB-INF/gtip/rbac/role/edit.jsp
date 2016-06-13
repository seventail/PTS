<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<g:ajaxResult>
	<form action="" id="editRoleForm">
		<label>角色名：</label><input type="text" name="role.name" maxlength="50"
								  value="<s:property value="role.name"/>"><br>
		<label>信息受限:</label><input type="checkbox" name="role.resourceLimited" value="true"
								   <s:if test="role.resourceLimited">checked="checked"
								   <%-- 如果上级为受限,则不再允许修改为未受限 --%>
		<s:if test="role.parent.resourceLimited">onclick="this.checked = !this.checked" </s:if>
	</s:if>
		/><br/>
		<s:set name="resourceTypeList" value="role.resourceTypeList"/>
		<select name="resourceTypes" size="5" style="width:100%" multiple="multiple">
			<option value="">请选择受限类型</option>
			<s:iterator value="resourceDefinitionList" id="i">
				<option value="<s:property value="#i.type.name"/>"
						<s:if test="#resourceTypeList.contains(#i.type)">selected="selected"</s:if>
					><s:property value="#i.name"/></option>
			</s:iterator>
		</select>
		<input type="hidden" name="idx" value="<s:property value="role.id"/>">
		<%-- sysRole兼容 --%>
		<input type="hidden" name="adminId" value="<s:property value="adminId"/>">
	</form>
</g:ajaxResult>