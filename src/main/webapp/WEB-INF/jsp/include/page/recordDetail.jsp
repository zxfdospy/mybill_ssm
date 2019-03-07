<%--
  Created by IntelliJ IDEA.
  User: zxfdo
  Date: 2019/3/7
  Time: 20:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<title>消费记录-我的小账本</title>

<script>

    function showRecordEditModal(obj) {
        var index = $(obj).attr("id");
        var id = $(obj).attr("recordid");
        var comment = document.getElementById('recordDetail').rows[index].cells[2].innerText;
        var date = document.getElementById('recordDetail').rows[index].cells[3].innerText;
        var spend = document.getElementById('recordDetail').rows[index].cells[4].innerText;
        var cid = $(obj).attr("recordcid");
        // console.log(id+"     "+cid);
        $("#recordEditID").val(id);
        $("#recordEditSpend").val(spend);
        $("#recordEditComment").val(comment);
        $("#recordEditDate").val(date);
        var page = "billCategoryRefreshByUid";
        $.post(
            page,
            function (data) {
                console.log(data);
                var categories = $.parseJSON(data);
                $("select#recordEditCategory").empty();
                for (i in categories) {
                    var old = $("select#recordEditCategory").html();
                    var category = categories[i];
                    if (category.id == cid)
                        $("select#recordEditCategory").html(old + "<option selected='selected' value='" + category.id + "'>" + category.name + "</option>");
                    else
                        $("select#recordEditCategory").html(old + "<option value='" + category.id + "'>" + category.name + "</option>");
                }
            }
        );
        $("#recordEditModal").modal('show');
    }


    $(function () {
        $('#recordEditDate').datetimepicker({
            // container:"#addRule .modal-content",
            format: 'yyyy-mm-dd hh:ii',
            autoclose: true,
            todayBtn: true,
            initialDate: new Date(),
            language: 'zh-CN',
        });

        $("#recordEditSubmitButton").click(function () {
            if (!checkEmpty("recordEditDate", "消费时间"))
                return false;
            if (!checkZero("recordEditSpend", "消费金额"))
                return false;
            var spend = $("#recordEditSpend").val();
            var cid = $("#recordEditCategory").val();
            var comment = $("#recordEditComment").val();
            var date = $("#recordEditDate").val();
            var id=$("#recordEditID").val();
            var page = "billRecordEditAjax";
            $.post(
                page,
                {"id":id,"spend": spend, "cid": cid, "comment": comment, "sdate": date},
                function (result) {
                    if (result == "success") {
                        location.reload();
                        alert("编辑成功");
                    } else {
                        alert("编辑失败");
                    }
                }
            )
        })
    })
</script>

<div class="workingArea">

    <div class="listDataTableDiv">
        <table id="recordDetail" class="table table-striped table-bordered table-hover table-condensed text-center ">
            <thead>
            <tr class="success">
                <td>序号</td>
                <td>分类</td>
                <td>备注</td>
                <td>时间</td>
                <td>金额</td>
                <td>编辑</td>
                <td>删除</td>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${rs}" var="r" varStatus="status">
                <tr>
                    <td>${status.count}</td>
                    <td>${r.category.name}</td>
                    <td>${r.comment}</td>
                    <td><fmt:formatDate value="${r.date}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>${r.spend/100}</td>
                    <td><a id="${status.count}" recordid="${r.id}" recordcid="${r.cid}" onclick="showRecordEditModal(this)" href="javascript:void(0)"><span class="glyphicon glyphicon-edit"></span></a></td>
                    <td><a deleteLink="true"  href="billRecordDelete?id=${r.id}"><span class="glyphicon glyphicon-trash"></span></a></td>
                </tr>
            </c:forEach>
            </tbody>

        </table>
    </div>

</div>

<div class="modal fade" id="recordEditModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header bg-warning">
                <button data-dismiss="modal" class="close" type="button">×<span class="sr-only">Close</span></button>
                <h4 class="modal-title">编辑记录</h4>
            </div>
            <div class="modal-body">
                <form method="post">
                    <table id="recordEditTable" class="recordEditTable">
                        <tr>
                            <td class="recordEditTableLeftTd">花费</td>
                            <td><input id="recordEditSpend" name="recordEditSpend" type="number" step="0.01"
                                       class="form-control"
                                       min="0"></td>
                        </tr>
                        <tr>
                            <td class="recordEditTableLeftTd">分类</td>
                            <td>
                                <select name="recordEditCategory" id="recordEditCategory" class="form-control">

                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="recordEditTableLeftTd">备注</td>
                            <td><input id="recordEditComment" name="recordEditComment" type="text" class="form-control">
                            </td>
                        </tr>
                        <tr>
                            <td class="recordEditTableLeftTd">日期</td>
                            <td><input class="form-control" size="16" type="text" value="" readonly id="recordEditDate"
                                       name="recordEditDate">
                            </td>
                        </tr>
                        <tr class="submitTR">
                            <td colspan="2" align="center">
                                <input type="hidden" id="recordEditID" value="">
                                <button type="submit" class="btn btn-success" id="recordEditSubmitButton">提 交
                                </button>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>