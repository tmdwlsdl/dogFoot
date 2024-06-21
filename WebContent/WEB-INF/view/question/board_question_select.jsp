<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="domain.question.vo.BoardQuestionVO" %>
<%@ page import="java.util.List" %>

<% request.setCharacterEncoding("UTF-8");%>
<%
	Object obj = request.getAttribute("listS");
	if (obj == null) return;

	List<BoardQuestionVO> list = (List<BoardQuestionVO>)obj;
	int nCnt = list.size();

	BoardQuestionVO _bqvo = null;
	if (nCnt == 1){
		_bqvo = list.get(0);
	}
%>


<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>게시글 수정</title>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Silkscreen:wght@400;700&display=swap" rel="stylesheet">
	<style>
		/* 공통 스타일 */
		body {
			font-family: 'Lato', sans-serif;
			line-height: 1.6;
			color: #333;
		}

		.scrollmenu {
			overflow: auto;
			white-space: nowrap;
			background-color: #333;
			font-family: "Black Han Sans", sans-serif;
			font-weight: 400;
			font-style: normal;
		}

		.scrollmenu a {
			display: inline-block;
			color: white;
			text-align: center;
			padding: 14px;
			text-decoration: none;
		}

		.scrollmenu a:hover {
			background-color: #777;
		}

		.title {
			text-align: center;
			margin-top: 20px;
			color: #000000;
			font-family: "Black Han Sans", sans-serif;
			font-weight: 400;
			font-style: normal;
		}

		.post-form {
			max-width: 800px;
			margin: 20px auto;
			padding: 20px;
			border: 1px solid #ddd;
			border-radius: 5px;
			background-color: #f9f9f9;
		}

		.post-form h2 {
			margin-bottom: 20px;
			font-family: "Black Han Sans", sans-serif;
		}

		.post-form label {
			display: block;
			margin-bottom: 10px;
			font-weight: bold;
		}

		.post-form input[type="text"],
		.post-form textarea {
			width: 100%;
			padding: 10px;
			margin-bottom: 20px;
			border: 1px solid #000000;
			border-radius: 5px;
		}

		.post-form input[type="submit"],
		.post-form input[type="button"] {
			position: relative;
			border: 0;
			padding: 15px 25px;
			text-align: center;
			color: black;
			background-color: #05050515;
			box-shadow: 0px 4px 0px #000000;
			text-decoration: none;
			border-radius: 5px;
			cursor: pointer;
			font-family: "Silkscreen", sans-serif;
			font-weight: 700;
			font-style: normal;
			display: inline-flex;
			align-items: center;
			justify-content: center;
		}

		.post-form input[type="submit"]:active,
		.post-form input[type="button"]:active {
			top: 4px;
			box-shadow: 0 0 #541686e0;
			background-color: #0dde64;
		}

		/* 오버레이 스타일 */
		.overlay {
			height: 100%;
			width: 0;
			position: fixed;
			z-index: 1;
			top: 0;
			left: 0;
			background-color: rgb(0, 0, 0);
			background-color: rgba(0, 0, 0, 0.9);
			overflow-x: hidden;
			transition: 0.5s;
		}

		.overlay-content {
			position: relative;
			top: 25%;
			width: 100%;
			text-align: center;
			margin-top: 30px;
		}

		.overlay a {
			padding: 8px;
			text-decoration: none;
			font-size: 36px;
			color: #818181;
			display: block;
			transition: 0.3s;
		}

		.overlay a:hover, .overlay a:focus {
			color: #f1f1f1;
		}

		.overlay .closebtn {
			position: absolute;
			top: 20px;
			right: 45px;
			font-size: 60px;
		}

		@media screen and (max-height: 450px) {
			.overlay a {
				font-size: 20px;
			}

			.overlay .closebtn {
				font-size: 40px;
				top: 15px;
				right: 35px;
			}
		}

		/* 푸터 스타일 */
		footer {
			width: 100%;
			background-color: #333;
			margin-bottom: 2rem;
			display: flex;
			justify-content: center;
			align-items: center;
		}

		.wrap {
			width: 80%;
			margin: 0 auto;
			display: flex;
			flex-direction: column;
			align-items: center;
			text-align: center;
			row-gap: 2em;
		}

		.social-icons i {
			font-size: 1.5rem;
			margin: 0 0.3em;
		}

		.options {
			display: grid;
			grid-template-columns: repeat(4, 1fr);
			grid-gap: 1em;
		}

		.option {
			color: #6f6f6f;
		}

		.option:hover {
			text-decoration: underline;
		}

		/* 기타 스타일 */
		h2 {
			font-weight: bold;
		}

		.hr1 {
			border: 0;
			height: 2px;
			background: #d3d3d3;
		}

		.grey {
			color: #727272;
		}

		#strong {
			font-weight: 900;
		}

		table {
			width: 100%;
			border-top: 1px solid #d3d3d3;
			border-collapse: collapse;
		}

		th {
			background-color: #d3d3d3;
			border-top: 3px solid #727272;
		}

		th, td {
			border-bottom: 1px solid #d3d3d3;
			padding: 10px;
		}

		.greylist {
			width: 50px;
			height: 30px;
			font-weight: 900;
			color: white;
			text-align: center;
			background: grey;
			border: solid 2px white;
			border-radius: 5px;
		}

		.gradient {
			width: 80px;
			height: 30px;
			font-weight: 900;
			color: white;
			text-align: center;
			background: linear-gradient(to bottom, grey, black);
			border: solid 2px white;
			border-radius: 5px;
		}

		.left {
			text-align: left;
		}

		.right {
			float: right;
		}

		.center {
			text-align: center;
		}

		a {
			color: black;
			text-decoration-line: none;
		}

		div.scrollmenu {
			background-color: #333;
			overflow: auto;
			white-space: nowrap;
		}

		div.scrollmenu a {
			display: inline-block;
			color: white;
			text-align: center;
			padding: 14px;
			text-decoration: none;
		}

		div.scrollmenu a:hover {
			background-color: #777;
		}
	</style>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){

			//  Update
			$(document).on("click", "#updateBtn", function(e){
				alert("수정 버튼 클릭함");
				e.preventDefault();
				$("#boardUpdateForm").attr({ "method":"GET", "action":"board_question_update.p"}).submit();
			});

			// Delete
			$(document).on("click", "#deleteBtn", function(e){
				alert("삭제 버튼 클릭함");
				e.preventDefault();
				$("#boardUpdateForm").attr({ "method":"GET", "action":"board_question_delete.p"}).submit();
			});

		});
	</script>
