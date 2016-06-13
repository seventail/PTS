<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<!DOCTYPE html>
<html>
<head>
	<title>菜单管理</title>
	<%@ include file="../../support/include/header.jsp" %>
	<script type="text/javascript" src="${pageContext.request.contextPath}/theme/ui.droppable.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/theme/tree.js"></script>
	<script>
		$(function() {
			var currentUI;
			var opts = {checkbox:true,expand:true,
				menu:{
					"添加菜单":function(ui) {
						currentUI = ui;
						var div = $("#addMenuDiv");
						div.dialog("open");
					},
					"修改菜单":function(ui) {
						currentUI = ui;
						var idx = currentUI.children("input").val();
						$("#editMenuDiv").invoke("/admin/platform/rbac/menu/do/edit", {idx:idx}, function(html) {
							html = $(html);
							this.html(html).dialog("open");
						});
					},
					"删除菜单":function(ui) {
						currentUI = ui;
						var idx = currentUI.children("input").val();
						currentUI.invoke("/admin/platform/rbac/menu/do/delete", {idx:idx}, "deleteNode");
					},
					"查看信息":function(ui) {
						currentUI = ui;
						var idx = currentUI.children("input").val();
						$("#menuInforDiv").invoke("/admin/platform/rbac/menu/do/show", {idx:idx}, "html");
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
			//添加菜单
			$("#addMenuDiv").dialog({
				autoOpen:false,
				modal:true,
				buttons:{
					"取消":function() {$(this).dialog('close');},
					"确定":function() {
						var form = $("#addMenuForm");
						if(form.validate().form()) {
							//设置parentId
							$("#menuParentIdInput").val(currentUI.children("input").val());
							var self = $(this);
							currentUI.invoke("/admin/platform/rbac/menu/do/add", form.serializeArray(), function(html) {
								this.addNodeList(html);
								self.dialog("close");
								form[0].reset();
							});
						}
					}
				}
			});

			//修改菜单
			$("#editMenuDiv").dialog({
				autoOpen:false,
				modal:true,
				buttons:{
					"取消":function() {$(this).dialog("close");},
					"确定":function() {
						var form = $("#editMenuForm");
						var self = $(this);
						currentUI.invoke("/admin/platform/rbac/menu/do/update", form.serializeArray(), function(re) {
							this.editNode(null, re["name"]);
							this.children("input").attr("checked", re["authorized"]);
							self.dialog("close");
						});
					}
				}
			});

			//启动tree插件
			$("#menuTree>ul:first").initTree(opts);
		});
	</script>
</head>
<body>
<div id="menuInforDiv" style="width:50%;float:right;"></div>
<div id="menuTree" style="width:50%;">
	<p>菜单树</p>
	<ul>
		<g:tree nodeList="menuList" expand="true"/>
	</ul>
</div>
<div id="addMenuDiv" title="添加菜单结点">
	<form action="" id="addMenuForm">
		<label>代码:</label><input type="text" name="menu.code" class="required"><br/>
		<label>名称:</label><input type="text" name="menu.name" class="required"><br/>
		<label>地址:</label><input type="text" name="menu.url"><br/>
		<label>序号:</label><input type="text" name="menu.index" value="0" class="number"><br/>
		<label>需要授权:</label><input type="checkbox" name="menu.authorized" checked="checked" value="true"><br/>
		<input type="hidden" name="menu.parent.id" id="menuParentIdInput">
	</form>
</div>
<div id="editMenuDiv" title="修改菜单"></div>
</body>
</html>