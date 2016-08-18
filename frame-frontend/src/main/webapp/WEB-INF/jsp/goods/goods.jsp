<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8" errorPage="../common/error.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="goods-page" class="page">
	<div id="goods-list-page" class="sub-page" style="z-index:3;">
		<div class="panel">
			<div class="form-group">
				<form id="goods-query" method="GET" action="goods/list.do" class="form-inline">
					<label>查询的结果与组合框一致</label>
			   		<input type="submit" value="查询" class="btn btn-default">
			   		<span class="tip">输入有误</span>
			   		<br>
					<input class="form-control" type="text" name="goodsName" placeholder="商品名" class="" value="${queryParam.goodsName}">
					<input class="form-control" type="text" name="price" placeholder="价格,必须有小数点" class=""  value="${queryParam.price}">
					<br>
					<input class="form-control" type="number" name="amount" placeholder="数量" class=""  value="${queryParam.amount}">
					<input class="form-control" type="text" name="supplierName" placeholder="供应商" class=""  value="${queryParam.supplierName}">
					<br>
					<p>
					</p>
					<input class="form-control" name="startDate" type="date" class="" value="${queryParam.startDate}">
					<input class="form-control" name="endDate" type="date" class="" value="${queryParam.endDate}">
					<div style="margin-top: 20px">
						<c:import url="../common/page.jsp">
							<c:param name="pageNum" value="${goodsPager.pageNum}" />
							<c:param name="totalPage" value="${goodsPager.totalPage}" />
						</c:import>
					</div>
			   	</form>
			   	<nav class="page-item" data-pagenum="${goodsPager.pageNum}" data-totalpage="${goodsPager.totalPage}"></nav>
			</div>
		</div>
		
		<div style="margin-top: 20px" class="panel" id="goods-list">
			<h3>显示所有商品:</h3>
			<br>
			<table class="table table-striped table-hover">
				<c:choose>
					<c:when test="${empty requestScope.goodsPager.dataList}">
						<div class="errormsg">
							<c:out value="${requestScope.IllegalInput}" default="未查找到结果" />
						</div>
					</c:when>
			
					<c:otherwise>
						<thead>
							<tr>
								<th>商品名</th>
								<th>价格</th>
								<th>描述</th>
								<th>数量</th>
								<th>类型</th>
								<th>供应商</th>
								<th>创建时间</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${requestScope.goodsPager.dataList}" var="item">
								<tr>
									<td class="">${item.goodsName}</td>
									<td class="">${item.price}</td>
									<td class="">${item.description}</td>
									<td class="">${item.amount}</td>
									<td class="">${item.type}</td>
									<td data-supplierid="${item.supplierId}" class="">${item.supplierName}</td>
									<td><fmt:formatDate value="${item.createTime}" pattern="yyyy年MM月dd日 E"/></td>
									<td>
										<input type="button" value="编辑" class="edit btn btn-default" data-id="${item.goodsId}">
									</td>
									<c:if test="${sessionScope.user.roleId eq 1}">
										<td>
											<input type="button" value="删除" class="delete btn btn-default" data-id="${item.goodsId}">
										</td>
									</c:if>
								</tr>
							</c:forEach>
						</tbody>
					</c:otherwise>
			
				</c:choose>
			</table>
		</div>
		<br/>
		<input type="button" id="open-add-page-button" value="添加商品" class="btn btn-default"></input>
		
	</div>
	
	<div id="goods-add-page" class="sub-page" style="z-index:2;">
		<h3>添加商品</h3>
		<div>
			<form id="goods-add" action="goods/add" method="POST">
				<div class="form-group">
					<label>商品名</label>
					<input type="text" name="goodsName" class="input"></input>
				</div>
				<div class="form-group">
					<label>价格</label>
					<input type="text" name="price"></input>
				</div>
				<div class="form-group">
					<label>数量</label>
					<input type="number" name="amount"></input>
				</div>
				<div class="form-group">
					<label>供应商</label>
					<select name="supplierId">
						<c:forEach items="${requestScope.supplierList}" var="ls">
							<option value="${ls.supplierId}">${ls.supplierName}</option>
						</c:forEach>
					</select>
				</div>
				<div class="form-group">
					<input name="types" value="食品" type="checkbox">
					<label>食品</label>
					<input name="types" value="用品" type="checkbox">
					<label>用品</label>
					<input name="types" value="其他" type="checkbox">
					<label>其他</label>
				</div>
				<textarea name="description" style="width: 390px; height: 99px;"></textarea>
				<input class="btn btn-default" type="submit" value="提交"></input>
			</form>
			<button type="button" class="back btn btn-default">返回</button>
		</div>
		<h3>校验提示</h3>
		<div id="goods-add-page_cue" class="validate-font-color"></div>
	</div>
	
	<div id="goods-edit-page" class="sub-page" style="z-index:1;">
		<h3>编辑商品</h3>
		<form id="goods-edit" action="goods/update" method="POST">
			<div class="form-group">
				<label>商品名</label>
				<input type="text" name="goodsName"></input>
			</div>
			<div class="form-group">
				<label>价格</label>
				<input type="text" name="price"></input>
			</div>
			<div class="form-group">
				<label>数量</label>
				<input type="number" name="amount"></input>
			</div>
			<div class="form-group">
				<label>供应商</label>
				<select name="supplierId">
					<c:forEach items="${requestScope.supplierList}" var="ls">
						<option value="${ls.supplierId}">${ls.supplierName}</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
				<input name="types" value="食品" type="checkbox">
				<label>食品</label>
				<input name="types" value="用品" type="checkbox">
				<label>用品</label>
				<input name="types" value="其他" type="checkbox">
				<label>其他</label>
			</div>
			<textarea name="description" style="width: 390px; height: 99px;"></textarea>
			<div>
				<input class="btn btn-default" type="submit" value="修改"></input>
			</div>
		</form>
		<span><button type="button" class="back btn btn-default">返回</button></span>
		<h3>校验提示</h3>
		<div id="goods-edit-page_cue" class="validate-font-color"></div>
	</div>
</div>