# CodexPlusPlus ARM64 Builder

這個 Repository 專門為 **Windows 11 ARM64 / Surface Laptop Ultra** 建置 Codex++。

## 目標

- 從 `BigPizzaV3/CodexPlusPlus` 取得指定版本原始碼。
- 套用 Windows ARM64 安全補丁，避免 ARM64 版本誤抓 x64 自動更新安裝包。
- 在 GitHub Actions 的 Windows ARM64 runner 上原生編譯。
- 產出：
  - `CodexPlusPlus-<version>-windows-arm64-setup.exe`：一鍵安裝版。
  - `CodexPlusPlus-<version>-windows-arm64-portable.zip`：免安裝備援版。
  - `SHA256SUMS.txt`：下載後可驗證檔案完整性。

## 你只要這樣使用

1. 打開本 Repository 的 **Actions**。
2. 選 **Build Codex++ Windows ARM64**。
3. 等工作流程成功（綠色勾勾）。
4. 在該次 Run 的 **Artifacts** 下載 `CodexPlusPlus-Windows-ARM64`。
5. 解壓 Artifact。
6. 在 Surface Laptop Ultra 上雙擊 `CodexPlusPlus-*-windows-arm64-setup.exe`。
7. 安裝完成後，桌面會出現：
   - `Codex++`
   - `Codex++ 管理工具`
8. 先安裝並登入官方 ChatGPT / Codex Desktop，再啟動 `Codex++`。

> 第一版沒有商業 Code Signing 憑證。Windows SmartScreen 可能顯示「Windows 已保護您的電腦」。只應從本 Repository 的 GitHub Actions 產物下載，並先核對 `SHA256SUMS.txt`。

## ARM64 驗證

PowerShell 執行：

```powershell
Get-ComputerInfo | Select-Object WindowsProductName, WindowsVersion, OsArchitecture
```

應看到 `ARM 64-bit` / `ARM64` 類似文字。

安裝後可在「工作管理員 → 詳細資料」確認：

- `codex-plus-plus.exe`
- `codex-plus-plus-manager.exe`

都能正常啟動。

## 上游版本策略

`UPSTREAM_REF.txt` 保存要建置的上游 Git commit / tag / branch。預設鎖定經過本 Builder 驗證的 commit，避免上游更新後突然壞掉。

也可以從 Actions 手動輸入 `upstream_ref` 測試新版；成功後再更新 `UPSTREAM_REF.txt`。

## 重要設計

- ARM64 payload 為原生 `aarch64-pc-windows-msvc`。
- Builder 會修改 updater 的 Windows 架構判斷，避免 ARM64 版本自動抓到 x64 installer。
- Installer 使用 NSIS 封裝；payload 是 ARM64 原生程式。
- 同時輸出 Portable ZIP，若 installer 被 SmartScreen 阻擋仍有備援方案。

## 授權

CodexPlusPlus 上游為 **AGPL-3.0-only**。本 Repository 只提供 ARM64 建置、補丁與封裝流程；產出的 CodexPlusPlus 仍依上游授權條款使用。

Upstream: https://github.com/BigPizzaV3/CodexPlusPlus
