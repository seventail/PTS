<%@ page import="com.greejoy.gtip.util.URLUtils" %>
<%@ page import="com.greejoy.gtip.module.rbac.api.helper.HttpInterfaceHelper" %>
<%@ page import="java.util.Collections" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<!DOCTYPE html
PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
Fly_m at 2009-9-7
-->
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh-CN">
<head>
	<title>操作失败</title>
</head>
<body>
<div style="color:blue;font:bold 20px;text-align:center;">
	操作失败:
</div>
<div style="color:red;text-align:center;">
	<%@ include file="../../support/include/actionerror.jsp" %>
	<br/>
	<%
		//加载系统切换模块
		com.greejoy.gtip.module.rbac.api.UnitedAgCenterParam centerParam = com.greejoy.gtip.module.rbac.api
			.UnitedAgCenterParam.getStaticAgCenterParam();
		boolean centerConnect = !com.greejoy.gtip.module.rbac.api.helper.HttpInterfaceHelper.isOffline(centerParam);
	%>
	<a
		style="color:#dd0000;"
		href="<%=centerConnect ? URLUtils.addParam(centerParam.getRequestUrl("logout"), Collections.singletonMap("_random", String.valueOf(Math.random()))) : request.getContextPath() + "/com.greejoy.logout/do/logout.q"%>">重新登陆</a>
	<br/>
	<%
		if(centerConnect) {
			String remoteUrl = URLUtils.addParam(centerParam.getRequestUrl("remoteCalledSystemChange"),
				Collections.singletonMap("uag", (String) session.getAttribute("uag")));
			String html = "";
			try {
				html = HttpInterfaceHelper.postQueryHtml(remoteUrl, Collections.<String, Object>emptyMap());
			} catch(Exception ignore) {
			}
			out.println(html);
		}
	%>
</div>
</body>
</html>