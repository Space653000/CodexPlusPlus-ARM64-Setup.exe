# CodexPlusPlus Windows ARM64 — 新手安裝與使用說明

這個 Repository 是專門為 **Windows 11 ARM64 / Surface 類 ARM64 電腦** 準備的 Codex++ Windows ARM64 建置版。

如果你是第一次使用 GitHub、第一次安裝 Codex++、不知道 `.exe`、`.zip`、SHA256 是什麼，照這份 README 一步一步做即可。

---

## 先講結論：你大多只需要下載 1 個檔案

如果你的電腦是 Windows ARM64，例如 Surface Laptop Ultra / Snapdragon / Windows on ARM，最簡單的方式就是下載：

**`CodexPlusPlus-1.3.0-windows-arm64-setup.exe`**

Release 頁面：

https://github.com/Space653000/CodexPlusPlus-ARM64-Setup.exe/releases/tag/v1.3.0-arm64

然後：

1. 下載 `CodexPlusPlus-1.3.0-windows-arm64-setup.exe`
2. 放到桌面
3. 雙擊
4. 完成安裝
5. 開啟 Codex++

如果你只是要使用 Codex++，其他檔案可以先不用碰。

---

# 1. 這個專案是什麼？

這個 Repository 的工作是：

1. 從上游 `BigPizzaV3/CodexPlusPlus` 取得 Codex++ 原始碼
2. 套用 Windows ARM64 相容性補丁
3. 使用 GitHub Actions 的 Windows ARM64 runner 原生編譯
4. 驗證執行檔是真正的 ARM64 PE
5. 產生安裝版與免安裝版
6. 產生 SHA256 驗證檔與 Build Manifest
7. 發布到 GitHub Release

上游原始專案：

https://github.com/BigPizzaV3/CodexPlusPlus

本專案 Release：

https://github.com/Space653000/CodexPlusPlus-ARM64-Setup.exe/releases

> **重要：這不是 OpenAI 官方產品。**
>
> Codex++ 是第三方社群專案，本 Repository 只是針對 Windows ARM64 建置與封裝。
>
> OpenAI、ChatGPT、Codex 與 Codex++ 是不同層級的東西。

---

# 2. 哪些電腦適合使用？

這個版本是給：

- Windows 11 ARM64
- Windows on ARM
- Surface ARM64 機種
- Snapdragon X / X Elite / X Plus 類 ARM64 Windows 電腦
- 其他使用 ARM64 Windows 的裝置

不建議拿這個版本裝在一般 Intel / AMD x64 Windows 電腦。

---

# 3. 先確認你的 Windows 是不是 ARM64

在 Windows 按：

**開始 → 搜尋 `PowerShell` → 開啟 Windows PowerShell**

貼上：

```powershell
Get-ComputerInfo | Select-Object WindowsProductName, WindowsVersion, OsArchitecture
```

如果看到類似：

```text
OsArchitecture : ARM 64-bit
```

或：

```text
ARM64
```

代表這個版本適合你的電腦。

另外也可以：

1. 開啟「設定」
2. 系統
3. 系統資訊 / 關於
4. 找「系統類型」

看到 ARM64 即可。

---

# 4. 安裝前先準備什麼？

建議先完成以下事項：

1. Windows Update 更新到最新
2. 已有可正常使用的官方 ChatGPT / Codex Desktop 環境
3. 已登入你的 OpenAI / ChatGPT 帳號
4. 網路正常
5. 至少保留約 1 GB 可用磁碟空間

建議啟動順序：

```text
Windows
  ↓
官方 ChatGPT / Codex Desktop
  ↓
登入帳號
  ↓
Codex++
```

---

# 5. Release 裡每個檔案是做什麼的？

目前 Release：

https://github.com/Space653000/CodexPlusPlus-ARM64-Setup.exe/releases/tag/v1.3.0-arm64

你會看到以下檔案：

| 檔案 | 用途 | 新手要不要用 |
|---|---|---|
| `CodexPlusPlus-1.3.0-windows-arm64-setup.exe` | 一鍵安裝版 | **最推薦** |
| `CodexPlusPlus-1.3.0-windows-arm64-portable.zip` | 免安裝版 | 備援使用 |
| `CodexPlusPlus-Windows-ARM64.zip` | 完整交付包 | 備份 / 保存 |
| `SHA256SUMS.txt` | 驗證下載檔案有沒有被改掉 | 建議保留 |
| `BUILD-MANIFEST.txt` | 記錄建置來源與版本 | 查資料時使用 |

如果你只是要用 Codex++：

> **下載 Setup EXE 就好。**

---

# 6. 最推薦：Setup EXE 一鍵安裝

## Step 1：打開 Release

開啟：

