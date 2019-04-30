package dao;

import entity.Blog;
import entity.User;
import entity.comment;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by mafx on 2019/4/20.
 */
public class newsDao {
    private final static String DRIVER = "com.mysql.jdbc.Driver";
    private final static String URL = "jdbc:mysql://localhost:3306/articlemanger?useUnicode=true&characterEncoding=utf-8";
    private final static String USERNAME = "root";
    private final static String PASSWORD = "root";
    QueryRunner run = new QueryRunner();
    Connection conn;
    String sql="select * from articles";
    List<Blog> list=new ArrayList<Blog>();
    public List<Blog> findAllNews(){
    try {
        Class.forName(DRIVER);
        conn= DriverManager.getConnection(URL,USERNAME,PASSWORD);
        list=run.query(conn,sql,new BeanListHandler<Blog>(Blog.class));
    }catch (Exception ex){
        ex.printStackTrace();
    }finally {
        try {
            conn.close();
        }catch (Exception ex){
            ex.printStackTrace();
        }
      }
        return list;
    }
    public List<Blog> findAllPageDao(int startIndex, int pageSize,int blogLevel,String operClass){
        String sql;
        if(operClass.equals("getAllBlog")){
            if(blogLevel==0) {
                sql = "select * from articles limit ?,?";//"所有博客"
            }else if(blogLevel==1){
                sql = "select * from articles where readNum>100 limit ?,?";//"精品博客"
            }else{
                sql = "select * from articles where readNum>50 and  readNum<100 limit ?,?";//"热门博客"
            }
        }else{
            sql = "select * from articles where userId="+blogLevel+" limit ?,?";
        }
        Object[] param={startIndex,pageSize};
        List<Blog> list=new ArrayList<Blog>();
        try {
            Class.forName(DRIVER);
            conn= DriverManager.getConnection(URL,USERNAME,PASSWORD);
            list=run.query(conn,sql,new BeanListHandler<Blog>(Blog.class),param);
        }catch (Exception ex){
            ex.printStackTrace();
        }finally {
            try {
                conn.close();
            }catch (Exception ex){
                ex.printStackTrace();
            }
        }
        return list;
    }
    public List<Blog> findAllPageDao(int startIndex, int pageSize,int blogLevel,String operClass,String litter){
        String sql="select * from articles where title like '%"+litter+"%' limit ?,?";
        Object[] param={startIndex,pageSize};
        List<Blog> list=new ArrayList<Blog>();
        try {
            Class.forName(DRIVER);
            conn= DriverManager.getConnection(URL,USERNAME,PASSWORD);
            list=run.query(conn,sql,new BeanListHandler<Blog>(Blog.class),param);
        }catch (Exception ex){
            ex.printStackTrace();
        }finally {
            try {
                conn.close();
            }catch (Exception ex){
                ex.printStackTrace();
            }
        }
        return list;
    }
    public User getUserByUsnAndPwd(String username, String pwd){
        String sql="SELECT * FROM users WHERE username=? AND pwd=?";
        User user=null;
        try {
            Class.forName(DRIVER);
            conn= DriverManager.getConnection(URL,USERNAME,PASSWORD);
            Object[] param={username,pwd};
            user=run.query(conn,sql,new BeanHandler<User>(User.class),param);
        }catch (Exception ex){
           ex.printStackTrace();
        }finally {
            try {
                conn.close();
            }catch(Exception ex){
                ex.printStackTrace();
            }
        }
       return user;
    }
    public int addBlogDao(Blog blog){
        String sql="insert into articles(title,date,article,issure,articleClass,blogClass,blogAbstract,userId)values(?,?,?,?,?,?,?,?)";
        String sql2="select id from articles";
        PreparedStatement ps=null;
        Object[] param={blog.getTitle(),blog.getDate(),blog.getArticle(),blog.getIssure(),blog.getArticleClass(),blog.getBlogClass(),blog.getBlogAbstract(),blog.getUserId()};
        ResultSet rs=null;
        int i=0;
        int id=-1;
        try {
            Class.forName(DRIVER);
            conn= DriverManager.getConnection(URL,USERNAME,PASSWORD);
            //run.insert(conn,sql,param);
             ps=conn.prepareStatement(sql2);
            i=run.update(conn,sql,param);
            if(i==1){
               rs=ps.executeQuery();
               rs.last();
               id=rs.getInt(1);
            }
        }catch (Exception ex){
            ex.printStackTrace();
        }finally {
            try {
                rs.close();
                ps.close();
                conn.close();
            }catch(Exception ex){
                ex.printStackTrace();
            }
        }
        return id;
    }
    public Blog getBlogByIdDao(int id){
        String sql="select * from articles where id="+id;
        Blog blog=null;
        try {
            Class.forName(DRIVER);
            conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            blog=run.query(conn, sql, new BeanHandler<Blog>(Blog.class));
        }catch(Exception ex){
           ex.printStackTrace();
        }finally {
            try {
                conn.close();
            }catch(Exception ex){
                ex.printStackTrace();
            }
        }
        return blog;
    }
    public int updateBlogDao(Blog blog){
        String sql="update articles set title=?,article=?,date=?,issure=?,articleClass=?,blogClass=? where id="+blog.getId();
        Object[] param={blog.getTitle(),blog.getArticle(),blog.getDate(),blog.getIssure(),blog.getArticleClass(),blog.getBlogClass()};
        int rows=0;
        try {
            Class.forName(DRIVER);
            conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            rows=run.update(conn,sql,param);

        }catch(Exception ex){
            ex.printStackTrace();
        }finally {
            try {
                conn.close();
            }catch(Exception ex){
                ex.printStackTrace();
            }
        }
        return rows;
    }
    public int deleteBlogDao(int id){
      String sql="delete from articles where id="+id;
        int rows=0;
        try {
            Class.forName(DRIVER);
            conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            rows=run.update(conn,sql);
        }catch(Exception ex){
            ex.printStackTrace();
        }finally {
            try {
                conn.close();
            }catch(Exception ex){
                ex.printStackTrace();
            }
        }
        return rows;
    }
    public void addComment(comment comm){
        String sql="insert into comment(comment,articleId,username)values(?,?,?)";
        Object[] prama={comm.getComment(),comm.getArticleId(),comm.getUsername()};
        try {
            Class.forName(DRIVER);
            conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            run.update(conn,sql,prama);
        }catch(Exception ex) {
            ex.printStackTrace();
        }
    }
    public List<comment> getCommentByIdDao(int id){
        String sql="select * from comment where articleId=?";
        String sql1="select readNum from articles where id="+id;
        String sql2="update articles set readNum=? where id=?";
        List<comment> commentsList=new ArrayList<comment>();
        try {
            Class.forName(DRIVER);
            conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            commentsList=run.query(conn,sql,new BeanListHandler<comment>(comment.class),id);
            PreparedStatement ps=conn.prepareStatement(sql1);
            PreparedStatement ps1=conn.prepareStatement(sql2);
            ResultSet rs=ps.executeQuery();
            rs.last();
            int reaNum=rs.getInt(1)+1;
            ps1.setInt(1,reaNum);
            ps1.setInt(2,id);
            ps1.executeUpdate();
        }catch(Exception ex) {
            ex.printStackTrace();
        }
        return commentsList;
    }
}
