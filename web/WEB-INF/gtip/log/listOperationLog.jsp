<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<!DOCTYPE html
PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>操作日志</title>
	<%@ include file="../support/include/header.jsp" %>
	<script type="text/javascript">
		$(function() {
			$('#InfoTable').operational();
		<g:permissionRequired code="010401" description="查看单个日志">
			$("#exceptionLogFrame").dialog({modal:true,autoOpen:false});
			$("#show").click(function() {
				if($("#InfoTable tr.selected").length == 1) {
					$("#exceptionLogFrame")[0].src = "${pageContext.request.contextPath}/admin/platform/log/operation/do/show.q?idx=" + $("#InfoTable tr.selected").attr("id");
					$("#exceptionLogFrame")["dialog"]("open");
				} else
					alert("请选中一行进行操作！");
			});
		</g:permissionRequired>
		});
	</script>
</head>
<body>
<div id="toolbar" class="space" style="float:right">
	<g:permissionRequired code="010401" description="查看单个日志">
		<a id="show"><span class="ui-icon ui-icon-search"></span>查看日志</a>
	</g:permissionRequired>
	<a id="search"><span class="ui-icon ui-icon-search"></span>查询日志</a>
</div>
<table id="InfoTable" class="manage-table space">
	<thead>
	<tr>
		<th>操作人员</th>
		<th>操作类型</th>
		<th>操作描述</th>
		<th>操作时间</th>
	</tr>
	</thead>
	<tbody>
	<s:iterator value="operationLogList">
		<tr id="<s:property value="id"/>">
			<td>
				<s:url id="url">
					<s:param name="username" value="%{username}"/>
				</s:url>
				<s:a href="%{#url}">
					<s:property value="username"/>
				</s:a>
			</td>
			<td>
				<s:url id="url">
					<s:param name="category" value="%{category}"/>
				</s:url>
				<s:a href="%{#url}">
					<s:property value="categoryName"/>
				</s:a>
			</td>
			<td><s:property value="infor"/></td>
			<td><s:date format="yyyy-MM-dd HH:mm:ss" name="date"/></td>
		</tr>
	</s:iterator>
	</tbody>
</table>
<%@ include file="../support/component/page.jsp" %>
<g:permissionRequired code="010401" description="查看单个日志">
	<iframe id="exceptionLogFrame" style=" height:500px;width:900px" frameborder="0" title="查看操作日志"></iframe>
</g:permissionRequired>
<%@ include file="../include/dateRangeQuery.jsp"%>
</body>
</html>