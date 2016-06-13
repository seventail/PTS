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
        <tr idx="<s:property value="station.id"/>" class="center wtr">
            <td><input type="checkbox" name="pid" value="<s:property value='station.id'/>"></td>
            <td><s:property value="station.id"/> </td>
            <td><s:property value="station.name"/></td>
            <td><s:property value="station.address"/></td>
            <td><s:property value="station.station_ip"/></td>
            <td><s:property value="station.station_port"/></td>
            <td><input onclick="perssion(<s:property value='station.id'/> )" class="perssion_button communication_test" name="submit" type="button" value="测 试"/></td>
        </tr>
    </table>
</g:ajaxResult>