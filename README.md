## 🙏 致谢与引用 (Credits & Acknowledgments)

本项目并非从零开始，它的成功构建离不开以下开源项目和开发者的杰出贡献。在此表示最诚挚的感谢！

### 核心源码与底层移植
本项目的自动化编译流水线主要依赖并拉取以下三个核心仓库的源码，均由 **[@jason-liu-4980](https://github.com/jason-liu-4980)** 及其贡献者开发：

*   **[sy108-mainline](https://github.com/jason-liu-4980/sy108-mainline)**：主控 OpenWrt 构建树与专属软件包（如 `udx-cellular`、`luci-app-udx`）。
*   **[linux-udx710](https://github.com/jason-liu-4980/linux-udx710)**：基于 Linux 7.3 的定制内核源码与 DTS 设备树。
*   **[sy108-uboot-spl](https://github.com/jason-liu-4980/sy108-uboot-spl)**：修改版 U-Boot 源码以及实现“不死固件”底层逻辑的 SML 封装工具。

> **许可证说明**：上述仓库均基于 `GPL-2.0-only` 协议开源。

### 自动化构建与 CI/CD 模板
*   **[xuxin1955/depend_ubuntu2204_openwrt](https://github.com/xuxin1955/depend_ubuntu2204_openwrt)**：提供了 Ubuntu 环境下快速安装 OpenWrt 编译依赖的脚本。
*   **[@P3TERX](https://github.com/P3TERX)**：本项目参考了其开源社区中广泛使用的 Actions 缓存与多阶段发布（Release）工作流思路。
*   **action-debugger**：提供了便捷的 SSH 云端调试能力（由 `WarpBuilds` 提供）。

### 底层硬件与刷机工具
*   **SPD Dump**：由 **[@TomKing062](https://github.com/TomKing062)** 开发的展锐底层刷机工具，以及绕过签名校验的 `custom_exec_no_verify_3f28.bin` 漏洞利用文件。
*   **UDX710 分区表**：初始分区表文件参考自 **[@dann2333](https://github.com/dann2333/udx710-mifi-info)**。

### 原厂数据提取
特别感谢对原厂固件进行逆向分析、提取并提供 `splloader.bin` 和 `sml.bin` 的社区大佬。没有这些原厂底层签名文件，就无法完成自定义 U-Boot 的封装。

---
**免责声明**：本仓库仅为个人学习、交流与技术验证之用。刷机有风险，因操作不当导致的设备损坏、数据丢失或变砖，需由操作者自行承担。
