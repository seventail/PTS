<%--
  Created by IntelliJ IDEA.
  User: CZJiang
  Date: 15-10-26
  Time: 下午9:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="/css/sys.css" rel="stylesheet" type="text/css" />
    <link href="/css/select.css" rel="stylesheet" type="text/css" />
    <link href="/theme/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/theme/My97DatePicker/skin/WdatePicker.css">
    <script type="text/javascript" src="/js/jquery.js"></script>
    <script type="text/javascript" src="/theme/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="/theme/greejoy.js"></script>
    <script type="text/javascript" src="/js/select-ui.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function(e) {
            $(".select1").uedSelect({
                width : 100
            });
            $(".date").click(function(){
                WdatePicker({dateFmt:'yyyy-MM-dd', isShowClear:true,readOnly:true});
            })
            var boxWidth = $(".carsAllInfor").width()/2;
            $(".carSearch").width($(".carsAllInfor").width()-2);
            $(".carsF").width(boxWidth-7);

            $(".tip").css("left",($(window).width()-635)/2);
            $(window).resize(function(){
                $(".tip").css("left",($(window).width()-635)/2);
            });
            $(".tiptop a").click(function(){
                $(".tip").fadeOut(200);
                $(".tipbg").hide();
            });
            $("#select_floor").live("change", function() {
                var floor_num = $(this).val();
                window.location.href="/admin/car/carSearch/do/carSearch.q?floorNum="+floor_num;
            });
            $(".stopInfo").click(function(){
                var busPlate= $(this).child;
                $().invoke("/admin/car/carSearch/do/carStopTen.q",{busPlate:busPlate},function(html){
                    $("#carStop10 tr").remove();
                    $("#carStop10").append($(html).find("tr"));
                    $(".tipbg").show();
                    $(".tip").fadeIn(200);
                })
            });
            $("#search").click(function(){
                var busNo=$("#busNo").val();
                var busPlate=$("#busPlate").val();
                var stopDate=$("#stopDate").val();
                if(busNo==""&&busPlate==""&&stopDate==""){
                    alert("请输入查询信息！");
                    return;
                }
                $().invoke("/admin/car/carSearch/do/beforeSearch.q",{busNo:busNo,busPlate:busPlate},function(re){
                    if(re=="success"){
                        window.location="/admin/car/carSearch/do/search.q?busNo="+busNo+"&busPlate="+busPlate+"&stopDate="+stopDate;
                    }else{
                        alert("请查看自编号与车牌号是否对应！");
                        return;
                    }
                })
            })
        });
        function showTip(url){
            $(".tipbg").show();
            $(".tip").fadeIn(200);
            $("#tipFrame").attr("src",url);
        }
        function carSearch(busPlate){
            $().invoke("/admin/car/carSearch/do/carStopTen.q",{busPlate:busPlate},function(html){
                $("#carStop10 tr").remove();
                $("#carStop10").append($(html).find("tr"));
                $(".tipbg").show();
                $(".tip").fadeIn(200);
            })
        }
        window.onload=function(){
            var size=${carListSize};
            if(parseInt(size)<7){
                $(".car_sys").css({"position":"absolute","top":"250px"});
            }else if(parseInt(size)<13){
                $(".car_sys").css({"position":"absolute","top":"395px"});
            }else if(parseInt(size)<19){
                $(".car_sys").css({"position":"absolute","top":"540px"});
            }
        }
    </script>
</head>

<body style="min-width:1000px;">
<div class="place">
    <span>位置：</span>
    <ul class="placeul">
        <li><a href="#">首页</a></li>
        <li><a href="#">车位查询</a></li>
        <li><a href="#">车位总体情况</a></li>
    </ul>
</div>
<div class="rightinfo">

    <ul class="carSearch">
        <li class="carSearchTi">楼层</li>
        <li class="carSearchIn">
            <div class="vocation">
                <select class="dfinput" name="floor" id="select_floor" style="width:100px;">
                    <s:iterator value="floorList">
                        <option <s:if test="floor_num==floorNum">selected="selected"</s:if> value="<s:property value='floor_num'/>"> <s:property value='floor_num'/> 楼</option>
                    </s:iterator>
                </select>
            </div>
        </li>
        <li class="carSearchTi">车辆自编号</li>
        <li class="carSearchIn"><input id="busNo" type="text" class="dfinput" value="<s:property value='busNo'/>"  style="width:110px;"/></li>
        <li class="carSearchTi">车牌号</li>
        <li class="carSearchIn"><input id="busPlate" type="text" class="dfinput" value="<s:property value='busPlate'/>"  style="width:110px;"/></li>
        <li class="carSearchTi">停车时间</li>
        <li class="carSearchIn"><div><input id="stopDate" type="text" value="<s:property value='stopDate'/>" class="dfinput date" style="width:110px;"/></div></li>
        <li class="carSearchIn"><input id="search" type="submit" class="scbtn" value="查询"/></li>
    </ul>
    <div class="height10"></div>
    <div class="carsList">
        <s:iterator value="#carInfoList">
            <div class="car" onclick="carSearch('<s:property value='busPlate'/>')">
                <ul class="carzbh"><li class="zbh">自编号：<s:property value="busNo"/> </li><li class="lc"><s:property value="floor_num"/> 楼</li></ul>
                <ul class="carcph"><s:property value="busPlate"/> </ul>
                <ul class="cardate">停车时间：<s:date name="stopDate" format="yyyy-MM-dd HH:mm:ss"/> </ul>
                <input type="hidden"  value="<s:property value='busPlate'/>"/>
            </div>
        </s:iterator>
    </div>
    <div class="car_sys" id="car_sys">
        <%@include file="/WEB-INF/gtip/support/component/page.jsp" %>
    </div>
</div>
<div class="tipbg"></div>
<div class="tip" style="width:630px;height:300px;">
    <div class="tiptop"><span>车辆最近10次的停车记录</span><a></a></div>
    <table class="tablelist" style="width:100%; margin:auto;">
        <thead>
        <tr>
            <th style="width:40px;">序号</th>
            <th style="width:100px;">车牌号</th>
            <th style="width:80px;">所停楼层</th>
            <th style="width:80px;">停车时长</th>
            <th style="width:150px;">进场时间</th>
            <th>出场时间</th>
        </tr>
        </thead>
        <tbody id="carStop10">
        <tr>
            <td>1</td>
            <td></td>
            <td>1楼</td>
            <td>9小时</td>
            <td>2015-9-21 08:45:32</td>
            <td>2015-9-21 18:12:21</td>
        </tr>
        </tbody>
    </table>
</div>
</body>
</html>
