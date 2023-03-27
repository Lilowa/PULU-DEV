<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!--소영: QNA jsp 테스트 -->
<style type="text/css">
html, body {
	margin: 0;
}

table.table.table-bordered.table-hover {
    border: 1px solid #ddd;
}
td.bannertd {
    padding: 0px !important;
}

.col-sm-3\; {
    display: inline-flex;
}


.form-control {
    display: inline-flex;
}


.panel-qna-container {
	margin-bottom: -16px;
}

.panel-qna-title {
	
}

.panel-qna-answer {
	display: none;
	/* 변화가 시작되는 쪽에다가 transition 적용해준다 0 -> 300px 
		  왜? 닫기 버튼을 누를 때 변화가 티남 */
	transition: all 1s;
}

.panel-comment-container {
	
}

.panel-comment-title {
	
}

.panel-comment-answer {
	display: none;
	/* 변화가 시작되는 쪽에다가 transition 적용해준다 0 -> 300px 
		  왜? 닫기 버튼을 누를 때 변화가 티남 */
	transition: all 1s;
}

#btn-all-close {
	background-color: #dddddd;
	border: none;
	color: #555;
	cursor: pointer;
    padding: 5px 10px;
    height: 32px;
    border-radius: 3px;

}

#btn-all-close:hover {
	background-color: #006F3E;
	color: #fff;
	transition: all 0.35s;
}

.active {
	display: block;
	/* 높이를 정해줘야지만 transition이 적용됨 */
	height: 115%;
}

.topBtn {
    padding: 0px 0px 5px;
    display: flex;
    justify-content: space-between;
}

.allQna {
	margin-right: 5px;
	height: 32px;
	padding: 6px 12px;
}

th{
	text-align: center;
	background-color: #006F3E;
	color: #fff
}

.click_td2 {
	display: flex;
	width: 96%;
	ma
}

.panel-body .btn {
	height: 32px;
    padding: 6px 12px;
	align-self: self-end;
}

.panel-body .btn:hover {
    color: #fff;
    background: #006F3E;
}

.panel-body p {
	widows: 96%;
	font-size: 15px;
}

.panel-body textarea {
	font-size: 15px;
}

pre {
	padding: 10px;
	margin:  10px;
	width: 96%;
	font-size : 15px
}

#adminQnaComDelete, #adminQnaComInsert {
	display: flex;
    flex-direction: column;
}

#adminQnaComDeleteBtns {
	display: flex;
    justify-content: flex-end;
}

.Deletebtn {
	height: 32px;
    padding: 6px 12px;
	align-self: self-end;
	color: red;
	border: 0px;
	border-radius: 5px; 
}

.Deletebtn:hover {
    color: #fff;
    background: red;
}
</style>


