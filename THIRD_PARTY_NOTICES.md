# 第三方组件与开源声明 (Third-Party Notices)

本项目（SY108-OpenWrt-Builder）的**自动化构建脚本与配置文件**采用 **MIT License** 开源。

但本项目的编译流水线在运行时，会动态拉取、编译第三方开源软件。这些软件遵循其各自的许可证。分发编译产物（固件）时，需遵守相应许可证的要求。

---

## 一、核心源码仓库（动态拉取并编译）

以下仓库由 **jason-liu-4980** 维护，均采用 **GPL-2.0-only** 许可证：

| 仓库 | 许可证 | 用途 |
| :--- | :--- | :--- |
| [sy108-mainline](https://github.com/jason-liu-4980/sy108-mainline) | GPL-2.0-only | OpenWrt 平台集成与用户态服务 |
| [linux-udx710](https://github.com/jason-liu-4980/linux-udx710) | GPL-2.0-only | Linux 7.3 内核、DTS 与驱动 |
| [sy108-uboot-spl](https://github.com/jason-liu-4980/sy108-uboot-spl) | GPL-2.0-only | U-Boot 2015.07 与 SPL 引导器 |

**GPL-2.0-only 的合规要点**：
- 若你**分发**由这些源码编译生成的固件（如 `sysupgrade.bin`、`uboot.bin`），根据 GPL-2.0 第 3 条，你有义务提供**对应的完整源码**，或提供获取源码的书面要约。
- 本仓库的 MIT 许可证**仅覆盖** `build.yml`、`*.sh`、`*.py` 等脚本文件，**不覆盖**上述 GPL 源码及其编译产物。

---

## 二、自动化构建模板与辅助脚本

| 组件 | 许可证 | 用途 |
| :--- | :--- | :--- |
| [xuxin1955/Actions](https://github.com/xuxin1955/Actions) | **GPL-3.0**[reference:7] | CI 流水线模板参考 |
| [xuxin1955/depend_ubuntu2204_openwrt](https://github.com/xuxin1955/depend_ubuntu2204_openwrt) | **MIT**[reference:8] | Ubuntu 编译依赖安装脚本 |

> **说明**：`xuxin1955/Actions` 的 GPL-3.0 许可证覆盖的是其**仓库内的代码**。本项目的 `build.yml` 是**独立编写**的，仅在架构思路上参考了该模板，并未直接复制其受 GPL-3.0 保护的代码。若你计划直接复用其流水线文件，则该文件应遵循 GPL-3.0。

---

## 三、刷机与提取工具（不包含在本仓库中）

以下工具**仅供用户在本地使用**，不参与 CI 编译流程，也不打包进固件：

| 工具 | 许可证 | 用途 |
| :--- | :--- | :--- |
| [TomKing062/spreadtrum_flash](https://github.com/TomKing062/spreadtrum_flash) (`spd_dump`) | **GPL-3.0-or-later** | 展锐底层刷机工具 |
| [dann2333/udx710-mifi-info](https://github.com/dann2333/udx710-mifi-info) | **GPL-3.0**（推定） | UDX710 分区表参考 |

> **注意**：`spd_dump` 的 GPL-3.0 许可证要求，若你**分发**该工具的二进制文件，必须同时提供其源代码。本仓库不包含 `spd_dump` 的任何副本，因此不触发该义务。

---

## 四、CI/CD 平台组件

| 组件 | 许可证 |
| :--- | :--- |
| `actions/checkout` | MIT |
| `actions/upload-artifact` / `download-artifact` | MIT |
| `actions/cache` | MIT |
| `insightsengineering/disk-space-reclaimer` | MIT |
| `WarpBuilds/action-debugger` | 详见其仓库 |

这些 GitHub Actions 均为 MIT 等宽松许可证，与本项目的 MIT 许可证完全兼容。

---

## 五、OpenWrt 及其软件包

编译过程中会从 OpenWrt 官方源拉取大量软件包，这些软件包各自遵循其许可证（常见为 GPL-2.0、MIT、BSD、ISC 等）。具体每个包的许可证，可在 OpenWrt 构建树的 `package/*/Makefile` 中通过 `PKG_LICENSE` 字段查看。

---

## 六、AI 辅助工具

本项目在开发过程中使用了生成式 AI 模型（ChatGPT、Gemini、DeepSeek）进行代码辅助、日志分析与工作流编写。AI 模型属于商业服务，**不属于开源软件组件**，其使用条款由各自的服务协议约束，不纳入本声明。

---

**最后更新**：2026-10-27

**免责声明**：本文件仅为许可证信息披露之用，不构成法律意见。若你对合规性有疑问，建议咨询专业法律人士。
