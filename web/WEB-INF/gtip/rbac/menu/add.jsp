<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<g:ajaxResult>
	<li><input type="checkbox" name="ids" value="<s:property value="menu.id"/>"
			   <s:if test="menu.authorized">checked="checked"</s:if>
			><span><s:property value="menu.name"/></span></li>
</g:ajaxResult>