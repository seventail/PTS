<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 时间查询选择器 start-->
<script type="text/javascript">
	$(function() {
		$("#startDate,#endDate").datepicker();
		$("#queryDiv").dialog({modal:true, autoOpen:false, buttons:{
			"查询":function() {
				var startV = $("#startDate").val();
				var endV = $("#endDate").val();
				if(startV || endV) {
					var url = window.self.location.href;
					if(url.indexOf("?") == -1)
						url += "?_x=1";
					//去掉先前的参数
					url = url.replace(/dateRange\.startDate=[^&]*/, "");
					url = url.replace(/dateRange\.endDate=[^&]*/, "");
					url += "&dateRange.startDate=" + startV + "&dateRange.endDate=" + endV;
					window.self.location.href = url;
				}
				$(this).dialog("close");
			}
		}});

		$("#search").click(function() {
			$("#queryDiv").dialog("open");
		});
	});
</script>
<div id="queryDiv">
	开始时间:<input id="startDate" name="dateRange.startDate"/><br/>
	结束时间:<input id="endDate" name="dateRange.endDate"/>
</div>
<!-- 时间查询选择器 end-->
