<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<g:ajaxResult>
	<tr id="<s:property value="e.id"/>">
		<s:iterator value="tableViewedPropertyMapList" var="v">
			<td><g:property value="e" property="%{#v.propertyName}" format="%{#v.format}"/></td>
		</s:iterator>
	</tr>
</g:ajaxResult>