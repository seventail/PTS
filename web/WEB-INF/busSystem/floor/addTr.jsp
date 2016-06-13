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
       <tr idx="<s:property value="floor.id"/>" class="center wtr">
           <td><input type="checkbox" name="pid" class="subCheckbox" value="<s:property value='floor.id'/>"></td>
           <td><s:property value='floor.id'/></td>
           <td><s:property value="floor.station.name"/> </td>
           <td><s:property value="floor.floor_num"/></td>
           <td><s:property value="floor.parking_lot"/></td>
       </tr>
    </table>
</g:ajaxResult>