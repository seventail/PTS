<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<!DOCTYPE html>
<html>
<head>
	<title>信息修改记录</title>
	<%@ include file="/WEB-INF/gtip/support/include/header.jsp" %>
	<script type="text/javascript">
		$(function() {
			$("#InfoTable").operational();
		});
	</script>
</head>
<body>
<div id="toolbar" class="space" style="float:right">
	<a id="search"><span class="ui-icon ui-icon-search"></span>查询日志</a>
</div>
<table id="InfoTable" class="manage-table space">
	<thead>
	<tr>
		<th>编号</th>
		<th>修改对象编号</th>
		<th>操作人员</th>
		<th>信息类型</th>
		<th>操作时间</th>
	</tr>
	</thead>
	<tbody>
	<s:iterator value="informationList">
		<tr>
			<td><s:property value="id"/></td>
			<td>
				<g:permissionRequired code="010201" description="查看单个修改信息">
				<a href="<%=request.getContextPath()%>/admin/platform/basic/modify/do/listDetails.q?idx=<s:property value="id"/>">
					</g:permissionRequired>
					<s:property value="modifyId"/>
					<g:permissionRequired code="010201" description="查看单个修改信息">
				</a>
				</g:permissionRequired>
			</td>
			<s:url var="url">
				<s:param name="modifyCriteria.username" value="%{username}"/>
			</s:url>
			<td>
				<s:a href="%{#url}">
					<s:property value="username"/>
				</s:a>
			</td>
			<td>
				<s:url var="url">
					<s:param name="modifyCriteria.clazz" value="%{clazz}"/>
				</s:url>
				<s:a href="%{#url}">
					<s:property value="typeName"/>
				</s:a>
			</td>
			<td><s:date format="yyyy-MM-dd HH:mm:ss" name="date"/></td>
		</tr>
	</s:iterator>
	</tbody>
</table>
<%@ include file="../../support/component/page.jsp" %>
<%@ include file="../../include/dateRangeQuery.jsp" %>
</body>
</html>