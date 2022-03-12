package dao;

import com.alibaba.fastjson.JSON;
import kcb.Kcb;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class WeekDao {
    public static String week_1(){
        PreparedStatement ps = Dao.creatementStatement("select * from week_1");
        ResultSet rs = null;
        List<Kcb> kcbs = new ArrayList<>();
        try {
            rs = ps.executeQuery();
            while (rs.next()){
                kcbs.add(new Kcb(rs.getString("time"),
                        rs.getString("monday"),
                        rs.getString("tuesday"),
                        rs.getString("wednesday"),
                        rs.getString("thursday"),
                        rs.getString("friday"),
                        rs.getString("saturday"),
                        rs.getString("sunday")));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return JSON.toJSONString(kcbs);
    }

    public static String week_2(){
        PreparedStatement ps = Dao.creatementStatement("select * from week_2");
        ResultSet rs ;
        List<Kcb> kcbs = new ArrayList<>();
        try {
            rs = ps.executeQuery();
            while (rs.next()){
                kcbs.add(new Kcb(rs.getString("time"),
                        rs.getString("monday"),
                        rs.getString("tuesday"),
                        rs.getString("wednesday"),
                        rs.getString("thursday"),
                        rs.getString("friday"),
                        rs.getString("saturday"),
                        rs.getString("sunday")));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        return JSON.toJSONString(kcbs);
    }
}
