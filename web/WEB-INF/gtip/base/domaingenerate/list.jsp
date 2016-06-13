<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<g:ajaxResult>
		<table id="entityTable" class="manage-table space">
			<thead>
			<tr>
				<s:iterator value="tableViewedPropertyMapList" var="v">
					<th><s:property value="#v.name"/></th>
				</s:iterator>
			</tr>
			</thead>
			<tbody>
			<s:iterator value="entityableList" var="k">
				<tr id="<s:property value="#k.id"/>">
					<s:iterator value="tableViewedPropertyMapList" var="v">
						<td><g:property value="#k" property="%{#v.propertyName}" format="%{#v.format}"/></td>
					</s:iterator>
				</tr>
			</s:iterator>
			</tbody>
		</table>
		<%@ include file="../../support/component/page-ajax.jsp" %>
</g:ajaxResult>