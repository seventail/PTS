<%--
  Created by IntelliJ IDEA.
  User: CZJiang
  Date: 15-10-26
  Time: 下午9:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="/css/sys.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/theme/My97DatePicker/skin/WdatePicker.css">
    <script type="text/javascript" src="/js/jquery.js"></script>
    <script type="text/javascript" src="/theme/greejoy.js"></script>
    <script type="text/javascript" src="/theme/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript">
        $(document).ready(function(e) {
            $(".date").click(function(){
                WdatePicker({dateFmt:'yyyy-MM-dd', isShowClear:true,readOnly:true});
            });
        });
    </script>
</head>

<body>
<div class="place">
    <span>位置：</span>
    <ul class="placeul">
        <li><a href="#">首页</a></li>
        <li><a href="#">报表统计</a></li>
        <li><a href="#">统计信息</a></li>
    </ul>
</div>

<div class="rightinfo" style="text-align:center;">
    <ul class="carSearch">
        <form action="/admin/chart/do/statistical.q" method="get">
            <li class="carSearchTi">年份</li>
            <li class="carSearchIn"><div>
                <select class="dfinput" name="year" style="width:110px;">
                    <option value="0">--请选择--</option>
                    <s:iterator value="#yearList" id="id">
                        <option <s:if test="year==#id">selected="selected"</s:if> value="<s:property value='#id'/>"> <s:property value="#id"/> 年</option>
                    </s:iterator>
                </select>
            <li class="carSearchTi">月份</li>
            <li class="carSearchIn"><div>
                <select class="dfinput" name="month" style="width:110px;">
                    <option value="0">--请选择--</option>
                    <option <s:if test="month==1">selected="selected"</s:if> value="1"> 1 月</option>
                    <option <s:if test="month==2">selected="selected"</s:if> value="2"> 2 月</option>
                    <option <s:if test="month==3">selected="selected"</s:if> value="3"> 3 月</option>
                    <option <s:if test="month==4">selected="selected"</s:if> value="4"> 4 月</option>
                    <option <s:if test="month==5">selected="selected"</s:if> value="5"> 5 月</option>
                    <option <s:if test="month==6">selected="selected"</s:if> value="6"> 6 月</option>
                    <option <s:if test="month==7">selected="selected"</s:if> value="7"> 7 月</option>
                    <option <s:if test="month==8">selected="selected"</s:if> value="8"> 8 月</option>
                    <option <s:if test="month==9">selected="selected"</s:if> value="9"> 9 月</option>
                    <option <s:if test="month==10">selected="selected"</s:if> value="10"> 10 月</option>
                    <option <s:if test="month==11">selected="selected"</s:if> value="11"> 11 月</option>
                    <option <s:if test="month==12">selected="selected"</s:if> value="12"> 12 月</option>
                </select>
            </div></li>
            <li class="carSearchTi">楼层</li>
            <li class="carSearchIn">
                <div>
                    <select class="dfinput" name="floor_num" style="width:110px">
                        <option value="0">--请选择--</option>
                        <s:iterator value="#floorList" id="id">
                            <option <s:if test="floor_num==#id">selected="selected"</s:if> value="<s:property value='#id'/>"> <s:property value="#id"/> 楼</option>
                        </s:iterator>
                    </select>
                </div>
            </li>
            <li class="carSearchIn"><input type="submit" class="scbtn" value="查询"/></li>
        </form>
    </ul>
    <img src="/images/company/<s:property value='imgName'/>.png"/>
</div>

</body>
</html>