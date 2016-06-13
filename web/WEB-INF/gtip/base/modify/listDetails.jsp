<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
	<title>信息详细修改记录</title>
	<%@ include file="/WEB-INF/gtip/support/include/header.jsp" %>
</head>
<body>
<div id="toolbar" class="space" style="float:right">
	<a id="search"><span class="ui-icon ui-icon-search"></span>查询日志</a>
</div>
<table id="InfoTable" class="manage-table space">
	<thead>
	<tr>
		<th>修改名称</th>
		<th>修改前值</th>
		<th>修改后值</th>
	</tr>
	</thead>
	<tbody>
	<s:iterator value="fieldModifyDetailList">
		<tr>
			<td><s:property value="fieldDesc"/></td>
			<td><s:property value="beforeModifyValue"/></td>
			<td><s:property value="afterModifyValue"/></td>
		</tr>
	</s:iterator>
	</tbody>
</table>
</body>
</html>