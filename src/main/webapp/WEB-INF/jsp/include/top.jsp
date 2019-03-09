<%--
  Created by IntelliJ IDEA.
  User: zxfdo
  Date: 2019/3/6
  Time: 15:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script>
    $(function () {
        $("button#addRecord").click(function () {
            var page = "billCategoryRefreshByUid";
            $.post(
                page,
                function (data) {
                    // console.log(data);
                    var categories = $.parseJSON(data);
                    $("select#recordCategory").empty();
                    for (i in categories) {
                        var old = $("select#recordCategory").html();
                        var category = categories[i];
                        $("select#recordCategory").html(old + "<option value='" + category.id + "'>" + category.name + "</option>");
                    }
                }
            );
            $("#recordAddModal").modal('show');
        });

        $('#recordDate').datetimepicker({
            // container:"#addRule .modal-content",
            format: 'yyyy-mm-dd hh:ii',
            autoclose: true,
            todayBtn: true,
            initialDate: new Date(),
            language: 'zh-CN',
        });
        $("button#addCategory").click(function () {
            $("#categoryAddModal").modal('show');
        });

        $("#categorySubmitButton").click(function () {
            if (!checkEmpty("categoryName", "分类名称"))
                return false;
            var name = $("#categoryName").val();
            var check = "billCategoryIsExist";
            $.post(
                check,
                {'name': name},
                function (result) {
                    if (result == "success") {
                        var page = "billCategoryAddAjax";
                        $.post(
                            page,
                            {'name': name},
                            function (result) {
                                if ("success" == result) {
                                    // location.reload();
                                    alert("添加成功");
                                    refreshSelectCategory();
                                    $("#categoryAddModal").modal('hide');
                                    categorySearch();
                                } else {
                                    alert("添加失败");
                                    $("#categoryAddModal").modal('hide');
                                }
                            }
                        )
                    } else {
                        alert("分类重复");
                        $(this).focus();
                    }
                }
            )
        });

        $("#recordSubmitButton").click(function () {
                if (!checkEmpty("recordDate", "消费时间"))
                    return false;
                if (!checkZero("recordSpend", "消费金额"))
                    return false;
                var spend = $("#recordSpend").val();
                var cid = $("#recordCategory").val();
                var comment = $("#recordComment").val();
                var date = $("#recordDate").val();
                var page = "billRecordAddAjax";
                $.post(
                    page,
                    {"spend": spend, "cid": cid, "comment": comment, "sdate": date},
                    function (result) {
                        if (result == "success") {
                            // location.reload();
                            alert("添加成功");
                            $("#recordAddModal").modal('hide');
                            recordSearch();
                        } else {
                            alert("添加失败");
                            $("#recordAddModal").modal('hide');
                        }
                    }
                )
            }
        )
    })</script>


<div class="navitagorDiv">
    <nav class="navbar navbar-inverse navbar-fixed-top">
        <%--<a class="navbar-brand" href="javascript:void(0)">本月消费</a>--%>
        <a class="navbar-brand" href="billCategoryList">分类预览</a>
        <a class="navbar-brand" href="billRecordList">消费记录</a>
        <%--<a class="navbar-brand" href="javascript:void(0)">个人设置</a>--%>
        <%--<div class="searchDiv" style="padding-top:8px">--%>
            <%--<div class="input-group">--%>
                <%--<input type="text" class="form-control" placeholder="Search for...">--%>
                <%--<span class="input-group-btn"><button class="btn btn-default" type="submit">搜索</button></span>--%>
            <%--</div>--%>
        <%--</div>--%>
        <div class="pull-right" style="display: inline-block;">
            <div class="pull-left" style="display: inline-block;padding-top: 8px">
                <button id="addRecord" class="btn btn-primary" type="button">记一笔</button>
                <button id="addCategory" class="btn btn-warning" type="button">增加分类</button>
            </div>
            <a id="login" class="navbar-brand " href="javascript:void(0)">${user.name}</a>
            <a class="navbar-brand " href="loginout">退出</a>
        </div>
        <div style="clear:both"></div>
    </nav>
</div>


<div class="modal fade" id="recordAddModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header bg-warning">
                <button data-dismiss="modal" class="close" type="button">×<span class="sr-only">Close</span></button>
                <h4 class="modal-title">添加记录</h4>
            </div>
            <div class="modal-body">
                <table id="recordAddTable" class="recordAddTable">
                    <tr>
                        <td class="recordAddTableLeftTd">花费</td>
                        <td><input id="recordSpend" name="recordSpend" type="number" step="0.01"
                                   class="form-control"
                                   min="0"></td>
                    </tr>
                    <tr>
                        <td class="recordAddTableLeftTd">分类</td>
                        <td>
                            <select name="recordCategory" id="recordCategory" class="form-control">

                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="recordAddTableLeftTd">备注</td>
                        <td><input id="recordComment" name="recordComment" type="text" class="form-control"></td>
                    </tr>
                    <tr>
                        <td class="recordAddTableLeftTd">日期</td>
                        <td><input class="form-control" size="16" type="text" value="" readonly id="recordDate"
                                   name="recordDate">
                        </td>
                    </tr>
                    <tr class="submitTR">
                        <td colspan="2" align="center">
                            <button type="button" class="btn btn-success" id="recordSubmitButton">提 交
                            </button>
                        </td>
                    </tr>
                </table>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>

<div class="modal fade" id="categoryAddModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header bg-warning">
                <button data-dismiss="modal" class="close" type="button">×<span class="sr-only">Close</span></button>
                <h4 class="modal-title">添加分类</h4>
            </div>
            <div class="modal-body">
                <table id="categoryAddTable" class="categoryAddTable">
                    <tr>
                        <td class="categoryAddTableLeftTd">分类名称</td>
                        <td><input id="categoryName" name="categoryName" type="text" class="form-control"></td>
                    </tr>
                    <tr class="submitTR">
                        <td colspan="2" align="center">
                            <button type="button" class="btn btn-success" id="categorySubmitButton">增加</button>
                        </td>
                    </tr>
                </table>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>
