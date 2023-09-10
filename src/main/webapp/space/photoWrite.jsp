<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- JSP최상단에 인클루드 하여 로그인 정보가 없다면 즉시
로그인 페이지로 이동시킨다.  -->    
<%@ include file="./IsLoggedIn.jsp"%>

<%@ include file="../include/global_head.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
/* 글쓰기 페이지에서 제목과 내용이 입력되었는지 검증하는 JS코드 */
function validateForm(form) { 
    if (form.title.value == "") {
        alert("제목을 입력하세요.");
        form.title.focus();
        return false;
    }
    if (form.content.value == "") {
        alert("내용을 입력하세요.");
        form.content.focus();
        return false;
    }
}
</script>
</head>
<body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/space/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/space_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/space/sub04_title.gif" alt="사진게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;사진게시판<p>
				</div>
				<div>
<!-- 게시판 들어가는 부분 S -->
<form name="writeFrm" method="post" action="../controller/photoWrite.tj?tname=photoboard"
      onsubmit="return validateForm(this);">
      
    <table class="table table-bordered" width="100%">
        <tr>
            <th style="text-align: center; vertical-align:middle;">제목</th>
            <td>
                <input type="text" name="title" style="width: 100%;" />
            </td>
        </tr>
        <tr>
            <th style="text-align: center; vertical-align:middle;">내용</th>
            <td>
                <textarea name="content" style="width: 100%; height: 350px; resize: none;" ></textarea>
            </td>
        </tr>
        <tr>
        	<th style="text-align: center; vertical-align:middle;">첨부파일</th>
        	<td>
        		<input type="file" name="ofile" />
        	</td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <button type="submit">작성 완료</button>
                <button type="reset">다시 입력</button>
                <button type="button" onclick="location.href='./sub01List.jsp?tname=photoboard';">
                    목록 보기</button>
            </td>
        </tr>
    </table>
</form>
<!-- 게시판 들어가는 부분 E -->
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>


	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>