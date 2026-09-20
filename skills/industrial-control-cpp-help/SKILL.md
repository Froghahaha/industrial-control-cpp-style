---
name: industrial-control-cpp-help
description: "显示 industrial-control-cpp-style skill 集合的快速入口、适用范围、专题选择和审查输出格式；一次性显示，不修改状态或文件。"
---

# Industrial Control C++ Help

这是一次性入口卡片，不改变模式、不写文件、不扫描仓库。

| 入口 | 用途 |
| --- | --- |
| `$industrial-control-cpp-style` | 默认代码产出规范：线性流程、所有权、故障、实时性和 C++17 |
| `$industrial-control-cpp-review` | 当前 diff 的短审查，只报告不修改 |
| `$industrial-control-cpp-audit` | 全仓库风险排序审查，只报告不修改 |
| `$industrial-control-cpp-debt` | 汇总 `industrial-contract` / `industrial-fault-debt` |
| `$industrial-control-cpp-help` | 显示本卡片 |

## Core reference topics

核心 skill 按需提供三个专题：业务流程与唯一提交点、契约与故障体系、按症状组织的反模式库。它们不依赖 MotionLib 或其它具体工程。

## 核心判断

```text
真实业务？
→ 哪个边界负责？
→ 正常拒绝、不可用、故障还是安全抑制？
→ 有明确 fallback 和退出条件吗？
→ 顶层能定位根因吗？
```

核心规范不提供 lite/full/ultra 强度模式：工控安全和故障语义不能靠强度开关削弱；专题 skill 通过显式调用按需使用。
