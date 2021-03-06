<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <title>选择商务车上车点</title>
    <link rel="stylesheet" href="${ctx }/resource/font-awesome-4.4.0/css/font-awesome.css" />
    <link rel="stylesheet" href="${ctx }/resource/css/style.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx }/resource/css/main.css"/>
    <link rel="stylesheet" href="${ctx }/resource/jquery-mobile/css/themes/default/jquery.mobile-1.4.5.min.css" />
    <script src="${ctx }/resource/js/jquery-1.10.1.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=ezofnKG8X1gQ29UuOUjQlo1Q"></script>
    <script type="text/javascript" src="${ctx }/resource/js/main.js" ></script>
    <script type="text/javascript" src="${ctx }/resource/jquery-mobile/js/jquery.mobile-1.4.5.min.js" ></script>
    <script type="text/javascript" src="${ctx }/resource/js/GeoUtils_min.js"></script>
    <style>
   
    </style>
</head>
<body data-role="page">
<div class="box stopPoint">
    <!--页头-->
   <%--  <div class="topColor">
        <a class="topIcon" onclick="javascript:window.history.back();"><img class="img" src="${ctx }/resource/image/main/backup.png"></a>
        <div class="topTitle">商务车</div>
        <a class="topIcon2" href="#userDetail"><img class="img" src="${ctx }/resource/image/main/user.png"></a>
    </div>
    <div class="clear"></div> --%>
    <!-- <div style="background:#35A8D7;height:5px;"></div>
    <a class="topIcon" href="#userDetail"><i class="fa fa-user"></i></a> -->
    
    <!--页头结束-->
    <!--主体-->
    <div class="mainBox bottom0">    	
    	<!-- <div id="r-result" class="taged tip bgred" >请输入:<input type="text" id="suggestId" size="20" value="请输入地点:" style="width:150px;" /></div> -->		
       <div class="mapContainer" id="mapContainer"></div>
       <span class="taged tip bgred"  id="r-result" >请输入或者在地图上选择上车地点！！<input type="text" id="suggestId" size="20" value="请输入地点:" style="width:auto;" />
       	<div id="searchResultPanel" style="border:1px solid #C0C0C0;width:auto;height:auto; display:none;"></div>
       </span>       
       <span class="taged tip bottom"  id="carprice" >在红线区域内收费为25元！<i class="fa fa-times"></i></span>
   
       <a class="btn blue" onclick="submitOrder()" data-ajax="false">提交订单</a>
    </div>
    	<%-- <form id="businessCarForm" action="${ctx }/airportbus/submitBusinessCarOrder.do" method="post"> --%>
    	<form id="businessCarForm" action="${ctx }/airportbus/goBusinessOrder.do" method="post">
    		<input type="hidden" id="sRouId" name="sRouId" value="${result.sRouId }"/>
	   		<input type="hidden" id="rouId" name="rouId" value="${result.rouId }" />	  
	       <input type="hidden" name="startSite" id="startSite" value="${result.startSite }" >
	       <input type="hidden" name="endSite" id="endSite" value="${result.endSite }" >
	       <input type="hidden" name="price" value="${result.price }" >
	       <%-- <input type="hidden" name="startTimeStr" value="${startTime }" >
	       <input type="hidden" name="mobile" value="${mobile }" >
	       <input type="hidden" name="sitNum" value="${sitNum }" >
	       <input type="hidden" name="bookType" value="${bookType }" > --%>
	       <input type="hidden" id="endLat" name="endLat" value="" >
	       <input type="hidden" id="endLon" name="endLon" value="" >
       </form>
    <!--主体结束-->
    <!--用户信息panel-->
	<!-- <div data-role="panel" id="userDetail" class="userDetail" data-display="overlay" data-position="right"  data-position-fixed="true"  >
		<ul>
			<li>
				<span class="logo"><img class="img" src="../../../resource/image/main/icon7.png" /></span>
				<span>136****8982</span>
				<a class="btn blue" href="#">退出</a>
			</li>
			<li class="li">
				<a href="../my/integration.html" data-transition="slide" data-direction="reverse"><i class="fa fa-money"></i>我的积分</a>
			</li>
			<li class="li">
				<a href="../my/myOrderList.html" data-transition="slide" data-direction="reverse"><i class="fa fa-newspaper-o"></i>我的订单</a>
			</li>
			<li class="li">
				<a href="../my/advice.html" data-transition="slide" data-direction="reverse"><i class="fa fa-commenting-o"></i>我的建议</a>
			</li>
			<li class="li">
				<a href="../service/lostList.html" data-transition="slide" data-direction="reverse"><i class="fa fa-tty"></i>失物招领</a>
			</li>
			
		</ul>
	</div> -->
    <!--页脚-->
  <%--   <div class="footer">
    <div class="iconBox">
        <div class="icon"><img src="${ctx }/resource/image/main/icon1.png"></div>
        <p>城际巴士</p>
    </div>
    <div class="iconBox">
        <div class="icon"><img src="${ctx }/resource/image/main/icon2.png"></div>
        <p role="mid">商务车</p>
    </div>
    <div class="iconBox">
        <div class="icon"><img src="${ctx }/resource/image/main/icon3.png"></div>
        <p>机场快线</p>
    </div>
    </div> --%>
    <!--页脚结束-->
