<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html
PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
Fly_m at 2009-9-7
-->
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh-CN">
<head>
	<title>跳转界面</title>
</head>
<body>
<%@ include file="../include/actionmessage.jsp" %>
<div style="color:blue;">
	准备跳转至<a href="<s:property value="url.url" escape="false"/>"><s:property value="url.name"/></a>
</div>
<script type="text/javascript">
	function changeUrl() {
		var url = "<s:property value="url.url" escape="false"/>";
		if(url) {
			window.self.location.href = url;
		}
		return false;
	}
	setTimeout(changeUrl, <s:property value="url.millisecond" default="2500"/>);
</script>
</body>
</html>