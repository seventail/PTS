<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
	<title>程序更新信息</title>
	<%@ include file="/WEB-INF/gtip/support/include/header.jsp" %>
</head>
<body>
<table id="publicInfoTable" class="manage-table space">
	<thead>
	<tr>
		<th>程序名称</th>
		<th>发布时间</th>
		<th>更新时间</th>
		<th>更新描述</th>
	</tr>
	</thead>
	<tbody>
	<s:iterator value="programeUpdateInforList" id="i">
		<tr>
			<td><s:property value="#i.clazz.name"/></td>
			<td><s:property value="#i.releaseTime"/></td>
			<td><s:date name="#i.updateTime" format="yyyy-MM-dd HH:mm:ss"/></td>
			<td><s:property value="updateDescription"/></td>
		</tr>
	</s:iterator>
	</tbody>
</table>
<%@ include file="../../../gtip/support/component/page.jsp" %>
</body>
</html>