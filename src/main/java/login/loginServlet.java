package login;


import dao.Dao;
import it.cosenonjaviste.crypto.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class loginServlet extends HttpServlet {


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        1调用请求对象对请求体使用utf-8字符集进行重新编辑
        request.setCharacterEncoding("utf-8");
        String userName,password;
//        2调用请求对象读取请求体参数信息
        userName = request.getParameter("userName");
        password = request.getParameter("password");

        PreparedStatement ps = Dao.creatementStatement("select count(*) from user where name=?");
        ResultSet rs = null;
        int result=0;
        String pass = null;
        try {
            ps.setString(1,userName);
            rs = ps.executeQuery();
            while (rs.next()){
                result = rs.getInt("count(*)");
            }
            if (result == 1){
                ps = Dao.creatementStatement("select pass from user where name=?");
                ps.setString(1,userName);
                rs = ps.executeQuery();
                while (rs.next()){
                    pass = rs.getString("pass");
                }
                if (!BCrypt.checkpw(password,pass)){
                    result = 0;
                }
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        if (result == 1){
            HttpSession session = request.getSession();
            session.setAttribute(userName,"登录成功");
            response.sendRedirect("/index.html");
        }else {
            response.sendRedirect("/login_err.html");
        }
    }


}