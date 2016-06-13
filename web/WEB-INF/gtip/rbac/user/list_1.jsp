<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<!DOCTYPE html>
<!--
Fly_m at 2009-9-7
-->
<html>
<head>
	<title>用户管理</title>
	<%@ include file="../../support/include/header.jsp" %>
	<script type="text/javascript">
		//		Gtip.postDebug = 1;
		$(function() {
			//operational table
			$('#InfoTable').operational();

			//添加用户按钮
			$("#add").click(function() {$('#addUserForm')["dialog"]('open');});

			//添加用户
			$("#addUserForm")["dialog"]({
				autoOpen:false,
				modal:true,
				buttons:{
					"取消":function() {$(this)["dialog"]('close');},
					"确定":function() {
						//validate form then submit and callback
						if($('#addUserForm').validate().form()) {
							var newItem = $('#addUserForm').serializeArray();
							var table = $("#InfoTable");
							var self = $(this);
							table.invoke("/admin/platform/rbac/user/do/add", newItem, function(html) {
								$(this).append(html);
								self["dialog"]("close");
								$("#addUserForm")[0].reset();
							});
						}
					}
				}
			});
			//修改用户按钮
			$("#edit").click(function() {
				var tr = $('#InfoTable tr.selected');
				if(tr.length == 1) {
					var id = tr.attr("id");
					var form = $('#editUserForm');
					form.invoke("/admin/platform/rbac/user/do/editOther", {idx:id}, function(html) {
						this.html(html);
						this["dialog"]("open");
					});
				}
				else alert("每次仅能选中一项进行修改");
			});

			//修改用户
			$("#editUserForm")["dialog"]({
				autoOpen:false,
				modal:true,
				buttons:{
					"取消":function() {$(this)["dialog"]('close');},
					"确定":function() {
						//validate form then submit and callback
						if($('#editUserForm').validate().form()) {
							var newItem = $('#editUserForm').serializeArray();
							//update data here
							var tr = $("#InfoTable tr.selected");
							var self = $(this);
							tr.invoke("/admin/platform/rbac/user/do/updateOther", newItem, function(html) {
								this.replaceWith(html);
								self["dialog"]("close");
								$("#editUserForm").empty();
							});
						}
					}
				}
			});

			//修改密码按钮
			$("#editPassword").click(function() {
				var tr = $("#InfoTable tr.selected");
				if(tr.length != 1) {
					alert("请选择一个用户进行修改");
					return;
				}
				var idx = tr.attr("id");
				$("#editPasswordForm input[name='idx']").val(idx);
				$("#editPasswordForm")["dialog"]("open");
			});
			//修改用户
			$("#editPasswordForm")["dialog"]({
				autoOpen:false,
				modal:true,
				buttons:{
					"取消":function() {$(this)["dialog"]("close");},
					"确定":function() {
						var form = $("#editPasswordForm");
						if(form.validate().form()) {
							var self = $(this);
							form.invoke("/admin/platform/rbac/user/do/changeOtherPassword", form.serializeArray(), function() {
								this[0].reset();
								self["dialog"]("close");
							});
						}
					}
				}
			});

			//启用/禁用用户
			$("#forbidTag").click(function() {
				var tr = $("#InfoTable tr.selected");
				if(tr.length == 1) {
					var idx = tr.attr("id");
					var td = $("#forbid" + idx);
					td.invoke("/admin/platform/rbac/user/do/forbidAjax", {idx:idx}, "html");
				} else
					alert("请选择一行进行操作");
			});
			//删除用户
			$('#delete').click(function() {
				var tr = $('#InfoTable tr.selected');
				if(tr.length == 1) {
					//delete data from database
					$("<p title='删除信息'>确定要删除此用户?</p>")["dialog"]({
						modal:true,autoOpen:true,
						buttons:{
							"取消":function() {$(this)["dialog"]('close');},
							"删除":function() {
								var self = $(this);
								tr.invoke("/admin/platform/rbac/user/do/delete", {idx:tr.attr("id")}, function() {
									this.remove();
									self["dialog"]("close");
								});
							}}});
				} else {
					alert("每次仅能选中一项进行删除");
				}
			});
			//userxrole dialog
			$("#userxroleIframe")["dialog"]({
				modal:true,autoOpen:false,height:450,
				buttons:{
					"取消":function() {$(this)["dialog"]("close");},
					"确定":function() {
						var self = $(this);
						var form = window.frames["userxroleIframe"].document.getElementById("userxroleForm");
						if(!form) {
							self["dialog"]("close");
							return;
						}
						form = $(form);
						var tr = $("#InfoTable tr.selected");
						var roleTd = $("#roleName" + tr.attr("id"));
						roleTd.invoke("/admin/platform/rbac/grant/userxrole/ajax/grantAjax", form.serializeArray(), function(re) {
							$(this).html(re);
							self["dialog"]("close");
						});
					}
				}
			});
			$("#userxrole").click(function() {
				var tr = $("#InfoTable tr.selected");
				if(tr.length == 1) {
					var idx = tr.attr("id");
					var frame = $("#userxroleIframe");
					frame.attr("src", "${pageContext.request.contextPath}/admin/platform/rbac/grant/userxrole/do/beforeGrant.q?idx=" + idx + "&_random=" + Math.random());
					frame["dialog"]("open");
				} else {
					alert("每次仅能选中一项进行操作");
				}
			});

			//userxresource
			$("#userxresource").click(function() {
				var tr = $("#InfoTable tr.selected");
				if(tr.length == 1) {
					var idx = tr.attr("id");
					var frame = $("#userxresourceIframe");
					frame.attr("src", "${pageContext.request.contextPath}/admin/platform/rbac/grant/userxresource/do/beforeGrant.q?idx=" + idx + "&_random=" + Math.random());
					frame["dialog"]("open");
				} else {
					alert("每次仅能选中一项进行操作");
				}
			});
			$("#userxresourceIframe")["dialog"]({
				modal:true,autoOpen:false,height:450,
				buttons:{
					"取消":function() {$(this)["dialog"]("close");},
					"确定":function() {
						var self = $(this);
						var form = window.frames["userxresourceIframe"]["document"].getElementById("userxresourceForm");
						if(!form) {
							self["dialog"]("close");
							return;
						}
						form = $(form);
						var tr = $("#InfoTable tr.selected");
						var resourceTd = $("#resourceInfor" + tr.attr("id"));
						resourceTd.invoke("/admin/platform/rbac/grant/userxresource/do/grant", form.serializeArray(), function(re) {
							$(this).html(re);
							self["dialog"]("close");
						});
					}
				}
			});
			

			$("input").tip();//input hover tip
			$("td").tip({tipClass:"linktip",stay:60000,left:-180});
		});
	</script>
