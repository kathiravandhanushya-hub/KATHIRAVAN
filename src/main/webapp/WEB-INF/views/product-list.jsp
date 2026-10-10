<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Explore Products - KathiravanMart" scope="request"/>
<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<div class="container">
    <div class="hero">
        <h1>Discover Top Products from Verified Sellers</h1>
        <p>A reliable multi-seller marketplace engineered on Java Servlets and Apache Tomcat.</p>

        <form action="${pageContext.request.contextPath}/products" method="get" class="search-bar">
            <select name="category" class="category-select">
                <option value="ALL">All Categories</option>
                <c:forEach items="${categories}" var="cat">
                    <option value="<c:out value='${cat}'/>" ${selectedCategory == cat ? 'selected' : ''}>
                        <c:out value="${cat}"/>
                    </option>
                </c:forEach>
            </select>
            <input type="text" name="q" class="search-input"
                   placeholder="Search products by keyword..."
                   value="<c:out value='${searchKeyword}'/>">
            <button type="submit" class="btn btn-primary">Search</button>
        </form>
    </div>

    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
        <h2>Catalog Listings (<c:out value="${products != null ? products.size() : 0}"/> items)</h2>
        <c:if test="${not empty searchKeyword or (selectedCategory != 'ALL' and not empty selectedCategory)}">
            <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary btn-sm">Clear Filters</a>
        </c:if>
    </div>

    <c:choose>
        <c:when test="${empty products}">
            <div class="card" style="text-align: center; padding: 3rem;">
                <p style="color: var(--gray-600); font-size: 1.1rem; margin-bottom: 1rem;">
                    No products matched your search or category filter.
                </p>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">View All Products</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="product-grid">
                <c:forEach items="${products}" var="p">
                    <div class="product-card">
                        <div style="position: relative;">
                            <img src="<c:out value='${p.imageUrl}'/>" alt="<c:out value='${p.name}'/>" class="product-img" onerror="this.src='https://via.placeholder.com/300?text=Product';">
                            <c:if test="${p.price lt 500}">
                                <span style="position: absolute; top: 10px; left: 10px; background: #ef4444; color: white; padding: 3px 8px; border-radius: 12px; font-size: 0.75rem; font-weight: 700; box-shadow: 0 2px 4px rgba(0,0,0,0.25);">⚡ Under ₹500</span>
                            </c:if>
                            <c:if test="${p.price ge 500 and p.price le 1000}">
                                <span style="position: absolute; top: 10px; left: 10px; background: #10b981; color: white; padding: 3px 8px; border-radius: 12px; font-size: 0.75rem; font-weight: 700; box-shadow: 0 2px 4px rgba(0,0,0,0.25);">🔥 Under ₹1,000</span>
                            </c:if>
                        </div>
                        <div class="product-body">
                            <span class="product-category"><c:out value="${p.category}"/></span>
                            <a href="${pageContext.request.contextPath}/products/${p.id}" class="product-title">
                                <c:out value="${p.name}"/>
                            </a>
                            <div class="product-seller">
                                Sold by <strong><c:out value="${p.sellerName}"/></strong>
                            </div>

                            <c:if test="${p.reviewCount > 0}">
                                <div class="rating-badge">
                                    ★ <c:out value="${p.averageRating}"/> (<c:out value="${p.reviewCount}"/>)
                                </div>
                            </c:if>

                            <div class="product-price">
                                ₹<c:out value="${p.price}"/>
                            </div>

                            <div class="product-actions">
                                <a href="${pageContext.request.contextPath}/products/${p.id}" class="btn btn-secondary btn-sm" style="flex: 1;">
                                    View Details
                                </a>
                                <c:if test="${sessionScope.currentUser.role == 'BUYER'}">
                                    <form action="${pageContext.request.contextPath}/cart/add" method="post" style="display: inline;">
                                        <input type="hidden" name="productId" value="${p.id}">
                                        <input type="hidden" name="quantity" value="1">
                                        <button type="submit" class="btn btn-primary btn-sm" title="Add to Cart">
                                            🛒
                                        </button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/wishlist/add" method="post" style="display: inline;">
                                        <input type="hidden" name="productId" value="${p.id}">
                                        <button type="submit" class="btn btn-secondary btn-sm" title="Add to Wishlist">
                                            ❤️
                                        </button>
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
