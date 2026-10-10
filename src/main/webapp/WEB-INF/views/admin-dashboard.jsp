<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Admin Panel - KathiravanMart" scope="request"/>
<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<div class="container">
    <div style="margin-bottom: 1.5rem;">
        <h1>⚙️ Administrator Control Panel (F7)</h1>
        <p style="color: var(--gray-600);">Marketplace governance, user moderation, order oversight, and listing control.</p>
    </div>

    <!-- System Metrics -->
    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 1.5rem; margin-bottom: 2rem;">
        <div class="card" style="border-left: 4px solid var(--primary);">
            <div style="font-size: 0.85rem; color: var(--gray-600); font-weight: 600; text-transform: uppercase;">Total Users</div>
            <div style="font-size: 1.8rem; font-weight: 800; color: var(--gray-900); margin-top: 0.5rem;">
                <c:out value="${stats.totalUsers}"/>
            </div>
        </div>

        <div class="card" style="border-left: 4px solid var(--success);">
            <div style="font-size: 0.85rem; color: var(--gray-600); font-weight: 600; text-transform: uppercase;">Marketplace GMV</div>
            <div style="font-size: 1.8rem; font-weight: 800; color: var(--gray-900); margin-top: 0.5rem;">
                ₹<c:out value="${stats.totalRevenue}"/>
            </div>
        </div>

        <div class="card" style="border-left: 4px solid var(--accent);">
            <div style="font-size: 0.85rem; color: var(--gray-600); font-weight: 600; text-transform: uppercase;">Total Orders</div>
            <div style="font-size: 1.8rem; font-weight: 800; color: var(--gray-900); margin-top: 0.5rem;">
                <c:out value="${stats.totalOrders}"/>
            </div>
        </div>

        <div class="card" style="border-left: 4px solid var(--secondary);">
            <div style="font-size: 0.85rem; color: var(--gray-600); font-weight: 600; text-transform: uppercase;">Active Listings</div>
            <div style="font-size: 1.8rem; font-weight: 800; color: var(--gray-900); margin-top: 0.5rem;">
                <c:out value="${stats.activeProducts}"/>
            </div>
        </div>
    </div>

    <!-- Section 1: Listings Moderation (F7) -->
    <div class="card" style="margin-bottom: 2rem;">
        <h3 style="margin-bottom: 1rem;">1. Listing Moderation & Management (F7)</h3>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Product</th>
                        <th>Seller</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th>Status</th>
                        <th>Moderate Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${products}" var="p">
                        <tr>
                            <td>#<c:out value="${p.id}"/></td>
                            <td><strong><c:out value="${p.name}"/></strong></td>
                            <td><c:out value="${p.sellerName}"/></td>
                            <td>₹<c:out value="${p.price}"/></td>
                            <td><c:out value="${p.stockQty}"/></td>
                            <td>
                                <span class="badge ${p.isActive ? 'badge-delivered' : 'badge-cancelled'}">
                                    <c:out value="${p.isActive ? 'Visible' : 'Hidden / Moderated'}"/>
                                </span>
                            </td>
                            <td>
                                <form action="${pageContext.request.contextPath}/admin/moderate" method="post" style="display: inline;">
                                    <input type="hidden" name="productId" value="${p.id}">
                                    <input type="hidden" name="active" value="${!p.isActive}">
                                    <button type="submit" class="btn ${p.isActive ? 'btn-secondary' : 'btn-success'} btn-sm">
                                        <c:out value="${p.isActive ? 'Hide Listing' : 'Approve Listing'}"/>
                                    </button>
                                </form>
                                <form action="${pageContext.request.contextPath}/admin/delete-product" method="post" style="display: inline;" onsubmit="return confirm('Permanently remove listing?');">
                                    <input type="hidden" name="productId" value="${p.id}">
                                    <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Section 2: User Directory (F7) -->
    <div class="card" style="margin-bottom: 2rem;">
        <h3 style="margin-bottom: 1rem;">2. User Directory (F7)</h3>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Joined At</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${users}" var="u">
                        <tr>
                            <td>#<c:out value="${u.id}"/></td>
                            <td><strong><c:out value="${u.name}"/></strong></td>
                            <td><c:out value="${u.email}"/></td>
                            <td><span class="user-badge"><c:out value="${u.role}"/></span></td>
                            <td><c:out value="${u.createdAt}"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Section 3: Marketplace Orders (F7) -->
    <div class="card">
        <h3 style="margin-bottom: 1rem;">3. Global Marketplace Orders (F7)</h3>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Buyer</th>
                        <th>Total Amount</th>
                        <th>Status</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${orders}" var="ord">
                        <tr>
                            <td>#<c:out value="${ord.id}"/></td>
                            <td><c:out value="${ord.buyerName}"/> (<c:out value="${ord.buyerEmail}"/>)</td>
                            <td>₹<c:out value="${ord.totalAmount}"/></td>
                            <td>
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
                            </td>
                            <td><c:out value="${ord.createdAt}"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/fragments/footer.jspf" %>
