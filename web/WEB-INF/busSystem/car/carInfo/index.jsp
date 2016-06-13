<%--
  Created by IntelliJ IDEA.
  User: CZJiang
  Date: 15-11-12
  Time: 下午1:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="/css/sys.css" rel="stylesheet" type="text/css" />
    <link href="/theme/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/js/jquery.js"></script>
    <script type="text/javascript" src="/theme/greejoy.js"></script>
    <script type="text/javascript" src="/theme/jquery-ui.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $(".tiptopedit a").click(function(){
                $(".tipedit").fadeOut(200);
                $(".tipbg").hide();
            });
            $("#synchronizationli").click(function(){
                $().invoke("/admin/carInfo/do/synchronization.q", null, function (re) {
                    if(re=="success"){
                        alert("更新成功！");
                        window.location.href="/admin/carInfo/do/index.q";
                        $(".tipadd").fadeOut(200);
                        $(".tipbg").hide();
                    }else{
                        alert("更新数据失败！");
                    }
                })
            });
            $("#editli").click(function(){
                var chk_value=[];
                $('input[name="pid"]:checked').each(function(){
                    chk_value.push($(this).val());
                });
                if ($('input[name="pid"]:checked').length==0){
                    alert("请选择要修改的信息！");
                    return;
                }else if($('input[name="pid"]:checked').length>1){
                    alert("请选择一条信息进行修改！");
                    return;
                }
                $().invoke("/admin/carInfo/do/beforeUpdate.q", {idx:chk_value[0]}, function (html) {
                    $("#edit li").remove();
                    $("#edit").append($(html).find("li"));
                    $(".tipbg").show();
                    $(".tipedit").fadeIn(200);
                })
            });
            $("#editCar").click(function(){
                var lx=$('input[name="editlx"]').val();
                var jsBusType=$('input[name="editjsBusType"]').val();
                var busCrewno=$('input[name="editbusCrewno"]').val();
                var idx=$('input[name="editcarInfoid"]').val();
                $().invoke("/admin/carInfo/do/update.q",{idx:idx,lx:lx,jsBusType:jsBusType,busCrewno:busCrewno},function(re){
                    $('input[name="pid"]:checked').each(function(){
                        $(this).parent("td").parent("tr").replaceWith($(re).find("tr"));
                    });
                    $(".tipedit").fadeOut(200);
                    $(".tipbg").hide();
                })
            })
        });
    </script>

</head>

<body>
<div class="place">
    <span>位置：</span>
    <ul class="placeul">
        <li><a href="#">首页</a></li>
        <li><a href="#">车位查询</a></li>
        <li><a href="#">车辆信息</a></li>
    </ul>
</div>

<div class="rightinfo">
    <div class="tools">
        <ul class="toolbar">
            <li id="synchronizationli"><span><img src="/images/t01.png" /></span>同步车辆信息</li>
            <li id="editli"><span><img src="/images/t02.png" /></span>修改</li>
        </ul>
    </div>
    <table class="tablelist" id="dataTable">
        <thead>
        <tr>
            <th></th>
            <th>编号</th>
            <th>自编号</th>
            <th>车牌号</th>
            <th>车辆类型</th>
            <th>品牌型号</th>
            <th>车队编号</th>
        </tr>
        </thead>
        <tbody>
        <s:iterator value="#carInfoList" id="u">
            <tr class="center">
                <td><input type="checkbox" name="pid" value="<s:property value='id'/>"></td>
                <td><s:property value="id"/> </td>
                <td><s:property value="busNo"/></td>
                <td><s:property value="busPlate"/></td>
                <td><s:property value="lx"/></td>
                <td><s:property value="jsBusType"/></td>
                <td><s:property value="busCrewno"/></td>
            </tr>
        </s:iterator>
        </tbody>
    </table>
    <%@include file="/WEB-INF/gtip/support/component/page.jsp" %>
    <script type="text/javascript">
        $('.tablelist tbody tr:odd').addClass('odd');
    </script>
</div>

<div class="tipbg"></div>
<div class="tipedit" style="height:350px;display:none;">
    <div class="tiptopedit"><span>修改车辆信息</span><a></a></div>
    <div style="padding-top:10px;">
        <ul class="forminfo" id="edit">
            <li><label>场站名称<b>*</b></label><input  name="parkname" type="text" class="dfinput"  style="width:218px;"/></li>
            <li><label>场站地址<b>*</b></label><input name="parkaddr" type="text" class="dfinput" style="width:218px;"/></li>
            <li><label>IP地址<b>*</b></label><input  name="parkIP" type="text" class="dfinput" style="width:218px;"/> </li>
            <li><label>端口<b>*</b></label><input  name="parkDK" type="text" class="dfinput" style="width:218px;"/> </li>
        </ul>
        <input style="margin-left:110px;" id="editCar" name="submit" type="submit" class="btn" value="保存修改"/>
    </div>
</div>
</body>
</html>

