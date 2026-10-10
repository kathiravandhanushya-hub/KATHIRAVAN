<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Server Error (500) - KathiravanMart" scope="request"/>
<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<div class="container" style="text-align: center; padding: 4rem 1rem;">
    <h1 style="font-size: 3rem; color: var(--danger);">500</h1>
    <h2 style="margin-bottom: 1rem;">Internal Server Error</h2>
    <p style="color: var(--gray-600); max-width: 500px; margin: 0 auto 2rem auto;">
        An unexpected error occurred while processing your request. Please try again later.
    </p>
    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Return to Catalog</a>
</div>

<%@ include file="/WEB-INF/fragments/footer.jspf" %>