<div>

	<div class="row">
		<div class="col-lg-12">
			<h2 class="page-header" onclick="location.href='adminQnaList.pulu';">QNA</h2>
		</div>
	</div>

	<!-- /.row -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">문의</div>
				<div class="panel-body">
					
					<!--------------- 리스트 위 버튼--------------->
					<div class="row">
						<div class="container" style="width:100%;">
							<form action="" method="post" class="topBtn" style="width:100%">
								<div class="col-sm-3;">
									<a href="/adminQnaList.pulu">
										<button type="button" class="btn btn-default allQna" >전체주문</button>
									</a> 
									<select class="form-control" name="select" onchange="window.open(value,'_self');" style="width: 120px; height:32px; ">
										<option value="">--답변상태--</option>
										<option
											value="/adminQnaList.pulu?searchNum=3&isSearch=%EB%8C%80%EA%B8%B0">답변대기</option>
										<option
											value="/adminQnaList.pulu?searchNum=3&isSearch=%EC%99%84%EB%A3%8C">답변완료</option>
									</select>
								</div>
								<button id="btn-all-close">QNA ALL Close</button>
							</form>
						</div>
					</div>
				<!--------------- 리스트 --------------->
				<table class="table table-bordered table-hover" style="border-collapse: collapse;">
					<thead>
						<tr align="center">
							<th>문의번호</th>
							<th>상품번호</th>
							<th>답변상태</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
						</tr>
					</thead>
					<c:choose>
						<c:when test="${fn:length(qnaList) > 0}">
							<c:forEach items="${qnaList}" var="row">
								<tbody class="text-center">
									<tr>
										<td width="10%">${row.QNA_NUM }</td>
										<td width="10%">${row.QNA_GOODS_NUM }</td>

										<c:choose>
											<c:when test="${row.QNA_STATUS == '답변완료'}">
												<td width="10%">답변완료</td>
											</c:when>
											<c:otherwise>
												<td style="color: blue;" width="10%">답변대기</td>
											</c:otherwise>
										</c:choose>

										<td class="text-left" width="*%">
											<div class="panel-qna-container">
												<p class="panel-qna-title" style="margin-left: 10px;">${row.QNA_SUBJECT}</p>
											</div>
										</td>
										<td width="10%">${row.QNA_ID}</td>
										<td width="15%">${row.QNA_DATE}</td>
									</tr>
									<tr>
										<td colspan="6" style="padding: 0; margin: 10">
											<!--------------- 제목 클릭시 나타나는 창 --------------->
											<div class="panel-qna-answer">
												<table style="width: 100%; border-collapse: collapse; margin-top: 15px; margin-bottom: 15px" >
													<c:choose>
														<c:when test="${row.QNA_COMMENT == null}">
															<tbody>
																<tr>
																	<td width="10%"><img alt="q" src="resources/img/icon/qq.png" width="30" height="30">
																	</td>
																	<td class="click_td2" width="*%" style="text-align: left; margin-left: 10px"><p style="word-break: break-all; margin-left: 10px; width: 96%;">${row.QNA_CONTENTS}</p>
																		<input style="text-align:left; margin-left: 10px" type="button" class="btn" value="문의삭제" onclick="adminQnaDelete(${row.QNA_NUM})"></td>
																</tr>
																<!-- <tr>
																		<td colspan="2"><hr style="width: 100%; padding: 0"></td>
																	</tr> -->
																<tr>
																	<td width="10%"><img alt="a" src="resources/img/icon/a.png" width="30" height="30">
																	</td>
																	<td width="*%" height="10px">
																		<!--------------- 댓글 입력 창 --------------->
																		<form role="form" id="adminQnaComInsert" method="post" action="adminQnaComInsert.pulu">
																			<input type="hidden" name="QNA_NUM" id="QNA_NUM" value="${row.QNA_NUM}" />
																			<table class="comInsert" style="width: 100%; height: 100%; padding: 10px; border: 0px;">
																				<tr height="5px">
																					<td style="text-align: left; padding: 0px;" height="100%" width="100%">
																						<textarea class="QNA_COMMENT" rows="5" style="width: 96%; height: 100%; border:0px; background:#f0f0f0; padding:10px; margin:10px; border-radius:10px;" placeholder="${row.QNA_COMMENT}" id="QNA_COMMENT" name="QNA_COMMENT">${row.QNA_COMMENT}</textarea>
																					</td>
																				</tr>
																				<tr>	
																					<td style="text-align-last: right;">
																						<input type="submit" class="btn" value="답변완료" onsubmit="location.href = location.href;" style="margin-right: 40px">
																						<%-- <input type="button" class="btn btn-default" value="수정완료" onclick="adminQnaComInsert('${row.QNA_COMMENT}','${row.QNA_NUM}')"> --%>
																					</td>
																				</tr>
																			</table>
																		</form>
																		<!--------------- /댓글 입력 창 --------------->
																	</td>
																</tr>
															</tbody>
														</c:when>
														<c:otherwise>
															<tbody>
																<tr>
																	<td width="10%"><img alt="q" src="resources/img/icon/qq.png" width="30" height="30"></td>
																	<td class="click_td2" width="*%" style="text-align: left;"><p style="word-break: break-all; margin-left: 10px; width: 96%;">${row.QNA_CONTENTS}</p>
																		<input type="button" class="btn" value="문의삭제" onclick="adminQnaDelete(${row.QNA_NUM})" style="margin-left: 10px;"></td>
																</tr>
																<!-- <tr>
																	내용/ 답변 분리 선
																	<td colspan="2"><hr style="width: 100%; padding: 0"></td>
																</tr> -->
																<tr id="comment">
																	<td width="10%"><img alt="a"
																		src="resources/img/icon/aa.png" width="30" height="30"></td>
																	<!-- 이미지 추후 변경 필수!! -->
																	<td width="*%">
																		<!--------------- 댓글 창 --------------->
																		<form role="form" id="adminQnaComDelete" method="post" action="adminQnaComDelete.pulu">
																			<input type="hidden" name="QNA_NUM" id="QNA_NUM" value="${row.QNA_NUM}" />
																			<pre style="text-align: left; margin-left: 10px">${row.QNA_COMMENT}</pre>
																			<div id="adminQnaComDeleteBtns">
																				<input type="button" class="panel-comment-container btn" id="comUpdate" name="comUpdate" value="답변수정" style="margin-right: 5px" />
																				<input type="button" class="Deletebtn" value="답변삭제" onclick="adminQnaComDelete('${row.QNA_COMMENT}','${row.QNA_NUM}')" style="margin-right: 40px">
																			</div>
																		</form>
																	</td>
																	<!--------------- /댓글 창 --------------->
																</tr>
																<tr style="padding: 0; margin: 0">
																	<td colspan="6" style="padding: 0; margin: 0">
																		<div class="panel-comment-answer">
																			<table style="width: 100%; border: 0px; border-collapse: collapse; padding: 10px;">
																				<!--------------- 댓글 수정 창 --------------->
																				<tr>
																					<td width="10%" style="padding: 0; margin: 0">
																						<img alt="a" src="resources/img/icon/a.png" width="30" height="30">
																					</td>
																					<td width="*%" height="10px" style="padding: 0; margin: 0">
																						
																						<form role="form" id="adminQnaComInsert" method="post" action="adminQnaComInsert.pulu">
																							<input type="hidden" name="QNA_NUM" id="QNA_NUM" value="${row.QNA_NUM}" />
																							<table class="comInsert" style="width: 100%; height: 100%; padding: 0px; border: 0px;">
																								<tr height="5px">
																									<td style="text-align: left; padding: 0px;" height="100%" width="100%">
																										<textarea class="QNA_COMMENT" id="QNA_COMMENT_text" rows="5" style="width: 96%; height: 100%; border:0px; background:#f0f0f0; padding:10px; margin:10px; border-radius:10px;" placeholder="${row.QNA_COMMENT}" id="QNA_COMMENT" name="QNA_COMMENT">${row.QNA_COMMENT}</textarea>
																									</td>
																								</tr>
																							</table>
																							<input type="submit" class="btn" value="수정완료" onsubmit="location.href = location.href;" style="margin-right:40px">
																						</form>
																				</tr>
																			</table>
																		</div>
																	</td>
																	<!--------------- /댓글 수정 창 --------------->
																</tr>
															</tbody>
														</c:otherwise>
													</c:choose>
													</tbody>
												</table>
											</div>
										</td>
									</tr>
								</tbody>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tbody>
								<tr>
									<td colspan="6" style="text-align: center;"><c:choose>
											<c:when test="${isSearch != null}"> 검색 결과가 없습니다 </c:when>
											<c:otherwise> 작성된 후기가 없습니다 </c:otherwise>
										</c:choose></td>
								</tr>
							</tbody>
						</c:otherwise>
					</c:choose>
					</tbody>
				</table>
				<!-------------------------------------------------------------------------------------------------------------------- -->

	
	
					<!--------------- 검색 + 페이징--------------->
					<div>
						<div style="border: 1px; float: left; width: 350px;">
							<div class="form-group input-group">
	
	
								<form action="">
									<select style="width: 110px;" class="form-control" name="searchNum" id="searchNum">
										<option value="0">상품번호</option>
										<option value="1">제목</option>
										<option value="2">작성자</option>
									</select> 
									<input class="form-control" type="text" name="isSearch" id="isSearch" style="width: 190px;" /> 
										<span class="input-group-btn">
											<button type="submit" class="btn btn-primary">
												<i class="fa fa-search"></i>
											</button>
										</span>
								</form>
							</div>
						</div>
						<div class="paging" style="border: 1px; float: right;">${pagingHtml}</div>
					</div>
				</div>
				<!-- /.panel -->
			</div>
			<!-- /.row -->
		</div>
	</div>

	<br />
	<form id="commonForm" name="commonForm"></form>
