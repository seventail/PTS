<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:if test="actionErrors != null && actionErrors.size > 0">
	<s:property value="actionErrors[0]"/>
</s:if>