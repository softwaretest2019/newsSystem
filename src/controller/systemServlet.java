package controller;

import entity.Blog;
import entity.Page;
import entity.User;
import entity.comment;
import service.findAllWithPageService;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by mafx on 2018/4/25.
 */
public class SystemServlet extends HttpServlet {

    private findAllWithPageService daws=new findAllWithPageService();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        String flag=request.getParameter("flag");
         switch (flag){
             case "login":
login(request,response);
break;
             case "loginout":
{request.getSession().invalidate();request.getRequestDispatcher("/index.jsp").forward(request,response);
break;}
             case "addBlog":
addBlog(request,response);
break;
             case "checkDetail":
getBlogDetail(request,response);
break;
             case "manger":
mangerBlog(request,response);
break;
             case "update":
getUpdateBlog(request,response);
break;
             case "updateBlog":
updateBlog(request,response);
break;
             case "delete":
deleteBlog(request,response);
break;
             case "addComment":
addComment(request,response);
break;
default:
login(request,response);
break;

         }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
          doPost(request,response);
    }
    private void login(HttpServletRequest request, HttpServletResponse response){
        String username=request.getParameter("username");
        String pwd=request.getParameter("password");
        User user=new User();
        user=daws.getUserByUsnAndPwd(username,pwd);

        try {
            if(user!=null) {
                request.getSession().setAttribute("user",user);
                response.getWriter().print("<script language='javascript'>alert('登录成功！！！');window.location.href='/index.jsp';</script>");
            }else{
                response.getWriter().print("<script language='javascript'>alert('用户名或密码错误请重新登录');history.back(-1);</script>");
            }
        }catch (Exception ex){
            ex.printStackTrace();
        }

    }
    private void addBlog(HttpServletRequest request, HttpServletResponse response){
        String title=request.getParameter("blogTitle");
        String article=request.getParameter("container");
        String articleClass=request.getParameter("articleClass");
        String blogClass=request.getParameter("blogClass");
        User user=(User)(request.getSession().getAttribute("user"));
        String issure=user.getUsername();
        int userId=user.getUserId();
        String blogAbstract=getArticleAbstract(article)+"......";
        Date date=new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String dateString = formatter.format(date);
        Blog blog=new Blog();
        blog.setArticle(article);
        blog.setArticleClass(articleClass);
        blog.setBlogClass(blogClass);
        blog.setDate(dateString);
        blog.setTitle(title);
        blog.setIssure(issure);
        blog.setBlogAbstract(blogAbstract);
        blog.setUserId(userId);
        findAllWithPageService fs=new findAllWithPageService();
        int id=fs.addBlogService(blog);
        request.setAttribute("id",id);
        request.setAttribute("title",title);
        if(id>0){
            //success
            try {
                //response.sendRedirect("/addSuccess.jsp?id="+id+"&title="+title);
                request.getRequestDispatcher("/addSuccess.jsp").forward(request, response);
            }catch(Exception ex){
                ex.printStackTrace();
            }
        }
    }
    private void getBlogDetail(HttpServletRequest request, HttpServletResponse response){
        int id=Integer.parseInt(request.getParameter("id"));
        findAllWithPageService fs=new findAllWithPageService();
        Blog blog=new Blog();
        blog=fs. getBlogDetailService(id);
        request.setAttribute("blog",blog);
        try {
            request.getRequestDispatcher("/detail.jsp").forward(request, response);
        }catch (Exception ex){
            ex.printStackTrace();
        }
    }
    private void mangerBlog(HttpServletRequest request, HttpServletResponse response){
        int pageNum=Integer.parseInt(request.getParameter("pageNum"));
        int pageSize=11;
        findAllWithPageService ns=new findAllWithPageService();
        int blogLevel=Integer.parseInt(request.getParameter("blogLevel"));/*0:所有博客 1：精品博客 2：热门博客*/
        String operClass=request.getParameter("operClass");
        if(!operClass.equals("getAllBlog")){
            User user=(User)(request.getSession().getAttribute("user"));
            blogLevel=user.getUserId();
            System.out.print(blogLevel);
        }
        Page pg=ns.findAllNews(pageNum,pageSize,blogLevel,operClass);
        request.setAttribute("page",pg);
        try {
            request.getRequestDispatcher("/mangerBlog.jsp").forward(request, response);
        }catch (Exception ex){
            ex.printStackTrace();
        }
    }
    private void getUpdateBlog(HttpServletRequest request, HttpServletResponse response){
        int id=Integer.parseInt(request.getParameter("id"));
        findAllWithPageService ns=new findAllWithPageService();
        Blog blog=ns.getBlogIdService(id);
        request.setAttribute("blogUp",blog);
        request.setAttribute("ifUp","update");
        try {
            request.getRequestDispatcher("/addBlog.jsp").forward(request, response);
        }catch (Exception ex){
            ex.printStackTrace();
        }
    }
     private void updateBlog(HttpServletRequest request, HttpServletResponse response){
         int id=Integer.parseInt(request.getParameter("id"));
         String title=request.getParameter("blogTitle");
         String article=request.getParameter("container");
         String articleClass=request.getParameter("articleClass");
         String blogClass=request.getParameter("blogClass");
         User user=(User)(request.getSession().getAttribute("user"));
         String issure=user.getUsername();
         Date date=new Date();
         SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
         String dateString = formatter.format(date);
         Blog blog=new Blog();
         blog.setArticle(article);
         blog.setArticleClass(articleClass);
         blog.setBlogClass(blogClass);
         blog.setDate(dateString);
         blog.setTitle(title);
         blog.setIssure(issure);
         blog.setId(id);
         findAllWithPageService fs=new findAllWithPageService();
         int ifsucceed=fs.updateBlogService(blog);
         request.setAttribute("id",id);
         request.setAttribute("title",title);
         //int id=fs.addBlogService(blog);
         if(ifsucceed==1){
             try {
                 request.getRequestDispatcher("/addSuccess.jsp").forward(request, response);
             }catch(Exception ex){
                 ex.printStackTrace();
             }
         }
     }
    private void deleteBlog(HttpServletRequest request, HttpServletResponse response){
        int id=Integer.parseInt(request.getParameter("id"));
        findAllWithPageService fs=new findAllWithPageService();
        int ifsucceed=fs.deleteBlogService(id);
        if(ifsucceed==1){
            try {
                response.sendRedirect("/systemServlet?flag=manger&pageNum=1&operClass=getBlogById&blogLevel=0");
            }catch(Exception ex){
                ex.printStackTrace();
            }
        }
    }
    private void addComment(HttpServletRequest request, HttpServletResponse response){
        int id=Integer.parseInt(request.getParameter("id"));
        String comment=request.getParameter("comment");
        User user=(User)(request.getSession().getAttribute("user"));
        String username=user.getUsername();
        comment comm=new comment();
        comm.setArticleId(id);
        comm.setComment(comment);
        comm.setUsername(username);
        findAllWithPageService fs=new findAllWithPageService();
        fs.addCommentService(comm);
        try {
            response.getWriter().print("<script language='javascript'>alert('评论提交成功！！！');window.location.href='/FindAllWithPage?flag=checkDetail&id=" + id + "';</script>");
        }catch(Exception ex){
            ex.printStackTrace();
        }
    }
    private String getArticleAbstract(String article){
        String tempArticle="";
        String articleSucceed="";
        int length;
        if(article.length()>2000)
            length=2000;
        else{
length=article.length();
}
                   for(int i=0;i<length;i++){
            if(article.charAt(i)=='<'){
                while(article.charAt(i)!='>'){
                    i++;
                }
            }
            tempArticle=tempArticle+article.charAt(i);
        }
        for(int i=0;i<tempArticle.length();i++){
            if(tempArticle.charAt(i)=='<'||tempArticle.charAt(i)=='>'){
                continue;
            }
            articleSucceed=articleSucceed+ tempArticle.charAt(i);
        }
        if(articleSucceed.length()>120){
articleSucceed=articleSucceed.substring(0,120);

}
                   return  articleSucceed;
    }
}

