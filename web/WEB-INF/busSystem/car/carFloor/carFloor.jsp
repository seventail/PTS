<%--
  Created by IntelliJ IDEA.
  User: CZJiang
  Date: 15-10-26
  Time: 下午9:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="/css/sys.css" rel="stylesheet" type="text/css" />
    <link href="/css/floor.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/js/jquery.js"></script>
    <script type="text/javascript" src="/js/jquery.idTabs.min.js"></script>
    <script type="text/javascript" src="/theme/greejoy.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $(".tiptopadd a").click(function(){
                $(".tipadd").fadeOut(200);
                $(".tipbg").hide();
            });
            $("#addId").click(function(){
                var place=$("#select_place").val();
                var controllerId=$("#zone_id").val();
                var address=$("#select_id").val();
                if(controllerId==0){
                    alert("请选择控制器！");
                    return;
                }
                if(controllerId<10){
                    controllerId="0"+controllerId;
                }
                if(address<10){
                    address="0"+address;
                }
                var itemNo=controllerId+address;
                $().invoke("/admin/car/detector/do/add.q", {place:place,itemNo:itemNo}, function (re) {
                    if(re=="true"){
                        alert("绑定成功！");
                        $("."+place).attr('style','background:#FF0000');
                        $("."+place).attr("href","javascript:showTip('"+place+"','"+itemNo+"')");
                    }else if(re=="false"){
                        alert("绑定成功！");
                        $("."+place).attr('style','background:#66DD00');
                        $("."+place).attr("href","javascript:showTip('"+place+"','"+itemNo+"')");
                    }else{
                        alert("绑定失败！");
                    }
                    $(".tipadd").fadeOut(200);
                    $(".tipbg").hide();
                });
            });
            $("#zone_id").live("change", function() {
                var zone = $(this).val();
                var floor_num=$("#floor_num").val();
                $().invoke("/admin/car/detector/do/getItemByZone.q", {floor_num:floor_num,zone:zone}, function(re) {
                    $("#select_id option").remove();
                    $(re).each(function(i, k) {
                        if(k.specialNum!=4){
                            $("#select_id").append("<option value=" + k + ">" + k + "</option>");
                        }
                    })

                })
            });
            $("#usual1 ul").idTabs();
        });
        function showTip(place,itemNo){
            var controllerId=itemNo.substring(0,2);
            var address=itemNo.substring(2,4);
            $("#select_place").val(place);
            $("#zone").val(controllerId);
            $("#itemNo").val(address);
            $(".tipbg").show();
            $(".tipadd").fadeIn(200);
        }
    </script>

</head>

<body style="min-width:1100px;">
<div class="place">
    <span>位置：</span>
    <ul class="placeul">
        <li><a href="carFloor.jsp#">首页</a></li>
        <li><a href="carFloor.jsp#">车位查询</a></li>
        <li><a href="carFloor.jsp#">楼层车位情况</a></li>
    </ul>
</div>
<div class="formbody">
    <div id="usual1" class="usual">
        <div class="itab">
            <ul>
                <s:iterator value="#floorList">
                    <li style="<s:if test="#carFloor.floor_num==floor_num">background:#5782FF</s:if>">
                        <a href ="/admin/car/carFloor/do/carFloor.q?floor_num=<s:property value="floor_num"/>">
                            <s:property value="floor_num"/> 楼</a></li>
                </s:iterator>
            </ul>
        </div>
    </div>
    <div id="tab1" class="tabson">
        <div class="tabCarLeftAll">
            <div class="tabCarLeft">
                <s:iterator value="#detectorList" status="str">
                    <a class="<s:property value='place'/>"
                       style="background:<s:if test='itemNo!=null'><s:if test='occupied'>#FF0000</s:if>
                                <s:else>#66DD00</s:else></s:if><s:else>#000000;opacity:0;filter:alpha(opacity=0); </s:else>"
                       href="javascript:showTip('<s:property value="place"/>','<s:property value="itemNo"/>' )">
                    </a>
                </s:iterator>
                <img src="/images/<s:property value='#carFloor.floor_num'/>lou.jpg" border="0"/>
            </div>
            <div class="tabCarZBH">
                <s:iterator value="list" id="id">
                    <ul>自编号：<s:property value="#id"/> </ul>
                </s:iterator>
            </div>
        </div>
        <div class="tabCarRight">
            <div class="circle" style="background:#5782FF;">
                <div class="pie_left"><div class="left" style="-webkit-transform:
				    rotate(<s:if test='#carFloor.percent>50'><s:property value="#carFloor.percent*3.6-180"/></s:if>deg);transform:
				    rotate(<s:if test='#carFloor.percent>50'><s:property value="#carFloor.percent*3.6-180"/></s:if>deg);">
                </div></div>
                <div class="pie_right"><div class="right" style="-webkit-transform:
				    rotate(<s:if test='#carFloor.percent>=50'>180</s:if><s:else><s:property value="#carFloor.percent*3.6"/></s:else>deg);transform:
				    rotate(<s:if test='#carFloor.percent>=50'>180</s:if><s:else><s:property value="#carFloor.percent*3.6"/></s:else>deg); ">
                </div></div>
                <div class="mask"><span style="font-size:24px;"><s:property value="#carFloor.percent"/></span></div>
            </div>
            <div class="carFloorInfor">
                <ul class="FITitle">总停车位</ul>
                <ul class="FINum"><s:property value="#carFloor.parking_lot"/><i>个</i></ul>
                <ul class="FITitle">已占用车位</ul>
                <ul class="FINum red"><s:property value="#carFloor.occupySeats"/><i>个</i></ul>
                <ul class="FITitle">未占用车位</ul>
                <ul class="FINum green"><s:property value="#carFloor.leftseats"/><i>个</i></ul>
            </div>
        </div>
    </div>
    <div id="tab2" class="tabson">2</div>
    <div id="tab3" class="tabson">3</div>
    <div id="tab4" class="tabson">4</div>
    <div id="tab5" class="tabson">5</div>
    <div id="tab6" class="tabson">6</div>
</div>
<div class="tipbg"></div>
<div class="tipadd" style="height:250px;display:none;">
    <div class="tiptopadd"><span>探头绑定</span><a></a></div>
    <div style="padding-top:10px;">
        <ul class="forminfo" id="add">
            <li><label>绑定控制器</label>
                <input type="text" disabled="disabled" style="width:96px" id="zone" class="dfinput" value=""/>
                探头编号
                <input type="text" disabled="disabled" style="width:96px" id="itemNo" class="dfinput" value=""/>
            </li>
            <li><label>控制器<b>*</b></label>
                <div class="vocation" style="float:left">
                    <select class="dfinput" id="zone_id" name="station_id" style="width:252px;margin-bottom:20px;">
                        <option value="0">--请选择--</option>
                        <s:iterator value="#controllerList" status="str">
                            <option value="<s:property value='#controllerList.get(#str.index)'/>"><s:property value='#controllerList.get(#str.index)'/></option>
                        </s:iterator>
                    </select>
                </div>
            </li>
            <li><label>探头编号<b>*</b></label>
                <div class="vocation" style="float:left">
                    <select class="dfinput" id="select_id" name="station_id" style="width:252px;margin-bottom:20px;">
                        <option value="0">--请选择--</option>
                    </select>
                </div>
            </li>
            <input type="hidden" id="select_place" value=""/>
            <input type="hidden" id="floor_num" value="<s:property value='#carFloor.floor_num'/>"/>
            <li><label>&nbsp;</label><input name="submit" type="submit" id="addId" class="btn" value="提交信息"/></li>
        </ul>
    </div>
</div>
</body>
</html>
