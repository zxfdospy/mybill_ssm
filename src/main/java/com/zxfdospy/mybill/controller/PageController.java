package com.zxfdospy.mybill.controller;

import com.zxfdospy.mybill.pojo.User;
import com.zxfdospy.mybill.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class PageController {
    @Autowired
    CategoryService categoryService;

    @RequestMapping("billwelcome")
    String billwelcome(){
        return "fore/index";
    }

    @RequestMapping("billhome")
    String indexPage(){
        return "fore/listRecord";
    }

    @RequestMapping("remind")
    String indexNoUserPage(){
        return "fore/indexNoUser";
    }
    @RequestMapping("registerPage")
    String registerPage(){
        return "fore/register";
    }
    @RequestMapping("billRecordList")
    String billRecordList(){
        return "fore/listRecord";
    }

    @RequestMapping("billCategoryList")
    String billCategoryList(){
        return "fore/listCategory";
    }
}
