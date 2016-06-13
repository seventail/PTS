<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
	<title>资源配置信息</title>
	<%@ include file="/WEB-INF/gtip/support/include/header.jsp" %>
	<style type="text/css">
		.edit {
			background: red
		}
	</style>
	<script type="text/javascript">
		$(function() {
			//operational table
			$('#publicInfoTable').operational();
			//editItem dialog
			$("#editResource").dialog({
				autoOpen:false,
				modal:true,
				buttons:{
					"取消":function() {$(this).dialog('close');},
					"确定":function() {
						//validate form then submit and callback
						var form = $("#editResource");
						if(form.validate().form()) {
							form[0]["key"].value = $("#resourceKey").val();
							var newItem = form.serializeArray();
							var tr = $("#publicInfoTable tr.selected");
							var self = $(this);
							tr.invoke("/admin/platform/system/resource/do/update", newItem, function(html) {
								$(this).addClass("edit");
								var td = tr.children("td");
								$(td[0]).html($("#resourceKey").val());
								$(td[1]).html($("#resourceValue").val());
								$("#message").html(html);
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
					$("#editResource").dialog("open");
					$("#resourceKey").val($(td[0]).html());
					$("#resourceValue").val($(td[1]).html());
				}
				else alert("每次仅能选中一行进行修改");
			});

			//click the save button
			$("#save").click(function() {
				window.self.location = "${pageContext.request.contextPath}/admin/platform/system/resource/do/save.q";
			});

			//资源列表改变时
			$("#resourceSelect").change(function() {
				window.self.location = "${pageContext.request.contextPath}/admin/platform/system/resource/do/list.q?resourceName=" + $(this).val();
			});
		});
	</script>
</head>
<body>
<div id="message">
	<%@ include file="../../support/include/actionmessage.jsp" %>
</div>
<div id="toolbar" class="space">
	<select style="float:left" id="resourceSelect">
		<option value="">资源列表</option>
		<s:iterator value="configList" id="i">
			<option value="<s:property value="#i"/>"
					<s:if test="%{(#i) == #parameters.resourceName[0]}">selected="selected" </s:if>
					><s:property value="#i"/></option>
		</s:iterator>
	</select>
	<a id="edit"><span class="ui-icon ui-icon-pencil"></span>修改</a>
	<a id="save"><span class="ui-icon ui-icon-pencil"></span>保存</a>
</div>
<table id="publicInfoTable" class="manage-table space">
	<thead>
	<tr>
		<th>资源Key</th>
		<th>资源Value</th>
	</tr>
	</thead>
	<tbody>
	<s:iterator value="resourceMap" id="i">
		<tr id="<s:property value="#i.key"/>Tr">
			<td><s:property value="#i.key"/></td>
			<td><s:property value="#i.value"/></td>
		</tr>
	</s:iterator>
	</tbody>
</table>
<%@ include file="../../../gtip/support/component/page.jsp" %>
<form action="" name="editResource" id="editResource" title="修改">
	<label>资源Key：</label><input type="text" id="resourceKey" disabled="disabled"><br>
	<label>资源Value：</label><input type="text" name="value" id="resourceValue" class="required">
	<input type="hidden" name="key">
</form>
</body>
</html>