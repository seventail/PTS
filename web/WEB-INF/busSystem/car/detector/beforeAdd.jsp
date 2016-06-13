<%--
  Created by IntelliJ IDEA.
  User: CZJiang
  Date: 15-10-27
  Time: 上午10:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<g:ajaxResult>
    <ul class="forminfo" id="add">
        <li><label>所属区域<b>*</b></label>
            <div class="vocation" style="float:left">
                <select class="dfinput" id="zone_id" name="station_id" style="width:252px;margin-bottom:20px;">
                    <option value="0">--请选择--</option>
                    <s:iterator value="#zoneList">
                        <option value="<s:property value='zone_num'/>"><s:property value="zone_num"/></option>
                    </s:iterator>
                </select>
            </div>
            </li>
        <li><label>探头编号<b>*</b></label>
            <div class="vocation" style="float:left">
                <select class="select1" name="station_id">
                    <option value="0">--请选择--</option>
                    <s:iterator value="#detectorList">
                        <option value="<s:property value='ItemNo'/>"><s:property value="ItemNo"/></option>
                    </s:iterator>
                </select>
            </div>
        </li>
        <li>
            <input type="hidden" name="place" value="<s:property value='place'/>">
        </li>
        <li><label>&nbsp;</label><input name="submit" type="submit" id="detectoradd" class="btn" value="提交信息"/></li>
    </ul>
</g:ajaxResult>