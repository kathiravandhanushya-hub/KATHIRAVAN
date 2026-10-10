# Sprint Retrospectives (RETRO.md)

As required by Section 16, this document captures retrospectives across the five two-week sprint execution cycles of the KathiravanMart capstone project.

---

### Sprint 1: Foundation & Authentication (Jul 27 – Aug 9, 2026)
- **What worked:** Layered MVC architecture and HikariCP connection pooling via `ServletContextListener` provided a rock-solid foundation.
- **What didn't:** Session fixation and BCrypt salt round balancing caused minor local delay.
- **One change for next sprint:** Standardize DTO transformations with Builder pattern early in the development cycle.

---

### Sprint 2: Core Commerce & Cart Flow (Aug 10 – Aug 23, 2026)
- **What worked:** Single-transaction checkout logic cleanly updated order items and atomic stock reduction.
- **What didn't:** Float values initially caused currency rounding mismatches.
- **One change for next sprint:** Strictly mandate `BigDecimal` for all monetary computations across all layers.

---

### Sprint 3: Seller Hub & Admin Moderation (Aug 24 – Sep 6, 2026)
- **What worked:** Seller ownership validation in `ProductServiceImpl` cleanly separated vendor data.
- **What didn't:** Complex SQL queries for seller revenue calculations needed multi-table grouping.
- **One change for next sprint:** Pre-verify database query execution plans with indexed columns before implementing DAO methods.

---

### Sprint 4: Order Workflows & Security Hardening (Sep 7 – Sep 20, 2026)
- **What worked:** PreparedStatement query parameterization and AuthFilter session verification passed all security audit checklists.
- **What didn't:** Custom error page redirection required explicit web.xml exception-type mapping.
- **One change for next sprint:** Implement automated regression tests for HTTP 400, 401, 403, and 404 response codes.

---

### Sprint 5: AI Integration & Final Polish (Sep 21 – Oct 10, 2026)
- **What worked:** Factory pattern allowing instant switching between `GeminiChatProvider` and `MockChatProvider` guaranteed high resilience.
- **What didn't:** Outbound network latency on external LLM calls risked blocking request threads.
- **One change for next sprint:** Enforce strict socket timeouts and in-memory question caching for all conversational endpoints.
