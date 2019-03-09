<%--
  Created by IntelliJ IDEA.
  User: zxfdo
  Date: 2019/2/18
  Time: 16:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>

<head>
    <script src="js/jquery/2.0.0/jquery.min.js"></script>
    <link href="css/bootstrap/3.3.6/bootstrap.min.css" rel="stylesheet">
    <script src="js/bootstrap/3.3.6/bootstrap.min.js"></script>
    <link href="css/custom/style.css" rel="stylesheet">

</head>


<script>
    $(function () {
        setInterval(changeTimeout,1000);
        function changeTimeout() {
            var time=$("span.timecount").text();
            time=time-1;
            $("span.timecount").text(time);
            if(time==0){
                self.location.href="billwelcome";
            }
        }
    })
</script>

<div class="registerSuccessDiv">

    <img src="img/site/registerSuccess.png">
    恭喜注册成功

    <div class="backtohome text-center"><span class="timecount" style="color:orange">3</span>秒后跳转首页...
    </div>
</div>


<%@include file="../include/footer.jsp"%>
