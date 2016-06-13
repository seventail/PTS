<%--
  Created by IntelliJ IDEA.
  User: CZJiang
  Date: 15-10-21
  Time: 下午9:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Simple jsp page</title></head>
<body>
<form action="" name="addItem" id="addUserForm" title="添加用户">
    <label>用户名：</label><input type="text" name="user.username" class="required" maxlength="50"><br>
    <label>密码：</label><input type="password" name="user.password" id="password" class="required" maxlength="50"
                             minlength="6" tip="至少六位"><br>
    <label>确认密码：</label><input type="password" name="repassword" class="required" equalTo="#password" maxlength="50"
                               minlength="6"><br>
    <label>真实姓名：</label><input type="text" name="user.name" class="required" maxlength="50"><br>
    <label>联系方式：</label><input type="text" name="user.linkInfor" maxlength="50"><br>
    <label>是否禁用：</label><input name="user.forbidFlag" value="true" type="radio">是&nbsp;
    <input name="user.forbidFlag" type="radio" value="false" checked="checked">否<br>
    <label>能否创建用户：</label><input name="user.createFlag" type="radio" value="true" checked="checked">是&nbsp;
    <input name="user.createFlag" type="radio" value="false">否<br>
</form>
</body>
</html>