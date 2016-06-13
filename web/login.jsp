<%--
  Created by IntelliJ IDEA.
  User: CZJiang
  Date: 15-10-21
  Time: 下午4:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.greejoy.gtip.component.ApplicationContextManager" %>
<%@ page import="com.greejoy.gtip.component.ConfigLoader" %>
<%@ page import="com.greejoy.gtip.component.security.SingleCipher" %>
<%@ page import="com.greejoy.gtip.module.rbac.api.UnitedAgCenterParam" %>
<%@ page import="com.greejoy.gtip.util.URLUtils" %>
<%@ page import="org.apache.commons.codec.binary.Hex" %>
<%@ page import="org.apache.commons.lang.time.DateFormatUtils" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.greejoy.gtip.GtipConstant" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>欢迎登录后台管理系统</title>
<link href="/css/sys.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script src="/js/cloud.js" type="text/javascript"></script>

<script language="javascript">
	$(function(){
    $('.loginbox').css({'position':'absolute','left':($(window).width()-692)/2});
	$(window).resize(function(){
    $('.loginbox').css({'position':'absolute','left':($(window).width()-692)/2});
    })
});
</script>

</head>

<body style="background-color:#1c77ac; background-image:url(/images/light.png); background-repeat:no-repeat; background-position:center top; overflow:hidden;">
<div id="mainBody">
  <div id="cloud1" class="cloud"></div>
  <div id="cloud2" class="cloud"></div>
</div>
<div class="loginbody">
	<span class="systemlogo"></span>
	<div class="loginbox">
		<form id="form1" name="form1" method="post" action="/login/do/login.q">
		<ul>
			<li><input name="user.username" id="user" type="text" class="loginuser" /></li>
			<li><input name="user.password" id="pass" type="password" class="loginpwd" /></li>
			<li><input name="submit" type="submit" class="loginbtn" value="登录"  /><label><input name="" type="checkbox" value="" checked="checked" />记住密码</label></li>
		</ul>
		</form>
	</div>
</div>
<div class="loginbm">版权所有 @  2015  </div>
</body>
</html>

