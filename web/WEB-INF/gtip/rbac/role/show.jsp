<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<g:ajaxResult>
	角色名:<s:property value="role.name"/><br/>
	信息受限:<s:property value="role.resourceLimitedInfor"/><br/>
	<s:if test="role.resourceLimited">
		受限类型:<s:property value="role.resourceTypeListInfor"/>
	</s:if>
</g:ajaxResult>