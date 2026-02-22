# App 截图生成器 - 设计文档

> 参考产品：[AppPreviewMaker](https://apppreviewmaker.com/)
> 技术栈：Flutter（兼容 PC 桌面端 + 移动端）
> 文档版本：v1.1
> 更新日期：2026-02-21

---

## 一、产品概述

App 截图生成器是一款面向独立开发者、UI/UX 设计师及产品团队的专业工具，用于快速生成符合 App Store 和 Google Play 上架规范的应用截图展示图。

### 核心价值

- **免费**：完全免费，无需注册，无水印，无限量导出
- **高效**：2 分钟内完成专业截图制作
- **专业**：导出高分辨率图片，满足各大应用商店提交要求
- **跨平台**：Flutter 实现，支持 PC 桌面端与移动端自适应布局

---

## 二、目标用户

| 用户类型 | 核心诉求 |
|---|---|
| 独立开发者 | 快速制作上架截图，节省设计成本 |
| UI/UX 设计师 | 高质量设备框架，像素级精准呈现 |
| 产品经理 | 快速迭代截图方案，缩短发布周期 |
| 营销团队 | 统一品牌风格，提升应用商店转化率 |

---

## 三、功能模块设计

### 3.1 设备框架库（Device Frame Library）

**功能描述：** 提供 50+ 主流设备框架模板

**支持设备类型：**

- **iOS 设备**
  - iPhone 16 Pro Max / 16 Pro / 16 Plus / 16
  - iPhone 15 Pro Max / 15 Pro / 15 Plus / 15
  - iPhone 14 Pro Max / 14 Pro / 14 Plus / 14
  - iPhone 13 系列 / iPhone 12 系列
  - iPad Pro 12.9" / iPad Pro 11" / iPad Air / iPad Mini

- **Android 设备**
  - Samsung Galaxy S24 Ultra / S24+ / S24
  - Google Pixel 9 Pro / 9
  - 其他主流 Android 旗舰设备

**设计要求：**
- 设备框架需像素级精准，符合实际物理尺寸比例
- 支持亮色 / 暗色外壳切换
- 框架图片需支持高分辨率（@3x）

---

### 3.2 画布编辑器（Canvas Editor）

**功能描述：** 可视化拖拽编辑界面，实时预览效果

**核心功能：**

| 功能 | 描述 |
|---|---|
| 拖拽布局 | 设备框架、文字、装饰元素均支持自由拖拽定位 |
| 实时预览 | 编辑操作实时反映在预览画布上 |
| 图层管理 | 支持多图层叠加，可调整图层顺序（上移/下移/置顶/置底） |
| 对齐辅助 | 拖拽时显示对齐参考线，支持居中对齐、边缘对齐 |
| 撤销/重做 | 支持多步操作历史记录（Ctrl+Z / Ctrl+Y） |
| 缩放画布 | 画布支持缩放查看，适配不同屏幕尺寸 |

---

### 3.3 截图上传（Screenshot Upload）

**功能描述：** 将用户自己的 App 截图嵌入设备框架

**支持方式：**
- 点击上传（文件选择器）
- 拖拽上传到画布
- 粘贴剪贴板图片（Ctrl+V）

**技术要求：**
- 支持格式：PNG、JPG、WebP
- 最大文件大小：20MB
- 上传后自动裁剪适配设备屏幕区域
- 支持在设备框架内拖拽调整截图位置和缩放比例

---

### 3.4 文字编辑（Text Customization）

**功能描述：** 为截图添加营销文案说明

**功能细节：**

- **文字内容：** 支持多行文本输入
- **字体：** 内置 20+ 常用英文/中文字体，支持 Google Fonts 加载
- **字号：** 自由调整，范围 8px ~ 200px
- **颜色：** RGB/HEX/HSL 颜色选择器
- **样式：** 粗体、斜体、下划线、删除线
- **对齐：** 左对齐、居中、右对齐
- **间距：** 字间距、行间距自定义
- **阴影：** 文字阴影颜色、模糊半径、偏移量调整

---

### 3.5 背景设计（Background Options）

**功能描述：** 丰富的背景样式选项

**背景类型：**

| 类型 | 说明 |
|---|---|
| 纯色背景 | 选择任意颜色填充 |
| 线性渐变 | 双色/多色渐变，支持角度调整（0~360°） |
| 径向渐变 | 从中心向外扩散的渐变效果 |
| 自定义图片 | 上传自定义背景图，支持缩放/平铺/居中 |
| 预设主题 | 内置 20+ 品牌配色方案（科技蓝、活力橙、极简白等） |

---

### 3.6 布局模板（Layout Templates）

**功能描述：** 预设专业布局，快速套用

**模板分类：**

- **App Store 竖屏模板**（1284×2778 / 1170×2532 等 iOS 标准尺寸）
- **Google Play 横竖屏模板**（1080×1920 / 1080×2160）
- **iPad 模板**（2048×2732）
- **自定义尺寸**（自由输入宽高像素值）

**布局样式（每种尺寸内）：**
1. 手机居中 + 顶部标题
2. 手机偏左 + 右侧文案
3. 手机偏右 + 左侧文案
4. 双手机并排展示
5. 手机 + 局部放大图

---

### 3.7 导出功能（Export）

**功能描述：** 生成可直接提交应用商店的高清图片

**导出配置：**

| 配置项 | 选项 |
|---|---|
| 格式 | PNG（无损）/ JPG（可调质量）/ WebP |
| 分辨率 | 1x / 2x / 3x |
| 导出范围 | 当前画布 / 全部场景批量导出 |
| 命名规则 | 自定义前缀 + 自动编号（如 `screenshot_01.png`） |

**批量导出：**
- 支持将同一套文案/背景套用到多个设备框架，一键批量导出所有尺寸
- 支持按语言区域（locale）分组导出，输出目录自动按语言分类命名

---

### 3.8 多语言目录自动填充（Locale Directory Auto-fill）

**功能描述：** 用户选择一个结构化目录，系统自动扫描目录内的截图和文案文件，按语言分类加载，实现多语言内容一键填充到画布。

#### 约定目录结构

```
[所选根目录]/
├── config.json              # 可选：全局样式覆盖（设备型号、背景色等）
├── en-US/
│   ├── descriptions.json    # 每张截图对应的标题 + 副标题
│   └── screenshots/
│       ├── 01_onboarding.png
│       ├── 02_home.png
│       └── 03_settings.png
├── zh-CN/
│   ├── descriptions.json
│   └── screenshots/
│       ├── 01_onboarding.png
│       └── ...
└── ja-JP/
    ├── descriptions.json
    └── screenshots/
```

#### descriptions.json 格式

```json
[
  { "title": "轻松上手",   "subtitle": "30 秒完成设置" },
  { "title": "功能一览",   "subtitle": "所有数据尽在掌握" },
  { "title": "深度定制",   "subtitle": "按你的方式使用" }
]
```

#### 自动填充规则

| 规则 | 说明 |
|---|---|
| 截图匹配 | 按文件名字典序排列，与 `descriptions.json` 数组索引对应 |
| 截图缺失 | 对应位置显示占位符，不阻断其他语言的加载 |
| 文案缺失 | `descriptions.json` 不存在时文字图层保留上一语言文案（可手动覆盖） |
| 格式支持 | 截图支持 PNG / JPG / WebP；文案支持 JSON / YAML / 纯文本（每行一条） |
| 子目录扫描 | `screenshots/` 目录支持一级子目录，按子目录名作为截图分组标签 |

#### UI 交互流程

```
工具栏点击「导入目录」
        │
        ▼
打开系统目录选择器（file_picker 选目录模式）
        │
        ▼
扫描目录，列出识别到的语言列表（如 en-US / zh-CN / ja-JP）
        │
        ▼
弹出「导入预览」Dialog：显示各语言截图数量、警告、文案预览
        │
        ▼
用户勾选需要导入的语言（全选 / 单选），确认
        │
        ▼
系统为每个语言克隆模板场景，自动填充截图路径 + 文案
        │
        ▼
画布左侧「语言切换栏」显示新增语言 Tab，可实时预览
```

---

### 3.9 多语言批量导出（Multi-locale Batch Export）

**功能描述：** 一次操作导出所有语言版本，输出目录结构与应用商店规范对齐，可直接提交 App Store Connect / Google Play Console。

#### 导出目录结构

```
[导出根目录]/
├── en-US/
│   ├── iPhone_6.5_inch/
│   │   ├── screenshot_01.png
│   │   ├── screenshot_02.png
│   │   └── screenshot_03.png
│   └── iPad_12.9_inch/
│       └── ...
├── zh-CN/
│   └── iPhone_6.5_inch/
│       └── ...
├── ja-JP/
│   └── ...
└── export_report.json       # 导出结果报告
```

#### 导出配置项

| 配置项 | 选项 |
|---|---|
| 导出语言 | 全部语言 / 仅选中语言 |
| 导出设备 | 全部设备尺寸 / 指定设备型号 |
| 目录命名规则 | App Store 规范（`iPhone_6.5_inch`）/ Google Play 规范（`phoneScreenshots`）/ 自定义 |
| 文件命名规则 | `{locale}_{device}_{index}.png` 或自定义模板 |
| 并发渲染 | 利用 Dart `Isolate` 并行渲染多语言，加速批量导出（最多 4 并发） |
| 导出报告 | 完成后生成 `export_report.json`，记录各语言导出状态与文件路径 |

#### 并发导出流程

```
用户点击「批量导出」
        │
        ▼
校验所有语言的截图完整性
（缺失则弹出 ChecklistDialog，可标记 Skip 继续）
        │
        ▼
选择导出目录（file_picker 选目录）
        │
        ▼
按 locale × device × scene 生成渲染 Task 队列
        │
        ▼
分发到 Dart Isolate 池（maxConcurrency=4）并行渲染：
  ├─ 将对应 locale 的文案写入 TextLayer
  ├─ 替换 DeviceFrameLayer 截图路径
  ├─ 离屏渲染 → Uint8List
  └─ 按规范写入 {root}/{locale}/{device}/{index}.png
        │
        ▼
主线程收集完成回调，实时更新进度条（0～100%）
        │
        ▼
所有任务完成 → 写入 export_report.json → 打开导出目录
```

---

## 四、界面布局设计

### 4.1 PC 端布局（宽屏 ≥ 1024px）

```
┌─────────────────────────────────────────────────────────┐
│  顶部导航栏：Logo | 新建项目 | 打开 | 保存 | 导出       │
├──────────┬──────────────────────────┬───────────────────┤
│          │                          │                   │
│  左侧面板 │      中央画布区域         │    右侧属性面板   │
│          │                          │                   │
│ ・设备库  │   [实时预览画布]          │ ・图层列表        │
│ ・模板库  │                          │ ・选中元素属性    │
│ ・背景    │                          │   - 位置/尺寸     │
│ ・文字    │                          │   - 文字样式      │
│ ・装饰    │                          │   - 背景设置      │
│          │                          │   - 导出设置      │
├──────────┴──────────────────────────┴───────────────────┤
│  底部工具栏：缩放比例 | 画布尺寸 | 撤销/重做             │
└─────────────────────────────────────────────────────────┘
```

### 4.2 移动端布局（窄屏 < 1024px）

```
┌─────────────────────┐
│  顶部导航栏（精简）  │
├─────────────────────┤
│                     │
│   中央画布区域       │
│   [实时预览画布]     │
│                     │
├─────────────────────┤
│  底部工具标签页      │
│ [设备][文字][背景]   │
│ [图层][导出]        │
└─────────────────────┘
```

**响应式适配策略：**
- 使用 `LayoutBuilder` + `MediaQuery` 检测屏幕宽度
- 断点：`< 600px` 移动端 | `600~1024px` 平板端 | `≥ 1024px` 桌面端
- 桌面端：三栏布局（左侧面板 + 画布 + 右侧属性）
- 移动端：单栏布局，工具面板使用底部 BottomSheet 或标签页

---

## 五、技术架构设计

### 5.1 技术栈

| 层级 | 技术选型 |
|---|---|
| UI 框架 | Flutter 3.x |
| 状态管理 | `flutter_riverpod` + `hooks_riverpod` |
| 画布渲染 | `CustomPaint` + `Canvas API` |
| SVG 渲染 | `flutter_svg`（设备框架资产） |
| 图片处理 | `image`（合成/裁剪/格式转换）+ `croppy`（可视化裁剪） |
| 文件导出 | `screenshot` + `flutter_image_compress` + `archive`（ZIP） |
| 文件操作 | `file_picker` + `path_provider` + `open_filex` |
| 剪贴板 | `super_clipboard`（图片粘贴） |
| 字体加载 | `google_fonts` |
| 拖拽交互 | Flutter 内置 `Draggable` + `desktop_drop` |
| 键盘快捷键 | `hotkey_manager`（桌面端） |
| 窗口管理 | `window_manager`（桌面端） |
| 用户反馈 | `toastification` |
| 持久化存储 | `shared_preferences` |
| 数据模型 | `freezed` + `json_serializable` |

### 5.2 核心数据模型

```dart
// ── 项目顶层 ────────────────────────────────────────────
/// 整个工程文件，包含多个语言 × 多个场景
class AppKitProject {
  String id;
  String name;
  DateTime updatedAt;
  List<String> supportedLocales;        // ['en-US', 'zh-CN', 'ja-JP']
  Map<String, LocaleSceneGroup> groups; // key = locale
  ExportConfig exportConfig;
}

/// 单一语言的场景组
class LocaleSceneGroup {
  String locale;                        // 'en-US'
  String? sourceDirectory;             // 导入时的原始目录路径（可为空）
  List<CanvasScene> scenes;            // 该语言下的所有截图场景
}

// ── 画布场景 ─────────────────────────────────────────────
class CanvasScene {
  String id;
  String name;
  double width;
  double height;
  BackgroundConfig background;
  List<CanvasLayer> layers;
}

// ── 图层基类 ─────────────────────────────────────────────
abstract class CanvasLayer {
  String id;
  double x, y;
  double width, height;
  double rotation;
  double opacity;
  int zIndex;
}

/// 设备框架图层
class DeviceFrameLayer extends CanvasLayer {
  DeviceModel device;
  String screenshotPath;               // 当前已填充的截图路径
}

/// 文字图层（支持多语言内容映射）
class TextLayer extends CanvasLayer {
  String text;                         // 当前显示文本（对应当前 locale）
  Map<String, String> localeTextMap;   // {'en-US': 'Easy Start', 'zh-CN': '轻松上手'}
  TextLayerStyle style;
}

// ── 背景配置 ─────────────────────────────────────────────
class BackgroundConfig {
  BackgroundType type; // solid / linearGradient / radialGradient / image
  Color? solidColor;
  List<Color>? gradientColors;
  double? gradientAngle;
  String? imagePath;
}

// ── 导出配置 ─────────────────────────────────────────────
class ExportConfig {
  List<String> targetLocales;          // 要导出的语言列表
  List<DeviceModel> targetDevices;     // 要导出的设备列表
  ExportFormat format;                 // png / jpg / webp
  double pixelRatio;                   // 1.0 / 2.0 / 3.0
  DirectoryNamingStyle dirNaming;      // appStore / googlePlay / custom
  String fileNameTemplate;             // '{locale}_{device}_{index}'
  int maxConcurrency;                  // Isolate 并发数，默认 4
}

// ── 目录扫描结果 ──────────────────────────────────────────
class LocaleDirectoryScanResult {
  String locale;
  List<String> screenshotPaths;        // 按文件名字典序排列的截图路径
  List<LocaleDescription> descriptions;// 从 descriptions.json 解析的文案
  bool hasDescriptionFile;
  List<String> warnings;               // 缺失文件 / 格式错误等提示
}

class LocaleDescription {
  String title;
  String subtitle;
}
```

### 5.3 单语言导出流程

```
用户点击导出（当前语言）
    │
    ▼
收集当前 locale 的画布场景数据
    │
    ▼
使用 Flutter Canvas 将所有图层离屏渲染到 ui.Image
    │
    ▼
将 ui.Image 编码为 PNG/JPG Bytes
    │
    ▼
写入本地文件 / 触发浏览器下载（Web端）
    │
    ▼
显示导出成功提示 + 文件路径
```

### 5.4 多语言并发批量导出流程

```
用户点击「批量导出」
    │
    ▼
读取 ExportConfig（目标语言 × 目标设备 × 格式）
校验各语言截图完整性（缺失弹出 ChecklistDialog，可 Skip）
    │
    ▼
打开目录选择器，确定导出根目录
    │
    ▼
生成渲染 Task 队列：
  foreach locale × foreach device × foreach scene → RenderTask
    │
    ▼
启动 Dart Isolate 池（maxConcurrency = 4）
  每个 Isolate 执行：
    ├─ 将 TextLayer.localeTextMap[locale] 写入场景
    ├─ 替换 DeviceFrameLayer.screenshotPath
    ├─ 离屏渲染 → Uint8List
    └─ 写入 {root}/{locale}/{device}/{index}.png
    │
    ▼
主线程收集完成回调，实时更新进度条（0～100%）
    │
    ▼
全部完成 → 生成 export_report.json → 打开导出目录
```

### 5.5 目录扫描 & 自动填充流程

```
用户点击「导入目录」
    │
    ▼
file_picker 选择根目录（getDirectoryPath 模式）
    │
    ▼
DirectoryScanner.scan(rootPath)
  ├─ 遍历一级子目录，正则匹配语言代码（如 en-US、zh-CN）
  ├─ 对每个语言目录：
  │   ├─ 扫描 screenshots/ 下图片（字典序排列）
  │   └─ 解析 descriptions.json / .yaml / .txt
  └─ 返回 List<LocaleDirectoryScanResult>
    │
    ▼
弹出「导入预览」Dialog
  ├─ 显示各语言名称、截图数量、文案预览、警告提示
  └─ 用户勾选语言，点击确认
    │
    ▼
LocaleSceneBuilder.build(scanResults, activeTemplate)
  ├─ 为每个 locale 克隆当前模板场景
  ├─ 截图路径注入 DeviceFrameLayer.screenshotPath
  └─ 文案注入 TextLayer.localeTextMap
    │
    ▼
更新 AppKitProject.groups
画布左侧「语言切换栏」显示新增 locale Tab
```

---

## 六、用户操作流程

### 6.1 手动制作流程（单语言）

```
Step 1：选择模板或新建画布
        ↓
Step 2：选择设备框架（iPhone / Android / iPad）
        ↓
Step 3：上传 App 截图（拖拽或点击上传）
        ↓
Step 4：添加文案，调整字体/颜色/位置
        ↓
Step 5：设置背景（渐变/纯色/自定义图片）
        ↓
Step 6：预览效果，满意后点击导出
        ↓
Step 7：选择导出格式/分辨率，下载文件
```

### 6.2 目录自动填充流程（多语言批量）

```
Step 1：按约定结构准备目录（截图 + descriptions.json）
        ↓
Step 2：设计好一套画布模板（设备框架、背景、文字样式）
        ↓
Step 3：工具栏点击「导入目录」，选择根目录
        ↓
Step 4：预览扫描结果，勾选需要导入的语言，确认
        ↓
Step 5：系统自动为每种语言生成场景组，填充截图和文案
        ↓
Step 6：在左侧「语言切换栏」逐一预览各语言效果
        ↓
Step 7：对个别语言/场景进行微调（文字位置、背景色等）
        ↓
Step 8：点击「批量导出」，选择输出目录和命名规范
        ↓
Step 9：等待并发渲染完成（显示进度条）
        ↓
Step 10：查看导出报告 export_report.json，打开输出文件夹
```

---

## 七、UI 设计规范

### 7.1 色彩系统

| 色彩 | 用途 | 值 |
|---|---|---|
| 主色 | 按钮、高亮、选中态 | `#6C63FF`（紫色） |
| 辅色 | 次要操作、标签 | `#FF6584`（珊瑚红） |
| 背景色 | 页面背景 | `#F5F5F5`（浅灰） |
| 画布背景 | 编辑器画布区域 | `#E0E0E0`（中灰） |
| 文字主色 | 标题、正文 | `#1A1A2E` |
| 文字次色 | 辅助说明 | `#6B7280` |

### 7.2 字体规范

- **标题：** 18~24px，FontWeight.bold
- **副标题：** 14~16px，FontWeight.w600
- **正文：** 13~14px，FontWeight.normal
- **标签/说明：** 11~12px，FontWeight.normal

### 7.3 间距规范

- 基础间距单位：8dp
- 组件内边距：16dp
- 卡片/面板间距：12dp
- 大区域间距：24dp

---

## 八、竞品对比分析

| 功能 | AppPreviewMaker | 本产品目标 |
|---|---|---|
| 免费使用 | ✅ 完全免费 | ✅ 完全免费 |
| 注册要求 | ❌ 无需注册 | ❌ 无需注册 |
| 水印 | ❌ 无水印 | ❌ 无水印 |
| 设备数量 | 50+ | 50+ |
| 桌面客户端 | ❌ 仅 Web | ✅ Flutter 原生客户端 |
| 离线使用 | ❌ 不支持 | ✅ 支持（本地工具） |
| 中文界面 | ❌ 仅英文 | ✅ 中英文双语 |
| 批量导出 | 未明确 | ✅ 支持 |
| 多语言同时导出 | ❌ 不支持 | ✅ locale × device 全组合并发导出 |
| 目录自动填充 | ❌ 不支持 | ✅ 扫描目录结构自动填充截图和文案 |
| 导出目录规范 | ❌ 不支持 | ✅ App Store / Google Play 标准命名 |
| 导出报告 | ❌ 不支持 | ✅ export_report.json |
| 自定义字体 | 基础支持 | ✅ 丰富字体库 |

---

## 九、推荐插件清单

按功能模块整理，可直接添加至 `pubspec.yaml`。

### 9.1 设备框架渲染

| 包名 | 版本 | 用途 |
|---|---|---|
| [`device_frame_plus`](https://pub.dev/packages/device_frame_plus) | `^1.5.0` | 提供 50+ 真机设备框架（iPhone / Android / iPad），像素级精准，下载量 27 万+ |

### 9.2 画布截图 & 图像导出

| 包名 | 版本 | 用途 |
|---|---|---|
| [`screenshot`](https://pub.dev/packages/screenshot) | `^3.0.0` | 将任意 Widget 渲染为图片（`ui.Image` / bytes），下载量 42 万+ |
| [`image`](https://pub.dev/packages/image) | `^4.x` | 纯 Dart 图像处理：裁剪、缩放、格式转换（PNG/JPG/WebP） |
| [`flutter_image_compress`](https://pub.dev/packages/flutter_image_compress) | `^2.x` | 高性能图片压缩（移动端原生接口），导出时减小文件体积 |

### 9.3 文件上传 & 保存 & 目录扫描

| 包名 | 版本 | 用途 |
|---|---|---|
| [`file_picker`](https://pub.dev/packages/file_picker) | `^10.3.10` | 跨平台文件/目录选择，`getDirectoryPath()` 用于导入目录，200 万+ 下载 |
| [`path_provider`](https://pub.dev/packages/path_provider) | `^2.x` | 获取本地存储路径（Documents / Downloads 目录） |
| [`desktop_drop`](https://pub.dev/packages/desktop_drop) | `^0.4.x` | 桌面端拖拽文件/目录到窗口上传（PC 端必备） |
| [`yaml`](https://pub.dev/packages/yaml) | `^3.x` | 解析 `descriptions.yaml` 文案配置文件 |
| [`path`](https://pub.dev/packages/path) | `^1.x` | 跨平台路径拼接与解析（目录扫描时使用） |

### 9.4 字体

| 包名 | 版本 | 用途 |
|---|---|---|
| [`google_fonts`](https://pub.dev/packages/google_fonts) | `^8.0.2` | 运行时加载 Google Fonts 1000+ 字体，官方维护，下载量 230 万+ |

### 9.5 颜色选择器

| 包名 | 版本 | 用途 |
|---|---|---|
| [`flex_color_picker`](https://pub.dev/packages/flex_color_picker) | `^3.8.0` | 功能最全的颜色选择器（RGB/HEX/HSV/HSL + 色板），25 万+ 下载 |

### 9.6 状态管理

| 包名 | 版本 | 用途 |
|---|---|---|
| [`flutter_riverpod`](https://pub.dev/packages/flutter_riverpod) | `^3.2.1` | 响应式状态管理（画布状态、图层列表、撤销历史），官方推荐 |
| [`riverpod_annotation`](https://pub.dev/packages/riverpod_annotation) | `^2.x` | 代码生成，减少样板代码 |

### 9.7 拖拽交互

| 包名 | 版本 | 用途 |
|---|---|---|
| Flutter 内置 `Draggable` + `DragTarget` | - | 轻量拖拽，适合图层拖拽排序 |
| [`flutter_draggable_gridview`](https://pub.dev/packages/flutter_draggable_gridview) | `^1.0.x` | 网格可拖拽重排，适用于模板选择网格 |

### 9.8 国际化（i18n）

| 包名 | 版本 | 用途 |
|---|---|---|
| [`flutter_localizations`](https://docs.flutter.dev/accessibility-and-localization/internationalization) | SDK 内置 | 中英文双语界面切换 |
| [`intl`](https://pub.dev/packages/intl) | `^0.19.x` | 格式化日期、数字，配合 ARB 文件使用 |

### 9.9 辅助工具

| 包名 | 版本 | 用途 |
|---|---|---|
| [`uuid`](https://pub.dev/packages/uuid) | `^4.x` | 为每个图层/场景生成唯一 ID |
| [`collection`](https://pub.dev/packages/collection) | `^1.x` | 列表操作增强（图层排序、拷贝等） |
| [`freezed`](https://pub.dev/packages/freezed) | `^2.x` | 不可变数据模型（配合 Riverpod），代码生成 |
| [`json_serializable`](https://pub.dev/packages/json_serializable) | `^6.x` | 项目文件序列化/反序列化（保存/加载工程文件） |

---

### ⚠️ 9.10 此前缺少的关键插件（补充）

#### 9.10.1 SVG 渲染

| 包名 | 版本 | 用途 |
|---|---|---|
| [`flutter_svg`](https://pub.dev/packages/flutter_svg) | `^2.2.3` | 渲染 SVG 格式的设备框架资产，Flutter 官方团队维护，310 万+ 下载 |

> **为什么必要：** `device_frame_plus` 内部设备框架使用 SVG 绘制，背景装饰素材也常为 SVG，缺少此包会导致资源无法显示。

#### 9.10.2 剪贴板图片粘贴

| 包名 | 版本 | 用途 |
|---|---|---|
| [`super_clipboard`](https://pub.dev/packages/super_clipboard) | `^0.9.1` | 读写剪贴板中的图片、文字等富媒体数据，支持全平台（含 Windows/macOS/Linux 桌面），10 万+ 下载 |

> **为什么必要：** 设计文档 3.3 节明确要求支持 **Ctrl+V 粘贴剪贴板图片**，Flutter 内置 `Clipboard` 只支持纯文本，必须用此包才能读取图片数据。

#### 9.10.3 桌面窗口管理

| 包名 | 版本 | 用途 |
|---|---|---|
| [`window_manager`](https://pub.dev/packages/window_manager) | `^0.5.1` | 设置窗口标题、最小尺寸、隐藏标题栏（自定义标题栏）、居中启动，28 万+ 下载，leanflutter.dev |

> **为什么必要：** PC 桌面端需要限制最小窗口尺寸（保证三栏布局不错乱）、设置标题栏应用名称，无此包桌面体验不完整。

#### 9.10.4 导出后打开目录

| 包名 | 版本 | 用途 |
|---|---|---|
| [`open_filex`](https://pub.dev/packages/open_filex) | `^4.7.0` | 批量导出完成后，调用系统文件管理器打开导出目录，32 万+ 下载 |

> **为什么必要：** 导出流程最后一步"打开导出目录"依赖此包，否则用户只能手动去找文件夹。

#### 9.10.5 截图裁剪调整

| 包名 | 版本 | 用途 |
|---|---|---|
| [`croppy`](https://pub.dev/packages/croppy) | `^1.4.1` | 上传截图后，在嵌入设备框架前提供裁剪/旋转界面，支持桌面+移动+Web |

> **为什么必要：** 用户截图尺寸往往与设备框架的屏幕区域比例不完全一致，需要手动精调裁剪区域，纯靠 `image` 包无法提供可视化裁剪 UI。

#### 9.10.6 用户偏好持久化

| 包名 | 版本 | 用途 |
|---|---|---|
| [`shared_preferences`](https://pub.dev/packages/shared_preferences) | `^2.x` | 本地持久化用户配置：上次导出目录、默认设备型号、默认语言、最近打开项目列表，官方包，3000 万+ 下载 |

> **为什么必要：** 没有持久化，每次启动都需重新配置导出路径和设备选项，体验极差。

#### 9.10.7 桌面键盘快捷键

| 包名 | 版本 | 用途 |
|---|---|---|
| [`hotkey_manager`](https://pub.dev/packages/hotkey_manager) | `^0.2.3` | 注册全局/应用内快捷键（Ctrl+Z 撤销、Ctrl+S 保存、Ctrl+E 导出等），leanflutter.dev |

> **为什么必要：** 设计文档 3.2 节提及 Ctrl+Z / Ctrl+Y 撤销重做快捷键。Flutter 内置 `Shortcuts` Widget 只能处理焦点内快捷键，桌面全局级快捷键需要此包。

#### 9.10.8 批量导出 ZIP 打包

| 包名 | 版本 | 用途 |
|---|---|---|
| [`archive`](https://pub.dev/packages/archive) | `^3.x` | 将批量导出的所有图片打包成单个 `.zip` 文件，方便一键下载，纯 Dart 实现 |

> **为什么必要：** 批量导出可能产生数十甚至数百个文件，打包成 ZIP 后用户可一键下载/传输，是生产力工具的标配。

#### 9.10.9 用户操作反馈通知

| 包名 | 版本 | 用途 |
|---|---|---|
| [`toastification`](https://pub.dev/packages/toastification) | `^2.x` | 显示操作成功/失败/进度的 Toast 通知（导出成功、文件保存路径等），Material 3 风格 |

> **为什么必要：** 导出完成、目录导入成功/失败等关键操作节点需要非阻断式用户反馈，`ScaffoldMessenger` 的 SnackBar 在桌面端体验较差。

---

### 9.11 完整 pubspec.yaml 依赖片段（已补充）

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter

  # 设备框架
  device_frame_plus: ^1.5.0

  # SVG 渲染（设备框架资产必需）
  flutter_svg: ^2.2.3

  # 画布导出
  screenshot: ^3.0.0
  image: ^4.2.0
  flutter_image_compress: ^2.3.0

  # 截图裁剪调整
  croppy: ^1.4.1

  # 文件操作 & 目录扫描
  file_picker: ^10.3.10
  path_provider: ^2.1.0
  desktop_drop: ^0.4.4
  yaml: ^3.1.2
  path: ^1.9.0

  # 剪贴板图片粘贴（Ctrl+V）
  super_clipboard: ^0.9.1

  # 批量导出 ZIP 打包
  archive: ^3.6.0

  # 导出后打开目录
  open_filex: ^4.7.0

  # 字体 & 颜色
  google_fonts: ^8.0.2
  flex_color_picker: ^3.8.0

  # 状态管理
  flutter_riverpod: ^3.2.1
  riverpod_annotation: ^2.3.0
  hooks_riverpod: ^3.2.1

  # 桌面窗口管理
  window_manager: ^0.5.1

  # 桌面键盘快捷键
  hotkey_manager: ^0.2.3

  # 用户偏好持久化
  shared_preferences: ^2.3.0

  # 用户操作反馈通知
  toastification: ^2.3.0

  # 工具
  uuid: ^4.4.0
  collection: ^1.18.0
  freezed_annotation: ^2.4.0
  json_annotation: ^4.9.0
  intl: ^0.19.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.0
  freezed: ^2.5.0
  json_serializable: ^6.8.0
  riverpod_generator: ^2.4.0
```

---

## 十、开发里程碑

| 阶段 | 目标 | 预估工时 |
|---|---|---|
| v0.1 MVP | 基础画布 + 设备框架 + 图片上传 + PNG 单场景导出 | 2 周 |
| v0.2 | 文字编辑 + 背景设置 + 预设模板 | 1.5 周 |
| v0.3 | 图层管理 + 撤销重做 + 单语言批量导出 | 1.5 周 |
| v0.4 | 目录扫描 + descriptions 解析 + 自动填充场景 | 1.5 周 |
| v0.5 | 多语言场景管理 + 语言切换栏 UI + localeTextMap 编辑 | 1 周 |
| v0.6 | Isolate 并发批量导出 + 进度条 + 导出报告 + 目录规范命名 | 1.5 周 |
| v0.7 | 响应式布局适配（移动端） + 中英文 i18n | 1 周 |
| v1.0 | 性能优化 + 完整设备库 + 用户测试 | 1 周 |

---

## 十一、附录

### 参考资源

- 竞品网站：https://apppreviewmaker.com/
- App Store 截图规范：https://developer.apple.com/help/app-store-connect/reference/screenshot-specifications
- Google Play 截图规范：https://support.google.com/googleplay/android-developer/answer/9866151
- Flutter 官方文档：https://docs.flutter.dev
