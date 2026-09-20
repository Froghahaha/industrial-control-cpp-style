---
name: industrial-control-cpp-debt
description: "汇总 C++ 工控代码中的 industrial-contract 和 industrial-fault-debt 标记，形成带位置、假设、适用范围和升级条件的契约/故障债务清单；只读取和报告。"
---

# 工控契约与故障债务

一次性扫描仓库中的显式债务标记，不把普通 TODO、历史注释或没有明确语义的 FIXME 自动当作工控债务。

## 扫描

使用 `rg` 扫描源文件，跳过 `.git`、构建目录、生成物和第三方代码：

```text
industrial-contract:
industrial-fault-debt:
```

每个命中点都必须读取附近代码，确认它确实描述了契约假设、故障分类缺口、恢复策略缺口或诊断投影缺口。

## 输出

按文件分组，每行：

```text
<file>:<line> <kind> <当前假设或缺口>. scope: <适用范围>. trigger: <升级条件>.
```

没有升级条件的标记追加 `no-trigger`，优先列出。末尾输出：

```text
<N> markers, <M> without an upgrade trigger.
```

该 skill 不写入 ledger、不修改代码；用户明确要求持久化时，才创建文件。
