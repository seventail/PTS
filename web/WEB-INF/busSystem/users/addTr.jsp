<%--
  Created by IntelliJ IDEA.
  User: CZJiang
  Date: 15-10-9
  Time: 下午2:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<g:ajaxResult>
    <table>
       <tr idx="<s:property value="users.id"/>" class="center wtr">
           <td><input type="checkbox" name="pid" value="<s:property value='users.id'/>"></td>
           <td><s:property value="users.id"/> </td>
           <td><s:property value="users.name"/></td>
           <td><s:property value="users.real_name"/></td>
           <td><s:property value="users.phone"/> </td>
       </tr>
    </table>
</g:ajaxResult>