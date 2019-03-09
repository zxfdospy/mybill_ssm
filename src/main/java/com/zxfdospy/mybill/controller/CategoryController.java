package com.zxfdospy.mybill.controller;

import com.zxfdospy.mybill.pojo.Category;
import com.zxfdospy.mybill.pojo.Record;
import com.zxfdospy.mybill.pojo.User;
import com.zxfdospy.mybill.service.CategoryService;
import com.zxfdospy.mybill.service.RecordService;
import com.zxfdospy.mybill.util.DateUtil;
import org.omg.CORBA.DATA_CONVERSION;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import javax.servlet.http.HttpSession;
import java.util.List;
import com.alibaba.fastjson.JSONObject;

@Controller
public class CategoryController {
    @Autowired
    CategoryService categoryService;
    @Autowired
    RecordService recordService;

    @RequestMapping("billCategoryAddAjax")
    @ResponseBody
    String billCategoryAddAjax(Category category, HttpSession session){
        User user=(User)session.getAttribute("user");
        if(user==null)
            return "fail";
        String name=category.getName();
        name= HtmlUtils.htmlEscape(name);
        int uid=user.getId();
        category.setUid(uid);
        category.setName(name);
        categoryService.add(category);
        return "success";
    }

    @RequestMapping("billCategoryEditAjax")
    @ResponseBody
    String billCategoryEditAjax(Category category, HttpSession session){
        User user=(User)session.getAttribute("user");
        if(user==null)
            return "fail";
        String name=category.getName();
        name= HtmlUtils.htmlEscape(name);
        int uid=user.getId();
        category.setUid(uid);
        categoryService.update(category);
        return "success";
    }


    @RequestMapping("billCategoryRefreshByUid")
    @ResponseBody
    String billCategoryRefreshByUid(HttpSession session){
        User user=(User)session.getAttribute("user");
        int uid=user.getId();
        List<Category> cs=categoryService.listByUid(uid);
        return JSONObject.toJSONString(cs);
    }

//    @RequestMapping("billCategoryList")
//    String billCategoryList(HttpSession session, Model model){
//        User user=(User)session.getAttribute("user");
//        int uid=user.getId();
//        List<Record> rs=recordService.listOrderByDate(uid);
//        List<Category> cs=categoryService.listByUid(uid);
//        for(Category c:cs){
//            long categorySpend=0;
//            int recordCount=0;
//            for(Record r:rs){
//                if(r.getCid()==c.getId()){
//                    categorySpend+=r.getSpend();
//                    recordCount++;
//                }
//            }
//            c.setCategorySpend(categorySpend);
//            c.setRecordCount(recordCount);
//        }
//        model.addAttribute("cs",cs);
//        return "fore/listCategory";
//    }



    @RequestMapping("billCategoryDelete")
    @ResponseBody
    String billCategoryDelete(@RequestParam int id){
        try {
            categoryService.delete(id);
        }catch (Exception e){
            return "fail";
        }
        return "success";
    }

    @RequestMapping("billCategoryIsExist")
    @ResponseBody
    String billCategoryIsExist(@RequestParam String name,HttpSession session){
        User user=(User)session.getAttribute("user");
        if(!categoryService.isExist(user.getId(),name))
            return "success";
        else
            return "fail";
    }

    @RequestMapping("billCategorySearchList")
    @ResponseBody
    String billCategorySearchList(@RequestParam boolean all,@RequestParam String start,@RequestParam String end,@RequestParam List<Integer> cs,HttpSession session){
        User user=(User)session.getAttribute("user");
        List<Record> rs=recordService.listSearch(user.getId(),all,start,end,cs);
        List<Category> categories=categoryService.listSearch(user.getId(),all,cs);
        for(Category c:categories){
            long categorySpend=0;
            int recordCount=0;
            for(Record r:rs){
                if(r.getCid()==c.getId()){
                    categorySpend+=r.getSpend();
                    recordCount++;
                }
            }
            c.setCategorySpend(categorySpend);
            c.setRecordCount(recordCount);
        }
        return JSONObject.toJSONString(categories);
    }
}