https://github.com/Space653000/CodexPlusPlus-ARM64-Setup.exe/releases/tag/v1.3.0-arm64

往下找到 **Assets**。

---

## Step 2：下載安裝檔

點：

```text
CodexPlusPlus-1.3.0-windows-arm64-setup.exe
```

Windows 通常會下載到：

```text
C:\Users\你的使用者名稱\Downloads
```

也就是「下載」資料夾。

你也可以下載後拖到桌面。

---

## Step 3：雙擊安裝

雙擊：

```text
CodexPlusPlus-1.3.0-windows-arm64-setup.exe
```

依畫面完成安裝。

安裝器會把 Codex++ 主程式放到電腦裡，不需要你自己解壓縮、不需要自己輸入程式指令。

---

# 7. 如果 Windows SmartScreen 跳警告怎麼辦？

這個版本目前不是使用商業 Code Signing 憑證簽章，所以 Windows 可能顯示：

```text
Windows 已保護您的電腦
```

或：

```text
Microsoft Defender SmartScreen 已防止啟動無法辨識的應用程式
```

這通常表示：

- Windows 不認識這個自建程式的發行者
- 不代表 ARM64 編譯失敗
- 也不代表程式一定有病毒

建議先確認：

1. 是從本 Repository 的 Release 下載
2. 檔名正確
3. SHA256 正確

確認後，如果你信任這個 Repository，可以：

1. 點 **更多資訊**
2. 確認檔案名稱
3. 點 **仍要執行**

如果你的公司電腦有 IT 政策禁止未知應用程式，請不要強行繞過公司政策。

---

# 8. 如何驗證 SHA256？

SHA256 可以理解成「檔案指紋」。

如果下載過程中檔案被改動，SHA256 通常就會不一樣。

目前 Setup EXE 的 SHA256：

```text
1d93d5d976601f4c32c14f5084acb25ea3497d9fd2839a7c441cdcc9d4d3e640
```

Portable ZIP：

```text
3e841de02fc3bfbde9dad02b25280dfc607ba78c00df4c7124bf3953b82fb26a
```

## 新手做法

假設檔案在「下載」資料夾。

打開 PowerShell，輸入：

```powershell
cd $HOME\Downloads
```

然後：

```powershell
Get-FileHash .\CodexPlusPlus-1.3.0-windows-arm64-setup.exe -Algorithm SHA256
```

會看到類似：

```text
Algorithm : SHA256
Hash      : 1D93D5D976601F4C32C14F5084ACB25EA3497D9FD2839A7C441CDCC9D4D3E640
```

大小寫不重要。

只要字串一致即可。

也可以打開 Release 裡的：

```text
SHA256SUMS.txt
```

進行比對。

---

# 9. 安裝完成後怎麼開？

建議先：

1. 開啟官方 ChatGPT / Codex Desktop
2. 確認已登入
3. 再開 Codex++

安裝後可以從：

- 桌面捷徑
- 開始選單
- Codex++ 執行檔

啟動。

Codex++ 主要執行檔包含：

```text
codex-plus-plus.exe
codex-plus-plus-manager.exe
```

這兩個檔案已由 Builder 驗證為：

```text
PE Machine = 0xAA64
```

也就是原生 ARM64。

---

# 10. Portable ZIP 是什麼？

檔案：

```text
CodexPlusPlus-1.3.0-windows-arm64-portable.zip
```

這是免安裝版。

適合以下情況：

- Setup EXE 被 SmartScreen 擋住
- 不想安裝
- 想先測試
- 想放在獨立資料夾
- 想保留備援版本

## Portable 使用方法

1. 下載 ZIP
2. 右鍵 ZIP
3. 選「全部解壓縮」
4. 建議解壓到：

```text
C:\CodexPlusPlus-ARM64
```

或：

```text
C:\Users\你的名字\Desktop\CodexPlusPlus-ARM64
```

5. 打開資料夾
6. 執行：

```text
codex-plus-plus.exe
```

需要管理功能時再執行：

```text
codex-plus-plus-manager.exe
```

不要直接在 ZIP 裡雙擊執行，建議一定先解壓縮。

---

# 11. `CodexPlusPlus-Windows-ARM64.zip` 是什麼？

這是完整交付包。

裡面包含：

- Setup EXE
- Portable ZIP
- SHA256SUMS.txt
- BUILD-MANIFEST.txt

適合：

- 完整備份
- 移到另一台自己的 ARM64 電腦
- 離線保存
- 封存某一版

一般日常使用不需要下載這個大包。

---

# 12. `BUILD-MANIFEST.txt` 是什麼？

這個檔案記錄：

- Builder Repository
- Builder commit
- 上游 Repository
- 上游 commit / ref
- Codex++ 版本
- Rust target
- GitHub runner architecture

用途是未來發現問題時，可以知道：

