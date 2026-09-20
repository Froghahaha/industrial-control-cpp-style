# industrial-control-cpp-style

面向 C++17 工控、机器人控制、运动规划、硬件管理和实时 Runtime 的 Codex skill 集合。

## 结构

```text
industrial-control-cpp-style/
├─ SKILL.md                                  # 默认核心规范
├─ references/                               # 按需加载的正向范式、故障体系和反模式
├─ skills/
│  ├─ industrial-control-cpp-review/         # 当前 diff 的短审查
│  ├─ industrial-control-cpp-audit/          # 全仓库审查
│  ├─ industrial-control-cpp-debt/           # 契约/故障债务汇总
│  └─ industrial-control-cpp-help/           # 入口和输出格式卡片
└─ scripts/
   └─ sync_to_codex.ps1                      # 同步并校验所有 skill
```

核心 skill 默认约束代码产出；专题 skill 都是一次性报告，不会未经请求修改代码。参考文件不依赖 MotionLib、Core、Hardware Manager 或任何具体工程，第三方可以独立使用。

## 安装/更新

在本仓库根目录运行：

```powershell
.\scripts\sync_to_codex.ps1
```

脚本会把核心 skill 和四个专题 skill 同步到当前用户的 `.codex\skills`，然后对每个目录运行 `quick_validate.py`。源仓库与安装副本保持同名，便于后续提交和演化。

## 设计原则

- 核心入口保持短小，专题内容按需披露；
- `MUST NOT` 只保留安全、故障和并发不变量；
- 业务流程优先保持线性、连续，候选计算和外部副作用有唯一提交点；
- 防御性代码必须有责任边界，禁止无策略的静默 fallback；
- 故障保留根因，并能从顶层定位模块、阶段、操作和恢复状态。
