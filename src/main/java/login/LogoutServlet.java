package login;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class LogoutServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        String we = req.getParameter("p1");
        if (loginServlet.password.equals(we)){
            resp.sendRedirect("/login.html");
        }else {
            req.setAttribute("info","密码错误");
            req.getRequestDispatcher("/logout.jsp").forward(req,resp);
        }
    }
}
