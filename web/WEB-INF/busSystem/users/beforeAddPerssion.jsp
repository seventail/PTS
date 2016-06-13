<%--
  Created by IntelliJ IDEA.
  User: CZJiang
  Date: 15-10-13
  Time: 下午2:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<g:ajaxResult>
    <table>
        <s:iterator value="#stationList" id="u">
            <tr class="center">
                <td>
                <input type="checkbox" name="floor_id" class="subCheckbox" value="<s:property value='id'/>"/>
                <s:property value="name"/>
                <s:iterator value="floorList">
                    <tr>
                        <td>
                        <input type="checkbox" name="" value="<s:property value='id'/>"/>
                        <s:property value="floor_num"/> 楼  </td>
                    </tr>
                </s:iterator>
                </td>
            </tr>
        </s:iterator>
    </table>
</g:ajaxResult>