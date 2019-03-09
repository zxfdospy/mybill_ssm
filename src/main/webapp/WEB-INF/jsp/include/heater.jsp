<%--
  Created by IntelliJ IDEA.
  User: zxfdo
  Date: 2019/3/6
  Time: 15:10
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>

<head>
    <script src="js/jquery/2.0.0/jquery.min.js"></script>
    <link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
    <link href="css/bootstrap/3.3.6/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <link href="css/bootstrap/3.3.6/bootstrap-select.css" rel="stylesheet">
    <script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <script src="js/bootstrap/3.3.6/bootstrap-datetimepicker.min.js"></script>
    <script src="js/bootstrap/3.3.6/bootstrap-datetimepicker.zh-CN.js"></script>
    <script src="js/bootstrap/3.3.6/bootstrap-select.js"></script>
    <link href="css/custom/style.css" rel="stylesheet">
    <script>
        function checkEmpty(id,name) {
            var value=$("#"+id).val();
            if(value.length==0){
                alert(name+"不能为空");
                $("#"+id).focus();
                return false;
            }
            return true;
        }


        function checkZero(id,name) {
            var value=$("#"+id).val();
            // alert(isNaN(value));
            if(value<=0) {
                alert(name+"不能小于等于0");
                $("#"+id).focus();
                return false;
            }
            return true
        }

        Date.prototype.format = function(format){
            var o = {
                "M+" : this.getMonth()+1, //month
                "d+" : this.getDate(), //day
                "H+" : this.getHours(), //hour
                "m+" : this.getMinutes(), //minute
                "s+" : this.getSeconds(), //second
                "q+" : Math.floor((this.getMonth()+3)/3), //quarter
                "S" : this.getMilliseconds() //millisecond
            }

            if(/(y+)/.test(format)) {
                format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
            }

            for(var k in o) {
                if(new RegExp("("+ k +")").test(format)) {
                    format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length));
                }
            }
            return format;
        };



        function refreshSelectCategory() {
            var page = "billCategoryRefreshByUid";
            $.post(
                page,
                function (data) {
                    // console.log(data);
                    var categories = $.parseJSON(data);
                    $("#selectCategoryRecord").empty();
                    for (i in categories) {
                        var old = $("#selectCategoryRecord").html();
                        var category = categories[i];
                        $("#selectCategoryRecord").html(old + "<option value='" + category.id + "'>" + category.name + "</option>");
                    }
                    $("#selectCategoryRecord").selectpicker("refresh");
                }
            );
        }

    </script>
</head>
