Unicode true
!include "MUI2.nsh"

!ifndef VERSION
  !define VERSION "0.0.0"
!endif

!define ROOT ".."
!define APPDIR "${ROOT}\\dist\\app"

Name "Codex++ ARM64"
OutFile "${ROOT}\\dist\\CodexPlusPlus-${VERSION}-windows-arm64-setup.exe"
InstallDir "$LOCALAPPDATA\\Programs\\Codex++-ARM64"
InstallDirRegKey HKCU "Software\\Codex++-ARM64" "InstallDir"
RequestExecutionLevel user
SetCompressor /SOLID lzma

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "TradChinese"

Section "Install"
  SetOutPath "$INSTDIR"

  nsExec::ExecToLog 'taskkill /IM codex-plus-plus.exe /F'
  Pop $0
  nsExec::ExecToLog 'taskkill /IM codex-plus-plus-manager.exe /F'
  Pop $0

  File "${APPDIR}\\codex-plus-plus.exe"
  File "${APPDIR}\\codex-plus-plus-manager.exe"

  CreateShortcut "$DESKTOP\\Codex++.lnk" "$INSTDIR\\codex-plus-plus.exe" "" "$INSTDIR\\codex-plus-plus.exe"
  CreateShortcut "$DESKTOP\\Codex++ 管理工具.lnk" "$INSTDIR\\codex-plus-plus-manager.exe" "" "$INSTDIR\\codex-plus-plus-manager.exe"

  CreateDirectory "$SMPROGRAMS\\Codex++ ARM64"
  CreateShortcut "$SMPROGRAMS\\Codex++ ARM64\\Codex++.lnk" "$INSTDIR\\codex-plus-plus.exe" "" "$INSTDIR\\codex-plus-plus.exe"
  CreateShortcut "$SMPROGRAMS\\Codex++ ARM64\\Codex++ 管理工具.lnk" "$INSTDIR\\codex-plus-plus-manager.exe" "" "$INSTDIR\\codex-plus-plus-manager.exe"
  CreateShortcut "$SMPROGRAMS\\Codex++ ARM64\\卸載 Codex++.lnk" "$INSTDIR\\uninstall.exe"

  WriteUninstaller "$INSTDIR\\uninstall.exe"

  WriteRegStr HKCU "Software\\Codex++-ARM64" "InstallDir" "$INSTDIR"
  WriteRegStr HKCU "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\Codex++-ARM64" "DisplayName" "Codex++ ARM64"
  WriteRegStr HKCU "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\Codex++-ARM64" "DisplayVersion" "${VERSION}"
  WriteRegStr HKCU "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\Codex++-ARM64" "Publisher" "BigPizzaV3 upstream / Space653000 ARM64 build"
  WriteRegStr HKCU "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\Codex++-ARM64" "DisplayIcon" "$INSTDIR\\codex-plus-plus-manager.exe"
  WriteRegStr HKCU "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\Codex++-ARM64" "InstallLocation" "$INSTDIR"
  WriteRegStr HKCU "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\Codex++-ARM64" "UninstallString" "$INSTDIR\\uninstall.exe"
SectionEnd

Section "Uninstall"
  nsExec::ExecToLog 'taskkill /IM codex-plus-plus.exe /F'
  Pop $0
  nsExec::ExecToLog 'taskkill /IM codex-plus-plus-manager.exe /F'
  Pop $0

  Delete "$DESKTOP\\Codex++.lnk"
  Delete "$DESKTOP\\Codex++ 管理工具.lnk"
  Delete "$SMPROGRAMS\\Codex++ ARM64\\Codex++.lnk"
  Delete "$SMPROGRAMS\\Codex++ ARM64\\Codex++ 管理工具.lnk"
  Delete "$SMPROGRAMS\\Codex++ ARM64\\卸載 Codex++.lnk"
  RMDir "$SMPROGRAMS\\Codex++ ARM64"

  Delete "$INSTDIR\\codex-plus-plus.exe"
  Delete "$INSTDIR\\codex-plus-plus-manager.exe"
  Delete "$INSTDIR\\uninstall.exe"
  RMDir "$INSTDIR"

  DeleteRegKey HKCU "Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\Codex++-ARM64"
  DeleteRegKey HKCU "Software\\Codex++-ARM64"
SectionEnd
