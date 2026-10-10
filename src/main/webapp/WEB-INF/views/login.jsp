<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Sign In - KathiravanMart" scope="request"/>
<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<div class="container" style="max-width: 460px; margin-top: 2rem;">
    <div class="card">
        <h2 style="margin-bottom: 0.5rem; text-align: center;">Welcome Back</h2>
        <p style="color: var(--gray-600); font-size: 0.9rem; text-align: center; margin-bottom: 1.5rem;">
            Sign in to your KathiravanMart account
        </p>

        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">
                <c:out value="${errorMessage}"/>
            </div>
        </c:if>

        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">
                <c:out value="${successMessage}"/>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" class="form-control"
                       value="<c:out value='${email}'/>" required autofocus placeholder="name@example.com">
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" class="form-control" required placeholder="••••••••">
            </div>

            <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 0.5rem;">
                Sign In
            </button>
        </form>

        <div style="margin-top: 1.5rem; padding-top: 1.25rem; border-top: 1px solid var(--gray-200); text-align: center; font-size: 0.9rem;">
            Don't have an account? <a href="${pageContext.request.contextPath}/register" style="color: var(--primary); font-weight: 500;">Create an account</a>
        </div>
    </div>

    <!-- Seed Demo Credentials Box for Faculty / Reviewers -->
    <div class="card" style="background-color: var(--gray-50); border-style: dashed; font-size: 0.85rem;">
        <h4 style="margin-bottom: 0.5rem; color: var(--gray-800);">🔑 Demo / Seed Accounts</h4>
        <p><strong>Admin:</strong> admin@kathiravanmart.com / Admin@123</p>
        <p><strong>Seller:</strong> technova@seller.com / Password@123</p>
        <p><strong>Buyer:</strong> aditya@buyer.com / Password@123</p>
    </div>
</div>

<%@ include file="/WEB-INF/fragments/footer.jspf" %>
