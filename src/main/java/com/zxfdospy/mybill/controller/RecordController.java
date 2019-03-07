package com.zxfdospy.mybill.controller;

import com.zxfdospy.mybill.pojo.Record;
import com.zxfdospy.mybill.pojo.User;
import com.zxfdospy.mybill.service.RecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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

    @RequestMapping("billRecordList")
    String billRecordsList(HttpSession session, Model model){
        User user=(User)session.getAttribute("user");
//        if(user==null){
//            return "fore/indexNoUser";
//        }
        int uid=user.getId();
        List<Record> rs=recordService.listOrderByDate(uid);
        model.addAttribute("rs",rs);
        return "fore/listRecord";
    }

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
    String billRecordDelete(int id){
        recordService.delete(id);
        return "redirect:billRecordList";
    }

}
