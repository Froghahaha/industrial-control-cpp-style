---
name: industrial-control-cpp-audit
description: "对 C++17 工控仓库进行一次性全仓库规范审查，按风险排序发现契约越界、静默 fallback、故障不可定位、实时资源失控、所有权不清和流程过度拆分；只报告，不修改。"
---

# 工控 C++ Repository Audit

这是 `industrial-control-cpp-review` 的全仓库版本。先识别 Core、Hardware Manager、Runtime、Application、驱动和测试边界，再按真实调用路径审查，不把生成代码、第三方代码和构建产物当作业务源文件。

优先搜索：

- `catch (...)` 后继续、旧值/零值/default fallback、无界重试；
- 输出发布早于硬件/外部提交；
- 故障被改写成无上下文 `false` 或日志；
- 可变 solver/Runtime/workspace 的多线程访问；
- 控制周期中的分配、阻塞、I/O、格式化和同步日志；
- 同一业务动作被多个模块或泛化 helper 隐藏；
- 公共接口缺少单位、所有权、线程、失败和副作用契约。

判断标准是：模块只校验自己拥有的业务不变量；内部故障不能伪装成功；外部不可用必须可见；候选结果和外部副作用必须有清晰提交边界；顶层必须能定位模块、阶段、操作和根因。命名、文件长度和拆分方式只有在显著增加认知负担时才列为问题。

## 输出格式

按风险从高到低，每条一行：

```text
<severity> <tag> <问题和影响>. 最小修复方向. [<path>:<line>]
```

严重级别：`critical`、`high`、`medium`、`low`。`critical/high` 仅用于安全语义、故障伪装、数据/输出错误或未定义并发行为；单纯命名或布局偏好不得升级。

报告末尾给出：

```text
top risk: <最高优先级问题>
next smallest step: <最小下一步>
```

只报告，不直接应用修复。
