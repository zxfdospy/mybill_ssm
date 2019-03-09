<%--
  Created by IntelliJ IDEA.
  User: zxfdo
  Date: 2019/3/7
  Time: 21:35
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix='fmt' %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<title>分类预览-我的小账本</title>

<script>
    function showCategoryEditModal(obj) {
        var index = $(obj).attr("id");
        var id = $(obj).attr("categoryid");
        var name = document.getElementById('categoryDetail').rows[index].cells[1].innerText;
        // console.log(id+"     "+cid);
        $("#categoryEditId").val(id);
        $("#categoryEditName").val(name);
        $("#categoryEditModal").modal('show');
    }

    function categorySearch(){
        var all = $("#listAllCategory").is(":checked");
        var cs = null;
        if (all == false)
            cs = $("#selectCategoryRecord").val();
        if(cs==null) {
            $("#listAllCategory").prop("checked", true);
            $("#selectCategoryRecord").attr('disabled', true);
            $("#selectCategoryRecord").selectpicker('refresh');
            all=true;
        }
        else
            cs=cs.toString();
        var start = $("#categoryDateStart").val();
        var end = $("#categoryDateEnd").val();
        var page = "billCategorySearchList";
        console.log(all);
        console.log(cs);
        console.log(start);
        console.log(end);

        $.post(
            page,
            {"all": all, "cs": cs, "start": start, "end": end},
            function (data) {
                // console.log(data);
                var cs=$.parseJSON(data);
                // console.log(rs);
                var html = '';
                for ( var i = 0; i < cs.length; i++) {//循环json对象，拼接tr,td的html
                    html = html + '<tr>';
                    html = html + '<td>' + (i+1) + '</td>';
                    html = html + '<td>' + cs[i].name + '</td>';
                    html = html + '<td>' + cs[i].recordCount + '</td>';
                    html = html + '<td>' + cs[i].categorySpend/100 + '</td>';
                    html = html + '<td>' +'<a '+'id='+(i+1)+' categoryid='+cs[i].id+" onclick='showCategoryEditModal(this)'"
                        +" href='javascript:void(0)'"+'>'+'<span'+" class='glyphicon glyphicon-edit'"+'>'+'</span>'+'</a>'+ '</td>';
                    html = html + '<td>' +'<a '+" href='javascript:void(0)'"+" onclick='deleteCategory("+cs[i].id+")'"+'>'+'<span'+" class='glyphicon glyphicon-trash'"+'>'+'</span>'+'</a>'+ '</td>';
                    html = html + '</tr>';
                }
                $("#categoryDetailTbody").empty();
                $("#categoryDetailTbody").html(html);
            }
        )
    }

    function deleteCategory(id){
        if(confirm("确认删除？")) {
            var page = "billCategoryDelete";
            $.post(
                page,
                {"id": id},
                function (result) {
                    if (result == "success") {
                        // alert("删除成功");
                        categorySearch();
                    }else {
                        alert("删除失败,请保证此分类下无记录");
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
        $("#categoryDateStart").val(DateStart);
        $("#categoryDateEnd").val(DateEnd);
        $("#categoryDateStart").attr("readonly", "readonly");
        $("#categoryDateEnd").attr("readonly", "readonly");

        // 给分类选项框加载分类
        refreshSelectCategory();
        //获取表格数据
        categorySearch();


        $("#categoryEditSubmitButton").click(function () {
            if (!checkEmpty("categoryEditName", "分类名称"))
                return false;
            var name = $("#categoryEditName").val();
            var id =$("#categoryEditId").val();
            var page = "billCategoryEditAjax";
            $.post(
                page,
                {"id":id,'name': name},
                function (result) {
                    if (result == "success") {
                        // location.reload();
                        alert("编辑成功");
                        $("#categoryEditModal").modal('hide');
                        categorySearch();
                    } else {
                        alert("编辑失败");
                        $("#categoryEditModal").modal('hide');
                    }
                }
            )
        });

        $('#categoryDateStart,#categoryDateEnd').datetimepicker({
            // container:"#addRule .modal-content",
            format: 'yyyy-mm-dd',
            autoclose: true,
            todayBtn: true,
            minView:2,
            // initialDate: new Date(),
            language: 'zh-CN',
        });

        // radio正选反选
        $("#listAllCategory").click(function (event) {
            // 禁用事件的默认动作
            event.preventDefault();
        });
        $("#listAllCategory").mouseup(function () {
            $(this).prop("checked", !$(this).is(":checked"));
            if ($(this).is(":checked"))
                $("#selectCategoryRecord").attr('disabled', true);
            else
                $("#selectCategoryRecord").attr('disabled', false);
            $("#selectCategoryRecord").selectpicker('refresh');
        });

        $("#categorySearchButton").click(function () {
            categorySearch();
        })

    })
</script>



<div class="workingArea">

    <div class="categorySearchDiv">
        <table class="categorySearchTable">
            <td class="form-control">
                <span>全部分类</span><input id="listAllCategory" name="listAllCategory" type="radio" checked="checked">
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
                <input class="form-control" size="16" type="text" value="" name="categoryDateStart" id="categoryDateStart">
            </td>
            <td>
                止日期
            </td>
            <td style="padding-left: 5px">
                <input class="form-control" size="16" type="text" value="" name="categoryDateEnd" id="categoryDateEnd">
            </td>
            <td>
                <button id="categorySearchButton" class="btn btn-success" type="button">搜索</button>
            </td>
        </table>
    </div>

    <div class="listDataTableDiv listCategory">
        <table id="categoryDetail" class="table table-striped table-bordered table-hover table-condensed text-center ">
            <thead>
            <tr class="success">
                <td>序号</td>
                <td>分类</td>
                <td>次数</td>
                <td>总金额</td>
                <td>编辑</td>
                <td>删除</td>
            </tr>
            </thead>
            <tbody id="categoryDetailTbody">
            <%--<c:forEach items="${cs}" var="c" varStatus="status">--%>
                <%--<tr>--%>
                    <%--<td>${status.count}</td>--%>
                    <%--<td>${c.name}</td>--%>
                    <%--<td>${c.recordCount}</td>--%>
                    <%--<td>${c.categorySpend/100}</td>--%>
                    <%--<td><a id="${status.count}" categoryid="${c.id}" onclick="showCategoryEditModal(this)" href="javascript:void(0)"><span class="glyphicon glyphicon-edit"></span></a></td>--%>
                    <%--<td><a deleteLink="true"  href="billCategoryDelete?id=${c.id}"><span class="glyphicon glyphicon-trash"></span></a></td>--%>
                <%--</tr>--%>
            <%--</c:forEach>--%>
            </tbody>

        </table>
    </div>


</div>

<div class="modal fade" id="categoryEditModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header bg-warning">
                <button data-dismiss="modal" class="close" type="button">×<span class="sr-only">Close</span></button>
                <h4 class="modal-title">编辑分类</h4>
            </div>
            <div class="modal-body">
                <table id="categoryEditTable" class="categoryEditTable">
                    <tr>
                        <td class="categoryEditTableLeftTd">分类名称</td>
                        <td><input id="categoryEditName" name="categoryEditName" type="text" class="form-control"></td>
                    </tr>
                    <tr class="submitTR">
                        <td colspan="2" align="center">
                            <input type="hidden" value="" id="categoryEditId">
                            <button type="button" class="btn btn-success" id="categoryEditSubmitButton">编辑</button>
                        </td>
                    </tr>
                </table>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>
