package com.zxfdospy.mybill.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PageController {

    @RequestMapping("billhome")
    String indexPage(){
        return "fore/index";
    }

    @RequestMapping("remind")
    String indexNoUserPage(){
        return "fore/indexNoUser";
    }
    @RequestMapping("registerPage")
    String registerPage(){
        return "fore/register";
    }
}
