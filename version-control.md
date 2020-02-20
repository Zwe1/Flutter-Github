# 版本管理

## 场景

近期工作中，遇到了一些在项目版本管理上的问题。由于客户要求，在整个项目的开发中，项目需要频繁的交付部署，这其中涵盖**Bug 修复及新的 Feature 开发**。
我们拥有一套针对该项目的 CI/CD 环境资源，在一段时间开发后，我们发现时常会**在部署 Bug 修复的时候，误带入了新的 Feature**，或是在部署 Feature 的时候带入了别的还无需交付的 Feature，整个分支管理和版本管理都处于一种比较混乱的状态，这对于交付质量和开发体验都有很大的负面影响。
通过分析我们项目现状以及可支配资源，给出了以下的建设性版本管理方案，以提高我们的版本管理效率，使**工程结构清晰**，增强可维护能力。

## 痛点

1. 在项目开发中存在庞大的修改 Bug 的工作，如何更好的管理 Bug 版本？
1. 项目中存在多个新功能需要开发，如何保证新功能不在错误的时间点提交？
1. 如何便捷的做项目间的**Bug 修复合并**？
1. 如何便捷的做项目间的**Feature 合并**？

## 版本控制模型

### 基础结构

由于目前阶段修改 Bug 的工作量巨大，占据总工作量近乎一半。考虑到我们支持持续集成及容器化部署，因此可虑阶段性的启用两套 CI 环境。
在此基础上，我们设定**两条主分支**，针对 Bug 和 Feature 进行分离的版本管理，使二者无交叉，仅在重要结点进行合并，从而保证版本的清晰与交付的准确。

### 业务背景

1. 我们的项目都起源于同一个基础版工程 —— dev。
2. oem-dev 和 oem-develop 为不同的两个项目。

![image.png](https://cdn.nlark.com/yuque/0/2019/png/105311/1575705318064-3df72a4f-c458-4b40-a0b1-382bd536f0b9.png#align=left&display=inline&height=682&name=image.png&originHeight=682&originWidth=1482&size=97264&status=done&style=none&width=1482)

hotfix-release 作为稳定的落地交付出包分支，运维每次仅需取用最新版本代码部署。

### 团队约定

1. 申请两套完整的 ci 系统，一套用于单纯的 bugfix，bug 测试及落地环境部署出包，一套用于新 feature 开发与测试。
1. 每个 bug 及 feature 都有一一对应的 jira 版本号，以确保每个改动都有根源可追溯。
1. 每个 commit 必须对应且仅对应一个 jira 版本号，以确保版本回溯和 commit 合并操作更加方便和精准。
1. 同一项目中采用一致标准的分支命名规范。

a. oem-develop-yzcx-hotfix      hotfix-release 分支
b. oem-develop-yzcx-feature    feature-release 分支
c. yzcx/fix-**_                            临时 fix 分支
d. yzcx/feat-_**                          独立功能开发分支
e. yzcx/[personName]-**_          个人分支
f. yzcx/merge-_**                        临时 merge 分支
g.yzcx/feat-\*\*\*-fix                      feature bugfix 分支

5. 不同项目可采取分支管理或分仓库管理。

分支管理：
a. 切换项目简单
b. 合并简单
c. 分支数量较多
分仓库管理：
a. 项目独立
b. 分支清晰
c. 合并较复杂
