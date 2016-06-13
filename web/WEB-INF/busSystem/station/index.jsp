<%--
  Created by IntelliJ IDEA.
  User: CZJiang
  Date: 15-10-23
  Time: 上午11:53
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
            $("#addli").click(function(){
                $(".tipbg").show();
                $(".tipadd").fadeIn(200);
            });
            $(".tiptopadd a").click(function(){
                $(".tipadd").fadeOut(200);
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
                $().invoke("/admin/station/do/beforeUpdate.q", {idx:chk_value[0]}, function (html) {
                    $("#edit li").remove();
                    $("#edit").append($(html).find("li"));
                    $(".tipbg").show();
                    $(".tipedit").fadeIn(200);
                })
            });
            $(".tiptopedit a").click(function(){
                $(".tipedit").fadeOut(200);
                $(".tipbg").hide();
            });
            $("#addId").click(function(){
                var station_name=$("#station_name").val();
                var station_address=$("#station_address").val();
                var station_ip=$("#station_ip").val();
                var station_port=$("#station_port").val();
                if(station_name==""){
                    alert("场站名称不能为空！");
                    return;
                }
                if(station_address==""){
                    alert("场站地址不能为空！");
                    return;
                }
                if(!check_station(station_ip,station_port)){
                    return;
                }
                $().invoke("/admin/station/do/add.q", {station_name:station_name,station_address:station_address,
                    station_ip:station_ip,station_port:station_port}, function (re) {
                    $("#dataTable").append($(re).find("tr"));
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
                    $().invoke("/admin/station/do/delete.q",{chk_value:chk_value},function(re){
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
            /*$(".communication_test").click(function(){
                var idx=$(this).parents("tr").attr("id");
                $().invoke("/admin/station/do/communication.q",{idx:idx},function(re){
                    if(re=="success"){
                        alert("通讯测试成功！");
                    }else{
                        alert("通讯测试失败，请检查IP和端口是否正解！");
                    }
                });
            });*/
            $(".communication").click(function(){
                var station_ip=$("#station_ip").val();
                var station_port=$("#station_port").val();
                if(!check_station(station_ip,station_port)){
                    return;
                }
                $().invoke("/admin/station/do/communication.q",{station_ip:station_ip,station_port:station_port},function(re){
                    if(re=="success"){
                        alert("通讯测试成功！");
                    }else{
                        alert("通讯测试失败，请检查IP和端口是否正解！");
                    }
                });
            });
        });
        function check_station(station_ip,station_port){
            var re=/^(\d+)\.(\d+)\.(\d+)\.(\d+)$/;
            if(station_ip==""||station_port==""){
                alert("数据库IP地址和端口不能为空！");
                return false;
            }
            if(re.test(station_ip)){
                if( !(RegExp.$1<256 && RegExp.$2<256 && RegExp.$3<256 && RegExp.$4<256)){
                    alert("请查看 IP 是否填写正确！");
                    return false;
                }
            }else{
                alert("请查看 IP 是否填写正确！");
                return false;
            }
            if(isNaN(station_port)){
                alert("数据库端口只能为数字！");
                return false;
            }
            return true;
        }
        function communication(){
            var station_ip=$("#ipedit").val();
            var station_port=$("#portedit").val();
            if(!check_station(station_ip,station_port)){
                return;
            }
            $().invoke("/admin/station/do/communication.q",{station_ip:station_ip,station_port:station_port},function(re){
                if(re=="success"){
                    alert("通讯测试成功！");
                }else{
                    alert("通讯测试失败，请检查IP和端口是否正解！");
                }
            });
        }
        function editStation(){
            var idx=$("#station_id").val();
            var station_name=$("#nameedit").val();
            var station_address=$("#addredit").val();
            var station_ip=$("#ipedit").val();
            var station_port=$("#portedit").val();
            if(station_name==""){
                alert("场站名称不能为空！");
                return;
            }
            if(station_address==""){
                alert("场站地址不能为空！");
                return;
            }
            if(!check_station(station_ip,station_port)){
                return;
            }
            $().invoke("/admin/station/do/update.q", {station_name:station_name,station_address:station_address,
                station_ip:station_ip,station_port:station_port,idx:idx}, function (re) {
                $('input[name="pid"]:checked').each(function(){
                    $(this).parent("td").parent("tr").replaceWith($(re).find("tr"));
                });
                $(".tipedit").fadeOut(200);
                $(".tipbg").hide();
            })
        }
        function perssion(idx){
            $().invoke("/admin/station/do/communication.q",{idx:idx},function(re){
                if(re=="success"){
                    alert("通讯测试成功！");
                }else{
                    alert("通讯测试失败，请检查IP和端口是否正确！");
                }
            });
        }
    </script>

</head>

<body>
<div class="place">
    <span>位置：</span>
    <ul class="placeul">
        <li><a href="#">首页</a></li>
        <li><a href="#">场站管理</a></li>
        <li><a href="#">场站列表</a></li>
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
            <th></th>
            <th>编号</th>
            <th>场站名称</th>
            <th>场站地址</th>
            <th>IP地址</th>
            <th>端口</th>
            <th>通讯测试</th>
        </tr>
        </thead>
        <tbody>
        <s:iterator value="stationList" id="u">
            <tr id="<s:property value='id'/>" class="center">
                <td><input type="checkbox" name="pid" class="subCheckbox" value="<s:property value='id'/>"></td>
                <td><s:property value="id"/> </td>
                <td><s:property value="name"/></td>
                <td><s:property value="address"/></td>
                <td><s:property value="station_ip"/></td>
                <td><s:property value="station_port"/></td>
                <td><input onclick="perssion(<s:property value='id'/> )" class="perssion_button communication_test" name="submit" type="button" value="测 试"/></td>
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
    <div class="tiptopadd"><span>添加场站</span><a></a></div>
    <div style="padding-top:10px;">
        <ul class="forminfo">
            <li><label>场站名称<b>*</b></label><input id="station_name" name="name" type="text" class="dfinput" value=""  style="width:218px;"/></li>
            <li><label>场站地址<b>*</b></label><input id="station_address" name="address" type="text" class="dfinput" value=""  style="width:218px;"/></li>
            <li><label>IP地址<b>*</b></label><input id="station_ip" name="station_ip" type="text" class="dfinput" value=""  style="width:218px;"/> </li>
            <li><label>端口<b>*</b></label><input id="station_port" name="station_port" type="text" class="dfinput" value=""  style="width:218px;"/> </li>
            <li><label>&nbsp;</label><input id="addId" name="submit" type="button" class="btn" value="提交信息"/> &nbsp;&nbsp;&nbsp;<input  type="button" class="btn_1 communication" value="通讯测试"/></li>
        </ul>
    </div>
</div>
<div class="tipedit" style="height:300px;display:none;">
    <div class="tiptopedit"><span>修改场站</span><a></a></div>
    <div style="padding-top:10px;">
        <ul class="forminfo" id="edit">
            <li><label>场站名称<b>*</b></label><input  name="parkname" type="text" class="dfinput" value=""  style="width:218px;"/></li>
            <li><label>场站地址<b>*</b></label><input name="parkaddr" type="text" class="dfinput" value=""  style="width:218px;"/></li>
            <li><label>IP地址<b>*</b></label><input  name="parkIP" type="text" class="dfinput" value=""  style="width:218px;"/> </li>
            <li><label>端口<b>*</b></label><input  name="parkDK" type="text" class="dfinput" value=""  style="width:218px;"/> </li>
            <li><label>&nbsp;</label><input id="editId" class="editId btn" name="submit" type="button" value="提交1信息"/></li>
        </ul>
    </div>
</div>
</body>
</html>

