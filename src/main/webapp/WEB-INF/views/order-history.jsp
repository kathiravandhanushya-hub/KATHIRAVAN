<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Orders - KathiravanMart" scope="request"/>
<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<div class="container">
    <c:choose>
        <c:when test="${sessionScope.currentUser.role == 'SELLER'}">
            <h1 style="margin-bottom: 1.5rem;">📦 Incoming Orders (Seller Hub)</h1>
        </c:when>
        <c:otherwise>
            <h1 style="margin-bottom: 1.5rem;">📦 My Order History</h1>
        </c:otherwise>
    </c:choose>

    <c:if test="${param.success == 'true'}">
        <div class="alert alert-success">
            Order #<c:out value="${param.orderId}"/> placed successfully! Your mock payment has been confirmed.
        </div>
    </c:if>

    <c:choose>
        <c:when test="${empty orders}">
            <div class="card" style="text-align: center; padding: 3rem;">
                <p style="font-size: 1.1rem; color: var(--gray-600); margin-bottom: 1rem;">
                    No orders found.
                </p>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Browse Products</a>
            </div>
        </c:when>
        <c:otherwise>
            <div style="display: flex; flex-direction: column; gap: 1.5rem;">
                <c:forEach items="${orders}" var="ord">
                    <div class="card">
                        <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid var(--gray-200); padding-bottom: 0.75rem; margin-bottom: 1rem;">
                            <div>
                                <span style="font-size: 1.1rem; font-weight: 700;">Order #<c:out value="${ord.id}"/></span>
                                <span style="font-size: 0.85rem; color: var(--gray-600); margin-left: 0.5rem;">Placed on <c:out value="${ord.createdAt}"/></span>
                            </div>
                            <div>
                                <span class="badge
                                    <c:choose>
                                        <c:when test="${ord.status == 'PENDING'}">badge-pending</c:when>
                                        <c:when test="${ord.status == 'CONFIRMED'}">badge-confirmed</c:when>
                                        <c:when test="${ord.status == 'SHIPPED'}">badge-shipped</c:when>
                                        <c:when test="${ord.status == 'DELIVERED'}">badge-delivered</c:when>
                                        <c:otherwise>badge-cancelled</c:otherwise>
                                    </c:choose>">
                                    <c:out value="${ord.status}"/>
                                </span>
                            </div>
                        </div>

                        <!-- Order Items List -->
                        <div style="display: flex; flex-direction: column; gap: 0.75rem; margin-bottom: 1rem;">
                            <c:forEach items="${ord.items}" var="it">
                                <div style="display: flex; justify-content: space-between; align-items: center; font-size: 0.95rem;">
                                    <div style="display: flex; align-items: center; gap: 0.75rem;">
                                        <img src="<c:out value='${it.productImage}'/>" alt="<c:out value='${it.productName}'/>"
                                             style="width: 44px; height: 44px; object-fit: cover; border-radius: 4px;"
                                             onerror="this.src='https://via.placeholder.com/44';">
                                        <div>
                                            <a href="${pageContext.request.contextPath}/products/${it.productId}" style="font-weight: 600; color: var(--gray-900); text-decoration: none;">
                                                <c:out value="${it.productName}"/>
                                            </a>
                                            <div style="font-size: 0.8rem; color: var(--gray-600);">
                                                Qty: <c:out value="${it.quantity}"/> &times; ₹<c:out value="${it.unitPrice}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div style="text-align: right;">
                                        <span style="font-weight: 600;">₹<c:out value="${it.subtotal}"/></span>
                                        <c:if test="${sessionScope.currentUser.role == 'BUYER' and (ord.status == 'DELIVERED' or ord.status == 'CONFIRMED')}">
                                            <div>
                                                <a href="${pageContext.request.contextPath}/products/${it.productId}" class="btn btn-secondary btn-sm" style="font-size: 0.75rem; margin-top: 0.25rem;">
                                                    Review & Rate ★
                                                </a>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Footer: Delivery details & status controls -->
                        <div style="background: var(--gray-50); padding: 0.75rem 1rem; border-radius: 6px; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 0.75rem;">
                            <div style="font-size: 0.85rem; color: var(--gray-600);">
                                <strong>Ship to:</strong> <c:out value="${ord.shippingAddress}"/>
                            </div>
                            <div style="display: flex; align-items: center; gap: 1.5rem;">
                                <div style="font-size: 1rem; font-weight: 700;">
                                    Total: ₹<c:out value="${ord.totalAmount}"/>
                                </div>

                                <!-- Order Status Workflow (O2) for Seller/Admin -->
                                <c:if test="${sessionScope.currentUser.role == 'SELLER' or sessionScope.currentUser.role == 'ADMIN'}">
                                    <form action="${pageContext.request.contextPath}/orders/${ord.id}/status" method="post" style="display: flex; gap: 0.35rem; align-items: center;">
                                        <select name="status" class="form-control" style="padding: 0.3rem 0.5rem; font-size: 0.85rem;">
                                            <option value="PENDING" ${ord.status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                                            <option value="CONFIRMED" ${ord.status == 'CONFIRMED' ? 'selected' : ''}>CONFIRMED</option>
                                            <option value="SHIPPED" ${ord.status == 'SHIPPED' ? 'selected' : ''}>SHIPPED</option>
                                            <option value="DELIVERED" ${ord.status == 'DELIVERED' ? 'selected' : ''}>DELIVERED</option>
                                            <option value="CANCELLED" ${ord.status == 'CANCELLED' ? 'selected' : ''}>CANCELLED</option>
                                        </select>
                                        <button type="submit" class="btn btn-primary btn-sm">Update</button>
                                    </form>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/fragments/footer.jspf" %>
