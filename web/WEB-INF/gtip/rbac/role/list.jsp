<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<!DOCTYPE html>
<html>
<head>
	<title>角色管理</title>
	<%@ include file="../../support/include/header.jsp" %>
	<script type="text/javascript" src="${pageContext.request.contextPath}/theme/ui.droppable.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/theme/tree.js"></script>
	<script type="text/javascript">
		$(function() {
			var currentUI;

			var opts = {checkbox:true,expand:true,
				menu:{
					<g:permissionRequired code="010501" description="添加角色">
					"添加角色":function(ui) {
						currentUI = ui;
						var idx = ui.children("input").val();
						$("#addRoleDiv").invoke("/admin/platform/rbac/role/do/beforeAdd", {idx:idx}, function(html) {
							this.html(html);
							this.dialog("open");
						});
					},
					</g:permissionRequired>
					<g:permissionRequired code="010504" description="修改角色">
					"修改角色":function(ui) {
						currentUI = ui;
						var idx = currentUI.children("input").val();
						$("#editRoleDiv").invoke("/admin/platform/rbac/role/do/edit", {idx:idx}, function(html) {
							this.html(html);
							this.dialog("open");
						});
					},
					</g:permissionRequired>
					<g:permissionRequired code="010502" description="删除角色">
					"删除角色":function(ui) {
						currentUI = ui;
						var idx = currentUI.children("input").val();
						currentUI.invoke("/admin/platform/rbac/role/do/delete", {idx:idx}, "deleteNode");
					},
					</g:permissionRequired>
					"分配权限":function(ul) {
						var idx = ul.children("input").val();
						var iframe = $("#rolexpermissionIframe");
						iframe.attr("src", "${pageContext.request.contextPath}/admin/platform/rbac/grant/rolexpermission/do/beforeGrant.q?idx=" + idx + "&_random=" + Math.random());
						iframe.dialog("open");
					},
					"分配菜单":function(ul) {
						currentUI = ul;
						var idx = ul.children("input").val();
						var iframe = $("#rolexmenuIframe");
						iframe.attr("src", "${pageContext.request.contextPath}/admin/platform/rbac/grant/rolexmenu/do/beforeGrant.q?idx=" + idx + "&_random=" + Math.random());
						iframe.dialog("open");
					},
					"查看信息":function(ui) {
						var idx = ui.children("input").val();
						$("#roleInforDiv").invoke("/admin/platform/rbac/role/do/show", {idx:idx}, "html");
					}
				},
				licall:function(li, opts) {
					li = $(li);
					opts.menu && li.menu(opts.menu);
					li.children("span").click(function() {
						$(this).liSpanClick();
					});
					li.children("input:checkbox").attr("disabled", true);
				}
			};
			//启动tree插件
			$("#roleTree>ul:first").initTree(opts);
			//添加角色
		<g:permissionRequired code="010501" description="添加角色">
			$("#addRoleDiv").dialog({
				autoOpen:false,
				modal:true,
				buttons:{
					"取消":function() {$(this).dialog('close');},
					"确定":function() {
						var form = $("#addRoleForm");
						var self = $(this);
						if(form.validate().form()) {
							//检查资源类型
							var checkbox = form.children("input:checkbox");
							if(!checkbox.attr("disabled") && checkbox.attr("checked")) {
								var select = form.children("select");
								if(select.length && !select.val()) {
									alert("你建立的角色是资源受限的,请选择受限资源类型");
									return;
								}
							}
							self.invoke("/admin/platform/rbac/role/ajax/addAjax", form.serializeArray(), function(re) {
								var role = re;
								$(currentUI).addNode(role["id"], role["name"], null, function(li) {
									//checked status
									$(li).children("input").attr("checked", role["checked"]);
								});
								self.dialog("close");
							});
						}
					}
				}
			});
		</g:permissionRequired>
		<g:permissionRequired code="010504" description="修改">
			//修改角色
			$("#editRoleDiv").dialog({
				autoOpen:false,
				modal:true,
				buttons:{
					"取消":function() {$(this).dialog("close");},
					"确定":function() {
						var form = $("#editRoleForm");
						var self = $(this);
						self.invoke("/admin/platform/rbac/role/ajax/updateAjax", form.serializeArray(), function(re) {
							currentUI.editNode(null, re["name"]);
							//处理checked
							if(re["resourceLimited"]) {
								currentUI.find("input:checkbox").attr("checked", true);
							} else {
								currentUI.children("input").attr("checked", false);
							}
							self.dialog("close");
						});
					}
				}
			});
		</g:permissionRequired>
			//分配权限
			$("#rolexpermissionIframe").dialog({
				autoOpen:false,
				modal:true,
				height:450,
				buttons:{
					"取消":function() {$(this).dialog("close");},
					"确定":function() {
						var self = $(this);
						var iframe = self[0];
						var form = window.frames["rolexpermissionIframe"].document.getElementById("rolexpermissionForm");
						if(!form) {
							self.dialog("close");
							return;
						}
						form = $(form);
						$(currentUI).invoke("/admin/platform/rbac/grant/rolexpermission/do/grant", form.serializeArray(), function() {
							self.dialog("close");
						});
					}
				}
			});

			//分配菜单
			$("#rolexmenuIframe").dialog({
				autoOpen:false,
				modal:true,
				buttons:{
					"取消":function() {$(this).dialog("close");},
					"确定":function() {
						var self = $(this);
						var form = window.frames["rolexmenuIframe"].document.getElementById("rolexmenuForm");
						if(!form) {
							self.dialog("close");
							return;
						}
						form = $(form);
						$(currentUI).invoke("/admin/platform/rbac/grant/rolexmenu/do/grant", form.serializeArray(), function() {
							self.dialog("close");
						});

					}
				}
			});
		});
	</script>
</head>
<body>
<div id="roleInforDiv" style="width:50%;float:right;"></div>
<div id="roleTree" style="width:50%;">
	<p>角色树</p>
	<ul>
		<g:tree nodeList="roleList" expand="true"/>
	</ul>
</div>
<g:permissionRequired code="010501" description="添加">
	<div id="addRoleDiv" title="添加角色"></div>
</g:permissionRequired>
<g:permissionRequired code="010504" description="修改">
	<div id="editRoleDiv" title="修改角色"></div>
</g:permissionRequired>
<iframe id="rolexpermissionIframe" name="rolexpermissionIframe" frameborder="0" width="400px" title="分配权限"></iframe>
<iframe id="rolexmenuIframe" name="rolexmenuIframe" width="400px" frameborder="0" title="分配菜单"></iframe>
</body>
</html>