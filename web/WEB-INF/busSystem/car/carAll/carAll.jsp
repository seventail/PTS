<%--
  Created by IntelliJ IDEA.
  User: CZJiang
  Date: 15-10-26
  Time: 下午9:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="g" uri="/gtip-tag" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<link href="/css/sys.css" rel="stylesheet" type="text/css" />
<link href="/css/select.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript" src="/js/select-ui.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(e) {
    $(".select1").uedSelect({
		width : 100
	});
	var boxWidth = $(".carsAllInfor").width()/2;
	//$(".carSearch").width($(".carsAllInfor").width()-2);
	//$(".carsF").width(boxWidth-7);
	//alert(boxWidth);
    });
</script>

</head>

<body style="min-width:1000px;">
<div class="place">
	<span>位置：</span>
	<ul class="placeul">
		<li><a href="#">首页</a></li>
		<li><a href="#">车位查询</a></li>
		<li><a href="#">车位总体情况</a></li>
	</ul>
</div>
<div class="rightinfo">
	<div class="height10"></div>
	<div class="carsAllInfor">
        <s:iterator value="carFloorList">
            <div class="carsF">
			<ul class="carsFTibg">
				<li class="carFTitle"><s:property value="floor_num"/> 楼停车情况</li>
				<li class="carFMore"><a href ="/admin/car/carFloor/do/carFloor.q?floor_num=<s:property value="floor_num"/>">详情>></a></li>
			</ul>
			<ul class="carsFInfo">
				<li><p>总停车位</p><span><s:property value="parking_lot"/><i>个</i></span></li>
				<li><p>已占用车位</p><span class="red"><s:property value="occupySeats"/><i>个</i></span></li>
				<li><p>未占用车位</p><span class="green"><s:property value="leftseats"/><i>个</i></span></li>
			</ul>
			<ul class="carsFLoad"><span style="width:<s:property value='percent'/>%; background:
			    <s:if test="percent>75">#ec9b6c</s:if><s:elseif test="percent>50">#b4d1d9</s:elseif>
			    <s:elseif test="percent>25">#78bc59</s:elseif><s:else>#78bc59</s:else> "></span></ul>
		</div>
        </s:iterator>

	</div>
</div>
</body>
</html>
