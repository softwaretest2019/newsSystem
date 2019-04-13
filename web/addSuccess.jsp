<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2018/6/12
  Time: 22:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
<head>
    <title>提示</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/all.css">
    <script src="${pageContext.request.contextPath}/resources/js/all.js"></script>
</head>
<body style="background-color:#F4F4F4; ">
<div class="container">
    <div class="message">

            <ul><h1>${requestScope.title}</h1></ul>
            <ul><h2><span class="glyphicon glyphicon-ok"></span>文章发布成功</h2></ul>
            <ul>
                <button type="button" class="btn btn-primary" onclick="javascript:addNewBlog('${pageContext.request.contextPath}');">写新文章</button>

                <!-- Indicates a successful or positive action -->
                <button type="button" class="btn btn-success" onclick="javascript:mangerBlog('${pageContext.request.contextPath}');">管理博文</button>

                <!-- Contextual button for informational alert messages -->
                <button type="button" class="btn btn-info" onclick="javascript:getDetail('${pageContext.request.contextPath}',${requestScope.id});">查看文章</button>
            </ul>

    </div>

</div>
</body>
</html>
