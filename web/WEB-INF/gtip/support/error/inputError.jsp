<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Collection" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.Map" %>
<!--
Fly_m at 2009-9-7
-->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html
PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh-CN">
<head>
	<title>输入错误信息</title>
</head>
<body>
<div style="color:blue;font:bold 20px;text-align:center;">
	如果你看到这个界面,说明信息输入不正确!请检查输入的信息:
</div>
<div style="color:red;">
    <s:actionerror />
    <s:fielderror />
	<table border="1" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td width="20%">输入参数名</td>
			<td>输入参数值</td>
		</tr>
		<%
			@SuppressWarnings("unchecked")
			Map<String, ?> paramMap = request.getParameterMap();
			for(Map.Entry<String, ?> e : paramMap.entrySet()) {
		%>
		<tr>
			<td><%=e.getKey()%>
			</td>
			<td>
				<%
					Object value = e.getValue();
					if(value.getClass().isArray())
						out.println(Arrays.toString((Object[])value));
					else
						out.println(value);
				%>
			</td>
		</tr>
		<%
			}
		%>
	</table>
</div>
</body>
</html>