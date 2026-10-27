@echo off
:: 强制切换到当前脚本所在的目录，防止找不到文件闪退
cd /d "%~dp0"
:: 设置控制台编码为 GBK，防止中文乱码
chcp 936 >nul
color 0A
title SY108 一键刷机工具

:start
cls
echo ===================================================
echo       SY108 (UDX710) OpenWrt 一键全自动刷机工具
echo ===================================================
echo 警告：刷机有风险！请确保你已提取原厂备份。
echo 注意：刷入 OpenWrt 会覆盖原有系统，请自行承担风险。
echo.
echo 当前目录下必须包含以下文件：
echo 1. uboot.bin (建议用原厂510KB那个，千万别用1.28MB的)
echo 2. boot.bin  (OpenWrt的主系统内核)
echo 3. system.bin (OpenWrt的主系统文件)
echo.
set /p choice=是否同意并开始安装? (Y/N):

if /i "%choice%"=="Y" (
    echo.
    echo 开始安装!!!!
    echo 现在你有 5 分钟的时间来连接设备，连接方法：
    echo.
    echo. ---------------------------------------------
    echo  1. 按住 RESET 键（或短接刷机触点）。
    echo  2. 将 USB 线插入电脑。
    echo  3. 黑窗口出现 Waiting for dl_diag 后，松开 RESET。
    echo. ---------------------------------------------
    echo.
    
    :: 核心刷机命令：按 uboot -> boot -> system 的顺序刷入，最后重启
    spd_dump --wait 600 skip_confirm 1 exec_addr 0x3f28 fdl fdl1 0x28007000 fdl fdl2 0x9efffe00 exec w uboot uboot.bin w boot boot.bin w system system.bin reset
    
    echo.
    echo.
    echo 安装过程结束。
    echo 如果看到 3 个进度条跑到了 100.0%，哪怕最后报了 TIMEOUT 断开，也说明数据写进去了。
    echo 现在，等待设备自动重启，然后插上网线访问 http://192.168.66.1
    echo.
    echo 异常情况：
    echo 1. 若出现 send_fail 提示，请检查驱动或线材。
    echo 2. 若进度条中断，请截图本页面反馈。
    pause
) else if /i "%choice%"=="N" (
    echo 取消安装，程序正在退出...
    timeout /t 2 >nul
    exit /b
) else (
    echo 无效输入，请重新输入 Y 或 N
    timeout /t 1 >nul
    goto start
)