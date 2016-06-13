<%--
  Created by IntelliJ IDEA.
  User: CZJiang
  Date: 15-11-16
  Time: 上午9:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<g:ajaxResult>
    <table class="tablelist">
        <tbody>
        <tr>
            <td><input type="checkbox" name="pid" value="<s:property value='carInfo.id'/>"></td>
            <td><s:property value="carInfo.id"/> </td>
            <td><s:property value="carInfo.busNo"/></td>
            <td><s:property value="carInfo.busPlate"/></td>
            <td><s:property value="carInfo.lx"/></td>
            <td><s:property value="carInfo.jsBusType"/></td>
            <td><s:property value="carInfo.busCrewno"/></td>
        </tr>
        </tbody>
    </table>
</g:ajaxResult>