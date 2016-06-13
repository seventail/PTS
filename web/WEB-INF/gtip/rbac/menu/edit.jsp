<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<g:ajaxResult>
	<form action="" id="editMenuForm">
		<label>名称:</label><input type="text" name="menu.name" value="<s:property value="menu.name"/>"><br/>
		<label>地址:</label><input type="text" name="menu.url" value="<s:property value="menu.url"/>"><br/>
		<label>序号:</label><input type="text" name="menu.index" value="<s:property value="menu.index"/>"><br/>
		<label>需要授权:</label><input type="checkbox" name="menu.authorized" value="true"
	<s:if test="menu.authorized">
								   checked="checked"
	</s:if>
			><br/>
		<input type="hidden" name="idx" value="<s:property value="menu.id"/>">
	</form>
</g:ajaxResult>