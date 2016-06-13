<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
	<title>数据备份</title>
	<%@ include file="/WEB-INF/gtip/support/include/header.jsp" %>
</head>
<body>
<s:url id="url" action="databackup/do/backup"/>
<s:a href="%{#url}">点此</s:a>备份
<table id="publicInfoTable" class="manage-table space">
	<thead>
	<tr>
		<th>文件名</th>
		<th>下载</th>
	</tr>
	</thead>
	<tbody>
	<s:iterator value="files" id="i">
		<tr>
			<td><s:property value="#i"/></td>
			<s:url id="url" action="databackup/do/download">
				<s:param name="name" value="#i"/>
			</s:url>
			<td><s:a href="%{#url}">下载</s:a></td>
		</tr>
	</s:iterator>
	</tbody>
</table>
</body>
</html>