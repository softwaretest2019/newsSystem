<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2018/6/5
  Time: 18:07
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
    <title>博客管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/all.css">
    <script src="${pageContext.request.contextPath}/resources/js/all.js"></script>
</head>
<body style="margin:0 auto;">
<div class="container mfxtop">
    <!--<div class="row clearfix">
        <div class="col-md-12 column">
            <ul class="nav nav-tabs dhfont">
                <li class="active">
                    <a href="#">博客列表</a>
                </li>
                <li>
                    <a href="#">博客检索</a>
                </li>
                <li>
                    <a href="#">撰写博客</a>
                </li>
                <li>
                    <a id="modal-275532" href="#modal-container-275532" role="button" class="btn" data-toggle="modal">登录/注册</a>
                </li>
                <li class="dropdown pull-right">
                    <a href="#" data-toggle="dropdown" class="dropdown-toggle">下拉<strong class="caret"></strong></a>
                    <ul class="dropdown-menu">

                        <li>
                            <a href="#">博客管理</a>
                        </li>
                        <li>
                            <a href="#">用户管理</a>
                        </li>
                        <li>
                            <a href="#">退出登录</a>
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
        </div>
    </div>-->
    <!------------------------------->
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
                            <a href="${pageContext.request.contextPath}/addBlog.jsp">撰写博客</a>
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
    <!------------------------------->
    <div class="mfxlist">
        <div class="row clearfix">
            <div class="col-md-12 column">
                <table class="table table-striped">

                    <thead>
                    <tr>
                        <th>序号</th>
                        <th>题目</th>
                        <th>日期</th>
                        <th>发布人</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${requestScope.page.list}" var="news">

                        <tr>
                            <td><a href="${pageContext.request.contextPath}/systemServlet?flag=checkDetail&id=${news.id}">${news.id}</a></td>
                            <td> <a href="${pageContext.request.contextPath}/systemServlet?flag=checkDetail&id=${news.id}">${news.title}</a></td>
                            <td>${news.date}</td>
                            <td>${news.issure}</td>
                            <td>
                                <button type="button" onclick="javascript:update('${pageContext.request.contextPath}',${news.id});" class="btn btn-success">编辑</button>
                                <button type="button" onclick="javascript:deletex('${pageContext.request.contextPath}',${news.id});" class="btn btn-danger">删除</button>
                            </td>
                        </tr>

                    </c:forEach>
                    </tbody>
                </table>

            </div>
            <div class="container">
                <div class="list_fenye">
                  <span class="list_fenye_span">博客列表：共有${requestScope.page.totalRecord}条博客，共${requestScope.page.totalPage }页，当前为${requestScope.page.pageNum}页</span>
                  <%--如果当前页为第一页时，就没有上一页这个超链接显示 --%>
                  <c:if test="${requestScope.page.pageNum ==1}">
                    <ul class="pagination pagination-lg fenyefloat">
                        <li><a href="${pageContext.request.contextPath}/systemServlet?pageNum=1&flag=manger&operClass=getBlogById&blogLevel=0">首页</a></li>

                        <c:forEach begin="${requestScope.page.start}" end="${requestScope.page.end}" step="1" varStatus="i">
                            <c:if test="${requestScope.page.pageNum == i}">
                                <li class="disabled"><a href="#">${i}</a></li>
                            </c:if>
                            <c:if test="${requestScope.page.pageNum != i}">
                                <li> <a href="${pageContext.request.contextPath}/systemServlet?pageNum=${i}&flag=manger&operClass=getBlogById&blogLevel=0">${i}</a></li>
                            </c:if>
                        </c:forEach>
                        <li><a href="${pageContext.request.contextPath}/systemServlet?pageNum=${requestScope.page.pageNum+1}&flag=manger&operClass=getBlogById&blogLevel=0">下一页</a></li>

                            <%--尾页 --%>
                        <li><a href="${pageContext.request.contextPath}/systemServlet?pageNum=${requestScope.page.totalPage}&flag=manger&operClass=getBlogById&blogLevel=0">尾页</a></li>
                    </ul>
                </c:if>
                <%--如果当前页不是第一页也不是最后一页，则有上一页和下一页这个超链接显示 --%>
                <c:if test="${requestScope.page.pageNum > 1 && requestScope.page.pageNum < requestScope.page.totalPage}">
                    <ul class="pagination pagination-lg fenyefloat">
                        <li><a href="${pageContext.request.contextPath}/systemServlet?pageNum=1&flag=manger&operClass=getBlogById&blogLevel=0">首页</a></li>
                        <li><a href="${pageContext.request.contextPath}/systemServlet?pageNum=${requestScope.page.pageNum-1}&flag=manger&operClass=getBlogById&blogLevel=0">上一页</a></li>
                        <c:forEach begin="${requestScope.page.start}" end="${requestScope.page.end}" step="1" varStatus="i">
                            <c:if test="${requestScope.page.pageNum == i}">
                                <li class="disabled"><a href="#">${i}</a></li>
                            </c:if>
                            <c:if test="${requestScope.page.pageNum != i}">
                                <li><a href="${pageContext.request.contextPath}/systemServlet?pageNum=${i}&flag=manger&operClass=getBlogById&blogLevel=0">${i}</a></li>
                            </c:if>
                        </c:forEach>
                        <li><a href="${pageContext.request.contextPath}/systemServlet?pageNum=${requestScope.page.pageNum+1}&flag=manger&operClass=getBlogById&blogLevel=0">下一页</a></li>

                            <%--尾页 --%>
                        <li><a href="${pageContext.request.contextPath}/systemServlet?pageNum=${requestScope.page.totalPage}&flag=manger&operClass=getBlogById&blogLevel=0">尾页</a></li>
                    </ul>
                </c:if>
                <%-- 如果当前页是最后一页，则只有上一页这个超链接显示，下一页没有 --%>
                <c:if test="${requestScope.page.pageNum == requestScope.page.totalPage&&requestScope.page.pageNum!=1}">
                    <ul class="pagination pagination-lg fenyefloat">
                        <li><a href="${pageContext.request.contextPath}/systemServlet?pageNum=1&flag=manger&operClass=getBlogById&blogLevel=0">首页</a></li>
                        <li><a href="${pageContext.request.contextPath}/systemServlet?pageNum=${requestScope.page.pageNum-1}&flag=manger&operClass=getBlogById&blogLevel=0">上一页</a></li>
                        <c:forEach begin="${requestScope.page.start}" end="${requestScope.page.end}" step="1" varStatus="i">
                            <c:if test="${requestScope.page.pageNum == i}">
                                <li class="disabled"><a href="#">${i}</a></li>
                            </c:if>
                            <c:if test="${requestScope.page.pageNum != i}">
                                <li><a href="${pageContext.request.contextPath}/systemServlet?pageNum=${i}&flag=manger&operClass=getBlogById&blogLevel=0">${i}</a></li>
                            </c:if>
                        </c:forEach>
                            <%--尾页 --%>
                        <li><a href="${pageContext.request.contextPath}/systemServlet?pageNum=${requestScope.page.totalPage}&flag=manger&operClass=getBlogById&blogLevel=0">尾页</a></li>
                    </ul>
                </c:if>
                </div>
            </div>
        </div>
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
