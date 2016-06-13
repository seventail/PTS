<%--
  Created by IntelliJ IDEA.
  User: CZJiang
  Date: 15-10-26
  Time: 下午3:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="/css/sys.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/js/jquery.js"></script>
    <script type="text/javascript" src="/theme/greejoy.js"></script>
    <script type="text/javascript">
        $(function(){
            $(".tipbg").show();
            $(".tip").fadeIn(200);
            $(".tiptop a").click(function(){
                $(".tip").fadeOut(200);
                $(".tipbg").hide();
            });
            $("#binding_station").click(function(){
                var idx=$("#station_id").val();
                if(idx==0){
                    alert("请选择场站！");
                    return;
                }
                $().invoke("/admin/station/binding/do/bindingStation.q",{idx:idx},function(re){
                    if(re=="success"){
                        var frm=parent.document.getElementById("topFrame");
                        frm.src="/admin/login/index/do/getTop.q";
                        alert("绑定成功！");
                        $(".tip").fadeOut(200);
                        $(".tipbg").hide();
                    }  else{
                        alert("绑定失败！");
                    }
                });
            });
        });
    </script>
</head>
<body>
<div>
    <img src="/images/homebg.jpg">
</div>
<div class="tipbg"></div>
<div class="tip" style="height:200px;display:none;">
    <div class="tiptop"><span>场站绑定</span><a></a></div>
    <div style="padding-top:10px;">
        <ul class="forminfo" id="edit">
            <li><label>场站名称<b>*</b></label>
                <div class="vocation" style="float:left">
                    <select class="dfinput" style="width:230px;margin-bottom:20px;" id="station_id" name="station_id">
                        <option value="0">--请选择--</option>
                        <s:iterator value="#stationList">
                            <option <s:if test="#station.id==id">selected="selected"</s:if>value="<s:property value='id'/>"><s:property value="name"/></option>
                        </s:iterator>
                    </select>
                </div>
            </li>
            <li><label>&nbsp;</label><input id="binding_station" name="submit" type="submit" class="btn" value="提交信息"/></li>
        </ul>
    </div>
</div>
</body>
</html>