 <%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2018/6/12
  Time: 11:12
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
    <title>撰写博客</title>
    <link rel="stylesheet"
    href="${pageContext.request.contextPath}/resources/bootstrap-select-1.12.4/dist/css/bootstrap-select.min.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/bootstrap-select-1.12.4/dist/css/bootstrap-select.css">
<link rel="stylesheet"
    href="${pageContext.request.contextPath}/resources/bootstrap-select-1.12.4/dist/css/bootstrap-select.min.css"/>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/bootstrap-select-1.12.4/dist/js/bootstrap-select.js"></script>
    <link rel="stylesheet" href="resources/css/all.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/ueditor/ueditor.all.js"></script>

</head>

<body >
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
                        <li class="active">
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
    <!--博客添加编辑块-->
    <div class="container blogAdd">
        <c:if test="${empty requestScope.ifUp}">
        <form action="${pageContext.request.contextPath}/systemServlet?flag=addBlog" method="post">
            </c:if>
                <c:if test="${not empty requestScope.ifUp}">
                <form action="${pageContext.request.contextPath}/systemServlet?flag=updateBlog&id=${requestScope.blogUp.id}" method="post">
                    </c:if>
                    <!-- 文章类型 -->                
                <div class="form-group articleClass">
                  <label for="basic" class="col-lg-2 control-label tishispan">文章类型</label>

                  <div class="col-lg-8" style="display: block;float:none;">
                    <select id="basic" class="selectpicker show-tick form-control" name="articleClass" >
                      <option value="未选择">请选择</option>
                        <option value="原创">原创</option>
                        <option value="转载">转载</option>
                        <option value="翻译">翻译</option>
                    </select>
                  </div>
                </div>
                <div class="form-group articleClass">
                  <label for="basic" class="col-lg-2 control-label tishispan">博客类型</label>

                  <div class="col-lg-8" style="display: block;float:none;">
                    <select id="basic" class="selectpicker show-tick form-control" name="blogClass" >
                      <option value="未选择">请选择</option>
                        <option value="人工智能">人工智能</option>
                        <option value="大数据">大数据</option>
                        <option value="数据库">数据库</option>
                        <option value="区块链">区块链</option>
                        <option value="云计算">云计算</option>
                        <option value="后端开发">后端开发</option>
                        <option value="前端开发">前端开发</option>
                        <option value="架构">架构</option>
                    </select>
                  </div>
                </div>
                    <div class="form-group">
                <div class="col-sm-10">
                    <input type="text" value="${requestScope.blogUp.title}" class="form-control" id="blogTitle" name="blogTitle" placeholder="请输入文章标题">
                </div>
                <div class="col-sm-10">
                <textarea id="container" name="container" style="width: 1050px;margin-top:20px; height: 600px;">
                    ${requestScope.blogUp.article}
                </textarea>

                <!-- <div class="col-sm-10 articleClass">
                    <label>文章类型：</label>
                    <select name="articleClass" class="form-control">
                        <option value="未选择">请选择</option>
                        <option value="原创">原创</option>
                        <option value="转载">转载</option>
                        <option value="翻译">翻译</option>
                    </select>
                </div>
                <div class="col-sm-10 articleClass" >
                    <label>博客类型：</label>
                    <select name="blogClass" class="form-control">
                        <option value="未选择">请选择</option>
                        <option value="人工智能">人工智能</option>
                        <option value="大数据">大数据</option>
                        <option value="数据库">数据库</option>
                        <option value="区块链">区块链</option>
                        <option value="云计算">云计算</option>
                        <option value="后端开发">后端开发</option>
                        <option value="前端开发">前端开发</option>
                        <option value="架构">架构</option>
                    </select>
                </div> -->
                <div class="col-sm-10 articleClass" >
                    <input type="submit" class="btn btn-success" value="发布博客"/>
                    <!-- Contextual button for informational alert messages -->
                    <button type="button" class="btn btn-info">保存草稿</button>
                </div>
            </div>
        </form>
    </div>
    <script type="text/javascript">
        var ue=UE.getEditor("container");
    </script>
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
</div>
</body>
</html>
