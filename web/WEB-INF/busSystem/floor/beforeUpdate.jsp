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
    <ul class="forminfo">
        <li><label>场站名称<b>*</b></label>
            <input disabled="disabled" name="station" type="text" class="dfinput"
                   value="<s:property value='floor.station.name'/>"  style="width:300px;"/></li>
        <li><label>楼层<b>*</b></label>
            <input disabled="disabled" name="floor" type="text" class="dfinput"
                   value="<s:property value='floor.floor_num'/>"  style="width:300px;"/> 楼</li>
        <li><label>总停车位<b>*</b></label>
            <input type="text" class="dfinput" name="editlot"
                   value="<s:property value='floor.parking_lot'/>"  style="width:300px;"/> 个 </li>
        <li><input type="hidden" name="editfloorid" value="<s:property value='floor.id'/>"/> </li>
        <li><label>&nbsp;</label><input onclick="editFloor()" name="submit" type="submit" class="btn" value="保存修改"/></li>
    </ul>
</g:ajaxResult>