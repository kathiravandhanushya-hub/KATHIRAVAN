-- Migration V3: Add Index on Orders Status for fast filtering and analytics
CREATE INDEX IF NOT EXISTS idx_orders_status ON orders(status);
