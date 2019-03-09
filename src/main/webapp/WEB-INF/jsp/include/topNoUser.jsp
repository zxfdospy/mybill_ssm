<%--
  Created by IntelliJ IDEA.
  User: zxfdo
  Date: 2019/3/7
  Time: 12:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<title>我的小账本</title>

<script>
    $(function () {

        // var now=new Date();
        // now.setDate(1);
        // var DateStart=now.format("yyyy-MM-dd");
        // now.setMonth(now.getMonth()+1);
        // now.setDate(0);
        // var DateEnd=now.format("yyyy-MM-dd");
        var date = new Date()
        var firstDay = new Date(date.getFullYear(), date.getMonth(), 1);
        var lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);
        var DateStart=firstDay.format("yyyy-MM-dd");
        var DateEnd=lastDay.format("yyyy-MM-dd");
        $("#recordDateStart").val(DateStart);
        $("#recordDateEnd").val(DateEnd);
        $("#recordDateStart").attr("readonly","readonly");
        $("#recordDateEnd").attr("readonly","readonly");





        $("a#login,button#loginButton").click(function () {
            $("#loginModal").modal('show');
        });

        $("button.loginSubmitButton").click(function () {
            var name = $("#modalname").val();
            var password = $("#modalpassword").val();

            if (0 == name.length || 0 == password.length) {
                $("span.errorMessage").html("请输入账号密码");
                $("div.loginErrorMessageDiv").show();
                return false;
            }
            var page = "billLoginAjax";
            $.post(
                page,
                {"name": name, "password": password},
                function (result) {
                    if ("success" == result) {
                        location.href = "billhome";
                    } else {
                        $("span.errorMessage").html("账号密码错误");
                        $("div.loginErrorMessageDiv").show();
                    }
                }
            );
            return true;
        });





        // $('#recordDateStart,#recordDateEnd').datetimepicker({
        //     // container:"#addRule .modal-content",
        //     format: 'yyyy-mm-dd',
        //     autoclose: true,
        //     todayBtn: true,
        //     // initialDate: new Date(),
        //     language: 'zh-CN',
        // });
        //
        // // radio正选反选
        // $("#listAllCategoryRecord").click(function (event) {
        //     // 禁用事件的默认动作
        //     event.preventDefault();
        // });
        // $("#listAllCategoryRecord").mouseup(function () {
        //     $(this).prop("checked", !$(this).is(":checked"));
        //     if($(this).is(":checked"))
        //         $("#selectCategoryRecord").attr('disabled',true);
        //     else
        //         $("#selectCategoryRecord").attr('disabled',false);
        //     $("#selectCategoryRecord").selectpicker('refresh');
        // });

    })</script>

<div class="navitagorDiv">
    <nav class="navbar navbar-default navbar-fixed-top navbar-inverse">
        <%--<a class="navbar-brand" href="javascript:void(0)">本月消费</a>--%>
        <a class="navbar-brand" href="javascript:void(0)">分类预览</a>
        <a class="navbar-brand" href="javascript:void(0)">消费记录</a>
        <%--<a class="navbar-brand" href="javascript:void(0)">个人设置</a>--%>
        <div class="pull-right" style="display: inline-block;">
            <a id="login" class="navbar-brand " href="javascript:void(0)">登录</a>
            <a class="navbar-brand " href="registerPage">注册</a>
        </div>
    </nav>
</div>

<div class="workingArea">

    <%--<div class="recordSearchDiv">--%>
        <%--<table class="recordSearchTable">--%>
            <%--<td class="form-control">--%>
                <%--<span>全部分类</span><input id="listAllCategoryRecord" type="radio">--%>
            <%--</td>--%>
            <%--<td>--%>
                <%--<select id="selectCategoryRecord" class="selectpicker" title="请选择分类" multiple data-live-search="true"--%>
                        <%--data-selected-text-format="count > 3">--%>
                    <%--<option>1</option>--%>
                    <%--<option>2</option>--%>
                <%--</select>--%>
            <%--</td>--%>
            <%--<td>--%>
                <%--起日期--%>
            <%--</td>--%>
            <%--<td style="padding-left: 5px">--%>
                <%--<input class="form-control" size="16" type="text" value=""  id="recordDateStart"--%>
                       <%--name="recordDateStart">--%>
            <%--</td>--%>
            <%--<td>--%>
                <%--止日期--%>
            <%--</td>--%>
            <%--<td style="padding-left: 5px">--%>
                <%--<input class="form-control" size="16" type="text" value=""  id="recordDateEnd"--%>
                       <%--name="recordDateEnd">--%>
            <%--</td>--%>
            <%--<td>--%>
                <%--<button class="btn btn-success">搜索</button>--%>
            <%--</td>--%>
        <%--</table>--%>
    <%--</div>--%>

    <%--<div style="clear: both"></div>--%>


    <div style="margin: 30px auto" class="text-center">
        <h1>使用本服务请先注册或登录</h1>
        <div>
            <button id="loginButton" class="btn btn-primary">登录</button>
            <a class="btn btn-warning" href="registerPage">注册</a>
        </div>
    </div>
</div>
<div class="modal " id="loginModal" tabindex="-1" role="dialog">
    <div class="modal-dialog loginDivInProductPageModalDiv">
        <div class="modal-content">
            <div class="loginDivInProductPage">
                <div class="loginErrorMessageDiv">
                    <div class="alert alert-danger">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"></button>
                        <span class="errorMessage"></span>
                    </div>
                </div>

                <div class="login_acount_text">账户登录</div>
                <div class="loginInput ">
                            <span class="loginInputIcon ">
                                <span class=" glyphicon glyphicon-user"></span>
                            </span>
                    <input id="modalname" name="modalname" placeholder="手机/会员名/邮箱" type="text">
                </div>

                <div class="loginInput ">
                            <span class="loginInputIcon ">
                                <span class=" glyphicon glyphicon-lock"></span>
                            </span>
                    <input id="modalpassword" name="modalpassword" type="password" placeholder="密码" type="text">
                </div>
                <div>
                    <a href="#nowhere">忘记登录密码</a>
                    <a href="register.jsp" class="pull-right">免费注册</a>
                </div>
                <div style="margin-top:20px">
                    <button class="btn btn-block btn-primary loginSubmitButton" type="submit">登录</button>
                </div>
            </div>
        </div>
    </div>
</div>
