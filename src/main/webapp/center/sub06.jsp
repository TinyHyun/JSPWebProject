<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

<body>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7188b41e54f57b2d2b33592c425980be"></script>
<script>
	$(() => {		
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(37.555882, 127.005346),
			level: 3
		};

		var map = new kakao.maps.Map(container, options);
		// 마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(37.555882, 127.005346); 

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);

		// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
		// marker.setMap(null);    
	});
</script>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/center/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<img src="../images/center/left_title.gif" alt="센터소개 Center Introduction" class="left_title" />
				<%@ include file="../include/center_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/center/sub07_title.gif" alt="오시는길" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;센터소개&nbsp;>&nbsp;오시는길<p>
				</div>
				<div class="con_box">
					<p class="con_tit"><img src="../images/center/sub07_tit01.gif" alt="오시는길" /></p>
					<p class="dot_tit">서울신라호텔 주소<br /></p>
					<p style="margin-bottom:15px;">서울시 중구 동호로 249 (우편번호 : 04605)</p>
					
					<div id="map" style="width:500px;height:400px;"></div>
					<br />
					
					<p class="con_tit"><img src="../images/center/sub07_tit02.gif" alt="자가용 오시는길" /></p>
					<div class="in_box">
						<p class="dot_tit">분당 방면</p>
						<p style="margin-bottom:15px;">한남대교 → 장충단길 → 서울신라호텔/신라면세점 </p>
						<p class="dot_tit">강남 방면</p>
						<p style="margin-bottom:15px;">동호대교 → 장충제육관 앞 사거리에서 좌회전 → 서울신라호텔/신라면세점  </p>
						<p class="dot_tit">용산 방면</p>
						<p style="margin-bottom:15px;">남산2호터널 통과 후 좌회전 → 서울신라호텔/신라면세점  </p>
					</div>
					<p class="con_tit"><img src="../images/center/sub07_tit03.gif" alt="대중교통 이용시" /></p>
					<div class="in_box">
						<p class="dot_tit">버스 이용시</p>
						<p style="margin-bottom:15px;">노선번호: 144번, 301번, 7212번 장충체육관 앞 하차  </p>
						<p class="dot_tit">지하철 이용시</p>
						<p style="margin-bottom:15px;">지하철 3호선 동대입구역 5번 출구</p>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
