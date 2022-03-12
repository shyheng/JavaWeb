package kcb;

import com.alibaba.fastjson.JSON;

import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.*;

public class KcbWeek {

    public static String day;

    public static int getweek(Date d1, Date d2) {
        // 获得当前日期与本周日相差的天数
        Calendar cd = Calendar.getInstance();
        cd.setTime(d2);
        int dayOfWeek = cd.get(Calendar.DAY_OF_WEEK) - 1;
        long daysBetween = (d1.getTime() - d2.getTime() + 1000000) / (60 * 60 * 24 * 1000);

        Calendar c = Calendar.getInstance();
        int days1 = (int) daysBetween-1;
        c.add(Calendar.DAY_OF_MONTH, -days1);
        day = day(c);

        int weekindex = (int) (daysBetween / 7 + 1);
        if (dayOfWeek + daysBetween % 7 > 7) {
            weekindex += 1;
        }
        return weekindex;
    }

    public static String day(Calendar calendar){
        SimpleDateFormat format = new SimpleDateFormat("MM-dd");
//            第一周第一天
        List<Map<String,String>> day1 = new ArrayList<>();
        for (int i = 0; i < 18; i++) {
            Map<String,String> map = new HashMap<>();
            if (i!=0){
                calendar.add(Calendar.DATE, 1);
            }
            map.put("w_1",format.format(calendar.getTime()));
            calendar.add(Calendar.DATE, 1);
            map.put("w_2",format.format(calendar.getTime()));
            calendar.add(Calendar.DATE, 1);
            map.put("w_3",format.format(calendar.getTime()));
            calendar.add(Calendar.DATE, 1);
            map.put("w_4",format.format(calendar.getTime()));
            calendar.add(Calendar.DATE, 1);
            map.put("w_5",format.format(calendar.getTime()));
            calendar.add(Calendar.DATE, 1);
            map.put("w_6",format.format(calendar.getTime()));
            calendar.add(Calendar.DATE, 1);
            map.put("w_7",format.format(calendar.getTime()));
            day1.add(map);
        }
        return JSON.toJSONString(day1);
    }

}
