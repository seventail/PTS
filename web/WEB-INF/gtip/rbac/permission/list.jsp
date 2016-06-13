<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<!DOCTYPE html>
<html>
<head>
	<title>权限管理</title>
	<%@ include file="../../support/include/header.jsp" %>
	<script type="text/javascript">
		$(function() {
			//operational table
			$('#InfoTable').operational();
			//editItem dialog
			$("#editPermissionDiv").dialog({
				autoOpen:false,
				modal:true,
				buttons:{
					"取消":function() {$(this).dialog('close');},
					"确定":function() {
						var form = $("#editPermissionForm");
						if(form.validate().form()) {
							var formData = form.serializeArray();
							var tr = $("#InfoTable tr.selected");
							var self = $(this);
							tr.invoke("/admin/platform/rbac/permission/do/update", formData, function(html) {
								tr.replaceWith(html);
								self.dialog('close');
								$("#editPermissionDiv").empty();
							});
						}
					}
				}
			});
			//open editItem dialog
			$("#edit").click(function() {
				var tr = $('#InfoTable tr.selected');
				if(tr.length == 1) {
					var id = tr.attr("id");
					var editPermissionDiv = $('#editPermissionDiv');
					editPermissionDiv.invoke("/admin/platform/rbac/permission/do/edit", {idx:id}, function(html) {
						editPermissionDiv.dialog('open');
						editPermissionDiv.html(html);
					});
				}
				else alert("每次仅能选中一项进行修改");
			});
			$("input").tip();//input hover tip
		})
	</script>
</head>
<body>
<div id="toolbar" class="space">
	<a id="edit"><span class="ui-icon ui-icon-pencil"></span>修改</a>
</div>
<table id="InfoTable" class="manage-table space">
	<thead>
	<tr>
		<th>代码</th>
		<th>类名</th>
		<th>方法名</th>
		<th>权限名</th>
		<th>依附权限</th>
	</tr>
	</thead>
	<tbody>
	<s:iterator value="permissionList">
		<tr id="<s:property value="id"/>">
			<td><s:property value="code"/></td>
			<td><s:property value="className"/></td>
			<td><s:property value="method"/></td>
			<td><s:property value="name"/></td>
			<td><s:property value="supportedPermission.name"/></td>
		</tr>
	</s:iterator>
	</tbody>
</table>
<%@ include file="../../support/component/page.jsp" %>
<div id="editPermissionDiv" title="修改权限"></div>
</body>
</html>