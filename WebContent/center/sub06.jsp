<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<style>
.customoverlay {position:relative;bottom:85px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;}
.customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
.customoverlay a {display:block;text-decoration:none;color:#000;text-align:center;border-radius:6px;font-size:14px;font-weight:bold;overflow:hidden;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
.customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:14px;font-weight:bold;}
.customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
</style>

 <body>
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
					
					<!-- 이미지를 지도api로 변경 START -->
					<!-- <img src="../images/center/sub07_img01.gif" class="con_img"/> -->
					<div id="map" style="width:710px;height:400px;"></div>
					<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fa661321d043cc93185808a1e42046ef"></script>
					<script>
						var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
						var options = { //지도를 생성할 때 필요한 기본 옵션
							center: new kakao.maps.LatLng(37.479096, 126.878931), //지도의 중심좌표.
							level: 3 //지도의 레벨(확대, 축소 정도)
						};
					
						var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
						// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성
						var mapTypeControl = new kakao.maps.MapTypeControl();
						// 지도에 컨트롤러 추가
						map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
						
						// 지도 확대 축소 제어 줌 컨트롤 생성
						var zoomControl = new kakao.maps.ZoomControl();
						map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
						
						// 마커가 표시될 위치입니다 
						/* var markerPosition  = new kakao.maps.LatLng(37.479096, 126.878931); */
						
						var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png', // 마커이미지의 주소입니다    
					    imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
					    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
					    
						 // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
					    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
					        markerPosition = new kakao.maps.LatLng(37.479096, 126.878931); // 마커가 표시될 위치입니다
						
						// 마커를 생성합니다
						var marker = new kakao.maps.Marker({
						    position: markerPosition,
						    image: markerImage // 마커이미지 설정 
						});
						
						// 커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
						var content = '<div class="customoverlay">' +
						    '  <a href="https://map.kakao.com/?itemId=15798453" target="_blank">' +
						    '    <span class="title">KOSMO</span>' +
						    '  </a>' +
						    '</div>';
						
						// 커스텀 오버레이가 표시될 위치입니다 
						    var position = new kakao.maps.LatLng(37.479096, 126.878931);
						
						// 커스텀 오버레이를 생성합니다
						    var customOverlay = new kakao.maps.CustomOverlay({
						        map: map,
						        position: position,
						        content: content,
						        yAnchor: 1 
						    });
						 
					    // 마커가 지도 위에 표시되도록 설정합니다
						marker.setMap(map);
					</script>
					<!-- 이미지를 지도api로 변경 END -->
					
					<br /><br />
					<p class="con_tit"><img src="../images/center/sub07_tit02.gif" alt="자가용 오시는길" /></p>
					<div class="in_box">
						<p class="dot_tit">강북 방향</p>
						<p style="margin-bottom:15px;">강변북로 진입 후 월드컵 경기장 방면으로 우측방향 → 난지도길 가양대교 방향으로 좌회전 → 상암동길 상암초교 방면으로 우회전 </p>
						<p class="dot_tit">일산 방향</p>
						<p style="margin-bottom:15px;">강변북로 수색/가양대교 방향으로 우측방향, 강변북로 수색역/월드컵경기장 방면으로 좌측방향 → 월드컵 경기장 방면으로 우측방향 → 상암동길 상암초교 방면으로 좌회전  </p>
					</div>
					<p class="con_tit"><img src="../images/center/sub07_tit03.gif" alt="대중교통 이용시" /></p>
					<div class="in_box">
						<p class="dot_tit">버스</p>
						<p style="margin-bottom:15px;">172번, 271번, 470번, 6715번, 7011번, 7013번, 7016번, 7019번, 7715번 월드컵3단지 정문 앞 하차  </p>
						<p class="dot_tit">지하철</p>
						<p style="margin-bottom:15px;">2호선, 6호선 합정역 2번출구에서 271번 환승 후 월드컵파크 3단지 정문 앞 하차<br />6호선 마포구청역 1번출구에서 271번 환승 후 월드컵파크 3단지 정문 앞 하차 </p>
						<p class="dot_tit">마을버스</p>
						<p>마포8번, 마포15번</p>
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
