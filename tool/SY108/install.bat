@shift 0
@echo off
chcp 65001 nul
start
cls
echo ===================================================
echo       SY108 (UDX710) OpenWrt 一键全自动刷机工具
echo ===================================================
echo 警告：刷机有风险！请确保你已提取原厂备份。
echo 注意：刷入 OpenWrt 会覆盖原有系统，请自行承担风险。
echo.
set p choice=是否同意并开始安装（YN）

if i %choice%==Y (
    echo.
    echo 开始安装!!!!
    echo 现在你有 5 分钟的时间来连接设备,连接方法：
    echo.
    echo. ---------------------------------------------
    echo  1. 按住 RESET 键（或短接刷机触点），用数据线连接电脑。
    echo  2. 运行本脚本，当屏幕出现 Waiting for dl_diag 时，松开 RESET 键。
    echo. ---------------------------------------------
    echo.
    
     调用 spd_dump 进行刷机
    spd_dump --wait 600 skip_confirm 1 exec_addr 0x3f28 fdl fdl1 0x28007000 fdl fdl2 0x9efffe00 exec w uboot uboot.bin w system sysupgrade.bin w recovery recovery.bin reset
    
    echo.
    echo.
    echo 安装过程结束，如果刷入过程全部成功，你会看到 3 个进度条。
    echo 若未出现 send_fail 等提示，说明刷入成功。
    echo 现在，等待设备重启，然后访问 http192.168.66.1 即可进入 OpenWrt 后台。
    echo.
    echo 异常情况：
    echo 1.若进度条中断、设备无法开机，请截图本页面进行反馈。
    pause
) else if i %choice%==N (
    echo 取消安装，程序正在退出...
    timeout t 2 nul
    exit b
) else (
    echo 无效输入，请重新输入Y或N
    timeout t 1 nul
    goto start
)