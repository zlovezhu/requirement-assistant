# 需求助手 - Supabase 云端配置指南

## 为什么使用 Supabase？

- ☁️ **多设备同步** - 任何设备打开都能看到最新数据
- 📷 **无限图片存储** - 图片存在云端，不占浏览器空间
- 🔒 **数据安全** - 数据存储在专业数据库，不会丢失
- 🆓 **免费额度** - 500MB 数据库 + 1GB 文件存储

---

## 一、创建 Supabase 项目

1. 打开 [https://supabase.com](https://supabase.com)
2. 点击 **Start your project**（用 GitHub 账号登录最方便）
3. 点击 **New Project**
4. 填写项目信息：
   - **Name**: `requirement-assistant`（或你喜欢的名字）
   - **Database Password**: 设置一个密码（记好它）
   - **Region**: 选择 `Southeast Asia (Singapore)` 或离你最近的
5. 点击 **Create new project**，等待几分钟

---

## 二、创建数据库表

项目创建完成后：

1. 在左侧菜单点击 **SQL Editor**
2. 点击 **+ New query**
3. 复制粘贴以下 SQL 代码：

```sql
-- 创建需求表
CREATE TABLE requirements (
  id TEXT PRIMARY KEY,
  title TEXT,
  source TEXT,
  priority TEXT,
  remark TEXT,
  remark_images TEXT[] DEFAULT '{}',
  date TEXT,
  filed BOOLEAN DEFAULT FALSE,
  schedule TEXT DEFAULT '',
  content TEXT,
  background TEXT,
  expected TEXT,
  proposer TEXT,
  other TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 创建索引加速查询
CREATE INDEX idx_requirements_date ON requirements(date);
CREATE INDEX idx_requirements_priority ON requirements(priority);
CREATE INDEX idx_requirements_filed ON requirements(filed);

-- 启用行级安全（可选，如果只有自己用可以跳过）
-- ALTER TABLE requirements ENABLE ROW LEVEL SECURITY;

-- 允许匿名用户读写（开发用，生产环境建议加认证）
CREATE POLICY "Allow all" ON requirements FOR ALL USING (true);
```

4. 点击 **Run** 执行

---

## 三、创建图片存储桶

1. 在左侧菜单点击 **Storage**
2. 点击 **New bucket**
3. 填写：
   - **Name**: `requirement-images`
   - **Public bucket**: ✅ 打开（这样图片可以公开访问）
4. 点击 **Create bucket**

5. 点击刚创建的 `requirement-images` 桶
6. 点击右上角 **Policies**
7. 点击 **New Policy** → **For full customization**
8. 设置：
   - **Policy name**: `Allow public access`
   - **Allowed operations**: 全部勾选 (SELECT, INSERT, UPDATE, DELETE)
   - **Target roles**: 选择 `anon`
   - **Policy definition**: 输入 `true`
9. 点击 **Review** → **Save policy**

---

## 四、获取连接信息

1. 在左侧菜单点击 **Settings** (⚙️ 齿轮图标)
2. 点击 **API**
3. 找到以下信息：
   - **Project URL**: 类似 `https://xxxxx.supabase.co`
   - **anon public key**: 一长串字符

---

## 五、配置 HTML 文件

打开 `requirement-assistant.html`，找到顶部的配置区域（大约在第 1842 行）：

```javascript
// ===== Supabase Configuration =====
const SUPABASE_URL = 'YOUR_SUPABASE_URL';  // 替换为你的 Project URL
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';  // 替换为你的 anon public key
```

把 `YOUR_SUPABASE_URL` 和 `YOUR_SUPABASE_ANON_KEY` 替换成你刚才获取的值。

例如：
```javascript
const SUPABASE_URL = 'https://abcdefgh.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.xxxxx...';
```

---

## 六、部署网站

配置完成后，你需要把 HTML 文件部署到网上，这样才能在其他设备访问。

### 方案 A：GitHub Pages（免费，推荐）

1. 创建 GitHub 仓库
2. 上传 `requirement-assistant.html` 并重命名为 `index.html`
3. 仓库设置 → Pages → 选择 main 分支
4. 等待几分钟，获得类似 `https://username.github.io/repo-name` 的网址

### 方案 B：Vercel（免费，更简单）

1. 打开 [https://vercel.com](https://vercel.com)
2. 导入 GitHub 仓库或直接拖拽文件
3. 自动部署，获得网址

### 方案 C：腾讯云 EdgeOne Pages（国内访问快）

1. 打开腾讯云 EdgeOne Pages
2. 上传文件或连接 Git 仓库
3. 获得国内可访问的网址

---

## 七、迁移本地数据

部署完成后：

1. 在新设备上打开网站
2. 左侧栏会显示 **☁️ 云端已连接**
3. 如果之前有本地数据，点击 **迁移到云端** 按钮
4. 等待迁移完成

---

## 常见问题

### Q: 看到 "云端加载失败" 怎么办？
A: 检查 SUPABASE_URL 和 KEY 是否填写正确，确保没有多余空格。

### Q: 图片上传失败？
A: 确保 Storage bucket 的访问策略已正确配置为公开。

### Q: 数据会丢失吗？
A: 不会。Supabase 提供自动备份，数据存储在专业的 PostgreSQL 数据库中。

### Q: 免费额度够用吗？
A: 对于个人需求管理完全够用。500MB 数据库可以存储上万条需求，1GB 文件存储足够几千张图片。

---

## 完成！

配置完成后，你就可以：
- 🖥️ 在电脑上记录需求
- 📱 在手机上查看和更新
- 🔄 数据实时同步
- 📷 图片原图保存，不压缩

有问题随时问我！
