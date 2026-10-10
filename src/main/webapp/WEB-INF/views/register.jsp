<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Create Account - KathiravanMart" scope="request"/>
<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<div class="container" style="max-width: 480px; margin-top: 2rem;">
    <div class="card">
        <h2 style="margin-bottom: 0.5rem; text-align: center;">Join KathiravanMart</h2>
        <p style="color: var(--gray-600); font-size: 0.9rem; text-align: center; margin-bottom: 1.5rem;">
            Register as a Buyer to shop or Seller to list products
        </p>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">
                <c:out value="${errorMessage}"/>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="form-group">
                <label for="name">Full Name</label>
                <input type="text" id="name" name="name" class="form-control"
                       value="<c:out value='${name}'/>" required autofocus placeholder="John Doe">
            </div>

            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" class="form-control"
                       value="<c:out value='${email}'/>" required placeholder="name@example.com">
            </div>

            <div class="form-group">
                <label for="password">Password (min 6 characters)</label>
                <input type="password" id="password" name="password" class="form-control"
                       minlength="6" required placeholder="••••••••">
            </div>

            <div class="form-group">
                <label for="role">Account Type</label>
                <select id="role" name="role" class="form-control" required>
                    <option value="BUYER" ${role == 'BUYER' ? 'selected' : ''}>Buyer (Browse, Cart & Purchase)</option>
                    <option value="SELLER" ${role == 'SELLER' ? 'selected' : ''}>Seller (List & Manage Products)</option>
                </select>
                <small style="color: var(--gray-600); font-size: 0.8rem; display: block; margin-top: 0.35rem;">
                    * Admin roles are assigned via secure seed configuration only.
                </small>
            </div>

            <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 0.5rem;">
                Create Account
            </button>
        </form>

        <div style="margin-top: 1.5rem; padding-top: 1.25rem; border-top: 1px solid var(--gray-200); text-align: center; font-size: 0.9rem;">
            Already have an account? <a href="${pageContext.request.contextPath}/login" style="color: var(--primary); font-weight: 500;">Sign In</a>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/fragments/footer.jspf" %>
