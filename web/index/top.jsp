<%--
  Created by IntelliJ IDEA.
  User: CZJiang
  Date: 15-10-21
  Time: 下午4:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.greejoy.gtip.util.URLUtils" %>
<%@ page import="java.util.Collections" %>
<%@ page import="com.greejoy.gtip.module.rbac.api.UnitedAgCenterParam"%>
<%@ page import="com.greejoy.gtip.component.ApplicationContextManager" %>
<%@ page import="com.greejoy.gtip.module.rbac.api.helper.HttpInterfaceHelper"%>
<%@ page import="com.greejoy.station.domain.Station" %>
<%@ page import="org.apache.struts2.ServletActionContext" %>
<%@ page import="com.greejoy.gtip.module.rbac.domain.User" %>
<%@ page import="com.greejoy.gtip.module.rbac.support.helper.UserHelper" %>
<%@ page import="com.greejoy.user.domain.UserXStation" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>无标题文档</title>
    <link href="/css/sys.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/js/jquery.js"></script>
    <script type="text/javascript" src="/theme/greejoy.js"></script>
    <script type="text/javascript">
         $(document).ready(function(){
             $(".tiptopadd a").click(function(){
                $(".tipadd").fadeOut(200);
                $(".tipbg").hide();
            });
        });
        function showTip(url){
            $(".tipbg").show();
            $(".tip").fadeIn(200);
            $("#tipFrame").attr("src",url);
        }
        function logout(){
            parent.window.location="/login/do/logout.q";
        }
    </script>


</head>

<body style="background:url(/images/topbg.gif) repeat-x;" >
<div class="topleft"><img src="/images/logo.png" /></div>
<div class="topright">
    <ul>
        <li>
            <a href="/admin/station/binding/do/beforeBinding.q"  target="rightFrame">
                <s:property value="#station_name"/>
            </a>
        </li>
        <li><a href="/admin/user/do/beforeUpdatePasswd.q" target="rightFrame"><s:property value="#session['session-current-login-user'].username"/></a></li>
        <li><a style="color:#dd0000;"
               href="javascript:logout()">退出</a></li>
        <li><a href="/admin/base/do/about.q"  target="rightFrame">关于</a> </li>
    </ul>
</div>
</body>
</html>
