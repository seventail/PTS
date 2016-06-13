<%--
  Created by IntelliJ IDEA.
  User: CZJiang
  Date: 15-10-9
  Time: 下午4:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<g:ajaxResult>
    <table>
        <tr class="center">
            <td>用户名</td>
            <td><input name="users.name" type="text" value="<s:property value="users.name"/>"/></td>
        </tr>
        <tr class="center">
            <td>真实姓名</td>
            <td><input name="users.real_name" type="text" value="<s:property value="users.real_name"/>"/></td>
        </tr>
        <tr class="center">
            <td>联系电话</td>
            <td><input type="text" name="users.phone" value="<s:property value="users.phone"/>"/></td>
        </tr>
        <tr><input value="<s:property value="users.id"/>" name="idx" type="hidden"/></tr>
    </table>
</g:ajaxResult>