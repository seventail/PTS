<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
	<title>数据库操作</title>
	<%@ include file="/WEB-INF/gtip/support/include/header.jsp" %>
	<script type="text/javascript">
		$(function() {
			$("#sqlResultTable").operational();
		});
	</script>
</head>
<body>
<div id="message">
	<%@ include file="../../support/include/actionmessage.jsp" %>
</div>
<div id="sqlDiv">
	<form action="${pageContext.request.contextPath}/admin/platform/system/sql/do/sql.q" method="post">
		请输入相应语句<br/>
		<textarea name="sql" rows="10" cols="100" id="sqlText"><s:property value="sql"/></textarea>
		<br/>
		<input type="submit" class="button" value="执行"/>
	</form>
</div>
<div id="sqlResultDiv">
	<table id="sqlResultTable" class="manage-table space">
		<s:if test="resultList.size > 0">
			<tr>
				<s:iterator value="columnList" id="column">
					<th><s:property value="#column"/></th>
				</s:iterator>
			</tr>
			<s:iterator value="resultList" id="m">
				<tr>
					<s:iterator value="columnList" id="c">
						<td><s:property value="#m[#c]"/></td>
					</s:iterator>
				</tr>
			</s:iterator>
		</s:if>
	</table>
</div>
</body>
</html>