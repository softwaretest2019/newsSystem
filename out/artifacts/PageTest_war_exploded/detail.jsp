<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2018/6/13
  Time: 10:48
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
    <title>阅读博客</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/all.css">
</head>

<body style="margin:0 auto;">
<div class="container mfxtop">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <nav class="navbar navbar-default" role="navigation">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"> <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button> <a class="navbar-brand" href="#">Blog</a>
                </div>

                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li>
                            <a href="${pageContext.request.contextPath}/index.jsp">博客列表</a>
                        </li>
                        <li>
                            <a href="#">撰写博客</a>
                        </li>
                        <li>
                            <a id="modal-275532" href="#modal-container-275532" role="button" class="btn" data-toggle="modal">登录/注册</a>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">下拉<strong class="caret"></strong></a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="${pageContext.request.contextPath}/systemServlet?flag=manger&pageNum=1&operClass=getBlogById&blogLevel=0">博客管理</a>
                                </li>
                                <li>
                                    <a href="#">博客检索</a>
                                </li>
                                <li>
                                    <a href="#">用户管理</a>
                                </li>
                                <li>
                                    <a href="${pageContext.request.contextPath}/systemServlet?flag=loginout">退出登录</a>
                                </li>
                                <li class="divider">
                                </li>

                                <li>
                                    <c:if test="${empty sessionScope.user}">
                                        <a href="#">未登录</a>
                                    </c:if>
                                    <c:if test="${not empty sessionScope.user}">
                                        <a href="#">欢迎您：${sessionScope.user.username}</a>
                                    </c:if>
                                </li>
                            </ul>
                        </li>
                    </ul>
                    <form class="navbar-form navbar-left" role="search">
                        <div class="form-group">
                            <input class="form-control" type="text" />
                        </div> <button type="submit" class="btn btn-default">查询</button>
                    </form>
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <c:if test="${empty sessionScope.user}">
                                <a href="#">未登录</a>
                            </c:if>
                            <c:if test="${not empty sessionScope.user}">
                                <a href="#">欢迎您：${sessionScope.user.username}</a>
                            </c:if>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/systemServlet?flag=loginout">Logout</a>
                        </li>
                    </ul>
                </div>

            </nav>
        </div>
    </div>
</div>
<div class="container blogAdd">
    <div class="container" style="background-color: white;width: 1050px;margin-top:20px;">
        <ul style="margin-left:400px;font-size:25px ;margin-top:10px;">${requestScope.blog.title}</ul>
        ${requestScope.blog.article}
        <p>作者：${requestScope.blog.issure}&nbsp;&nbsp;发布日期：${requestScope.blog.date}</p>
    </div>
    <form action="${pageContext.request.contextPath}/systemServlet?flag=addComment&id=${requestScope.blog.id}" method="post" class="detail_form">
        <textarea name="comment" style="width: 500px" class="detail_text" placeholder="请输入评论"></textarea><br>
        <input type="submit" value="提交评论" class="btn btn-success detail_btn"/>
    </form>
    <div class="detail_pinglun">
        <c:forEach var="comment" items="${commentList}">
            <div class="one_detail_pinglun">

                <p>用户：${comment.username}</p>
                <p>评论：${comment.comment}</p>
            </div>

        </c:forEach>
    </div>
</div>
<!--
遮罩层
-->
<div class="container">
    <div class="row clearfix">
        <div class="col-md-12 column">

            <div class="modal fade" id="modal-container-275532" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h4 class="modal-title" id="myModalLabel">
                                登录/注册
                            </h4>
                        </div>
                        <div class="modal-body">
                            <form action="${pageContext.request.contextPath}/FindAllWithPage?flag=login" method="post">
                                <div class="form-group">
                                    <label>用户名：</label>
                                    <input type="text" class="form-control" name="username"  placeholder="username">
                                </div>
                                <div class="form-group">
                                    <label>密&nbsp;&nbsp;码：</label>
                                    <input type="password" class="form-control" name="password"  placeholder="Password">
                                </div>
                                <c:if test="${not empty requestScope.message}">
                                    <p style="color:green;">${requestScope.message}</p>
                                </c:if>
                                <input type="submit" style="width:100px;" class="btn btn-success" value="登录"/>
                                <a href="#" style="width:100px;" class="btn btn-success" role="button">注册</a>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
                        </div>
                    </div>

                </div>

            </div>

        </div>
    </div>
</div>
</body>
</html>
