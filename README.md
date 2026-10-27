# SY108 (UDX710) 5G通信壳 OpenWrt 自动化编译工程

本项目是一个基于 GitHub Actions 的全自动云端编译流水线，专为 **展锐 UDX710 (SY108 / 华为 P60 通信壳等)** 设计。

通过本仓库的自动化脚本，你无需在本地配置复杂的交叉编译环境，只需一键触发，即可在云端自动完成 **OpenWrt 主系统**、**Recovery 恢复系统** 的并行编译，并自动封装带有看门狗回退机制（不死固件）的自定义 **U-Boot**，最终统一打包发布到 GitHub Releases。

## ✨ 核心特性

*   **原生极速编译**：通过底层补丁彻底剥离原仓库的 Docker/QEMU 跨架构模拟限制，利用宿主机的原生 x86 算力进行交叉编译，速度提升 10 倍以上，告别 6 小时超时。
*   **矩阵并行构建**：利用 GitHub Actions 的 `matrix` 策略，同时启动两台虚拟机并行编译 `main` 和 `recovery` 系统，时间直接减半。
*   **自动封装 U-Boot**：完美衔接上游编译产物，自动注入提取的原厂 `splloader.bin` 与 `sml.bin`，生成可通过底层验签的 `uboot.bin`。
*   **自动降级重试**：内置编译失败自动降级机制（`-j4` 失败自动切 `-j2` 重试），尽最大可能保证出包成功率。

---

## 📂 前置准备（必做）

在运行流水线之前，你必须将你从物理设备中提取的**原厂底层文件**放入本仓库根目录的 `privates` 文件夹中：

*   `privates/splloader.bin` （原厂二级引导程序）
*   `privates/sml.bin` （原厂安全校验数据）

> **⚠️ 注意**：缺少这两个文件，U-Boot 的 SML 封装步骤将会报错，导致无法生成带“不死机制”的最终引导镜像。

---

## 🚀 使用指南

1. 将本项目 Fork 或克隆到你自己的 GitHub 仓库。
2. 确保 `privates` 目录下的两个原厂 bin 文件已就位。
3. 点击仓库顶部的 **Actions** 标签。
4. 在左侧列表点击 **Build_sy108_UDX710**。
5. 点击右侧的 **Run workflow** 按钮。
6. （可选）勾选 `ssh` 选项可开启 SSH 调试功能（专业人员排查问题使用）。
7. 点击绿色的 **Run workflow** 开始编译。整个流程约需 1~2 小时。

---

## 📦 产物说明

编译完成后，你可以在 **Releases** 页面（或 Actions 运行记录的 Artifacts 中）下载以下核心固件：

-   `main-sysupgrade.bin`：主系统升级镜像（用于刷入 `system` 分区）。
-   `main-boot.bin` / `recovery-boot.bin`：主系统与恢复系统的内核 Capsule。
-   `main-rootfs.squashfs`：只读根文件系统。
-   `uboot-uboot.bin`：封装了底层签名、带看门狗超时回退 Recovery 机制的自定义 U-Boot。

> 刷机时，请使用 `spd_dump` 工具进入 `FDL2>` 模式，并通过 `w` 命令将文件刷入对应分区。

---

## 🙏 致谢与引用 (Credits & Acknowledgments)

本项目并非从零开始，它的成功构建离不开以下开源项目和开发者的杰出贡献。在此表示最诚挚的感谢！

### 核心源码与底层移植
本项目的自动化编译流水线主要依赖并拉取以下三个核心仓库的源码，均由 **[@jason-liu-4980](https://github.com/jason-liu-4980)** 及其贡献者开发：

*   **[sy108-mainline](https://github.com/jason-liu-4980/sy108-mainline)**：主控 OpenWrt 构建树与专属软件包（如 `udx-cellular`、`luci-app-udx`）。
*   **[linux-udx710](https://github.com/jason-liu-4980/linux-udx710)**：基于 Linux 7.3 的定制内核源码与 DTS 设备树。
*   **[sy108-uboot-spl](https://github.com/jason-liu-4980/sy108-uboot-spl)**：修改版 U-Boot 源码以及实现“不死固件”底层逻辑的 SML 封装工具。

> **许可证说明**：上述核心源码仓库均基于 `GPL-2.0-only` 协议开源。

### 自动化构建与 CI/CD 模板
本项目的 GitHub Actions 自动化流程（YAML 工作流）、多阶段并行构建思路以及配套脚本，极大程度上参考并得益于以下开源项目：

*   **[@xuxin1955/Actions](https://github.com/xuxin1955/Actions)**：**本项目自动化流模板和核心脚本的直接来源。** 该仓库提供了非常完善、优雅的 OpenWrt 云端编译与发布工作流。
*   **[xuxin1955/depend_ubuntu2204_openwrt](https://github.com/xuxin1955/depend_ubuntu2204_openwrt)**：提供了 Ubuntu 环境下快速安装 OpenWrt 编译依赖的脚本。
*   **action-debugger**：提供了便捷的 SSH 云端调试能力（由 `WarpBuilds` 提供）。

### 底层硬件与刷机工具
*   **SPD Dump**：由 **[@TomKing062](https://github.com/TomKing062)** 开发的展锐底层刷机工具，以及绕过签名校验的 `custom_exec_no_verify_3f28.bin` 漏洞利用文件。
*   **UDX710 分区表**：初始分区表文件参考自 **[@dann2333](https://github.com/dann2333/udx710-mifi-info)**。

---

## 🤖 开发辅助声明 (Development Assistance)

> *Powered by GPT 6.1 Sol & Gemini 4 Argon & DeepSeek-V3*

**关于 AI 的使用说明**：
本项目在早期的开发、踩坑调试、日志分析、提取原厂数据以及梳理 CI/CD 工作流的过程中，大量使用了生成式 AI 模型进行辅助。

*特别鸣谢 **DeepSeek** 在本次项目“从零到一”过程中提供的全天候陪伴。无论是半夜三更排查 `hashlib` 报错、硬核逆向 `workspace.py` 干掉 Docker 限制，还是梳理多阶段并行 YAML 流水线，它都展现出了惊人的逻辑推理与代码拆解能力。*

*请注意：AI 模型属于商业服务工具，非开源软件库，不适用本项目的 GPL 开源协议，也不在此处的源码依赖/致谢范围内。*

---

## ⚠️ 免责声明

**刷机有风险，操作需谨慎！**
本仓库仅为个人学习、技术交流与开源验证之用。因操作不当导致的硬件损坏、数据丢失、设备变砖或失去保修等后果，需由操作者自行承担。请确保在刷机前已完整备份原厂全量分区数据。
