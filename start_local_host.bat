@echo off
chcp 65001 >nul
rem ============================================================
rem  Cassette Deck Studio  ローカルサーバー起動
rem  このファイルを HTML と曲ファイルがあるフォルダに置いて
rem  ダブルクリックしてください。
rem ============================================================
cd /d "%~dp0"
title Cassette Deck Studio - Local Server

set PORT=5000
set PAGE=cassette_deck_studio.html
if exist "index.html" set PAGE=

rem --- すでに起動済みならブラウザだけ開く ---
netstat -ano | findstr /r /c:":%PORT% .*LISTENING" >nul
if not errorlevel 1 (
  echo すでにポート %PORT% でサーバーが動いています。ブラウザを開きます。
  start "" "http://localhost:%PORT%/%PAGE%"
  timeout /t 3 >nul
  exit /b
)

rem --- Python を探す（py → python の順） ---
set PY=
where py >nul 2>nul
if not errorlevel 1 set PY=py
if not defined PY (
  where python >nul 2>nul
  if not errorlevel 1 set PY=python
)
if not defined PY goto NOPYTHON

echo ------------------------------------------------------------
echo  Cassette Deck Studio を起動します
echo  フォルダ : %cd%
echo  URL      : http://localhost:%PORT%/%PAGE%
echo.
echo  止めるときは、この画面で Ctrl + C を押すか、画面を閉じてください。
echo ------------------------------------------------------------

rem --- サーバーが立ち上がるのを少し待ってからブラウザを開く ---
start "" cmd /c "timeout /t 2 >nul & start "" http://localhost:%PORT%/%PAGE%"

%PY% -m http.server %PORT%
echo.
echo サーバーが停止しました。
pause
exit /b

:NOPYTHON
echo ------------------------------------------------------------
echo  Python が見つかりませんでした。
echo  https://www.python.org/downloads/ から Python をインストールしてください。
echo  （インストール時に「Add python.exe to PATH」にチェックを入れてください）
echo ------------------------------------------------------------
pause