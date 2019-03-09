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
                // console.log(data);
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

    function recordSearch(){
        var all = $("#listAllCategoryRecord").is(":checked");
        var cs = null;
        if (all == false)
            cs = $("#selectCategoryRecord").val();
        if(cs==null) {
            $("#listAllCategoryRecord").prop("checked", true);
            $("#selectCategoryRecord").attr('disabled', true);
            $("#selectCategoryRecord").selectpicker('refresh');
            all=true;
        }
        else
            cs=cs.toString();
        var start = $("#recordDateStart").val();
        var end = $("#recordDateEnd").val();
        var page = "billRecordSearchList";
        $.post(
            page,
            {"all": all, "cs": cs, "start": start, "end": end},
            function (data) {
                // console.log(data);
                var rs=$.parseJSON(data);
                // console.log(rs);
                var html = '';
                for ( var i = 0; i < rs.length; i++) {//循环json对象，拼接tr,td的html
                    html = html + '<tr>';
                    html = html + '<td>' + (i+1) + '</td>';
                    html = html + '<td>' + rs[i].category.name + '</td>';
                    html = html + '<td>' + rs[i].comment + '</td>';
                    var newDate=new Date(parseInt(rs[i].date));
                    date=newDate.format("yyyy-MM-dd HH:mm");
                    html = html + '<td>' + date+ '</td>';
                    html = html + '<td>' + rs[i].spend/100 + '</td>';
                    html = html + '<td>' +'<a '+'id='+(i+1)+' recordid='+rs[i].id+' recordcid='+rs[i].cid+" onclick='showRecordEditModal(this)'"
                        +" href='javascript:void(0)'"+'>'+'<span'+" class='glyphicon glyphicon-edit'"+'>'+'</span>'+'</a>'+ '</td>';
                    html = html + '<td>' +'<a '+" href='javascript:void(0)'"+" onclick='deleteRecord("+rs[i].id+")'"+'>'+'<span'+" class='glyphicon glyphicon-trash'"+'>'+'</span>'+'</a>'+ '</td>';
                    html = html + '</tr>';
                }
                $("#recordDetailTbody").empty();
                $("#recordDetailTbody").html(html);
            }
        )
    }

    function deleteRecord(id){
        if(confirm("确认删除？")) {
            var page = "billRecordDelete";
            $.post(
                page,
                {"id": id},
                function (result) {
                    if (result == "success") {
                        // alert("删除成功");
                        recordSearch();
                    }else {
                        alert("删除失败");
                    }
                }
            )
        }else {
            return false;
        }
    }


    $(function () {

        // 设置默认起止时间
        var date = new Date()
        var firstDay = new Date(date.getFullYear(), date.getMonth(), 1);
        var lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);
        var DateStart = firstDay.format("yyyy-MM-dd");
        var DateEnd = lastDay.format("yyyy-MM-dd");
        $("#recordDateStart").val(DateStart);
        $("#recordDateEnd").val(DateEnd);
        $("#recordDateStart").attr("readonly", "readonly");
        $("#recordDateEnd").attr("readonly", "readonly");

        // 给分类选项框加载分类
        refreshSelectCategory();
        //刷新表格
        recordSearch();


        $('#recordEditDate').datetimepicker({
            // container:"#addRule .modal-content",
            format: 'yyyy-mm-dd hh:ii',
            autoclose: true,
            todayBtn: true,
            // initialDate: new Date(),
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
            var id = $("#recordEditID").val();
            var page = "billRecordEditAjax";
            $.post(
                page,
                {"id": id, "spend": spend, "cid": cid, "comment": comment, "sdate": date},
                function (result) {
                    if (result == "success") {
                        // location.reload();
                        alert("编辑成功");
                        $("#recordEditModal").modal('hide');
                        recordSearch();
                    } else {
                        alert("编辑失败");
                        $("#recordEditModal").modal('hide');
                    }
                }
            )
        });

        $('#recordDateStart,#recordDateEnd').datetimepicker({
            // container:"#addRule .modal-content",
            format: 'yyyy-mm-dd',
            autoclose: true,
            todayBtn: true,
            minView:2,
            // initialDate: new Date(),
            language: 'zh-CN',
        });

        // radio正选反选
        $("#listAllCategoryRecord").click(function (event) {
            // 禁用事件的默认动作
            event.preventDefault();
        });
        $("#listAllCategoryRecord").mouseup(function () {
            $(this).prop("checked", !$(this).is(":checked"));
            if ($(this).is(":checked"))
                $("#selectCategoryRecord").attr('disabled', true);
            else
                $("#selectCategoryRecord").attr('disabled', false);
            $("#selectCategoryRecord").selectpicker('refresh');
        });


        $("#recordSearchButton").click(function () {
            recordSearch();
        })

    })
</script>

<div class="workingArea">

    <div class="recordSearchDiv">
        <table class="recordSearchTable">
            <td class="form-control">
                <span>全部分类</span><input id="listAllCategoryRecord" name="listAllCategoryRecord" type="radio" checked="checked">
            </td>
            <td>
                <select id="selectCategoryRecord" name="selectCategoryRecord" class="selectpicker" title="请选择分类" disabled="disabled"
                        multiple data-live-search="true"
                        data-selected-text-format="count > 3">
                </select>
            </td>
            <td>
                起日期
            </td>
            <td style="padding-left: 5px">
                <input class="form-control" size="16" type="text" value="" name="recordDateStart" id="recordDateStart">
            </td>
            <td>
                止日期
            </td>
            <td style="padding-left: 5px">
                <input class="form-control" size="16" type="text" value="" name="recordDateEnd" id="recordDateEnd">
            </td>
            <td>
                <button id="recordSearchButton" class="btn btn-success" type="button">搜索</button>
            </td>
        </table>
    </div>

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
            <tbody id="recordDetailTbody">
            <%--<c:forEach items="${rs}" var="r" varStatus="status">--%>
                <%--<tr>--%>
                    <%--<td>${status.count}</td>--%>
                    <%--<td>${r.category.name}</td>--%>
                    <%--<td>${r.comment}</td>--%>
                    <%--<td><fmt:formatDate value="${r.date}" pattern="yyyy-MM-dd HH:mm"/></td>--%>
                    <%--<td>${r.spend/100}</td>--%>
                    <%--<td><a id="${status.count}" recordid="${r.id}" recordcid="${r.cid}"--%>
                           <%--onclick="showRecordEditModal(this)" href="javascript:void(0)"><span--%>
                            <%--class="glyphicon glyphicon-edit"></span></a></td>--%>
                    <%--<td><a href="javascript:void(0)" onclick="deleteRecord(${r.id})"><span--%>
                            <%--class="glyphicon glyphicon-trash"></span></a></td>--%>
                <%--</tr>--%>
            <%--</c:forEach>--%>
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
                                <button type="button" class="btn btn-success" id="recordEditSubmitButton">提 交
                                </button>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>


