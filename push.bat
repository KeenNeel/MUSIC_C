@echo off
chcp 65001 > nul
echo ==========================================
echo  GitHub 自動プッシュスクリプト
echo ==========================================
echo.

:: 1. 変更されたファイルをすべて追加
echo [1/3] ファイルを追加中 (git add)...
git add .

:: 2. 日時を自動で取得してコミットメッセージにする
set COMMIT_MSG=自動バックアップ: %date% %time%
echo [2/3] コミットを作成中 (git commit)...
git commit -m "%COMMIT_MSG%"

:: 3. GitHubへプッシュ
echo [3/3] GitHubへプッシュ中 (git push)...
git push origin main

echo.
echo ==========================================
echo  すべての処理が完了しました！
echo ==========================================
pause