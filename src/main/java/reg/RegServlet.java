package reg;

import dao.Dao;
import it.cosenonjaviste.crypto.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RegServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String userName,password;
        userName = request.getParameter("username");
        password = request.getParameter("password");


        int result = 0;

        ResultSet rs = null;
        PreparedStatement ps = Dao.creatementStatement("select count(*) from user where name=?");
        try {
            ps.setString(1,userName);
            rs = ps.executeQuery();
            while (rs.next()){
                result = rs.getInt("count(*)");
            }
            if (result == 1){
                request.setAttribute("info","用户名重复,请在输一遍");
                request.getRequestDispatcher("/reg.jsp").forward(request,response);
            }else {
                String hashed = BCrypt.hashpw(password, BCrypt.gensalt());
                ps = Dao.creatementStatement("insert into user(name,pass) values(?,?)");
                try {
                    ps.setString(1,userName);
                    ps.setString(2,hashed);
                    result = ps.executeUpdate();
                    if (result == 1){
                        response.sendRedirect("/login.html");
                    }
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                }


            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }







    }
}
