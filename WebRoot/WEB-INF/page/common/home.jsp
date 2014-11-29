<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>电话自动外呼系统</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link type="text/css" href="<c:url value='css/common.css'/>" rel="stylesheet" />
	<link type="text/css" href="<c:url value='css/layout.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='js/jquery-1.11.1.min.js'/>"></script>
	<!-- menu plugin start -->
	<link type="text/css" href="<c:url value='css/menu.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='js/menu.js?v=8'/>"></script>
	<!-- menu plugin end -->
	<style type="text/css">
		#zuojifenji{width:100px; height:280px; top:200px; border-radius:4px; background:#bbff77; right:20px; border:1px solid #3B9FFF; position:fixed;}
		.com-ask-float-block0{cursor:pointer; border:0px; bottom:124px; min-width:40px; height:30px; width:65px; margin:0px; padding:0px; position:fixed; right:40px; border-radius:0; line-height:16px; font-weight:bold; color:#fff; text-align:center; line-height:28px;}
		.com-ask-float-block{cursor: pointer; border: 0px; bottom: 124px; min-width: 40px; height: 30px; width: 60px; margin: 0px; padding: 0px; position: fixed; right: 40px; border-radius: 0; line-height: 16px; font-weight:bold; color: #fff; text-align:center; line-height:28px; background:url(images/common_float_telbg1.jpg);}
		.com-ask-float-block:hover{ cursor:pointer; border:0px; bottom:124px; min-width:40px; height:30px; width:60px; margin:0px; padding:0px; position:fixed; right:40px; border-radius:0; line-height:16px; font-weight:bold; color:#fff; text-align:center; line-height:28px; background:url(images/common_float_telbg.jpg);}
		.bohaopan-fix{display:none; width:200px; height:280px; top:200px; border-radius:4px; background:#E0EEFB; right:130px;border:1px solid #3B9FFF; position:fixed;}
	</style>
	<!--[if IE 6]>
	<style type="text/css">
		html{overflow:hidden}
		body{height:100%;overflow:auto}
		#zuojifenji{position:absolute; _top:200px; }
		.bohaopan-fix{position:absolute; _top:200px;}
		.com-ask-float-block0{position:absolute; _top:0px;}
		.com-ask-float-block{position:absolute;_top:2px;}
		.bohao1{position:absolute; _top:277px;}
		.bohao2{position:absolute; _top:317px;}
		.bohao3{position:absolute; _top:357px;}
		.bohao4{position:absolute; _top:497px;}
		.bohao5{position:absolute; _top:537px;}
	</style>
	<![endif]-->
</head>
<body>
<div id="container">
<a id="popHuifang" target="mainFrame"></a>
	<!-- header -->
  	<div id="header">
  		<div class="tit1"><s:property value="#application.vta.product"/></div>
  		<div class="tit2"><s:property value="#application.vta.customer"/>
  			<!-- js 客户端测试 -->
  			<!-- 
  			<input type="button" onclick="js_detectcall('callin','ani=808;dnis=10086;param=a,1,1;')" value="测试弹屏"/>
  			<input type="button" onclick="js_monitor_acdgrp('5,933300,呼叫,0,0,0,0.00%,0/0')" value="测试业务组监控"/>
  			<input type="button" onclick="js_seat_minitor('0,正常,来电,*9000#,agt000')" value="测试分机监控"/>
  			<input id="button1" type="button" value="Button" onclick="changeOCX()"/>
  			-->
			<object id="OCXPlugin" classid="clsid:9730588D-7548-42E8-8779-F98D76A2A09E" width="0" height="0"></object>
  		</div>
  		<div class="tit3"><s:property value="#application.vta.provider"/></div>
    </div>
    <!-- nav -->
  	<div id="nav">
    	<div class="nav_left">
    		<div class="nav_left_wel">
    		<span>欢迎：&nbsp;<s:property value="#session.vts.roleName"/></span><span><s:property value="#session.vts.username"/></span>
    		</div>
    		<div id="navigate" class="nav_left_path">
    			<span id="calling_num" class="calling_num"></span>
    		</div>
        </div>
        <div class="nav_right">
            <span><a class="menu_righta" href="javascript:showUpdatePwdDiv()" id="bt">修改密码</a></span>
            <span><a class="menu_righta" href="javascript:logout()">[&nbsp;注销&nbsp;]</a></span>
            <c:if test="${sessionScope.vts.roleID eq 1 }">
            <span><a class="menu_righta" href="javascript:viewOCXLog()">查看日志</a></span>
            </c:if>
        </div>
    </div>
    <!-- main -->
  	<div id="main">
    	<div class="main_left">
            <ul class="menu">
                <s:property value="#application.vta.getMenuInfoByRoleID(#session.vts.roleID, #session.vts.account)" escape="false"/>
            </ul>
        </div>
        <div class="main_right">
            <iframe id="mainFrame" name="mainFrame" src="main.jsp" class="mainFrame" scrolling="no" marginwidth="1" marginheight="1" frameborder="0">
        		
            </iframe>
        </div>
        <div class="clear"></div>
  	</div>
  	<!-- footer -->
  	<div id="footer">
        <p>
        <a href="#">设为首页</a>&nbsp;|&nbsp;
        <a href="#">收藏本站</a>&nbsp;|&nbsp;
        <a href="#">联系我们</a>&nbsp;|&nbsp;
        <a href="#">帮助中心</a>&nbsp;|&nbsp;
        <a href="#">常见问题</a>
        <!-- 记录js分页当前页码 start -->
        <input type="hidden" id="curTaskPage" value="1"/>
        <input type="hidden" id="curTelnumPage" value="1"/>
        <input type="hidden" id="curAcdPage" value="1"/>
        <input type="hidden" id="curAgentPage" value="1"/>
        <input type="hidden" id="curSubtelPage" value="1"/>
        <input type="hidden" id="curBlackPage" value="1"/>
        
        <%-- 客户资料导入及分配页面当前页 --%>
        <input type="hidden" id="curCusImportPage" value="1"/>
        <%-- 客户资料管理页面当前页 --%>
        <input type="hidden" id="curCusManagePage" value="1"/>
        <!-- 记录js分页当前页码 end -->
        </p>
        <span>Copyright @ 2005-2014 All Rights Reserved 版权所有 · 南京威帝通讯科技有限公司&nbsp;&nbsp;V141125</span>
        <!--
        <div id="ocxLog" style="font-size:12px; text-align:left; text-indent:10px;">vtcx log</div>
        -->
    </div>
    <!-- print window -->
	<div style="height:0px;">
	<iframe id="printFrame" name="printFrame" scrolling="no" width="1024" height="0" marginwidth="0" marginheight="0" frameborder="0" ></iframe>
	</div>
</div>

<!--POP UPDATEPASS START-->
<div id="popDiv" style="display:none;"> 
	<form id="form1" action="<c:url value='/user-updatePwd.action'/>" method="post" onsubmit="return validatePwdinput(this)">
    <div class="lab_ipt_item">
    	<span class="lab120">账号：</span>
        <div class="ipt-box">
        	<label><s:property value="#session.vts.account"/></label>
        </div>
    </div>
    <div class="lab_ipt_item">
    	<span class="lab120">原密码：</span>
        <div class="ipt-box">
        	<input type="text" id="oldpwdx" name="oldpwd" class="ipt_text_w150 inputDefault" />
            <span class="asterisk">*</span>
        </div>
    </div>
    <div class="lab_ipt_item" id="ywtype">
    	<span class="lab120">新密码：</span>
        <div class="ipt-box">
        	<input type="password" id="newpwdx" name="newpwd" class="ipt_text_w150 inputDefault" />
            <span class="asterisk">*</span>
        </div>
    </div>
    <div class="lab_ipt_item" id="whnum">
    	<span class="lab120">确认密码：</span>
        <div class="ipt-box">
        	<input type="password" id="repwdx" class="ipt_text_w150 inputDefault" />
            <span class="asterisk">*</span>
        </div>
    </div>
	<div class="lab_ipt_item">
		<span class="lab120"></span>
		<div class="ipt-box"><input type="submit" class="btn4" value="确定"/></div>
		<div class="ipt-box" style="margin-left:20px;"><input type="button" class="btn4" value="取消" onclick="layer.closeAll()"/></div>
	</div>	
	</form>
</div>
<!--POP UPDATEPASS END-->

<!--POP OCXLOG START-->
<div id="popOCXLogDiv" style="display:none;"> 
	<div style="width:750px; height:300px; max-height:260px; overflow-y:auto;">
		<table width="100%" cellpadding="0" cellspacing="0" style="border-top:1px solid #3B9FFF; border-left:1px solid #3B9FFF; line-height:18px;">
	    	<thead class="tab_border">
	    		<tr style="font-weight:bold;">
		    		<td width="20%">&nbsp;时间&nbsp;</td>
		    		<td>&nbsp;日志信息</td>
		    	</tr>
	    	</thead>
	    	<tbody id="ocxLogTabId" class="tab_border"></tbody>
	    </table>
    </div>
</div>
<!--POP OCXLOG END -->

<form id="form2" action="<c:url value='/user-logout.action'/>" method="post"></form>
<!--POP LAYER END-->
<script type="text/javascript" src="<c:url value='/js/updatepwd.js?v=3'/>"></script>
<script type="text/javascript" src="<c:url value='/js/CM.ocxlog_view.js?v=1'/>"></script>
<!-- layer 弹出插件 start -->
<script type="text/javascript" src="<c:url value='/layer/layer.min.js'/>"></script>
<!-- layer 弹出插件 end -->
<!-- ajax file upload -->
<script type="text/javascript" src="<c:url value='/js/jquery.form-3.46.0.js'/>"></script>
<script type="text/javascript">
	//logout
	function logout()
	{
		var ocx = document.getElementById("OCXPlugin");
		layer.confirm("确定要注销吗？",function(){
			ocx.AgentCheckOut();
			$("#form2").ajaxSubmit({ 
				success:function(data){ //提交成功的回调函数
					location.href="index.action";
		        }
			});
		    return false;
		});
	}
</script>
<script type="text/javascript">
	/*************** 弹屏   ***************/ 
	function js_detectcall(line,ani,dnis,param){
		param = param.split(",");
		if(param[0]=="a")
		{
			//获取回访类型
			$.ajax({
				type: "POST",
				dataType: "json",
				data: {tid: param[1]},
				url: "huifangType.action",
				success: function(data) {
					$("#popHuifang")[0].href="huifang-list.action?flag="+data+"&tid="+param[1]+"&ttid="+param[2];
					$("#popHuifang")[0].click();
				}
			});
		}
		else
		{
			return false;
		}
	}

	/*************** 业务组监控   ***************/ 
	/*
	5,,呼叫,0,0,0,0.00%,0/0
	@@ani,@@autocalldesc,@@trkapp,@@callnum,@@ansnum,@@ansrate,@@freenum/@@onlinenum"
	组编号,主叫号码,呼叫状态,补充中继数,呼叫总数,应答数,应答率,空闲座席数/在线总数,
	*/
	function js_monitor_acdgrp(fromClientCts, str){
		//check cts
		var curCts = "<s:property value='#session.vts.curCTS'/>";
		if(curCts==fromClientCts.toLowerCase())
		{
			//
			str = str.split(",");
			//获取表格对象
		    var tabObj = window.frames["mainFrame"].document.getElementById("acdMonitorTab");
		    if (tabObj == null)
			    return false;
			//将字符串转化成整型变量
			var i = parseInt(str[0]);
			if(tabObj.rows[i] == null)
				return false;
			tabObj.rows[i].cells[3].innerText=str[1];
			tabObj.rows[i].cells[4].innerText=str[2];
			tabObj.rows[i].cells[5].innerText=str[3];
			tabObj.rows[i].cells[6].innerText=str[4];
			tabObj.rows[i].cells[7].innerText=str[5];
			tabObj.rows[i].cells[8].innerText=str[6];
			tabObj.rows[i].cells[9].innerText=str[7];
			tabObj.rows[i].cells[10].innerText=str[8];
		}
		else
		{
			
		}
	}
	
	/*************** 座席分机监控  ***************/
	/*
	js提供的内容:电话编号,分机状态,呼叫方向,对方号码,登录话务员
	*/
	function js_seat_minitor(fromClientCts, str, listen){
		//check cts
		var curCts = "<s:property value='#session.vts.curCTS'/>";
		if(curCts==fromClientCts.toLowerCase())
		{
			str = str.split(",");
			//获取表格对象
			var tabObj = window.frames["mainFrame"].document.getElementById("subTelMonitorTab");
			if (tabObj == null)
			    return false;
			var i = parseInt(str[0])+1;
			if(tabObj.rows[i] == null)
				return false;
			tabObj.rows[i].cells[2].innerText=str[1];
			tabObj.rows[i].cells[3].innerText=str[2];
			tabObj.rows[i].cells[4].innerText=str[3];
			tabObj.rows[i].cells[5].innerText=str[4];
			if(parseInt(listen)==0)
			{
				tabObj.rows[i].cells[6].innerText='';
			}
			else
			{
				var tel = tabObj.rows[i].cells[1].innerText;
				tabObj.rows[i].cells[6].innerHTML="<a href=\"javascript:listen('"+tel+"')\">监听</a>";
			}
		}
		else
		{
			
		}
	}
</script>


<!-- ocx event -->
<script type="text/javascript" for="OCXPlugin" event="OnLog(info)">
	//js format date
	Date.prototype.Format = function (fmt) { //author: meizz 
	    var o = {
	        "M+": this.getMonth() + 1, //月份 
	        "d+": this.getDate(), //日 
	        "h+": this.getHours(), //小时 
	        "m+": this.getMinutes(), //分 
	        "s+": this.getSeconds(), //秒 
	        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
	        "S": this.getMilliseconds() //毫秒 
	    };
	    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	    for (var k in o)
	    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	    return fmt;
	}

	//$("#ocxLog")[0].innerHTML=info;
	//get current time
	var d = new Date().Format("yyyy-MM-dd hh:mm:ss");
	//
	//当子页面不是ocxlog页面时， 获取不到ocxTabId对象
	/*
	var tabId = window.frames["mainFrame"].document.getElementById("ocxTabId").insertRow(0);
	if(null!=tabId)
	{
		//JS代码通过表格对象的insertRow方法动态向表格的最顶端添加新的行
		var dateCol = tabId.insertCell(0);
		var infoCol = tabId.insertCell(1);
		dateCol.innerHTML="&nbsp;"+d;
		infoCol.innerHTML="&nbsp;"+info;
	}
	*/
	//显示OCX日志信息在弹出层
	var ocxTab = document.getElementById("ocxLogTabId").insertRow(0);
	var dtCol = ocxTab.insertCell(0);
	var ifCol = ocxTab.insertCell(1);
	dtCol.innerHTML="&nbsp;"+d;
	ifCol.innerHTML="&nbsp;"+info;
	
</script>

<script type="text/javascript" for="OCXPlugin" event="OnRing(line,ani,dnis,param)">
	//$("#ocxLog")[0].innerHTML=param;
	js_detectcall(line,ani,dnis,param);
</script>

<script type="text/javascript" for="OCXPlugin" event="OnACDReport(fromClientCts,str)">
	js_monitor_acdgrp(fromClientCts, str);
</script>

<script type="text/javascript" for="OCXPlugin" event="OnSubTelReport(fromClientCts,str,listen)">
	js_seat_minitor(fromClientCts, str, listen);
</script>

<script type="text/javascript">
	function changeOCX(){
		var ocxplugin = document.getElementById("OCXPlugin");
		ocxplugin.SetLine("1","100","2");
	}
</script>
<script type="text/javascript">
	$(function(){
		//登录成功CheckIn
		var agttel = "<s:property value='#session.vts.agttelnum'/>";
		var ocx = document.getElementById("OCXPlugin");
		ocx.AgentCheckIn(agttel,0);
		//判断OCX
		if(document.all.OCXPlugin.object==null)
		{
			//alert("VTCX控件不存在或没有正确加载，请使用360兼容模式或IE浏览器");
		}
		else
		{
		}
	});
</script>
<!-- 链接服务器并成功登录时发生的事件 -->
<script type="text/javascript" for="OCXPlugin" event="OnConnect(serverip,port,client)">
	//alert("链接服务器成功! IP:"+serverip+", 端口："+port+", 客户端账号:"+client);
</script>
<!-- 链接中断或无法链接服务器时,发生的事件 -->
<script type="text/javascript" for="OCXPlugin" event="OnError(code,info)">
	//alert("链接中断或无法链接服务器, 原因:"+info);
</script>


<%-- 我的分机 start --%>
<div id="zuojifenji">
	<h2 style="text-align:center">我的分机</h2>
</div>
<a class="com-ask-float-block0" id="line0" title="分机状态[点击播放提示音]" style="top:227px"><img id="tel_state" src="images/phone_0602.jpg"/></a>
<a class="com-ask-float-block bohao1" id="line1" title="拔号" style="top:277px">拔号</a>
<a class="com-ask-float-block bohao2" id="line2" title="重拔" style="top:317px">重拔</a>
<a class="com-ask-float-block bohao3" id="line3" title="应答" style="top:357px">应答</a>
<a class="com-ask-float-block bohao4" id="line4" title="挂断" style="top:397px;">挂机</a>
<a class="com-ask-float-block bohao5" id="line5" title="呼我" style="top:437px;">呼我</a>
<style type="text/css">
	#bohaopan table{text-align:center; height:280px; width:200px; background:#bbff77; border:0;}
	#bohaopan .num_input{color:#000; width:100%; height:40px;}
	#bohaopan .num_input1{color:#000; width:40%; height:60px;}
</style>
<div id="bohaopan" class="bohaopan-fix">
	<table>
		<tr>
			<td colspan="3">
				<input type="text" id="nummessege" class="ipt_bohao_w190" maxlength="11"/>
			</td>
		</tr>
		<tr>
			<td>
				<input type="button" value="1" id="1" onclick="onclicknum(1)" class="num_input"/>
			</td>
			<td>
				<input type="button" value="2" id="2" onclick="onclicknum(2)" class="num_input"/>
			</td>
			<td>
				<input type="button" value="3" id="3" onclick="onclicknum(3)" class="num_input"/>
			</td>
		</tr>
		<tr>
			<td>
				<input type="button" value="4" id="4" onclick="onclicknum(4)" class="num_input"/>
			</td>
			<td>
				<input type="button" value="5" id="5" onclick="onclicknum(5)" class="num_input"/>
			</td>
			<td>
				<input type="button" value="6" id="6" onclick="onclicknum(6)" class="num_input"/>
			</td>
		</tr>
		<tr>
			<td>
				<input type="button" value="7" id="7" onclick="onclicknum(7)" class="num_input"/>
			</td>
			<td>
				<input type="button" value="8" id="8" onclick="onclicknum(8)" class="num_input"/>
			</td>
			<td>
				<input type="button" value="9" id="9" onclick="onclicknum(9)" class="num_input"/>
			</td>
		</tr>
		<tr>
			<td>
				<input type="button" value="*" id="mul" onclick="onclicknum('*')" class="num_input"/>
			</td>	
			<td>
				<input type="button" value="0" id="0" onclick="onclicknum(0)" class="num_input"/>
			</td>
			<td>
				<input type="button" value="#" id="mul" onclick="onclicknum('#')" class="num_input"/>
			</td>
		</tr>
		<tr>
			<td>
				<input type="button" value="清除" id="clear" onclick="onclickclear()" class="num_input"/>
			</td>
			<td>	
				<input type="button" value="呼叫" id="result" onclick="onDial()" class="num_input"/>
			</td>
			<td>	
				<input type="button" value="关闭" onclick="closeBohaopan()" class="num_input"/>
			</td>
		</tr>
	</table>
</div>
<%-- 我的分机 end --%>
<script type="text/javascript">
	//ocx插件
	var ocx = document.getElementById("OCXPlugin");
	//拔号盘 
	var bohp = document.getElementById("bohaopan");
	//工具栏显示信息 
	var ing = "正在呼叫：";
	//正在呼叫号码
	var callingTel = document.getElementById("calling_num"); 

	var agttel = "<s:property value='#session.vts.agttelnum'/>";
	//
	$(function(){
		//播放提示音 
		$("#line0").bind("click",function(){
			ocx.doPlayInfo();
		});

		//拔号
		$("#line1").bind("click",function(){
			bohp.style.display="block";
		});

		//重拔
		$("#line2").bind("click",function(){
			var recalltel = ocx.GetLastCallee();
			ocx.doDial(recalltel);
			callingTel.innerHTML=ing+recalltel;
		});
		
		//挂断
		$("#line4").bind("click",function(){
			ocx.doOnHook();
			callingTel.innerHTML="";
		});
		
		//呼我 ocx.AgentCallMe();
		$("#line5").bind("click",function(){
			//需要修改
			ocx.AgentCallMe("8115");
			callingTel.innerHTML=ing+"8115";
		});
	});
	//拔号盘按钮点击
	function onclicknum(nums) { 
		str = document.getElementById("nummessege"); 
		str.value = str.value + nums;
		if(str.value.length>11)
		{
			str.value=(str.value).substring(0,11);
		}	 
	} 
	//拔号盘清除
	function onclickclear() { 
		str = document.getElementById("nummessege"); 
		str.value = ""; 
	} 
	//关闭拔号盘
	function closeBohaopan()
	{
		bohp.style.display="none";
	}
	//拔号盘呼叫
	function onDial()
	{
		var tel = $("#nummessege").val();
		var regT = /^([0-9]|[-])+$/g;
		var regP = /0?(13|14|15|18)[0-9]{9}/;
		
		if(!tel)
		{
			alert("请输入要拔打的号码！");
			return false;
		}
		else if(!regT.exec(tel) && !regP.exec(tel))
		{
			alert("请输入合理的电话号码");
			return false;
		}
		else
		{
			ocx.doDial(tel);
			callingTel.innerHTML=ing+tel;
		}
	}
	
</script>

<%-- 4.1 指挥座席线路状态改变 --%>
<script type="text/javascript" for="OCXPlugin" event="OnLineChange(line,state,desc)">
	//分机状态
	var ts = document.getElementById("tel_state");
	var imgnum = [0,1,2,3,4];
	var img="images/phone_060";
	//正在呼叫
	var callingTel = document.getElementById("calling_num");
	//拔号
	var line1 = document.getElementById("line1");
	//重拔
	var line2 = document.getElementById("line2");
	//应答
	var line3 = document.getElementById("line3");
	//挂断
	var line4 = document.getElementById("line4");
	
	//0:断开
	if(state==0)
	{
		ts.src=img+imgnum[0]+".jpg";
		line1.style.display="";
		line2.style.display="";
		line3.style.display="";
		line4.style.display="none";
		//
		callingTel.innerHTML="";
	}
	//1:空闲
	else if(state==1)
	{
		ts.src=img+imgnum[1]+".jpg";
		line1.style.display="";
		line2.style.display="";
		line3.style.display="";
		line4.style.display="";
		//
		callingTel.innerHTML="";
	}
	//2:通话 
	else if(state==2)
	{
		ts.src=img+imgnum[3]+".jpg";
		line1.style.display="none";
		line2.style.display="none";
		line3.style.display="none";
		line4.style.display="";
	}
	//3:振铃 
	else if(state==3)
	{
		ts.src=img+imgnum[2]+".jpg";
		line1.style.display="none";
		line2.style.display="none";
		line3.style.display="";
		line4.style.display="";
	}
	//4:拨号 
	else if(state==4)
	{
		ts.src=img+imgnum[3]+".jpg";
		line1.style.display="";
		line2.style.display="";
		line3.style.display="none";
		line4.style.display="";
	}
	//5:催挂
	else if(state==5)
	{
		ts.src=img+imgnum[4]+".jpg";
		line1.style.display="none";
		line2.style.display="none";
		line3.style.display="none";
		line4.style.display="";
	}
	else
	{
		alert("状态错误");
	}
	
</script>

</body>
</html>
