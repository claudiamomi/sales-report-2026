@echo off
chcp 65001 >nul
title 直客銷售週報 - 一鍵部署

cd /d "%~dp0"

echo.
echo  ============================================
echo   直客銷售週報 - 一鍵部署
echo  ============================================
echo.

REM ─────────── Step 1：複製最新 HTML ───────────
echo [1/3] 從藍莓週報產出資料夾複製最新 index.html...
set SOURCE="C:\Users\Artisan\Documents\AI協作\行銷團隊\藍莓_業績週報\週報產出\index.html"

if not exist %SOURCE% (
    echo.
    echo   [失敗] 找不到源檔案：
    echo   %SOURCE%
    echo   請先確認藍莓有產出最新的週報
    echo.
    pause
    exit /b 1
)

copy /Y %SOURCE% "index.html" >nul
if errorlevel 1 (
    echo   [失敗] 複製失敗！
    pause
    exit /b 1
)
echo   [完成] 已複製最新 index.html
echo.

REM ─────────── Step 2：Git add + commit ───────────
echo [2/3] 加入變更並建立 commit...
set GIT="C:\Program Files\Git\cmd\git.exe"

%GIT% add index.html
%GIT% commit -m "更新週報"
echo.

REM ─────────── Step 3：Git push ───────────
echo [3/3] 推送到 GitHub...
%GIT% push
if errorlevel 1 (
    echo.
    echo   [失敗] Push 失敗！
    echo   可能原因：網路斷線 / GitHub 認證過期
    echo   請截圖上方錯誤訊息給藍莓看
    echo.
    pause
    exit /b 1
)

echo.
echo  ============================================
echo   [成功] 部署完成！
echo.
echo   網址：https://claudiamomi.github.io/sales-report-2026/
echo   約 1-2 分鐘後網頁會顯示最新版
echo  ============================================
echo.
pause
exit /b 0
