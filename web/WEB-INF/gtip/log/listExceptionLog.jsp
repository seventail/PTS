<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<!DOCTYPE html>
<html>
<!--
Fly_m at 2009-9-12
-->
<head>
	<title>错误日志</title>
	<%@ include file="../support/include/header.jsp" %>
	<script type="text/javascript">
		$(function() {
			$('#InfoTable').operational();
		<g:permissionRequired code="010301" description="查看单个日志">
			$("#exceptionLogFrame").dialog({modal:true,autoOpen:false,width:800,height:600});
			$("#show").click(function() {
				if($("#InfoTable tr.selected").length == 1) {
					var url = "${pageContext.request.contextPath}/admin/platform/log/exception/do/show.q?idx=" + $("#InfoTable tr.selected").attr("id");
					$("#exceptionLogFrame").load(url, null, null);
					$("#exceptionLogFrame").dialog("open");
				} else
					alert("请选中一行进行操作！");
			});
		</g:permissionRequired>
		});
	</script>
</head>
<body>
<div id="toolbar" class="space" style="float:right">
	<g:permissionRequired code="010301" description="查看单个日志">
		<a id="show"><span class="ui-icon ui-icon-search"></span>查看日志</a>
	</g:permissionRequired>
	<a id="search"><span class="ui-icon ui-icon-search"></span>查询日志</a>
</div>
<table id="InfoTable" class="manage-table space">
	<thead>
	<tr>
		<th width="10%">操作人员</th>
		<th width="20%">出错类型</th>
		<th>出错信息</th>
		<th width="15%">出错时间</th>
	</tr>
	</thead>
	<tbody>
	<s:iterator value="exceptionLogList">
		<tr id="<s:property value="id"/>">
			<s:url id="url">
				<s:param name="username" value="%{username}"/>
			</s:url>
			<td>
				<s:a href="%{#url}"><s:property value="username"/></s:a>
			</td>
			<s:url id="url">
				<s:param name="className" value="%{className}"/>
			</s:url>
			<td>
				<s:a href="%{#url}">
					<s:property value="className"/>
				</s:a>
			</td>
			<td><s:property value="infor"/></td>
			<td><s:date format="yyyy-MM-dd HH:mm:ss" name="date"/></td>
		</tr>
	</s:iterator>
	</tbody>
</table>
<%@ include file="../support/component/page.jsp" %>
<g:permissionRequired code="010301" description="查看单个日志">
	<div id="exceptionLogFrame" title="查看错误日志"></div>
</g:permissionRequired>
<%@ include file="../include/dateRangeQuery.jsp"%>
</body>
</html>