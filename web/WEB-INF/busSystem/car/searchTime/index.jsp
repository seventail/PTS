<%--
  Created by IntelliJ IDEA.
  User: CZJiang
  Date: 2015/12/28
  Time: 15:11
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
            $("#select_btn").click(function(){
                var num=$("#select_num").val();
                if(num==0){
                    alert("请选择查看天数！");
                    return;
                }
                $().invoke("/admin/searchTime/do/setSearchTime.q",{num:num},function(re){
                    if(re=="success"){
                        alert("时间设置成功！");
                        $(".tip").fadeOut(200);
                        $(".tipbg").hide();
                    }  else{
                        alert("时间设置失败！");
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
    <div class="tiptop"><span>车辆查询时间设置</span><a></a></div>
    <div style="padding-top:10px;">
        <ul class="forminfo" id="edit">
            <li><label><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*</b>从</label>
                <div class="vocation" style="float:left">
                    <select class="dfinput" style="width:230px;margin-bottom:20px;" id="select_num">
                        <option value="0">--请选择--</option>
                        <option value="1" <s:if test="num==1">selected="selected"</s:if>>1</option>
                        <option value="5" <s:if test="num==5">selected="selected"</s:if>>5</option>
                        <option value="10" <s:if test="num==10">selected="selected"</s:if>>10</option>
                        <option value="15" <s:if test="num==15">selected="selected"</s:if>>15</option>
                        <option value="20" <s:if test="num==20">selected="selected"</s:if>>20</option>
                        <option value="25" <s:if test="num==25">selected="selected"</s:if>>25</option>
                        <option value="30" <s:if test="num==30">selected="selected"</s:if>>30</option>
                        <option value="40" <s:if test="num==40">selected="selected"</s:if>>40</option>
                    </select>
                </div>
                <label>&nbsp;&nbsp;天前开始查看</label>
            </li>
            <li><label>&nbsp;</label><input id="select_btn" name="submit" type="submit" class="btn" value="提交信息"/></li>
        </ul>
    </div>
</div>
</body>
</html>

