package Filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by mafx on 2018/6/16.
 */
//@WebFilter(filterName = "LiginFilter")
public class LiginFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request=(HttpServletRequest)req;
        HttpServletResponse response=(HttpServletResponse) resp;
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session=request.getSession();
        if(session.getAttribute("user")==null){
            try{

                response.getWriter().print("<script language='javascript'>alert('您还没有登录，请登录');window.location.href='/index.jsp';</script>");
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

             return;
        }
        chain.doFilter(req, resp);
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
