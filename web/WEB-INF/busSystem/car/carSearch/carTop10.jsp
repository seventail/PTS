<%--
  Created by IntelliJ IDEA.
  User: CZJiang
  Date: 15-11-7
  Time: 下午8:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<g:ajaxResult>
    <table class="manage-table">
        <s:iterator value="#carStopInfoList" status="str">
            <tr>
                <td><s:property value="#str.index+1"/></td>
                <td><s:property value="plateNo" /></td>
                <td><s:property value="floor_num" /></td>
                <td><s:property value="stopTime" /> 小时</td>
                <td><s:date name="startDate" format="yyyy-MM-dd HH:mm:ss" /></td>
                <td><s:date name="outDate" format="yyyy-MM-dd HH:mm:ss"/></td>
            </tr>
        </s:iterator>
    </table>
</g:ajaxResult>
