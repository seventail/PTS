<%--
  Created by IntelliJ IDEA.
  User: CZJiang
  Date: 15-10-9
  Time: 上午11:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<!DOCTYPE html>
<html>
<head>
    <title>用户列表</title>
    <link href="/css/sys.css" rel="stylesheet" type="text/css" />
    <link href="/theme/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/js/jquery.js"></script>
    <script type="text/javascript" src="/theme/greejoy.js"></script>
    <script type="text/javascript" src="/theme/jquery-ui.js"></script>
    <script type="text/javascript" src="/js/jquery.ztree.core-3.5.min.js"></script>
    <script type="text/javascript" src="/js/jquery.ztree.excheck-3.5.min.js"></script>
    <style type="text/css">
        .ztree span{display:inline}
    </style>
    <script type="text/javascript">
        $(document).ready(function(){
            $(".tiptop a").click(function(){
                $(".tip").fadeOut(200);
                $(".tipbg").hide();
            });
            $("#addli").click(function(){
                $(".tipbg").show();
                $(".tipadd").fadeIn(200);
            });
            $(".tiptopedit a").click(function(){
                $(".tipedit").fadeOut(200);
                $(".tipbg").hide();
            });
            $(".tiptopadd a").click(function(){
                $(".tipadd").fadeOut(200);
                $(".tipbg").hide();
            });
            $(".tiptopper a").click(function(){
                $(".tipper").fadeOut(200);
                $(".tipbg").hide();
            });
            $("#addId").click(function(){
                var username=$("#username").val();
                var password=$("#password").val();
                var name=$("#name").val();
                var linkInfor=$("#link").val();
                var repassword=$("#repassword").val();
                var telphone=$("#telphone").val();
                if(username==""){
                    alert("用户名不能为空！");
                    return;
                }
                if(password==""){
                    alert("密码不能为空！");
                    return;
                }
                if(repassword==""){
                    alert("确认密码不能为空！");
                    return;
                }
                if(password!=repassword){
                    alert("两次密码输入不一致！");
                    return;
                }
                if(linkInfor==""){
                    alert("联系电话不能为空！");
                    return;
                }
                if(!checkTel(linkInfor)){
                    alert("电话号码格式不正确！");
                    return;
                }
                if(name==""){
                    alert("真实姓名不能为空！");
                    return;
                }
                $("#linkInfor").val(linkInfor+","+telphone);
                var newItem = $('#addUserForm').serializeArray();
                $().invoke("/admin/platform/rbac/user/do/add", newItem, function(html) {
                    $("#dataTable").append($(html).find("tr"));
                    $(".tipadd").fadeOut(200);
                    $(".tipbg").hide();
                });
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
                    $().invoke("/admin/user/do/delete.q",{chk_value:chk_value},function(re){
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
                $().invoke("/admin/platform/rbac/user/do/editOther", {idx:chk_value[0]}, function (html) {
                    $("#editUser li").remove();
                    $("#editUser").append($(html).find("li"));
                    $(".tipbg").show();
                    $(".tipedit").fadeIn(200);
                })
            });
            $("#forbidFlag").click(function(){
                var chk_value="";
                $('input[name="pid"]:checked').each(function(){
                    if(chk_value==""){
                        chk_value=$(this).val();
                    }else{
                        chk_value=chk_value+"."+$(this).val();
                    }
                }) ;
                if(chk_value==""){
                    alert("请选择要禁用的用户！");
                    return;
                }
                $().invoke("/admin/user/do/forbidAjax.q",{chk_value:chk_value},function(re){
                    if(re=="success"){
                        window.location.href="/admin/user/do/index.q";
                        alert("所选用户已成功禁用/启用！");
                    }else{
                        alert("用户禁用/启用失败！");
                    }
                })
            });
            $("#userPerssion").click(function(){
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

                Gtip.invoke("/admin/user/ajax/perssion",{idx:chk_value[0]},function(re){
                    var user = re["user"];
                    var stationList = re["stationList"];
                    var userXPerssionList = re["userXPerssionList"];
                    var zTreeObj;
                    var setting = {
                            check: {
                                enable: true
                            },
                            data: {
                                simpleData: {
                                    enable: true
                                }
                            },
                            view: {
                                showIcon: false
                            }
                        };
                    var zNodes = new Array();
                    var hadSS = "";
                    var hadSL = "";
                    for(var i=0;i<userXPerssionList.length;i++){
                        hadSS+=userXPerssionList[i].station.id+",";
                    }
                    for(var i=0;i<userXPerssionList.length;i++){
                        hadSL+=userXPerssionList[i].floor.id+",";
                    }
                    for(var i=0;i<stationList.length;i++){
                        var station = "{\"id\":\""+stationList[i].id+"\",\"pId\":\"0\",\"name\":\""+stationList[i].name+"\",\"open\":\"false\",\"checked\":";
                        if(hadSS.indexOf(stationList[i].id)!=-1)
                            station+="\"true\"}";
                        else
                            station+="\"false\"}";
                        var jsonStation = JSON.parse(station);
                        zNodes.push(jsonStation);
                        for(var j=0;j<stationList[i].floorList.length;j++){
                            var floor = "{\"id\":\""+stationList[i].id+"-"+stationList[i].floorList[j].id+"\",\"pId\":\""+stationList[i].id+"\",\"name\":\""+stationList[i].floorList[j].floor_num+"楼\",\"open\":\"true\",\"checked\":";
                            if(hadSL.indexOf(stationList[i].floorList[j].id)!=-1)
                                floor+="\"true\"}";
                            else
                                floor+="\"false\"}";
                            var jsonFloor = JSON.parse(floor);
                            zNodes.push(jsonFloor);
                        }
                    }
                    zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, zNodes);
                    $(".tipbg").show();
                    $(".tipper").fadeIn(200);
                    $("#perssionId").click(function(){
                        this.disabled=true;
                        var nodes = zTreeObj.getCheckedNodes(true);
                        var ss=""
                        for(var i=0;i<nodes.length;i++){
                            ss+=nodes[i].id;
                            if(i!=nodes.length-1)
                                ss+=".";
                        }
                        window.location.href="/admin/user/perssion/do/add.q?idx="+user.id+"&chk_value="+ss;
                    });
                })

            })
        });
        function editUser(){
            var link=$("input[name='link']").val();
            var telphone=$("input[name='telphone']").val();
            $("input[name='user.linkInfor']").val(link+","+telphone);
            var newItem = $('#editUser').serializeArray();
            $().invoke("/admin/platform/rbac/user/do/updateOther", newItem, function(html) {
                $('input[name="pid"]:checked').each(function(){
                    $(this).parent("td").parent("tr").replaceWith($(html).find("tr"));
                });
                $(".tipedit").fadeOut(200);
                $(".tipbg").hide();
            });
        }
        function checkTel(value){
            var isPhone = /^([0-9]{3,4}-)?[0-9]{7,8}$/;
            var isMob=/^((\+?86)|(\(\+86\)))?(13[012356789][0-9]{8}|15[0-9]{9}|18[0-9]{9}|147[0-9]{8})$/;
            if(isMob.test(value)||isPhone.test(value)){
                return true;
            }
            else{
                return false;
            }
        }
    </script>
</head>

<body>
<div class="place">
    <span>位置：</span>
    <ul class="placeul">
        <li><a href="#">首页</a></li>
        <li><a href="#">用户管理</a></li>
        <li><a href="#">用户列表</a></li>
    </ul>
</div>

<div class="rightinfo">
    <div class="tools">
        <ul class="toolbar">
            <li id="addli"><span><img src="/images/t01.png" /></span>添加</li>
            <li id="editli"><span><img src="/images/t02.png" /></span>修改</li>
            <li id="delete"><span><img src="/images/t03.png" /></span>删除</li>&nbsp;&nbsp;&nbsp;
            <li id="forbidFlag"><span><img src="/images/t02.png" /></span>启用/禁用</li>
            <li id="userPerssion"><span><img src="/images/t02.png" /></span>分配权限</li>
        </ul>
    </div>

    <table class="tablelist" id="dataTable">
        <thead>
        <tr>
            <th style="width:5%"></th>
            <th style="width:10%">编号</th>
            <th style="width:10%">用户名</th>
            <th style="width:15%">手机</th>
            <th style="width:15%">座机</th>
            <th style="width:10%">真实姓名</th>
            <th style="width:10%">禁用</th>
        </tr>
        </thead>
        <tbody>
        <s:iterator value="userList">
            <tr>
                <td><input type="checkbox" name="pid" value="<s:property value="id"/> "/> </td>
                <td><s:property value="id"/></td>
                <td><s:property value="username"/></td>
                <td><s:property value="linkInfor.split(',')[0]"/></td>
                <td><s:property value="linkInfor.split(',')[1]"/></td>
                <td><s:property value="name"/></td>
                <td><s:if test="forbidFlag">是</s:if><s:else>否</s:else></td>
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
<div class="tipadd" style="height:450px;display:none;">
    <div class="tiptopadd"><span>添加用户</span><a></a></div>
    <div style="padding-top:10px;">
        <form class="forminfo" name="addItem" id="addUserForm" title="添加用户">
            <li><label>用户名<b>*</b></label><input name="user.username" id="username" type="text" class="dfinput"  style="width:218px;"/></li>
            <li><label>密码<b>*</b></label><input name="user.password" id="password" type="password" class="dfinput"  style="width:218px;"/></li>
            <li><label>确认密码<b>*</b></label><input  name="repassword" id="repassword" type="password" class="dfinput"  style="width:218px;"/></li>
            <li><label>手机<b>*</b></label><input  id="link" type="text" class="dfinput" style="width:218px;"/></li>
            <li><label>座机</label><input id="telphone" type="text" class="dfinput" style="width:218px;"/></li>
            <li><label>真实姓名<b>*</b></label><input name="user.name" id="name" type="text" class="dfinput"  style="width:218px;"/> </li>
            <li class="radio_style"><label>是否禁用<b>*</b></label>
                是 <input name="user.forbidFlag" type="radio" value="true" class="radio_style"/>&nbsp;&nbsp;
                否 <input name="user.forbidFlag" type="radio" value="false" checked="checked" class="radio_style"/>
            </li>
            <li class="radio_style"><label>能否创建用户<b>*</b></label>
                是 <input name="user.createFlag" type="radio" value="true" checked="checked" class="radio_style"/>&nbsp;&nbsp;
                否 <input name="user.createFlag" type="radio" value="false"  class="radio_style"/>
            </li>
            <li><label>&nbsp;</label><input id="addId" name="submit" type="button" class="btn" value="提交信息"/></li>
            <input type="hidden" id="linkInfor" name="user.linkInfor" value="">
        </form>
    </div>
</div>
<div class="tipedit" style="height:300px;display:none;">
    <div class="tiptopedit"><span>修改用户</span><a></a></div>
    <div style="padding-top:10px;">
        <form action="" class="forminfo" id="editUser">
            <li><label><b>*</b></label><input  name="parkname" type="text" class="dfinput" value=""  style="width:218px;"/></li>
            <li><label>场站地址<b>*</b></label><input name="parkaddr" type="text" class="dfinput" value=""  style="width:218px;"/></li>
            <li><label>IP地址<b>*</b></label><input  name="parkIP" type="text" class="dfinput" value=""  style="width:218px;"/> </li>
            <li><label>端口<b>*</b></label><input  name="parkDK" type="text" class="dfinput" value=""  style="width:218px;"/> </li>
            <li><label>&nbsp;</label><input id="editUserId" class="editId btn" name="submit" type="button" value="提交信息"/></li>
        </form>
    </div>
</div>
<div class="tipper" style="height:320px;display:none;">
    <div class="tiptopper"><span>添加用户权限</span><a></a></div>
    <div>
       <ul id="treeDemo" class="ztree" style="height:210px;overflow:auto;"></ul>
    </div>
    <li style="margin-top:10px;margin-left:50px;"><label>&nbsp;</label><input id="perssionId" class="btn" name="submit" type="button" value="提交信息"/></li>
</div>

</body>
</html>