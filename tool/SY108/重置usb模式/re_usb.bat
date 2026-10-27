@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

echo 通信壳USB模式设置脚本 by Voodoo
echo =========================================
echo 设置设备USB模式（临时/永久）并重启
echo =========================================

:choose_mode
set /p MODE_TYPE="请选择模式类型 (0=临时, 1=永久): "
if "%MODE_TYPE%"=="0" goto choose_usb
if "%MODE_TYPE%"=="1" goto choose_usb
echo 输入无效，请输入 0 或 1
goto choose_mode

:choose_usb
echo 可选USB模式:
echo 1. CDC-NCM
echo 2. CDC-ECM
echo 3. RNDIS
set /p USB_CHOICE="请输入数字选择USB模式: "
if "%USB_CHOICE%"=="1" set USB_MODE=CDC-NCM
if "%USB_CHOICE%"=="2" set USB_MODE=CDC-ECM
if "%USB_CHOICE%"=="3" set USB_MODE=RNDIS
if not defined USB_MODE (
    echo 输入无效，请输入 1, 2 或 3
    goto choose_usb
)

if "%MODE_TYPE%"=="1" (
    set FILE=/mnt/data/mode.cfg
) else (
    set FILE=/mnt/data/mode_tmp.cfg
)

set MODE_NUM=3
if /I "%USB_MODE%"=="CDC-NCM" set MODE_NUM=1
if /I "%USB_MODE%"=="CDC-ECM" set MODE_NUM=2
if /I "%USB_MODE%"=="RNDIS"   set MODE_NUM=3

adb shell sync
adb shell "echo %MODE_NUM% > %FILE%"
adb shell sync
adb shell "cat %FILE%"
adb shell /sbin/reboot

echo 完成，重启中
adb kill-server
pause
