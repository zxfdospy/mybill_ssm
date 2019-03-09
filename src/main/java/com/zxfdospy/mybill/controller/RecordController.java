package com.zxfdospy.mybill.controller;

import com.alibaba.fastjson.JSONObject;
import com.zxfdospy.mybill.pojo.Record;
import com.zxfdospy.mybill.pojo.User;
import com.zxfdospy.mybill.service.RecordService;
import com.zxfdospy.mybill.util.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class RecordController {
    @Autowired
    RecordService recordService;

    @RequestMapping("billRecordAddAjax")
    @ResponseBody
    String billRecordAddAjax(@RequestParam String spend,@RequestParam String cid,@RequestParam String comment,@RequestParam String sdate, HttpSession session){
        User user=(User) session.getAttribute("user");
        if(user==null)
            return "fail";
        int uid=user.getId();
        double dSpend=Double.parseDouble(spend);
        dSpend*=100;
        long lSpend=(long)dSpend;
        Record record=new Record();
        comment= HtmlUtils.htmlEscape(comment);
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        Date date=new Date();
        try {
             date=simpleDateFormat.parse(sdate);
        } catch (ParseException e) {
            e.printStackTrace();
            return "fail";
        }
        record.setCid(Integer.parseInt(cid));
        record.setComment(comment);
        record.setSpend(lSpend);
        record.setDate(date);
        record.setUid(uid);
        recordService.add(record);
        return "success";
    }

//    @RequestMapping("billRecordList")
//    String billRecordsList(HttpSession session, Model model){
//        User user=(User)session.getAttribute("user");
//        if(user==null){
//            return "fore/indexNoUser";
//        }
//        int uid=user.getId();
//        List<Record> rs=recordService.listOrderByDate(uid);
//        List<Record> rs=recordService.listSearch(user.getId(),true, DateUtil.getThisMonthBegin(),DateUtil.getThisMonthEnd(),null);
//        model.addAttribute("rs",rs);
//        System.out.println(new Date().toString());
//        return "fore/listRecord";
//    }

    @RequestMapping("billRecordEditAjax")
    @ResponseBody
    String billRecordEditAjax(@RequestParam String id,@RequestParam String spend,@RequestParam String cid,@RequestParam String comment,@RequestParam String sdate, HttpSession session){
        User user=(User) session.getAttribute("user");
        if(user==null)
            return "fail";
        int uid=user.getId();
        int rid=Integer.parseInt(id);
        double dSpend=Double.parseDouble(spend);
        dSpend*=100;
        long lSpend=(long)dSpend;
        Record record=new Record();
        comment= HtmlUtils.htmlEscape(comment);
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        Date date=new Date();
        try {
            date=simpleDateFormat.parse(sdate);
        } catch (ParseException e) {
            e.printStackTrace();
            return "fail";
        }
        record.setCid(Integer.parseInt(cid));
        record.setComment(comment);
        record.setSpend(lSpend);
        record.setDate(date);
        record.setUid(uid);
        record.setId(rid);
        recordService.update(record);
        return "success";
    }

    @RequestMapping("billRecordDelete")
    @ResponseBody
    String billRecordDelete(@RequestParam int id){
        recordService.delete(id);
        return "success";
    }


    @RequestMapping("billRecordSearchList")
    @ResponseBody
    String billRecordSearchList(@RequestParam boolean all,@RequestParam String start,@RequestParam String end,@RequestParam List<Integer> cs,HttpSession session){
        User user=(User)session.getAttribute("user");
        List<Record> rs=recordService.listSearch(user.getId(),all,start,end,cs);
        return JSONObject.toJSONString(rs);
    }
}
