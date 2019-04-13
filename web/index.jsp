<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2018/6/5
  Time: 18:03
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
    <title>$Title$</title>
  </head>
  <body>
 <jsp:forward page="${pageContext.request.contextPath}/FindAllWithPage?pageNum=1&flag=list&blogLevel=0&operClass=getAllBlog"/>
  </body>
</html>
