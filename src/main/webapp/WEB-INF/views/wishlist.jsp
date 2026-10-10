<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="My Wishlist - KathiravanMart" scope="request"/>
<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<div class="container" style="max-width: 900px;">
    <h1 style="margin-bottom: 1.5rem;">❤️ Saved Items / Wishlist (O1)</h1>

    <c:choose>
        <c:when test="${empty wishlistItems}">
            <div class="card" style="text-align: center; padding: 3rem;">
                <p style="font-size: 1.1rem; color: var(--gray-600); margin-bottom: 1.5rem;">
                    Your wishlist is currently empty.
                </p>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Browse Catalog</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="card">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Price</th>
                                <th>Stock</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${wishlistItems}" var="w">
                                <tr>
                                    <td>
                                        <div style="display: flex; align-items: center; gap: 1rem;">
                                            <img src="<c:out value='${w.productImage}'/>" alt="<c:out value='${w.productName}'/>"
                                                 style="width: 50px; height: 50px; object-fit: cover; border-radius: 4px;"
                                                 onerror="this.src='https://via.placeholder.com/50';">
                                            <div>
                                                <a href="${pageContext.request.contextPath}/products/${w.productId}"
                                                   style="font-weight: 600; color: var(--gray-900); text-decoration: none;">
                                                    <c:out value="${w.productName}"/>
                                                </a>
                                                <div style="font-size: 0.8rem; color: var(--gray-600);">
                                                    <c:out value="${w.category}"/>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td><strong>₹<c:out value="${w.productPrice}"/></strong></td>
                                    <td>
                                        <span class="badge ${w.stockQty > 0 ? 'badge-delivered' : 'badge-cancelled'}">
                                            <c:out value="${w.stockQty > 0 ? 'In Stock' : 'Out of Stock'}"/>
                                        </span>
                                    </td>
                                    <td>
                                        <div style="display: flex; gap: 0.5rem;">
                                            <form action="${pageContext.request.contextPath}/cart/add" method="post" style="display: inline;">
                                                <input type="hidden" name="productId" value="${w.productId}">
                                                <input type="hidden" name="quantity" value="1">
                                                <button type="submit" class="btn btn-primary btn-sm" ${w.stockQty <= 0 ? 'disabled' : ''}>
                                                    🛒 Move to Cart
                                                </button>
                                            </form>
                                            <form action="${pageContext.request.contextPath}/wishlist/remove" method="post" style="display: inline;">
                                                <input type="hidden" name="productId" value="${w.productId}">
                                                <button type="submit" class="btn btn-danger btn-sm" title="Remove">&times;</button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/WEB-INF/fragments/footer.jspf" %>
