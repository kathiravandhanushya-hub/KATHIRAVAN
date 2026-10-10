<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Seller Dashboard - KathiravanMart" scope="request"/>
<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<div class="container">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem;">
        <div>
            <h1>📊 Seller Management Dashboard</h1>
            <p style="color: var(--gray-600);">Manage your products, track revenue, and fulfill orders.</p>
        </div>
        <a href="#addProductSection" class="btn btn-primary">+ Create New Product Listing</a>
    </div>

    <!-- Seller Sales Dashboard Metrics (O3) -->
    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 1.5rem; margin-bottom: 2rem;">
        <div class="card" style="border-left: 4px solid var(--primary);">
            <div style="font-size: 0.85rem; color: var(--gray-600); font-weight: 600; text-transform: uppercase;">Total Revenue (O3)</div>
            <div style="font-size: 1.8rem; font-weight: 800; color: var(--gray-900); margin-top: 0.5rem;">
                ₹<c:out value="${metrics.revenue != null ? metrics.revenue : '0.00'}"/>
            </div>
        </div>

        <div class="card" style="border-left: 4px solid var(--success);">
            <div style="font-size: 0.85rem; color: var(--gray-600); font-weight: 600; text-transform: uppercase;">Total Orders (O3)</div>
            <div style="font-size: 1.8rem; font-weight: 800; color: var(--gray-900); margin-top: 0.5rem;">
                <c:out value="${metrics.orderCount != null ? metrics.orderCount : '0'}"/>
            </div>
        </div>

        <div class="card" style="border-left: 4px solid var(--accent);">
            <div style="font-size: 0.85rem; color: var(--gray-600); font-weight: 600; text-transform: uppercase;">Listed Products</div>
            <div style="font-size: 1.8rem; font-weight: 800; color: var(--gray-900); margin-top: 0.5rem;">
                <c:out value="${products != null ? products.size() : '0'}"/>
            </div>
        </div>
    </div>

    <!-- Active Listings (F2) -->
    <div class="card" style="margin-bottom: 2rem;">
        <h3 style="margin-bottom: 1rem;">Your Current Listings</h3>
        <c:choose>
            <c:when test="${empty products}">
                <p style="color: var(--gray-600); padding: 1rem 0;">No active listings yet. Add your first product below!</p>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Category</th>
                                <th>Price</th>
                                <th>Stock</th>
                                <th>Ratings</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${products}" var="p">
                                <tr>
                                    <td>
                                        <div style="display: flex; align-items: center; gap: 0.75rem;">
                                            <img src="<c:out value='${p.imageUrl}'/>" alt="<c:out value='${p.name}'/>"
                                                 style="width: 44px; height: 44px; object-fit: cover; border-radius: 4px;"
                                                 onerror="this.src='https://via.placeholder.com/44';">
                                            <div>
                                                <strong><c:out value="${p.name}"/></strong>
                                            </div>
                                        </div>
                                    </td>
                                    <td><c:out value="${p.category}"/></td>
                                    <td>₹<c:out value="${p.price}"/></td>
                                    <td><c:out value="${p.stockQty}"/></td>
                                    <td>★ <c:out value="${p.averageRating}"/> (<c:out value="${p.reviewCount}"/>)</td>
                                    <td>
                                        <span class="badge ${p.isActive ? 'badge-delivered' : 'badge-cancelled'}">
                                            <c:out value="${p.isActive ? 'Active' : 'Inactive'}"/>
                                        </span>
                                    </td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/seller/products/delete" method="post" style="display: inline;" onsubmit="return confirm('Are you sure you want to delete this listing?');">
                                            <input type="hidden" name="productId" value="${p.id}">
                                            <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Create Product Form (F2) -->
    <div id="addProductSection" class="card">
        <h3 style="margin-bottom: 1.25rem;">Create New Product Listing (F2)</h3>
        <form action="${pageContext.request.contextPath}/seller/products" method="post">
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                <div class="form-group">
                    <label for="name">Product Name</label>
                    <input type="text" id="name" name="name" class="form-control" required placeholder="e.g. Ergonomic Office Desk">
                </div>

                <div class="form-group">
                    <label for="category">Category</label>
                    <select id="category" name="category" class="form-control" required>
                        <option value="Electronics">Electronics</option>
                        <option value="Fashion">Fashion</option>
                        <option value="Home & Living">Home & Living</option>
                        <option value="Books">Books</option>
                        <option value="Sports">Sports</option>
                    </select>
                </div>
            </div>

            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                <div class="form-group">
                    <label for="price">Price (₹ INR)</label>
                    <input type="number" step="0.01" id="price" name="price" class="form-control" required placeholder="1499.00">
                </div>

                <div class="form-group">
                    <label for="stockQty">Stock Quantity</label>
                    <input type="number" id="stockQty" name="stockQty" class="form-control" required min="0" placeholder="25">
                </div>
            </div>

            <div class="form-group">
                <label for="imageUrl">Image URL</label>
                <input type="url" id="imageUrl" name="imageUrl" class="form-control" placeholder="https://images.unsplash.com/photo-...">
            </div>

            <div class="form-group">
                <label for="description">Product Description</label>
                <textarea id="description" name="description" class="form-control" rows="3" placeholder="Provide full technical and cosmetic details..."></textarea>
            </div>

            <button type="submit" class="btn btn-success" style="padding: 0.75rem 2rem;">
                Publish Listing
            </button>
        </form>
    </div>
</div>

<%@ include file="/WEB-INF/fragments/footer.jspf" %>
