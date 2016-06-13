<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<!DOCTYPE html>
<html>
<head>
	<title>权限树管理</title>
	<%@ include file="../../support/include/header.jsp" %>
	<script type="text/javascript" src="${pageContext.request.contextPath}/theme/tree.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/theme/ui.droppable.js"></script>
	<script type="text/javascript">
		$(function() {
			var currentUI;
			//			Gtip.postDebug = 1;
			var opts = {checkbox:false,expand:true,
				menu:{
					"添加权限结点":function(ui) {
						currentUI = ui;
						var idx = ui.children("input").val();
						var div = $("#addPermissionNodeDiv");
						$("#addPermissionNodeForm input[name='permissionNode.parent.id']").val(idx);
						div.dialog("open");
					},
					"修改权限结点":function(ui) {
						currentUI = ui;
						var idx = currentUI.children("input").val();
						$("#editPermissionNodeDiv").invoke("/admin/platform/rbac/permissionNode/do/edit", {idx:idx}, function(html) {
							html = $(html);
							this.html(html).dialog("open");
						});
					},
					"删除权限结点":function(ui) {
						currentUI = ui;
						var idx = currentUI.children("input").val();
						currentUI.invoke("/admin/platform/rbac/permissionNode/do/delete", {idx:idx}, "deleteNode");
					}
				},
				pmenu:{
					"移除":function(ui) {
						var idx = ui.children("input").val();
						ui.invoke("/admin/platform/rbac/grant/permissionNode/do/remove", {idx:idx}, function() {
							ui.find("span.selected").removeClass("selected");
							$("#permissionListDiv ul.list").append(ui.remove().draggable(dragConfig));
						});
					}
				},
				licall:function(li, opt) {
					var self = $(li);
					if(self.children("input").attr("name") == "ids") {
						opt.defaultLicall(li, opt);
						//使权限可往tree上拖
						self.droppable(droppableConfig);
					}
					//root结点可以点击和右键事件
					else if(self.children("input").attr("name") == "root") {
						opt.defaultLicall(li, opt);
					}
					//这是权限结点
					else {
						self.menu(opts.pmenu);
						self.children("span").click(function() {
							$(this).liSpanClick();
						});
					}
				}
			};
			//添加角色
			$("#addPermissionNodeDiv").dialog({
				autoOpen:false,
				modal:true,
				buttons:{
					"取消":function() {$(this).dialog('close');},
					"确定":function() {
						var form = $("#addPermissionNodeForm");
						var self = $(this);
						currentUI.invoke("/admin/platform/rbac/permissionNode/do/add", form.serializeArray(), function(html) {
							this.addNodeList(html, null, function(htm) {
								htm.droppable(droppableConfig);
							});
							self.dialog("close");
							form[0].reset();
						});
					}
				}
			});

			//修改角色
			$("#editPermissionNodeDiv").dialog({
				autoOpen:false,
				modal:true,
				buttons:{
					"取消":function() {$(this).dialog("close");},
					"确定":function() {
						var form = $("#editPermissionNodeForm");
						var self = $(this);
						currentUI.invoke("/admin/platform/rbac/permissionNode/do/update", form.serializeArray(), function(re) {
							this.editNode(null, re["name"]);
							self.dialog("close");
						});
					}
				}
			});

			//使权限可选
			$("#permissionListDiv ul.list li").live("click", function(e) {
				e = e || window.event;
				if(e.ctrlKey) {
					$(this).toggleClass("selected");
				}
				else {
					$(this).parents("ul:first li").removeClass("selected");
					$(this).addClass("selected");
				}
			});

			var droppableConfig = {
				over:function() {$(this).children("span").addClass("selected");},
				out:function() {$(this).children("span").removeClass("selected");},
				drop:function() {
					var idx = $(this).children("input").val();
					if(!idx || idx == "0") {
						alert("不能分配给根结点");
						return;
					}
					var ids = [];
					var x = $("#permissionListDiv li.selected");
					x.each(function() {
						var v = $(this).children("input").val();
						v && (ids.push(v));

					});
					//准备grant
					var self = $(this);
					self.invoke("/admin/platform/rbac/grant/permissionNode/do/grant", {idx:idx, ids:ids}, function() {
						//取消各个绑定信息
						x.each(function() {
							$(this).unbind(".draggable")
									.removeClass("ui-draggable"
									+ " ui-draggable-dragging"
									+ " ui-draggable-disabled"
									+ " selected")
									.css({top:0, left:0});
						});
						self.addNodeList(x, {menu:false});
					});
				},greedy:true
			};
			//启动tree插件
			$("#permissionNodeTree>ul:first").initTree(opts);
			//启动拖动事件
			var dragConfig = {
				drag:function(event, ui) {
					//使自己也被选中,以便drop时正确计算
					$(this).addClass("selected");
					var select = $("#permissionListDiv li.selected");
					var offset = ui.position;
					select.each(function() {$(this).css({top:offset.top,left:offset.left})});
				},
				revert:function(dropped) {
					var draggable = $(this).data("draggable");
					if(!dropped) {
						var select = $("#permissionListDiv li.selected");
						select.animate(draggable.originalPosition, parseInt(draggable.options.revertDuration, 10));
					}
					return false;
				}
			};
			$("#permissionListDiv ul.list li").draggable(dragConfig);
		});
	</script>
</head>
<body>
<div id="permissionListDiv" style="width:50%;float:right;">
	<b>权限值列表</b>
	<ul class="list">
		<s:iterator value="permissionList">
			<li><input type="checkbox" value="<s:property value="id"/>" style="display:none;"/><span><s:property
					value="name"/></span></li>
		</s:iterator>
	</ul>
</div>
<div id="permissionNodeTree" style="width:50%;">
	<p>权限树</p>
	<ul>
		<g:tree nodeList="treeNodeList" expand="true"/>
	</ul>
</div>
<div id="addPermissionNodeDiv" title="添加权限结点">
	<form action="" id="addPermissionNodeForm">
		<label>名称:</label><input type="text" name="permissionNode.name" class="required"><br/>
		<input type="hidden" name="permissionNode.parent.id" value="<s:property value="role.id"/>">
	</form>
</div>
<div id="editPermissionNodeDiv" title="修改权限结点"></div>
</body>
</html>