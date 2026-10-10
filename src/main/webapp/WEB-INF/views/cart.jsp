<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Shopping Cart - KathiravanMart" scope="request"/>
<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<div class="container" style="max-width: 900px;">
    <h1 style="margin-bottom: 1.5rem;">Your Shopping Cart</h1>

    <c:choose>
        <c:when test="${empty cartItems}">
            <div class="card" style="text-align: center; padding: 3rem;">
                <p style="font-size: 1.1rem; color: var(--gray-600); margin-bottom: 1.5rem;">
                    Your shopping cart is currently empty.
                </p>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Start Shopping</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="card">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Unit Price</th>
                                <th>Quantity</th>
                                <th>Subtotal</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${cartItems}" var="item">
                                <tr>
                                    <td>
                                        <div style="display: flex; align-items: center; gap: 1rem;">
                                            <img src="<c:out value='${item.productImage}'/>" alt="<c:out value='${item.productName}'/>"
                                                 style="width: 50px; height: 50px; object-fit: cover; border-radius: 4px;"
                                                 onerror="this.src='https://via.placeholder.com/50';">
                                            <div>
                                                <a href="${pageContext.request.contextPath}/products/${item.productId}"
                                                   style="font-weight: 600; color: var(--gray-900); text-decoration: none;">
                                                    <c:out value="${item.productName}"/>
                                                </a>
                                                <div style="font-size: 0.8rem; color: var(--gray-600);">
                                                    <c:out value="${item.category}"/>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>₹<c:out value="${item.productPrice}"/></td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/cart/update" method="post" style="display: flex; gap: 0.4rem; align-items: center;">
                                            <input type="hidden" name="cartItemId" value="${item.id}">
                                            <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.stockQty}"
                                                   class="form-control" style="width: 70px; padding: 0.35rem;">
                                            <button type="submit" class="btn btn-secondary btn-sm" title="Update Quantity">✓</button>
                                        </form>
                                    </td>
                                    <td style="font-weight: 600;">₹<c:out value="${item.subtotal}"/></td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/cart/remove" method="post">
                                            <input type="hidden" name="cartItemId" value="${item.id}">
                                            <button type="submit" class="btn btn-danger btn-sm" title="Remove Item">&times;</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Running Total (F4) -->
                <div style="margin-top: 2rem; padding-top: 1.5rem; border-top: 2px solid var(--gray-200); display: flex; justify-content: space-between; align-items: center;">
                    <div>
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary">
                            &larr; Continue Shopping
                        </a>
                    </div>
                    <div style="text-align: right;">
                        <span style="font-size: 1.1rem; color: var(--gray-600);">Running Total:</span>
                        <div style="font-size: 1.8rem; font-weight: 800; color: var(--primary);">
                            ₹<c:out value="${runningTotal}"/>
                        </div>
                        <a href="${pageContext.request.contextPath}/checkout" class="btn btn-success" style="margin-top: 0.75rem; padding: 0.75rem 2rem; font-size: 1rem;">
                            Proceed to Checkout &rarr;
                        </a>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/fragments/footer.jspf" %>