</div>
<script type="text/javascript">
		/* 테이블 아코디언 형식 적용 (show, hide : css 참고) */
		// panel-qna-container
		const panelQnaContainer = document.querySelectorAll(".panel-qna-container"); // NodeList 객체
		// panel-qna-answer
		let panelQnaAnswer = document.querySelectorAll(".panel-qna-answer");
		// btn-all-close
		const btnAllClose = document.querySelector("#btn-all-close");
		 
		// 반복문 순회하면서 해당 QNA제목 클릭시 콜백 처리
		for( let i=0; i < panelQnaContainer.length; i++ ) {
			panelQnaContainer[i].addEventListener("click", function() { // 클릭시 처리할 일
			// QNA 제목 클릭시 -> 본문이 보이게끔 -> active 클래스 추가
			panelQnaAnswer[i].classList.toggle("active");
			});
		};
		  
		btnAllClose.addEventListener("click", function() {
		// 버튼 클릭시 처리할 일  
			for(let i=0; i < panelQnaAnswer.length; i++) {
				panelQnaAnswer[i].classList.remove("active");
			};
		});

		/* QNA 코멘트 수정폼 열기 */
		// panel-comment-container
		const panelCommentContainer = document.querySelectorAll(".panel-comment-container"); // NodeList 객체
		// panel-comment-answer
		let panelCommentAnswer = document.querySelectorAll(".panel-comment-answer");
			  
		for( let i=0; i < panelCommentContainer.length; i++ ) {
			panelCommentContainer[i].addEventListener("click", function() {     // 클릭시 처리할 일
			// QNA 제목 클릭시 -> 본문이 보이게끔 -> active 클래스 추가
			panelCommentAnswer[i].classList.toggle("active");
			    });
		  };
	  

		/* QNA 관리자 삭제 */
		function adminQnaDelete(QNA_NUM){
			var comSubmit = new ComSubmit();
			if (confirm("삭제 하겠습니까?") == true) {
				comSubmit.setUrl("<c:url value='/adminQnaDelete.pulu' />");
				comSubmit.addParam("QNA_NUM", QNA_NUM);
				comSubmit.submit();
				opener.location.href = location.href;
			}
		}

		/* QNA 답변 삭제 */
		function adminQnaComDelete(QNA_COMMENT, QNA_NUM){
			var comSubmit = new ComSubmit();
			if (confirm("삭제 하겠습니까?") == true) {
				comSubmit.setUrl("<c:url value='/adminQnaComDelete.pulu' />");
				comSubmit.addParam("QNA_NUM", QNA_NUM);
				comSubmit.addParam("QNA_COMMENT", QNA_COMMENT);
				comSubmit.submit();
				opener.location.href = location.href;
			}
		}
		
		/****** 줄바꿈 ***********/
		$(document).ready(function(){
	 		let str = document.getElementById("QNA_COMMENT_text").value;
			str = str.toString().replaceAll("<br/>", "\r\n");
			str = str.toString().replaceAll("</br>", "\r\n");
			document.getElementById("QNA_COMMENT_text").value = str;
		})
	</script>
