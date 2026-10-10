<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Checkout - KathiravanMart" scope="request"/>
<%@ include file="/WEB-INF/fragments/header.jspf" %>
<%@ include file="/WEB-INF/fragments/nav.jspf" %>

<div class="container" style="max-width: 900px;">
    <h1 style="margin-bottom: 1.5rem;">Secure Checkout</h1>

    <div style="display: grid; grid-template-columns: 1.4fr 1fr; gap: 2rem;">
        <!-- Checkout Form & Mock Payment -->
        <div>
            <div class="card">
                <h3 style="margin-bottom: 1rem;">1. Shipping Address</h3>
                <form action="${pageContext.request.contextPath}/checkout" method="post" id="checkoutForm">
                    <div class="form-group">
                        <label for="shippingAddress">Delivery Address Details</label>
                        <textarea id="shippingAddress" name="shippingAddress" class="form-control" rows="4"
                                  placeholder="House/Apartment #, Street, City, State, PIN Code" required>42 Anna Salai, Guindy, Chennai - 600025</textarea>
                        <small style="color: var(--gray-600); font-size: 0.8rem;">Minimum 10 characters required for validation.</small>
                    </div>

                    <h3 style="margin: 1.5rem 0 1rem 0;">2. Mock Payment Confirmation (F5)</h3>
                    <div style="background-color: var(--gray-50); border: 1px solid var(--gray-300); border-radius: 8px; padding: 1.25rem; margin-bottom: 1.5rem;">
                        <p style="font-size: 0.9rem; color: var(--gray-800); margin-bottom: 0.75rem;">
                            <strong>Mock Payment Channel:</strong> As specified in project requirements, real gateways are excluded. Checkout uses an instant mock payment authorization step.
                        </p>
                        <div class="form-group" style="margin-bottom: 0;">
                            <label><input type="radio" name="paymentMethod" value="MOCK_PAYMENT" checked> Instant Mock Payment Confirmation</label>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-success" style="width: 100%; padding: 0.85rem; font-size: 1.1rem; font-weight: 700;">
                        Place Order (₹<c:out value="${runningTotal}"/>)
                    </button>
                </form>
            </div>
        </div>

        <!-- Order Summary Column -->
        <div>
            <div class="card" style="background: white;">
                <h3 style="margin-bottom: 1rem; border-bottom: 1px solid var(--gray-200); padding-bottom: 0.75rem;">Order Summary</h3>
                <div style="display: flex; flex-direction: column; gap: 0.75rem; margin-bottom: 1.5rem;">
                    <c:forEach items="${cartItems}" var="item">
                        <div style="display: flex; justify-content: space-between; font-size: 0.9rem;">
                            <div>
                                <div><strong><c:out value="${item.productName}"/></strong></div>
                                <span style="color: var(--gray-600); font-size: 0.8rem;">Qty: <c:out value="${item.quantity}"/> &times; ₹<c:out value="${item.productPrice}"/></span>
                            </div>
                            <div style="font-weight: 600;">
                                ₹<c:out value="${item.subtotal}"/>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div style="border-top: 2px solid var(--gray-200); padding-top: 1rem; display: flex; justify-content: space-between; align-items: center;">
                    <span style="font-size: 1.1rem; font-weight: 600;">Order Total:</span>
                    <span style="font-size: 1.5rem; font-weight: 800; color: var(--primary);">₹<c:out value="${runningTotal}"/></span>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/fragments/footer.jspf" %>