</head>
<body>
<div class="scrollmenu">
	<a href="<c:url value='/main'/>">Home</a>
	<a href="<c:url value='/login'/>">login</a>
	<a href="<c:url value='/board_free'/>">자유게시판</a>
	<a href="<c:url value='/board_popularity'/>">인기게시판</a>
	<a href="<c:url value='/board_job'/>">취업게시판</a>
	<a href="<c:url value='/board_question'/>">질문게시판</a>
	<a href="#base">남는게 시팜</a>
	<a href="#custom">Custom</a>
	<a href="#more">More</a>
	<a href="#logo">Logo</a>
	<a href="#friends">Friends</a>
	<a href="#partners">Partners</a>
	<a href="#people">People</a>
	<a href="#work">Work</a>
</div>

<h1 class="title">게시글 수정</h1>

<div class="post-form">
	<h2>글 수정하기</h2>
	<form name="boardUpdateForm" id="boardUpdateForm">
		<input type="hidden" name="boardquestionid" id="boardquestionid" value="<%= _bqvo.getBoardquestionid() %>">
		<label for="title">제목</label>
		<input type="text" id="title" name="title" value="<%= _bqvo.getTitle() %>" required>

		<label for="content">내용</label>
		<textarea id="content" name="content" rows="10" required><%= _bqvo.getContent() %></textarea>

		<input type="button" id="updateBtn" value="수정하기">
		<input type="button" id="deleteBtn" value="삭제하기">
	</form>
</div>

<footer>
	<div class="wrap">
		<div class="options">
			<div class="option">자막 및 음성</div>
			<div class="option">음성 지원</div>
			<div class="option">고객 센터</div>
			<div class="option">미디어 센터</div>
			<div class="option">투자 정보(IR)</div>
			<div class="option">입사 정보</div>
			<div class="option">이용 약관</div>
			<div class="option">개인 정보</div>
			<div class="option">법적 고지</div>
			<div class="option">쿠키 설정</div>
			<div class="option">회사 정보</div>
			<div class="option">문의하기</div>
		</div>
	</div>
</footer>
</body>
</html>