</div>
<%@ include file="../../../common/common.jsp" %>
   <script type="text/javascript" src="${ctx }/resource/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
var price;
var startPlace='${result.startSite}';
var endPlace='${result.endSite}';
var sRouId='${result.sRouId}';

var result;
var cityName;
var ply;
var oldCarPriceHtml;
var manyClick = false;
var bmarker;
if(startPlace=="沈阳桃仙国际机场"){
	cityName=endPlace;
}else{
	cityName=startPlace;
}
  price='${result.price}';
  //cityCode=${cityCode};
  var map = new BMap.Map("mapContainer");
  //逆地址解析
  var geoc = new BMap.Geocoder();   
		$(function(){
			 $.ajax({
				url:"${ctx}/airportbus/getLines.do?json",
				async: false,
				data:{sRouId:sRouId },
				type: "POST",dataType:'json',
				error:function(){},
				success:function(result){
					showLines(result);					
				}
			}); 
			 
			$("#carprice").html('在红线区域内收费为'+price+'元！');
			
			 var url = location.href.split('#')[0];
			/* $.ajax({
				url:"${ctx}/bwebCommon/getSign.do?json",
				dataType :"json",
				data:{url:url},
				success:function(data){
					//console.log(data);
					wx.config({
					    debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
					    appId: data.appId, // 必填，公众号的唯一标识
					    timestamp: data.timestamp, // 必填，生成签名的时间戳
					    nonceStr: data.nonceStr, // 必填，生成签名的随机串
					    signature: data.signature,// 必填，签名，见附录1
					    jsApiList: ["getLocation","openLocation"] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
					});
					
					wx.ready(function(data2){
					    // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
					    wx.getLocation({
						    type: 'wgs84', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
						    success: function (res) {
						        var latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
						        var longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
						        var speed = res.speed; // 速度，以米/每秒计
						        var accuracy = res.accuracy; // 位置精度
						        
						        //latinit=res.latitude;
								//lnginit=res.longitude;	
								
						var initMarker = new BMap.Marker(new BMap.Point(res.longitude, res.latitude));
					    map.addOverlay(initMarker);	   
					    var label = new BMap.Label("当前位置",{offset:new BMap.Size(20,-10)});
					    initMarker.setLabel(label);
						    }
						});
					});
					wx.error(function(res){
				//		alert("验证错误");
					});
					
				},error:function(e){
			//		alert(e);
				}
			});   
			
			/*  var geolocation = new BMap.Geolocation();
			geolocation.getCurrentPosition(function(r){
				if(this.getStatus() == BMAP_STATUS_SUCCESS){
					  latinit=r.latitude;
					  lnginit=r.longitude;					  					  
				//根据浏览器定位获取经纬度，来展示最近公交站点
		      var marker3 = new BMap.Marker(new BMap.Point(r.longitude, r.latitude));
		      map.addOverlay(marker3);	   
		      var label = new BMap.Label("当前位置",{offset:new BMap.Size(20,-10)});
		  	      marker3.setLabel(label);
				}
				else {
					alert('failed'+this.getStatus());
				}        
			},{enableHighAccuracy: true})     */
			
		})  
		
			//回车检索地址
			 $('#suggestId').bind('keydown', function (event) {			
	            if (event.keyCode == "13") {
	            	var address = $("#suggestId").val();
	    			geoc.getPoint(address, function(point){
	    				if (point) {
	    					translatePoint(point);
	    				}else{
	    					alert("您选择地址没有解析到结果!");
	    				}
	    			}, cityName);
	            }
	        });
		
			
			
		
		//添加多边形(边界)
		function showLines(result){			
			map.centerAndZoom(cityName, 12) ;
			//地图缩放
			map.enableScrollWheelZoom(true);
			var pts=[];
			for(var i=0;i<result.length-1;i++){				
				   var point= new BMap.Point(result[i].B_LON, result[i].B_LAT);
				 	pts.push(point);
			}
			ply=new BMap.Polygon(pts, {strokeColor:"red", strokeWeight:3, strokeOpacity:1,fillOpacity:0}); 
			map.addOverlay(ply); 			
		}
			
			
		//点击地图事件
		map.addEventListener("click",function(e){
			
			var pt=new BMap.Point(e.point.lng, e.point.lat)
			if(manyClick == true){
				alert("请不要重复点击");
				return "";
			}
			manyClick = true;
			 window.setTimeout(function() {
	        	translatePoint(pt);	            
	        }, 500);
			
		}); 
			
		//判断时候在多边形范围内 
		function translatePoint(pt){
			var result = BMapLib.GeoUtils.isPointInPolygon(pt, ply);
			if(ply != null){
				var result = BMapLib.GeoUtils.isPointInPolygon(pt, ply);
				if(result == false){
						oldCarPriceHtml=$("#carprice").html();
						$("#carprice").html("<a href='tel:024-58633333' style='color:#fff'>您选择的目的地已超出送达范围。如有需求请拨打服务电话：024-58633333!</a> ")
						//alert("您选择的目的地已超出送达范围。如有需求请拨打服务电话：024-58633333!")
						manyClick = false;
						return "";
					}else{
						$("#carprice").html(oldCarPriceHtml);
					}
			};			
			
			var marker = new BMap.Marker(pt);
			map.removeOverlay(bmarker);
			map.addOverlay(marker);
			
			geoc.getLocation(pt, function(rs){
	            var addComp = rs.addressComponents;
		         // alert(addComp.province + ", " + addComp.city + ", " + addComp.district + ", " + addComp.street + ", " + addComp.streetNumber);
		         var result=addComp.city+addComp.district+addComp.street;		         
		         $("#endSite").val(result);
				var label = new BMap.Label("上车位置:"+result,{offset:new BMap.Size(20,-10)});
		  	    marker.setLabel(label);
				bmarker=marker;
				manyClick = false;
	        });      
			
			
			$("#endLat").attr("value",pt.lat);	
			$("#endLon").attr("value",pt.lng);	
	}
	
		//shanggxl添加只能百度智能搜索(结合自身需求修改)
			 function G(id) {
	       		 return document.getElementById(id);
	  		  }
			 var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
			            {"input" : "suggestId"
			                ,"location" : cityName
			            });
	
			    ac.addEventListener("onhighlight", function(e) {  //鼠标放在下拉列表上的事件
			        var str = "";
			        var _value = e.fromitem.value;
			        var value = "";
			        if (e.fromitem.index > -1) {
			            value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
			        }
			        str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;
	
			        value = "";
			        if (e.toitem.index > -1) {
			            _value = e.toitem.value;
			            value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
			        }
			        str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;
			
					$("#endSite").val(value);
			        G("searchResultPanel").innerHTML = str;
			    });
	
			    var myValue;
			    ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
			        var _value = e.item.value;
			        myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
			        G("searchResultPanel").innerHTML ="onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;
			        setPlace()
			    });
				
			    function setPlace(){		    	
			        function myFun(){
			            var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
			            translatePoint(pp);
			         }
			        
			        var local = new BMap.LocalSearch(map, { //智能搜索
			            onSearchComplete: myFun
			        });
			        
			        local.search(myValue);
			  }
			 
			    
			    
			    
		    //最后提交
		    function submitOrder(){
				var endLat=$("#endLat").val();
				if(endLat==''){
					alert("请选择上车地点！");
					return;
				}
				var temp=$("#endSite").val();
				if(confirm("确定  "+temp+"  为上车点？")){
				 document.getElementById('businessCarForm').submit(); 
				}
			}
</script>
</body>
</html>