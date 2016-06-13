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
            $("#about").click(function(){
                $(".tip").fadeOut(200);
                $(".tipbg").hide();
            })
        });
    </script>
</head>
<body>
<div>
    <img src="/images/homebg.jpg">
</div>
<div class="tipbg"></div>
<div class="tip" style="height:360px;display:none;">
    <div class="tiptop"><span>关于</span><a></a></div>
    <div style="padding-top:10px;">
        <ul class="forminfo" id="edit">
            <li><b style="font-size:16px;"><s:text name="project.name"/></b></li>
            <li><label>版本:</label><s:text name="project.version"/></li>
            <li><label>公司:</label>成都捷众科技有限公司</li>
            <li><label>网址:</label><a href="http://www.greejoy.com" target="_blank">www.greejoy.com</a></li>
            <li><label>电话:</label>028-84391238</li>
            <li><label>邮件:</label><a href="mailto:greejoy@126.com">greejoy@126.com</a></li>
            <li>&copy;2009 Greejoy. All rights reserved.</li>
            <li><label>&nbsp;</label><input id="about" name="submit" type="submit" class="btn" value="确定"/></li>
        </ul>
    </div>
</div>
</body>
</html>