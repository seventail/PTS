<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:if test="actionMessages != null && actionMessages.size > 0">
	<s:property value="actionMessages[0]"/>
</s:if>