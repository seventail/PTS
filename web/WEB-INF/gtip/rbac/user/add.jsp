<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<g:ajaxResult>
    <table>
        <tr>
            <td><input type="checkbox" name="pid" value="<s:property value="user.id"/> "/> </td>
            <td><s:property value="user.id"/></td>
            <td><s:property value="user.username"/></td>
            <td><s:property value="user.linkInfor.split(',')[0]"/></td>
            <td><s:property value="user.linkInfor.split(',')[1]"/></td>
            <td><s:property value="user.name"/></td>
            <td><s:if test="user.forbidFlag">是</s:if><s:else>否</s:else></td>
        </tr>
    </table>
</g:ajaxResult>