> 「這個 EXE 到底是用哪一版原始碼編出來的？」

目前核心 target：

```text
aarch64-pc-windows-msvc
```

---

# 13. 安裝器為什麼可能不是 ARM64 PE？

這點很容易誤會。

目前 NSIS Setup 安裝器外殼可能是 x86 / x64 工具產生的安裝器。

但真正安裝進電腦裡的：

```text
codex-plus-plus.exe
codex-plus-plus-manager.exe
```

才是需要確認的主程式。

Builder 已驗證它們是：

```text
ARM64 / 0xAA64
```

所以判斷 Codex++ 是否為原生 ARM64，應該看 payload，而不是只看 NSIS 安裝器外殼。

---

# 14. 第一次啟動建議順序

第一次使用時建議：

```text
1. Windows 開機
2. 確認網路正常
3. 開啟官方 ChatGPT / Codex Desktop
4. 完成登入
5. 確認 Codex 本身可以正常使用
6. 再啟動 Codex++
7. 如果有 Manager，先用預設設定
8. 不要第一次就亂改所有設定
```

先確認「預設狀態可以正常啟動」，之後再慢慢調設定。

---

# 15. 如果 Codex++ 打不開

依序檢查：

## A. 確認 Windows 是 ARM64

```powershell
Get-ComputerInfo | Select-Object OsArchitecture
```

應該看到 ARM64 / ARM 64-bit。

---

## B. 確認不是直接從 ZIP 裡執行

Portable ZIP 要先：

```text
右鍵 → 全部解壓縮
```

再執行。

---

## C. 重新開機

安裝完第一次不能開，可以先重新啟動 Windows。

---

## D. 確認官方 ChatGPT / Codex Desktop 可以正常啟動

Codex++ 本身不是 OpenAI 官方 Codex 的替代品。

如果官方程式本身不能工作，先處理官方程式問題。

---

## E. Windows Defender 是否隔離檔案

打開：

```text
Windows 安全性
→ 病毒與威脅防護
→ 保護歷程記錄
```

看是否有檔案被隔離。

不要看到警告就直接關閉整套 Defender。

先確認來源與 SHA256。

---

# 16. 如果出現「此應用程式無法在你的電腦上執行」

先確認：

1. Windows 是 ARM64
2. 下載的是：

```text
windows-arm64
```

不是 x64 版

3. ZIP 已完整解壓
4. SHA256 正確
5. Windows Update 已更新

如果你其實是 Intel / AMD x64 Windows，請不要使用這個 ARM64 build。

---

# 17. 找不到 ChatGPT / Codex 怎麼辦？

請先分開測試：

## 測試 1

不開 Codex++。

只開官方 ChatGPT / Codex Desktop。

確認可以正常登入、正常使用。

## 測試 2

官方程式正常後，再開 Codex++。

如果只有 Codex++ 找不到官方程式，通常才是：

- 路徑偵測問題
- AppX / 安裝位置問題
- Codex++ 上游版本相容問題

這時可以在 GitHub Issues 回報。

Repository：

https://github.com/Space653000/CodexPlusPlus-ARM64-Setup.exe

---

# 18. 被防毒軟體攔截怎麼辦？

不要第一時間把防毒整套關掉。

建議：

1. 確認下載來源
2. 驗證 SHA256
3. 查看 Defender / 防毒軟體的偵測名稱
4. 確認被擋的是哪個檔案
5. 再判斷是否允許

如果檔案不是從本 GitHub Release 下載，建議不要執行。

---

# 19. 想重新安裝怎麼辦？

建議：

1. 關閉 Codex++
2. 關閉 Codex++ Manager
3. Windows「設定」
4. 應用程式
5. 已安裝的應用程式
6. 找 Codex++
7. 卸載
8. 重新啟動 Windows
9. 再執行新版 Setup EXE

如果找不到卸載項目，可以改用 Portable ZIP 測試。

---

# 20. 怎麼移除 Codex++？

如果你使用 Setup EXE：

```text
Windows 設定
→ 應用程式
→ 已安裝的應用程式
→ Codex++
→ 卸載
```

如果你使用 Portable ZIP：

1. 關閉 Codex++
2. 刪掉解壓縮資料夾即可

Portable 版通常沒有傳統安裝程序。

---

# 21. 怎麼更新新版？

這個專案會把上游版本固定在：

```text
UPSTREAM_REF.txt
```

目的不是永遠停在舊版，而是避免上游一更新，ARM64 build 就突然壞掉。

更新流程概念：

```text
上游 Codex++ 新版
  ↓
測試新的 upstream ref
  ↓
ARM64 編譯
  ↓
PE ARM64 驗證
  ↓
Setup / Portable 打包
  ↓
SHA256
  ↓
GitHub Release
```

