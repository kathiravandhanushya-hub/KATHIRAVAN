<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Bad Request (400) - KathiravanMart" scope="request"/>
<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<div class="container" style="text-align: center; padding: 4rem 1rem;">
    <h1 style="font-size: 3rem; color: var(--warning);">400</h1>
    <h2 style="margin-bottom: 1rem;">Bad Request</h2>
    <p style="color: var(--gray-600); max-width: 500px; margin: 0 auto 2rem auto;">
        The request could not be processed due to invalid parameters or formatting.
    </p>
    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Return to Catalog</a>
</div>

<%@ include file="/WEB-INF/fragments/footer.jspf" %>
