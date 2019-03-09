package com.zxfdospy.mybill.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtil {

    public static String getThisMonthBegin(){
        Calendar c=Calendar.getInstance();
        c.setTime(new Date());
        c.set(Calendar.DATE,1);
        c.set(Calendar.HOUR_OF_DAY,0);
        c.set(Calendar.MINUTE,0);
        c.set(Calendar.SECOND,0);
        c.set(Calendar.MILLISECOND,0);
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        String begin=sdf.format(c.getTime());
        return begin;
    }

    public static String getThisMonthEnd(){
        Calendar c=Calendar.getInstance();
        c.setTime(new Date());
        c.set(Calendar.HOUR_OF_DAY,0);
        c.set(Calendar.MINUTE,0);
        c.set(Calendar.SECOND,0);
        c.set(Calendar.MILLISECOND,0);
        c.set(Calendar.DATE,1);
        c.add(Calendar.MONTH,1);
        c.add(Calendar.SECOND,-1);
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        String end=sdf.format(c.getTime());
        return end;
    }
}
