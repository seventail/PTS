<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<!DOCTYPE html>
<html>
<head>
	<title>公共基础信息管理</title>
	<%@ include file="/WEB-INF/gtip/support/include/header.jsp" %>
	<script type="text/javascript">
		//		Gtip.postDebug = 1;
		var _select;
		$(function() {
			//operational table
			$('#publicInfoTable').operational();
		<g:permissionRequired code="010101" description="添加字典">
			//addItem dialog
			$("#addItem").dialog({
				autoOpen:false,
				modal:true,
				buttons:{
					"取消":function() {$(this).dialog('close');},
					"确定":function() {
						//validate form then submit and callback
						if($('#addItem').validate().form()) {
							var $this = $(this);
							var newItem = $('#addItem').serializeArray();
							Gtip.invoke("/admin/platform/basic/dictionary/ajax/add", newItem, function(re) {
								var res = $.jsonGrep(re, ["typeName", "value", "code"]);
								$('#publicInfoTable').insertTR(res, re["id"]);
								$("#addItem")[0].reset();
								$this.dialog('close');
								$("#message").show(re["message"]);
							});
						}
					}
				}
			});
			//open addItem dialog
			$("#add").click(function() {
				//取得当前查看的类型值,在添加时默认选中的类型与查看的类型值一致
				var leftSelectType = $("#dictionarySelect").val();
				Gtip.util.fixSelected($("#dictionaryAddSelect")[0], leftSelectType);
				$('#addItem').dialog('open')
			});
		</g:permissionRequired>
		<g:permissionRequired code="010103" description="修改字典">
			//editItem dialog
			$("#editItem").dialog({
				autoOpen:false,
				modal:true,
				buttons:{
					"取消":function() {$(this).dialog('close');},
					"确定":function() {
						//validate form then submit and callback
						if($('#editItem').validate().form()) {
							var newItem = $('#editItem').serializeArray();
							var $this = $(this);
							Gtip.invoke("/admin/platform/basic/dictionary/ajax/update", newItem, function(re) {
								newItem = $.jsonGrep(re, ["typeName", "value", "code"]);
								$('#publicInfoTable').updataTR("#publicInfoTable tr.selected", newItem, re["id"]);
								$this.dialog('close');
								$("#message").show(re["message"]);
							});
						}
					}
				}
			});
			//open editItem dialog
			$("#edit").click(function() {
				var tr = $('#publicInfoTable tr.selected');
				if(tr.length == 1) {
					var clazz = getClazz(tr.children().html());
					Gtip.invoke("/admin/platform/basic/dictionary/ajax/edit", {"clazz":clazz, "idx":tr.attr("id")}, function(re) {
						Gtip.util.fixSelected($("#dictionaryEditSelect")[0], clazz);
						$("#editItem input[name='dictionary.value']").val(re["value"]);
						$("#editItem input[name='idx']").val(tr.attr("id"));
						$("#editItem input[name='dictionary.code']").val(re["code"]);
						$("#editItem input[name='clazz']").val(clazz);
						$('#editItem').dialog('open');
					});
				}
				else alert("每次仅能选中一行进行修改");
			});
		</g:permissionRequired>
			//根据类型名称取clazz
			function getClazz(name) {
				var re = null;
				$.each(_select, function(i, r) {
					if(r["value"] == name) {
						re = r["key"];
						return false;
					}
				});
				return re;
			}

			//select item
			$("#selectAll").click(function() {$("#publicInfoTable tbody tr").addClass("selected")});
			$("#selectNon").click(function() {$("#publicInfoTable tbody tr").removeClass("selected")});
			$("#selectToggle").click(function() {$("#publicInfoTable tbody tr").toggleClass("selected")});
			$("input").tip();//input hover tip

			//加载字典映射
			Gtip.invoke("/admin/platform/basic/dictionary/ajax/listType", null, function(re) {
				_select = re;
				Gtip.util.fillSelect($("#dictionarySelect")[0], re, "key", "value", "", "<s:property value="clazzName"/>");
				$("#dictionaryAddSelect").length && Gtip.util.fillSelect($("#dictionaryAddSelect")[0], re, "key", "value");
				$("#dictionaryEditSelect").length && Gtip.util.fillSelect($("#dictionaryEditSelect")[0], re, "key", "value");
			});

			//字典映射改变时
			$("#dictionarySelect").change(function() {
				window.self.location = "${pageContext.request.contextPath}/admin/platform/basic/dictionary/do/list.q?clazz=" + $(this).val();
			});
		})
	</script>
</head>
<body>
<div id="toolbar" class="space">
	<select style="float:left" id="dictionarySelect"></select>
	<a id="selectAll"><span class="ui-icon ui-icon-check"></span>全选</a>
	<a id="selectNon">取消全选</a>
	<a id="selectToggle"><span class="ui-icon ui-icon-circle-check"></span>反选</a>
	<span class="ui-icon ui-icon-grip-dotted-vertical"></span>
	<g:permissionRequired code="010101" description="添加字典">
		<a id="add"><span class="ui-icon ui-icon-plus"></span>添加</a>
	</g:permissionRequired>
	<g:permissionRequired code="010103" description="修改字典">
		<a id="edit"><span class="ui-icon ui-icon-pencil"></span>修改</a>
	</g:permissionRequired>
</div>
<table id="publicInfoTable" class="manage-table space">
	<thead>
	<tr>
		<th>字典类型</th>
		<th>名称</th>
		<th>编码</th>
	</tr>
	</thead>
	<tbody>
	<s:iterator value="dictionaryList">
		<tr id="<s:property value="id"/>">
			<td><s:property value="typeName"/></td>
			<td><s:property value="value"/></td>
			<td><s:property value="code"/></td>
		</tr>
	</s:iterator>
	</tbody>
</table>
<%@ include file="../../../gtip/support/component/page.jsp" %>
<g:permissionRequired code="010101" description="添加字典">
	<form action="" name="addItem" id="addItem" title="添加信息">
		<label>字典类型:</label><select name="clazz" id="dictionaryAddSelect" class="required"></select><br/>
		<label>名称：</label><input type="text" name="dictionary.value" class="required" maxlength="50"><br>
		<label>编码：</label><input type="text" name="dictionary.code" class="alphanum required" maxlength="2"><br>
	</form>
</g:permissionRequired>
<g:permissionRequired code="010103" description="修改字典">
	<form name="editItem" id="editItem" title="修改">
		<input type="hidden" name="clazz"/>
		<input type="hidden" name="idx"/>
		<label>字典类型:</label><select name="clazzSelect" id="dictionaryEditSelect" disabled="disabled"></select><br/>
		<label>名称：</label><input type="text" name="dictionary.value" class="required" maxlength="50"><br>
		<label>编码：</label><input type="text" name="dictionary.code" disabled="disabled" class="alphanum required"
								 maxlength="2">
	</form>
</g:permissionRequired>
</body>
</html>