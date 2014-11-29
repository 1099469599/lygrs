<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 	<title>电话自动外呼系统</title>
	<link type="text/css" href="<c:url value='css/common.css?v=7'/>" rel="stylesheet" />
	<link type="text/css" href="<c:url value='css/layout.css?v=5'/>" rel="stylesheet" />

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 	<meta http-equiv="cache-control" content="no-cache"/>
 	<meta http-equiv="expires" content="0"/>
	<script type="text/javascript" src="<c:url value='js/jquery-1.11.1.min.js'/>"></script>
	<!-- 日期控件 start -->
    <link type="text/css" href="<c:url value='datePicker/skin/WdatePicker.css?v=1'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='datePicker/WdatePicker.js?v=1'/>"></script>
    <!-- 日期控件 end -->
 	<!-- jPage 分页插件 start -->
 	<link type="text/css" href="<c:url value='jPage/jPages.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='jPage/jPages.js'/>"></script>
 	<!-- jPage 分页插件  end -->
 	<script type="text/javascript" src="<c:url value='js/changeTabColor.js'/>"></script>
</head>
<body>
<div id="contentWrap">
	<h3 class="h3_title">来电客户资料信息&nbsp;</h3>
	<%-- 方便保存返回操作，回到客户资料管理页面 --%>
   	<form id="form1" name="form1" action="customer-query.action" method="post">
   		<input type="hidden" name="q_pino" value="${q_pino }"/>
   		<input type="hidden" name="q_caryear" value="${q_caryear }"/>
   		<input type="hidden" name="q_chuxcs" value="${q_chuxcs }"/>
   		<input type="hidden" name="q_chephm" value="${q_chephm }"/>
   		<input type="hidden" name="q_uname" value="${q_uname }"/>
   		<input type="hidden" name="q_mobile" value="${q_mobile }"/>
   		<input type="hidden" name="q_agtacc" value="${q_agtacc }"/>
   		<input type="hidden" id="pageflag" name="pageflag"/>
   	</form>
   	<div id="usual1" class="usual"> 
  		<div id="tab1" class="tabson" style="padding-left:20px;">
  			<form id="form2" name="form2" action="<c:url value='customer-saveTanpinInfo.action'/>" method="post">
  			<input type="hidden" name="cid" value="${cid }"/>
  			
			<div id="error_msg" class="error_msg"></div>
			
			<div class="formtitle"><span>车辆信息</span></div>
			<div class="queryDiv_n">
			   	<ul class="queryWrap_ul" style="padding-left:70px;">
					<li><label>车龄：</label><input type="text" id="caryearx" name="caryear" value="${caryear }" class="ipt50" maxlength="3"/></li>
			        <li><label>出险次数：</label><input type="text" id="chuxcsx" name="chuxcs" value="${chuxcs }" class="ipt50" maxlength="3"/></li>
			        <li><label>初登日期：</label><input type="text" name="chudrq" value="${fn:substring(chudrq,0,19) }" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate inputDefault" style="width:140px; height:20px" maxlength="22"/></li>
			        <li><label>保险到期：</label><input type="text" name="baoxdq" value="${fn:substring(baoxdq,0,19) }" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate inputDefault" style="width:140px; height:20px" maxlength="22"/></li>
				</ul>
			</div>
			<div class="queryDiv_n">
			   	<ul class="queryWrap_ul" style="padding-left:70px;">
					<li><label>厂牌号码：</label><input type="text" name="changphm" value="${changphm }" class="ipt100" maxlength="30"/></li>
			        <li><label>车牌号码：</label><input type="text" name="chephm" value="${chephm }" class="ipt100" maxlength="20"/></li>
			        <li><label>车架号：</label><input type="text" name="chejh" value="${chejh }" class="ipt100" maxlength="30"/></li>
			        <li><label>发动机编号：</label><input type="text" name="fadjbh" value="${fadjbh }" class="ipt100" maxlength="30"/></li>
				</ul>
			</div>
			<div class="formtitle"><span>客户信息</span></div>
			<div class="queryDiv_n">
			   	<ul class="queryWrap_ul" style="padding-left:70px;">
					<li><label>客户姓名：</label><input type="text" name="uname" value="${uname }" class="ipt100" maxlength="20"/></li>
			        <li><label>身份证号：</label><input type="text" id="idcardx" name="idcard" value="${idcard }" class="ipt155" maxlength="18"/></li>
				</ul>
			</div>
			<div class="queryDiv_n">
			   	<ul class="queryWrap_ul" style="padding-left:70px;">
					<li><label>手机：</label><input type="text" id="mobilex" name="mobile" value="${mobile }" maxlength="15" class="ipt100"/></li>
			        <li><label>家庭电话：</label><input type="text" id="hometelx" name="hometel" value="${hometel }" maxlength="15" class="ipt100"/></li>
			        <li><label>办公电话：</label><input type="text" id="officetelx" name="officetel" value="${officetel }" maxlength="15" class="ipt100"/></li>
				</ul>
			</div>
			<div class="queryDiv_n">
			   	<ul class="queryWrap_ul" style="padding-left:70px;">
					<li><label>派送地址：</label><input type="text" name="address" value="${address }"  maxlength="100" class="ipt500"/></li>
				</ul>
			</div>
			<div class="queryDiv_n">
			   	<ul class="queryWrap_ul" style="padding-left:70px;">
					<li><label style="vertical-align:top;">备注信息：</label><textarea name="noteinfo" class="ipt_area_w300">${noteinfo }</textarea></li>
				</ul>
			</div>
			<div class="queryDiv_n">
			   	<ul class="queryWrap_ul" style="padding-left:70px;">
					<li><label style="vertical-align:top;">来电记录：</label><textarea name="laidjl" class="ipt_area_w300">${laidjl }</textarea></li>
				</ul>
			</div>
			<div class="queryDiv_n">
			   	<ul class="queryWrap_ul_w600 left">
			        <li style="padding-left:150px"><input type="button" onclick="saveTanpinBtn()" value="保&nbsp;&nbsp;存" class="btn4"/></li>
			        <li style="padding-left:50px"><input type="button" onclick="document.form1.submit()" value="返&nbsp;&nbsp;回" class="btn4"/></li>
				</ul>
				<ul class="queryWrap_ul_w100 right">
			        <li>
			        </li>
				</ul>
			</div>
			</form>
  		</div>
  	</div>
	
</div>

<!-- layer 弹出插件 start -->
<script type="text/javascript" src="<c:url value='layer/layer.min.js'/>"></script>
<!-- layer 弹出插件 end -->
<!--POP PLAYER START-->
<div id="popMusicDiv" style="display:none;"></div>
<!--POP PLAYER END-->
<script type="text/javascript" src="<c:url value='js/jquery.form-3.46.0.js?v=5'/>"></script>
<script type="text/javascript" src="<c:url value='js/cts.js?v=2'/>"></script>
<script type="text/javascript" src="<c:url value='js/customer_info.js?v=14'/>"></script>
</body>
</html>