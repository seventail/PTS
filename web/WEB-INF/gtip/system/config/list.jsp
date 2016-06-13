<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
	<title>资源配置信息</title>
	<%@ include file="/WEB-INF/gtip/support/include/header.jsp" %>
	<script type="text/javascript">
		$(function() {
			//operational table
			$('#publicInfoTable').operational();
			//editItem dialog
			$("#editConfig").dialog({
				autoOpen:false,
				modal:true,
				buttons:{
					"取消":function() {$(this).dialog('close');},
					"确定":function() {
						//validate form then submit and callback
						var form = $("#editConfig");
						if(!form[0]["idx"].value) {
							alert("没有用户信息");
							return;
						}
						if(form.validate().form()) {
							form[0]["key"].value = $("#configKey").val();
							var newItem = form.serializeArray();
							var tr = $("#publicInfoTable tr.selected");
							var self = $(this);
							tr.invoke("/admin/platform/system/config/do/update", newItem, function() {
								var td = tr.children("td");
								$(td[0]).html($("#configKey").val());
								$(td[1]).html($("#configValue").val());
								self.dialog('close');
							});
						}
					}
				}
			});
			//open editItem dialog
			$("#edit").click(function() {
				var tr = $('#publicInfoTable tr.selected');
				if(tr.length == 1) {
					var td = tr.children("td");
					$("#editConfig").dialog("open");
					$("#configKey").val($(td[0]).html());
					$("#configValue").val($(td[1]).html());
				}
				else alert("每次仅能选中一行进行修改");
			});

			//资源列表改变时
			$("#userSelect").change(function() {
				if($(this).val())
					window.self.location = "${pageContext.request.contextPath}/admin/platform/system/config/do/list.q?idx=" + $(this).val();
			});
			$("#userSelect").invoke("/admin/platform/rbac/user/ajax/listAjax", null, function(re) {
				Gtip.util.fillSelect($("#userSelect")[0], re, "id", "username",null,<s:property value="idx" default="0"/>);
			});
		});
	</script>
</head>
<body>
<div id="message">
	<%@ include file="../../support/include/actionmessage.jsp" %>
</div>
<div id="toolbar" class="space">
	<select style="float:left" id="userSelect"></select>
	<a id="edit"><span class="ui-icon ui-icon-pencil"></span>修改</a>
</div>
<table id="publicInfoTable" class="manage-table space">
	<thead>
	<tr>
		<th>配置key</th>
		<th>配置Value</th>
	</tr>
	</thead>
	<tbody>
	<s:iterator value="userConfigDetailList" id="i">
		<tr>
			<td><s:property value="#i.key"/></td>
			<td><s:property value="#i.value"/></td>
		</tr>
	</s:iterator>
	</tbody>
</table>
<%@ include file="../../../gtip/support/component/page.jsp" %>
<form action="" name="editConfig" id="editConfig" title="修改">
	<label>配置Key：</label><input type="text" id="configKey" disabled="disabled"><br>
	<label>配置Value：</label><input type="text" name="value" id="configValue" class="required">
	<input type="hidden" name="key">
	<input type="hidden" name="idx" value="<s:property value="idx"/>">
</form>
</body>
</html>