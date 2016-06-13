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
    <ul class="forminfo">
        <li><label>自编号<b>*</b></label>
            <input disabled="disabled" name="station" type="text" class="dfinput"
                   value="<s:property value='carInfo.busNo'/>"  style="width:300px;"/></li>
        <li><label>车牌号<b>*</b></label>
            <input disabled="disabled" name="floor" type="text" class="dfinput"
                   value="<s:property value='carInfo.busPlate'/>"  style="width:300px;"/></li>
        <li><label>车辆类型<b>*</b></label>
            <input type="text" class="dfinput" name="editlx"
                   value="<s:property value='carInfo.lx'/>"  style="width:300px;"/></li>
        <li><label>品牌型号<b>*</b></label>
            <input type="text" class="dfinput" name="editjsBusType"
                   value="<s:property value='carInfo.jsBusType'/>"  style="width:300px;"/></li>
        <li><label>车队编号<b>*</b></label>
            <input type="text" class="dfinput" name="editbusCrewno"
                   value="<s:property value='carInfo.busCrewno'/>"  style="width:300px;"/></li>
        <li><input type="hidden" name="editcarInfoid" value="<s:property value='carInfo.id'/>"/> </li>
    </ul>
</g:ajaxResult>