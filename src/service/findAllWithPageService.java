package service;

import dao.newsDao;
import entity.Blog;
import entity.Page;
import entity.User;
import entity.comment;

import java.util.List;
/**
 * Created by mafx on 2018/6/5.
 */
public class FindAllWithPageService {
    public Page<Blog> findAllNews(int pageNum, int pageSize,int blogLevel,String operClass) {
        newsDao newsDao=new newsDao();
        List<Blog> news = newsDao.findAllNews();
        int totalRecord = news.size();
        Page pg = new Page(pageNum,pageSize,totalRecord);
        int startIndex=pg.getStartIndex();
        pg.setList(newsDao.findAllPageDao(startIndex,pageSize,blogLevel,operClass));
        return pg;
    }
    public Page<Blog> findAllNews(int pageNum, int pageSize,int blogLevel,String operClass,String litter) {
        NewsDao newsDao=new NewsDao();
        List<Blog> news = newsDao.findAllNews();
        int totalRecord = news.size();
        Page pg = new Page(pageNum,pageSize,totalRecord);
        int startIndex=pg.getStartIndex();
        pg.setList(newsDao.findAllPageDao(startIndex,pageSize,blogLevel,operClass,litter));
        return pg;
    }
    public User getUserByUsnAndPwd(String username, String pwd){
        NewsDao newsDao=new NewsDao();
       return newsDao.getUserByUsnAndPwd(username,pwd);
    }
    public int addBlogService(Blog blog){
        NewsDao newsDao=new NewsDao();
        int id=newsDao.addBlogDao(blog);
        return id;
    }
    public Blog getBlogDetailService(int id){
        NewsDao newsDao=new NewsDao();
        return newsDao.getBlogByIdDao(id);
    }
    public Blog getBlogIdService(int id){
        NewsDao newsDao=new NewsDao();
        return newsDao.getBlogByIdDao(id);
    }
    public int updateBlogService(Blog blog){
        NewsDao newsDao=new NewsDao();
        return newsDao.updateBlogDao(blog);
    }
    public int deleteBlogService(int id){
        NewsDao newsDao=new NewsDao();
        return newsDao.deleteBlogDao(id);

    }
    public void addCommentService(comment comm){
        NewsDao newsDao=new NewsDao();
        newsDao.addComment(comm);
    }
    public List<comment> getCommentById(int id){
        NewsDao newsDao=new NewsDao();
        return newsDao.getCommentByIdDao(id);
    }
}