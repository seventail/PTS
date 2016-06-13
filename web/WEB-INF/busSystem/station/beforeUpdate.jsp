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
    <ul class="forminfo" id="edit">
        <li><label>场站名称<b>*</b></label><input id="nameedit" name="parkname" type="text" class="dfinput" value="<s:property value='station.name'/>"  style="width:218px;"/></li>
        <li><label>场站地址<b>*</b></label><input id="addredit"name="parkaddr" type="text" class="dfinput" value="<s:property value='station.address'/>"  style="width:218px;"/></li>
        <li><label>IP地址<b>*</b></label><input id="ipedit" name="parkIP" type="text" class="dfinput" value="<s:property value='station.station_ip'/>"  style="width:218px;"/> </li>
        <li><label>端口<b>*</b></label><input id="portedit" name="parkDK" type="text" class="dfinput" value="<s:property value='station.station_port'/>"  style="width:218px;"/> </li>
        <li><input id="station_id" type="hidden" value="<s:property value='station.id'/>"/>  </li>
        <li><label>&nbsp;</label><input onclick="editStation()" class="btn" name="submit" type="button" value="提交信息"/>&nbsp;&nbsp;&nbsp;<input onclick="communication()" type="button" class="btn_1" value="通讯测试"/></li>
    </ul>
</g:ajaxResult>