新手不需要自己改 `UPSTREAM_REF.txt`。

看到新的 GitHub Release 再更新即可。

---

# 22. GitHub Actions 是做什麼的？

Repository 裡有自動化建置流程。

主要 workflow：

```text
.github/workflows/build-arm64.yml
```

它會自動：

```text
抓上游原始碼
→ 套 ARM64 patch
→ 安裝 Node
→ 安裝 Rust ARM64 target
→ Build frontend
→ Cargo ARM64 Release build
→ 驗證 PE 0xAA64
→ 打 Portable ZIP
→ 打 NSIS Setup EXE
→ SHA256
→ Build Manifest
→ GitHub Artifact
```

發布 workflow：

```text
.github/workflows/publish-release.yml
```

它負責把成功產物放到 GitHub Release。

---

# 23. 為什麼不直接把 EXE 塞進 Repository 原始碼？

Git Repository 比較適合保存：

- 原始碼
- Workflow
- Patch
- README
- 設定檔

大型二進位：

- `.exe`
- `.zip`

比較適合放在 GitHub Releases。

這樣：

- 比較好下載
- 不會讓 Git history 越來越肥
- 可以清楚分版本
- 可以附 SHA256
- 比較符合 GitHub 一般發布方式

---

# 24. 目前版本資訊

目前 Release：

```text
Codex++ 1.3.0 Windows ARM64
```

Tag：

```text
v1.3.0-arm64
```

Rust target：

```text
aarch64-pc-windows-msvc
```

主程式 ARM64 驗證：

```text
codex-plus-plus.exe          → 0xAA64
codex-plus-plus-manager.exe  → 0xAA64
```

Release：

https://github.com/Space653000/CodexPlusPlus-ARM64-Setup.exe/releases/tag/v1.3.0-arm64

---

# 25. 新手到底應該下載哪個？

最簡單答案：

## 一般使用

下載：

```text
CodexPlusPlus-1.3.0-windows-arm64-setup.exe
```

## Setup 被擋 / 想免安裝

下載：

```text
CodexPlusPlus-1.3.0-windows-arm64-portable.zip
```

## 想全部備份

下載：

```text
CodexPlusPlus-Windows-ARM64.zip
```

## 想檢查檔案完整性

下載：

```text
SHA256SUMS.txt
```

## 想查是哪一版原始碼編的

下載：

```text
BUILD-MANIFEST.txt
```

---

# 26. 最簡單完整 SOP

如果你不想看前面全部說明，只看這裡：

```text
① 確認 Windows 是 ARM64

② 安裝並登入官方 ChatGPT / Codex Desktop

③ 打開：
https://github.com/Space653000/CodexPlusPlus-ARM64-Setup.exe/releases/tag/v1.3.0-arm64

④ 下載：
CodexPlusPlus-1.3.0-windows-arm64-setup.exe

⑤ 建議驗證 SHA256

⑥ 雙擊 Setup EXE

⑦ SmartScreen 出現時，先確認檔名、來源、SHA256

⑧ 完成安裝

⑨ 先開官方 ChatGPT / Codex Desktop

⑩ 再開 Codex++

⑪ 第一次先用預設設定，不要一次亂改全部選項
```

---

# 27. 安全提醒

請只從：

```text
https://github.com/Space653000/CodexPlusPlus-ARM64-Setup.exe
```

以及這個 Repository 的 Releases 下載。

不要從陌生網盤、Discord 私訊、不明短網址重新下載他人改過的 EXE。

下載後建議用 SHA256 驗證。

---

# 28. 授權與第三方聲明

CodexPlusPlus 上游使用：

```text
AGPL-3.0-only
```

本 Repository 提供的是：

- Windows ARM64 建置流程
- ARM64 相容補丁
- GitHub Actions
- 安裝封裝
- Release 發布

CodexPlusPlus 本身仍依上游授權條款使用。

本 Repository 與 Codex++ 均不是 OpenAI 官方產品。

OpenAI、ChatGPT、Codex 等名稱的權利屬其各自權利人。

---

# 29. 重要連結

本 Repository：

https://github.com/Space653000/CodexPlusPlus-ARM64-Setup.exe

最新 ARM64 Release：

https://github.com/Space653000/CodexPlusPlus-ARM64-Setup.exe/releases/tag/v1.3.0-arm64

全部 Releases：

https://github.com/Space653000/CodexPlusPlus-ARM64-Setup.exe/releases

上游 CodexPlusPlus：

https://github.com/BigPizzaV3/CodexPlusPlus

---

## 一句話版

> **Windows ARM64 / Surface 使用者：下載 `CodexPlusPlus-1.3.0-windows-arm64-setup.exe`，先確認官方 ChatGPT / Codex Desktop 能正常登入，再安裝並啟動 Codex++。**
