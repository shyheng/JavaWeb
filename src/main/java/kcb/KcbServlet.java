package kcb;

import dao.Dao;
import dao.WeekDao;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import static kcb.KcbWeek.day;

public class KcbServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        String we = req.getParameter("week");
        int weeks = Integer.parseInt(we);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("utf-8");

        if (weeks%2 == 1){
            resp.getWriter().print(WeekDao.week_1());
        }else {
            resp.getWriter().print(WeekDao.week_2());
        }
        resp.getWriter().flush();
    }
}
