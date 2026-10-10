<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="${product.name} - KathiravanMart" scope="request"/>
<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<div class="container" style="max-width: 1000px;">
    <div style="margin-bottom: 1rem;">
        <a href="${pageContext.request.contextPath}/products" style="color: var(--primary); text-decoration: none; font-size: 0.9rem;">
            &larr; Back to Products
        </a>
    </div>

    <c:if test="${param.reviewed == 'true'}">
        <div class="alert alert-success">
            Thank you! Your verified review and rating have been posted.
        </div>
    </c:if>

    <div class="card" style="display: grid; grid-template-columns: 1fr 1fr; gap: 2.5rem; align-items: start;">
        <div>
            <img src="<c:out value='${product.imageUrl}'/>" alt="<c:out value='${product.name}'/>"
                 style="width: 100%; border-radius: 8px; max-height: 400px; object-fit: cover;"
                 onerror="this.src='https://via.placeholder.com/400?text=Product';">
        </div>

        <div>
            <span class="product-category"><c:out value="${product.category}"/></span>
            <h1 style="font-size: 1.8rem; margin: 0.5rem 0 0.75rem 0; color: var(--gray-900);">
                <c:out value="${product.name}"/>
            </h1>

            <p style="color: var(--gray-600); margin-bottom: 1rem; font-size: 0.95rem;">
                Sold by <strong><c:out value="${product.sellerName}"/></strong>
            </p>

            <c:if test="${product.reviewCount > 0}">
                <div class="rating-badge" style="font-size: 0.95rem; margin-bottom: 1.25rem;">
                    ★ <c:out value="${product.averageRating}"/> / 5.0 (<c:out value="${product.reviewCount}"/> ratings)
                </div>
            </c:if>

            <div style="font-size: 2rem; font-weight: 800; color: var(--gray-900); margin-bottom: 1.25rem;">
                ₹<c:out value="${product.price}"/>
            </div>

            <div style="margin-bottom: 1.5rem; color: var(--gray-800); line-height: 1.6;">
                <h4 style="margin-bottom: 0.35rem; font-size: 1rem;">Description</h4>
                <p><c:out value="${product.description}"/></p>
            </div>

            <div style="margin-bottom: 1.5rem;">
                <span class="badge ${product.stockQty > 0 ? 'badge-delivered' : 'badge-cancelled'}">
                    <c:choose>
                        <c:when test="${product.stockQty > 0}">
                            In Stock (<c:out value="${product.stockQty}"/> available)
                        </c:when>
                        <c:otherwise>
                            Out of Stock
                        </c:otherwise>
                    </c:choose>
                </span>
            </div>

            <c:choose>
                <c:when test="${sessionScope.currentUser != null and sessionScope.currentUser.role == 'BUYER'}">
                    <form action="${pageContext.request.contextPath}/cart/add" method="post" style="display: flex; gap: 0.75rem; margin-bottom: 1rem;">
                        <input type="hidden" name="productId" value="${product.id}">
                        <input type="number" name="quantity" value="1" min="1" max="${product.stockQty}"
                               class="form-control" style="width: 80px;" ${product.stockQty <= 0 ? 'disabled' : ''}>
                        <button type="submit" class="btn btn-primary" ${product.stockQty <= 0 ? 'disabled' : ''}>
                            🛒 Add to Cart
                        </button>
                    </form>
                    <form action="${pageContext.request.contextPath}/wishlist/add" method="post">
                        <input type="hidden" name="productId" value="${product.id}">
                        <button type="submit" class="btn btn-secondary">
                            ❤️ Save to Wishlist
                        </button>
                    </form>
                </c:when>
                <c:when test="${sessionScope.currentUser == null}">
                    <p style="color: var(--gray-600); font-size: 0.95rem;">
                        <a href="${pageContext.request.contextPath}/login" style="color: var(--primary);">Sign in as a Buyer</a> to purchase this item.
                    </p>
                </c:when>
            </c:choose>
        </div>
    </div>

    <!-- Section: Reviews & Ratings (F8) -->
    <div class="card" style="margin-top: 2rem;">
        <h3 style="margin-bottom: 1rem;">Customer Reviews & Ratings</h3>

        <c:choose>
            <c:when test="${eligibleToReview}">
                <div style="background: var(--gray-50); border: 1px solid var(--gray-200); padding: 1.25rem; border-radius: 8px; margin-bottom: 1.5rem;">
                    <h4 style="margin-bottom: 0.5rem;">Write a Verified Review</h4>
                    <form action="${pageContext.request.contextPath}/reviews" method="post">
                        <input type="hidden" name="productId" value="${product.id}">
                        <div class="form-group">
                            <label for="rating">Star Rating (1 to 5)</label>
                            <select id="rating" name="rating" class="form-control" style="max-width: 160px;" required>
                                <option value="5">★★★★★ (5 Stars)</option>
                                <option value="4">★★★★☆ (4 Stars)</option>
                                <option value="3">★★★☆☆ (3 Stars)</option>
                                <option value="2">★★☆☆☆ (2 Stars)</option>
                                <option value="1">★☆☆☆☆ (1 Star)</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="comment">Your Feedback</label>
                            <textarea id="comment" name="comment" class="form-control" rows="3"
                                      placeholder="Share your experience with this product..." required></textarea>
                        </div>
                        <button type="submit" class="btn btn-success btn-sm">Submit Review</button>
                    </form>
                </div>
            </c:when>
            <c:otherwise>
                <p style="font-size: 0.85rem; color: var(--gray-600); margin-bottom: 1.5rem; font-style: italic;">
                    * Reviews and star ratings are permitted only after you have purchased and completed an order for this product (F8).
                </p>
            </c:otherwise>
        </c:choose>

        <c:choose>
            <c:when test="${empty reviews}">
                <p style="color: var(--gray-600);">No reviews yet for this product. Be the first to order and review!</p>
            </c:when>
            <c:otherwise>
                <div style="display: flex; flex-direction: column; gap: 1rem;">
                    <c:forEach items="${reviews}" var="rev">
                        <div style="border-bottom: 1px solid var(--gray-200); padding-bottom: 0.75rem;">
                            <div style="display: flex; justify-content: space-between; margin-bottom: 0.25rem;">
                                <strong><c:out value="${rev.userName}"/></strong>
                                <span style="color: var(--accent); font-weight: bold;">★ <c:out value="${rev.rating}"/> / 5</span>
                            </div>
                            <p style="color: var(--gray-800); font-size: 0.95rem; margin-bottom: 0.25rem;">
                                <c:out value="${rev.comment}"/>
                            </p>
                            <span style="font-size: 0.75rem; color: var(--gray-600);">
                                <c:out value="${rev.createdAt}"/>
                            </span>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="/WEB-INF/fragments/footer.jspf" %>
