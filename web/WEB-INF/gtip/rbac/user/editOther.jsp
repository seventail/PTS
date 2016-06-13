<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<g:ajaxResult>
    <ul class="forminfo" id="edit">
        <li><label>用户名<b>*</b></label><input type="text" class="dfinput" name="user.username" maxlength="50" disabled="disabled" value="<s:property value="user.username"/>"></li>
        <li><label>真实姓名<b>*</b></label><input type="text" class="dfinput" name="user.name" maxlength="50" value="<s:property value="user.name"/>"></li>
        <li><label>手机<b>*</b></label><input type="text" class="dfinput" name="link" maxlength="50" value="<s:property value="user.linkInfor.split(',')[0]"/>"></li>
        <li><label>座机<b>*</b></label><input type="text" class="dfinput" name="telphone" maxlength="50" value="<s:property value="user.linkInfor.split(',')[1]"/>"></li>
        <li><input type="hidden" name="idx" value="<s:property value="user.id"/>"></li>
        <li><input type="hidden" name="user.linkInfor" value=""></li>
        <li><label>&nbsp;</label><input onclick="editUser()" class="editUserId btn" name="submit" type="button" value="提交信息"/></li>
    </ul>
</g:ajaxResult>