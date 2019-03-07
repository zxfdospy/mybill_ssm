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
    <script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <script src="js/bootstrap/3.3.6/bootstrap-datetimepicker.min.js"></script>
    <script src="js/bootstrap/3.3.6/bootstrap-datetimepicker.zh-CN.js"></script>
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

        $(function () {
            $("a").click(function () {
                var deleteLink = $(this).attr("deleteLink");
                if("true"==deleteLink){
                    var confirmDelete = confirm("确认要删除");
                    if(confirmDelete)
                        return true;
                    return false;
                }
            })
        })

    </script>
</head>
