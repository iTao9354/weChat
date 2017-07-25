<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
	<title>绑定手机号码</title>
	<head>
		<meta name="viewport"
			content="width=device-width, initial-scale=1.0, minimum-scale=0.5,user-scalable=0" />
		<link href="<%=path%>/resouces/common/css/jquery.mobile-1.3.2.min.css" 
			rel="stylesheet" type="text/css" />
		<link href="<%=path%>/resouces/demo/style.css" rel="stylesheet"
			type="text/css" />
		<link href="<%=path%>/resouces/common/wx_css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=path%>/resouces/js/jquery-2.1.1.min.js"></script>
		<script type="text/javascript" src="<%=path%>/resouces/js/jquery.mobile-1.3.2.min.js"></script>
		<style type="text/css">
		img {
	        position: absolute;
	        top: 50%;
	        margin-top: -12.5px;
	   		left: 5%;
	   		width: 26px;
	   		height: 25px;
        }
        .tip{
        	padding:20px;
        	height:20px;
        	line-height:20px;
        }
        .submit{
        	 
        	text-align:center;
        }
        .top {
        	background-color:#006400;
        	color:white;
        	margin-bottom:10px;
        }
        .font{
        	color:#00BFFF;
        }
        #warnDiv{
        	color:red;
        }
        #visitResultDiv{
        	font-size:14px;
        	text-align:center;
        }
		</style>
		<script type="text/javascript">
			function mbundleView(){ 
				var openId = jQuery("#openId").val();
				var url = "<%=path %>/manabundle.action?openId="+openId;
				window.location.href=url;
				
			}	      
		</script>
	</head>
	<body>
		<div data-role="page" id="pbundle" data-theme="d">
			<div data-role="header" data-theme="e">
		      	 <h1>
		      	 	信息提示
		      	 </h1>
		    </div>
			<div data-role="content" >
				<form method="post" action="<%=path %>/mbundleView/mbundleView!mobileBundle.action">
					<div id="visitResultDiv">
						该用户还未进行绑定！
						 <input type="hidden" name="openId" id="openId" value="${openId}" />
					</div>
					<div class="submit">
						<input type="button" id="submit" data-role="none" data-inline="true" value="绑定"  
								data-ajax="false" onclick="mbundleView();"/>					 
					</div>
				</form>
			</div>
		</div>
		
	</body>
</html>
