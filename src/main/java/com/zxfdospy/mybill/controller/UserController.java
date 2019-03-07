package com.zxfdospy.mybill.controller;

import com.zxfdospy.mybill.pojo.User;
import com.zxfdospy.mybill.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import javax.servlet.http.HttpSession;

@Controller
public class UserController {
    @Autowired
    UserService userService;

    @RequestMapping("billRegisterUser")
    String billRegisterUser(Model model, User user, HttpSession session){
        String name =  user.getName();
        boolean exist = userService.isExist(name);
        name = HtmlUtils.htmlEscape(name);
        user.setName(name);
        user.setPassword(DigestUtils.md5DigestAsHex(user.getPassword().getBytes()));


        if(exist){
            String m ="用户名已经被使用,不能使用";
            model.addAttribute("msg", m);
            model.addAttribute("user", null);
            return "fore/register";
        }
        userService.add(user);
        session.setAttribute("user",user);
        return "fore/registerSuccessPage";
    }

    @RequestMapping("loginout")
    String loginout(HttpSession session){
        session.removeAttribute("user");
        return "fore/index";
    }

    @RequestMapping("billLoginAjax")
    @ResponseBody
    public String billLoginAjax(@RequestParam("name") String name, @RequestParam("password") String password,HttpSession session) {
        name = HtmlUtils.htmlEscape(name);
        password=DigestUtils.md5DigestAsHex(password.getBytes());
        User user = userService.get(name,password);
        if(null==user){
            return "fail";
        }
        session.setAttribute("user", user);
        return "success";
    }


}
