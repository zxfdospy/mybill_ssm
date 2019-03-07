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
    $(function () {
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
                    if ("success" == result) {
                        location.reload();
                        alert("编辑成功");
                    } else {
                        alert("编辑失败");
                    }
                }
            )
        });
    })
</script>

<div class="workingArea">

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
            <tbody>
            <c:forEach items="${cs}" var="c" varStatus="status">
                <tr>
                    <td>${status.count}</td>
                    <td>${c.name}</td>
                    <td>${c.recordCount}</td>
                    <td>${c.categorySpend/100}</td>
                    <td><a id="${status.count}" categoryid="${c.id}" onclick="showCategoryEditModal(this)" href="javascript:void(0)"><span class="glyphicon glyphicon-edit"></span></a></td>
                    <td><a deleteLink="true"  href="billCategoryDelete?id=${c.id}"><span class="glyphicon glyphicon-trash"></span></a></td>
                </tr>
            </c:forEach>
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
                            <button type="submit" class="btn btn-success" id="categoryEditSubmitButton">编辑</button>
                        </td>
                    </tr>
                </table>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div>