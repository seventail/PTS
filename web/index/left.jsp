<%@ page import="com.greejoy.gtip.module.rbac.domain.User" %>
<%@ page import="com.greejoy.gtip.module.rbac.support.helper.UserHelper" %>
<%@ page import="org.apache.struts2.ServletActionContext" %>
<%--
  Created by IntelliJ IDEA.
  User: CZJiang
  Date: 15-10-21
  Time: 下午4:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>无标题文档</title>
    <link href="/css/sys.css" rel="stylesheet" type="text/css" />
    <script language="JavaScript" src="/js/jquery.js"></script>

    <script type="text/javascript">
        $(function(){
            //导航切换
            $(".menuson li").click(function(){
                $(".menuson li.active").removeClass("active")
                $(this).addClass("active");
            });

            $('.title').click(function(){
                var $ul = $(this).next('ul');
                $('dd').find('ul').slideUp();
                if($ul.is(':visible')){
                    $(this).next('ul').slideUp();
                }else{
                    $(this).next('ul').slideDown();
                }
            });
        })
    </script>


</head>

<body style="background:#f0f9fd;">
<div class="lefttop"><span></span>栏目菜单</div>

<dl class="leftmenu">

    <dd>
        <div class="title">
            <span><img src="/images/leftico01.png" /></span>场站管理
        </div>
        <ul class="menuson">
            <s:if test="flag">
               <li><cite></cite><a href='/admin/station/do/index.q' target='rightFrame'>场站管理</a><i></i></li>
            </s:if>
            <li><cite></cite><a href="/admin/floor/do/index.q" target="rightFrame">楼层管理</a><i></i></li>
        </ul>
    </dd>

    <dd><div class="title"><span><img src="/images/leftico02.png" /></span>车位查询</div>
        <ul class="menuson">
            <li><cite></cite><a href="/admin/car/carAll/do/carAll.q" target="rightFrame">楼层车位总体情况</a><i></i></li>
            <li><cite></cite><a href="/admin/car/carSearch/do/carSearch.q" target="rightFrame">车位查询</a><i></i></li>
            <s:if test="flag">
                <li><cite></cite><a href="/admin/carInfo/do/index.q" target="rightFrame">车辆信息</a><i></i></li>
                <li><cite></cite><a href="/admin/searchTime/do/index.q" target="rightFrame">车辆查询时间设置</a><i></i></li>
            </s:if>
        </ul>

    </dd>
    <dd><div class="title"><span><img src="/images/leftico03.png" /></span>报表统计</div>
        <ul class="menuson">
            <li><cite></cite><a href="/admin/chart/do/chart.q" target="rightFrame">统计信息</a><i></i></li>
        </ul>

    </dd>
    <dd><div class="title"><span><img src="/images/leftico04.png" /></span>用户管理</div>
        <ul class="menuson">
            <li><cite></cite><a href="/admin/user/do/index.q" target="rightFrame">用户列表</a><i></i></li>
        </ul>

    </dd>

</dl>
</body>
</html>
