<!--
Created by Fly_m at 2008-5-16
成都捷众科技有限公司
-->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!-- 分页组件 -->
<s:if test="page.hasPreviousPage || page.hasNextPage">
	<div class="turnpage">
			<%-- 开头两个 --%>
		<s:url id="goto"><s:param name="page.currentPage" value="1"/></s:url>
		<s:a href="%{goto}" title="首页"><span class="ui-icon ui-icon-arrowthickstop-1-w"></span></s:a>
		<s:if test="page.hasPreviousPage">
			<s:url id="goto">
				<s:param name="page.currentPage" value="%{page.currentPage - 1}"/>
			</s:url>
		</s:if>
		<s:a href="%{goto}" title="上一页"><span class="ui-icon ui-icon-triangle-1-w"></span></s:a>
			<%-- 页面显示 --%>

		<s:if test="page.totalPage <= 6">
			<s:bean name="org.apache.struts2.util.Counter" id="counter">
				<s:param name="first" value="1"/>
				<s:param name="last" value="page.totalPage"/>
			</s:bean>
			<s:iterator value="#counter">
				<s:url id="goto"><s:param name="page.currentPage" value="top"/></s:url>
				<s:if test="top == page.currentPage"><a class="cur"><span><s:property/></span></a></s:if>
				<s:else><s:a href="%{goto}"><span><s:property/></span></s:a></s:else>
			</s:iterator>
		</s:if>
		<s:else>
			<s:bean name="org.apache.struts2.util.Counter" id="counter">
				<s:param name="first"
						 value="%{page.currentPage % 6 == 0 ? page.currentPage - 5 : page.currentPage / 6 * 6 + 1}"/>
				<s:param name="last"
						 value="%{page.currentPage % 6 == 0 ? page.currentPage : (page.currentPage / 6 * 6 + 6) < page.totalPage ? (page.currentPage / 6 * 6 + 6) : page.totalPage}"/>
			</s:bean>
			<s:iterator value="#counter">
				<s:url id="goto"><s:param name="page.currentPage" value="top"/></s:url>
				<s:if test="top == page.currentPage"><a class="cur"><span><s:property/></span></a></s:if>
				<s:else><s:a href="%{goto}"><span><s:property/></span></s:a></s:else>
			</s:iterator>
		</s:else>
			<%-- 结尾两个 --%>
		<s:url id="goto"><s:param name="page.currentPage" value="page.totalPage"/></s:url>
		<s:if test="page.hasNextPage">
			<s:url id="goto"><s:param name="page.currentPage" value="%{page.currentPage + 1}"/></s:url>
		</s:if>
		<s:a href="%{goto}" title="下一页"><span class="ui-icon ui-icon-triangle-1-e"></span></s:a>
		<s:url id="goto"><s:param name="page.currentPage" value="page.totalPage"/></s:url>
		<s:a href="%{goto}" title="尾页"><span class="ui-icon ui-icon-arrowthickstop-1-e"></span></s:a>&nbsp;&nbsp;
		页次:<s:property value="page.currentPage"/>/<s:property value="page.totalPage"/>&nbsp;&nbsp;
		每页:<s:property value="page.pageSize"/>条&nbsp;&nbsp;
		共计:<s:property value="page.totalCount"/>条&nbsp;&nbsp;
		<s:if test="page.totalPage <= 100">
			<s:bean name="org.apache.struts2.util.Counter" id="counter">
				<s:param name="first" value="1"/>
				<s:param name="last" value="page.totalPage"/>
			</s:bean>
			<select  onchange="window.location.href = this.options[this.selectedIndex].value;" size="1">
				<s:iterator value="#counter">
					<s:url id="goto"><s:param name="page.currentPage" value="top"/></s:url>
					<s:if test="top == page.currentPage">
						<option value="<s:property value="%{goto}"/>" selected="selected">第<s:property/>页</option>
					</s:if>
					<s:else>
						<option value="<s:property value="%{goto}"/>">第<s:property/>页</option>
					</s:else>
				</s:iterator>
			</select>
		</s:if>
	</div>
</s:if>