<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<g:ajaxResult>
	代码:<s:property value="menu.code"/><br/>
	名称:<s:property value="menu.name"/><br/>
	地址:<s:property value="menu.url"/><br/>
	序号:<s:property value="menu.index"/><br/>
	需要授权:<s:property value="menu.authorizedInfor"/>
</g:ajaxResult>