</head>
<body>
<div id="toolbar" class="space">
	<a id="add"><span class="ui-icon ui-icon-plus"></span>添加用户</a>
	<a id="edit"><span class="ui-icon ui-icon-pencil"></span>修改信息</a>
	<a id="editPassword"><span class="ui-icon ui-icon-pencil"></span>修改密码</a>
	<a id="forbidTag"><span class="ui-icon ui-icon-pencil"></span>启用/禁用</a>
	<a id="delete"><span class="ui-icon ui-icon-trash"></span>删除用户</a>
	<span class="ui-icon ui-icon-grip-dotted-vertical"></span>
	<a id="userxrole">分配角色</a>
	<a id="userxresource">分配资源</a>
</div>
<table id="InfoTable" class="manage-table space">
	<thead>
	<tr>
		<th>用户名</th>
		<th>真实姓名</th>
		<th>联系方式</th>
		<th>状态</th>
		<th>角色</th>
		<th>受限资源</th>
	</tr>
	</thead>
	<tbody>
	<s:iterator value="userList" id="u">
		<tr id="<s:property value="id"/>">
			<td><s:property value="username"/></td>
			<td><s:property value="name"/></td>
			<td><s:property value="linkInfor"/></td>
			<td id="forbid<s:property value="id"/>"><s:property value="forbidInfor"/></td>
			<td id="roleName<s:property value="id"/>"><s:property value="role.name"/></td>
			<td id="resourceInfor<s:property value="id"/>"><s:property value="resourceInfor"/></td>
		</tr>
	</s:iterator>
	</tbody>
</table>
<%@ include file="../../support/component/page.jsp" %>
<form action="" name="addItem" id="addUserForm" title="添加用户">
	<label>用户名：</label><input type="text" name="user.username" class="required" maxlength="50"><br>
	<label>密码：</label><input type="password" name="user.password" id="password" class="required" maxlength="50"
							 minlength="6" tip="至少六位"><br>
	<label>确认密码：</label><input type="password" name="repassword" class="required" equalTo="#password" maxlength="50"
							   minlength="6"><br>
	<label>真实姓名：</label><input type="text" name="user.name" class="required" maxlength="50"><br>
	<label>联系方式：</label><input type="text" name="user.linkInfor" maxlength="50"><br>
	<label>是否禁用：</label><input name="user.forbidFlag" value="true" type="radio">是&nbsp;
	<input name="user.forbidFlag" type="radio" value="false" checked="checked">否<br>
	<label>能否创建用户：</label><input name="user.createFlag" type="radio" value="true" checked="checked">是&nbsp;
	<input name="user.createFlag" type="radio" value="false">否<br>
</form>
<form action="" name="editItem" id="editUserForm" title="修改用户"></form>
<form action="" id="editPasswordForm" title="修改密码">
	<input type="hidden" name="idx">
	<label>新密码:</label><input type="password" name="user.password" id="passwordEdit" class="required" maxlength="20"
							  minlength=6 tip="至少六位">
	<label>确认密码:</label><input type="password" name="repassword" id="user.password" equalTo="#passwordEdit"
							   class="required" maxlength="20" minlength=6 tip="至少六位">
</form>
<iframe id='userxroleIframe' name="userxroleIframe" width='300' frameborder='0' title='分配角色'></iframe>
<iframe id="userxresourceIframe" name="userxresourceIframe" width="300" frameborder="0" title="分配资源"></iframe>
</body>
</html>