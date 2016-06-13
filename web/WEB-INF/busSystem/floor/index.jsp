<%--
  Created by IntelliJ IDEA.
  User: CZJiang
  Date: 15-10-27
  Time: 上午11:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
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
            $("#addli").click(function(){
                $(".tipbg").show();
                $(".tipadd").fadeIn(200);
            });
            $(".tiptopadd a").click(function(){
                $(".tipadd").fadeOut(200);
                $(".tipbg").hide();
            });
            $(".tiptopedit a").click(function(){
                $(".tipedit").fadeOut(200);
                $(".tipbg").hide();
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
                $().invoke("/admin/floor/do/beforeUpdate.q", {idx:chk_value[0]}, function (html) {
                    $("#edit li").remove();
                    $("#edit").append($(html).find("li"));
                    $(".tipbg").show();
                    $(".tipedit").fadeIn(200);
                })
            });
            $("#addId").click(function(){
                var floor_num=$("#floor_num").val();
                var parking_lot=$("#parking_lot").val();
                var station_id=$("#station_id").val();
                if(station_id==""){
                    alert("请选择场站");
                    return;
                }
                if(isNaN(floor_num)){
                    alert("楼层只能为数字！");
                    return;
                }
                if(isNaN(parking_lot)){
                    alert("总停车位只能为数字！");
                    return;
                }
                $().invoke("/admin/floor/do/add.q", {station_id:station_id,floor_num:floor_num,parking_lot:parking_lot}, function (re) {
                    $("#dataTable").append($(re).find("tr"));
                    $(".tipadd").fadeOut(200);
                    $(".tipbg").hide();
                })
            });
            $(".editId").click(function(){
                var parking_lot=$("#parking_lot").val();
                var idx=$("#floor_id").val();
                $().invoke("/admin/floor/do/update.q", {parking_lot:parking_lot,idx:idx}, function (re) {
                    $('input[name="pid"]:checked').each(function(){
                        $(this).parent("td").parent("tr").replaceWith($(re).find("tr"));
                    });
                    $(".tipadd").fadeOut(200);
                    $(".tipbg").hide();
                })
            });
            $("#delete").click(function(){
                var chk_value="";
                $('input[name="pid"]:checked').each(function(){
                    if(chk_value==""){
                        chk_value=$(this).val();
                    }else{
                        chk_value=chk_value+"."+$(this).val();
                    }
                }) ;
                if(chk_value==""){
                    alert("请选择要删除的信息！");
                    return;
                }
                if (confirm("确定要删除选中的信息吗?")) {
                    $().invoke("/admin/floor/do/delete.q",{chk_value:chk_value},function(re){
                        if(re=="success"){
                            $('input[name="pid"]:checked').each(function(){
                                $(this).parent("td").parent("tr").remove();
                            }) ;
                            alert("删除成功！");
                        }else{
                            alert("删除失败！");
                        }
                    });
                }
            });
        });
        function editFloor(){
            var parking_lot=$('input[name="editlot"]').val();
            var idx=$('input[name="editfloorid"]').val();
            $().invoke("/admin/floor/do/update.q", {parking_lot:parking_lot,idx:idx}, function (re) {
                $('input[name="pid"]:checked').each(function(){
                    $(this).parent("td").parent("tr").replaceWith($(re).find("tr"));
                });
                $(".tipedit").fadeOut(200);
                $(".tipbg").hide();
            })
        }
    </script>
</head>

<body>
<div class="place">
    <span>位置：</span>
    <ul class="placeul">
        <li><a href="#">首页</a></li>
        <li><a href="#">场站管理</a></li>
        <li><a href="#">楼层列表</a></li>
    </ul>
</div>

<div class="rightinfo">
    <div class="tools">
        <ul class="toolbar">
            <li id="addli"><span><img src="/images/t01.png" /></span>添加</li>
            <li id="editli"><span><img src="/images/t02.png" /></span>修改</li>
            <li id="delete"><span><img src="/images/t03.png" /></span>删除</li>
        </ul>
    </div>

    <table class="tablelist" id="dataTable">
        <thead>
        <tr>
            <th style="width:50px;"></th>
            <th>编号</th>
            <th>站场名称</th>
            <th>楼层</th>
            <th>总停车位</th>
        </tr>
        </thead>
        <tbody>
        <s:iterator value="#floorList">
            <tr>
                <td><input name="pid" type="checkbox" value="<s:property value='id'/>" /></td>
                <td><s:property value="id"/></td>
                <td><s:property value="station.name"/></td>
                <td><s:property value="floor_num"/></td>
                <td><s:property value="parking_lot"/></td>
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
<div class="tipadd" style="height:300px;display:none;">
    <div class="tiptopadd"><span>添加楼层</span><a></a></div>
    <div style="padding-top:10px;">
        <ul class="forminfo">
            <li><label>场站名称<b>*</b></label>
                <div class="vocation" style="float:left">
                    <select class="dfinput" style="width:302px;margin-bottom:15px;" id="station_id" name="station_id">
                        <option value="0">--请选择--</option>
                        <s:iterator value="#stationList">
                            <option value="<s:property value='id'/>"><s:property value="name"/></option>
                        </s:iterator>
                    </select>
                </div>
            </li>
            <li><label>楼层<b>*</b></label><input id="floor_num" name="floor.floor_num" type="text" class="dfinput" style="width:300px;"/> 楼</li>
            <li><label>总停车位<b>*</b></label><input id="parking_lot" name="floor.parking_lot" type="text" class="dfinput"   style="width:300px;"/> 个 </li>
            <li><label>&nbsp;</label><input id="addId" name="submit" type="submit" class="btn" value="提交信息"/></li>
        </ul>
    </div>
</div>
<div class="tipedit" style="height:300px;display:none;">
    <div class="tiptopedit"><span>修改楼层</span><a></a></div>
    <div style="padding-top:10px;">
        <ul class="forminfo" id="edit">
            <li><label>场站名称<b>*</b></label><input  name="parkname" type="text" class="dfinput"  style="width:218px;"/></li>
            <li><label>场站地址<b>*</b></label><input name="parkaddr" type="text" class="dfinput" style="width:218px;"/></li>
            <li><label>IP地址<b>*</b></label><input  name="parkIP" type="text" class="dfinput" style="width:218px;"/> </li>
            <li><label>端口<b>*</b></label><input  name="parkDK" type="text" class="dfinput" style="width:218px;"/> </li>
        </ul>
    </div>
</div>
</body>
</html>
