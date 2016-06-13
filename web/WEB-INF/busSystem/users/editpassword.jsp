<%--
  Created by IntelliJ IDEA.
  User: CZJiang
  Date: 15-11-11
  Time: 下午2:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="/css/sys.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/js/jquery.js"></script>
    <script type="text/javascript" src="/theme/greejoy.js"></script>
    <script type="text/javascript">
        $(function(){
            $(".tipbg").show();
            $(".tip").fadeIn(200);
            $(".tiptop a").click(function(){
                $(".tip").fadeOut(200);
                $(".tipbg").hide();
            });
            $("#updatePasswd").click(function(){
                var newPassword=$("#new_password").val();
                var oldPassword=$("#old_password").val();
                var re_password=$("#re_password").val();
                if(newPassword.length<6){
                    alert("密码长度不能小于6位数！");
                    return;
                }
                if(newPassword!=re_password){
                    alert("两次新密码输入不一致！请重新输入！");
                    return;
                }
                $().invoke("/admin/user/do/updatePasswd.q",{newPassword:newPassword,oldPassword:oldPassword}, function(re) {
                    if(re=="success"){
                        parent.window.location="/login/do/logout.q";
                        alert("密码修改成功！请重新登陆！");
                    } else{
                        alert("密码修改失败！");
                    }
                });
            });
        });
    </script>
</head>
<body>
<div>
    <img src="/images/homebg.jpg">
</div>
<div class="tipbg"></div>
<div class="tip" style="height:360px;display:none;">
    <div class="tiptop"><span>修改用户密码</span><a></a></div>
    <div style="padding-top:10px;">
        <ul class="forminfo" id="edit">
            <li><label>用户名<b>*</b></label>
                <input type="text" class="dfinput" disabled="disabled" value="<s:property value='#user.username'/> "/>
            </li>
            <li><label>真实姓名<b>*</b></label>
                <input type="text" class="dfinput" disabled="disabled" value="<s:property value='#user.name'/> "/>
            </li>
            <li><label>旧密码<b>*</b></label>
                <input type="password" class="dfinput" id="old_password" />
            </li>
            <li><label>新密码<b>*</b></label>
                <input type="password" class="dfinput" id="new_password"/>
            </li>
            <li><label>确认新密码<b>*</b></label>
                <input type="password" class="dfinput" id="re_password"/>
            </li>
            <li><label>&nbsp;</label><input id="updatePasswd" name="submit" type="submit" class="btn" value="提交信息"/></li>
        </ul>
    </div>
</div>
</body>
</html>