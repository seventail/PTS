<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<!DOCTYPE html>
<html>
<%-- Created by flym at 2010-9-12 --%>
<head><title>基础数据操作</title>
	<%@ include file="../../support/include/header.jsp" %>
	<script type="text/javascript">
		//列表展现时,分页组件点击事件
		function clickPage(url) {
			$("#listTableDiv").invoke(url, null, function(html) {
				$(this).html(html);
				$("#entityTable").operational();
			});
		}
		$(function() {
			//下拉列表
			$("#generatedTypeSelect").invoke("/admin/platform/basic/domaingenerate/ajax/listTypeAjax", null,
				function(re) {
					Gtip.util.fillSelect(this, re, "key", "value", null, "<s:property value="clazz.name"/>");
				})["change"](function() {
				var self = $(this);
				var v = self.val();
				if(!v)
					return;
				clickPage("/admin/platform/basic/domaingenerate/do/list.q?clazz=" + v);
			});

		<g:permissionRequired code="010601" description="添加信息">
			//添加信息
			$("#addFrame")["dialog"]({modal:true,autoOpen:false,width:900,height:500, buttons:{
				"取消":function() {
					$(this)["dialog"]('close');
				},
				"确定":function() {
					var self = $(this);
					var frameWindow = window.frames["addFrame"]["window"];
					var form = frameWindow["document"].getElementById("addForm");
					if(!form) {
						self["dialog"]("close");
						return;
					}
					form = $(form);
					var valid = frameWindow["validateForm"] ? frameWindow["validateForm"]() : form.validate().form();
					if(valid) {
						$("#listTableDiv").invoke("/admin/platform/basic/domaingenerate/do/add", form.serialize(),
							function(re) {
								$(this)["insertTR"](re);
								self["dialog"]("close");
							});
					}
				}
			}});
			$("#add").click(function() {
				var clazz = $("#generatedTypeSelect").val();
				if(!clazz) {
					alert("请选择数据类型");
					$("#generatedTypeSelect").focus();
					return;
				}
				$("#addFrame")[0].src = "${pageContext.request.contextPath}/admin/platform/basic/domaingenerate/do/beforeAdd.q?clazz=" + clazz;
				$("#addFrame")["dialog"]("open");
			});
		</g:permissionRequired>
		<g:permissionRequired code="010604" description="修改基础信息">
			//修改信息
			$("#editFrame")["dialog"]({modal:true, autoOpen:false,width:900,height:500,
				buttons:{
					"取消":function() {
						$(this)["dialog"]("close");
					},
					"确定":function() {
						var self = $(this);
						var frameWindow = window.frames["editFrame"]["window"];
						var form = frameWindow["document"].getElementById("editForm");
						if(!form) {
							self["dialog"]("close");
							return;
						}
						form = $(form);
						//不再进行验证,修改时不需要验证
						$("#listTableDiv").invoke("/admin/platform/basic/domaingenerate/do/update",
							form.serializeArray(), function(html) {
							$(this).find("tr.selected").replaceWith(html);
							self["dialog"]("close");
						});
					}
				}});
			$("#edit").click(function() {
				var tr = $("#entityTable tr.selected");
				if(tr.length == 1) {
					var clazz = $("#generatedTypeSelect").val();
					var id = tr.attr("id");
					if(clazz && id) {
						$("#editFrame")[0].src = "${pageContext.request.contextPath}/admin/platform/basic/domaingenerate/do/edit.q?clazz=" + clazz + "&idx=" + id;
						$("#editFrame")["dialog"]("open");
					}
				} else {
					alert("每次仅能选中一项进行删除");
				}
			});
		</g:permissionRequired>
		<g:permissionRequired code="010605" description="删除基础信息">
			//删除信息
			$("#delete").click(function() {
				var tr = $('#entityTable tr.selected');
				if(tr.length == 1) {
					$("#deleteDialog")["dialog"]("open");
				} else {
					alert("每次仅能选中一项进行删除");
				}
			});
			$("#deleteDialog")["dialog"]({
				modal:true,autoOpen:false,
				buttons:{
					"取消":function() {
						$(this)["dialog"]('close');
					},
					"删除":function() {
						var self = $(this);
						var tr = $('#entityTable tr.selected');
						tr.invoke("/admin/platform/basic/domaingenerate/do/delete",
						{idx:tr.attr("id"),clazz:$("#generatedTypeSelect").val()}, function() {
							this.remove();
							self["dialog"]("close");
						});
					}}});
		</g:permissionRequired>
		})
	</script>
</head>
<body>
<div id="toolbar" class="space">
	<select style="float:left" id="generatedTypeSelect"></select>
	<a id="add"><span class="ui-icon ui-icon-plus"></span>添加</a>
	<a id="edit"><span class="ui-icon ui-icon-pencil"></span>修改</a>
	<a id="delete"><span class="ui-icon ui-icon-minus"></span>删除</a>
	<span id="message" style="float:right;"></span>
</div>
<div id="listTableDiv">

</div>
<g:permissionRequired code="010601">
	<iframe id="addFrame" style="height:500px;width:900px" frameborder="0" title="添加信息"></iframe>
</g:permissionRequired>
<g:permissionRequired code="010604">
	<iframe id="editFrame" style="height:500px;width:900px" frameborder="0" title="修改信息"></iframe>
</g:permissionRequired>
<g:permissionRequired code="010605">
	<p id="deleteDialog" title='删除信息'>确定要删除此信息?</p>
</g:permissionRequired>
</body>
</html>