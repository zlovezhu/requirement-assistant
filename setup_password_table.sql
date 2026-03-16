-- ================================================
-- 创建密码配置表（用于云端存储密码）
-- 请在 Supabase SQL Editor 中运行此脚本
-- ================================================

-- 创建配置表用于存储密码
CREATE TABLE IF NOT EXISTS app_config (
  key TEXT PRIMARY KEY,
  value TEXT NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 插入默认密码（admin123 的 SHA-256 哈希）
INSERT INTO app_config (key, value) VALUES 
  ('password_hash', '240be518fabd2724ddb6f04eeb9d5b0e0cbfe949849b92f0208a5c5c93f1fb2e')
ON CONFLICT (key) DO NOTHING;

-- 启用 RLS（行级安全）
ALTER TABLE app_config ENABLE ROW LEVEL SECURITY;

-- 允许匿名读取（验证密码需要）
CREATE POLICY "Allow anonymous read" ON app_config FOR SELECT USING (true);

-- 允许匿名更新（修改密码需要）
CREATE POLICY "Allow anonymous update" ON app_config FOR UPDATE USING (true);

-- 允许匿名插入（首次设置密码需要）
CREATE POLICY "Allow anonymous insert" ON app_config FOR INSERT WITH CHECK (true);
