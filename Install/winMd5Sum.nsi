; winMd5Sum.nsi - based on example1.nsi
;

; The name of the installer
Name "winMd5Sum"
Icon "install.ico"
UninstallIcon "uninst.ico"

LicenseText "winMd5Sum is a free, as-is product. Please read the license terms below before installing."
LicenseData license.txt

; The file to write
OutFile "Install-winMd5Sum.exe"

; The default installation directory
InstallDir $PROGRAMFILES\winMd5Sum

; The text to prompt the user to enter a directory
DirText "This will install winMd5Sum on your computer. Choose a directory"

Page license
Page components
Page directory
Page instfiles

; The stuff to install
Section "!winMd5Sum (required)"
  SectionIn RO
  SetOutPath $INSTDIR
  File "..\Release\winMd5Sum.exe"
  WriteUninstaller "uninstall.exe"
SectionEnd


; == start menu
Section "Create Start Menu Icons"
  SetOutPath $INSTDIR
  CreateDirectory "$SMPROGRAMS\winMd5Sum"
  CreateShortCut "$SMPROGRAMS\winMd5Sum\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0
  CreateShortCut "$SMPROGRAMS\winMd5Sum\winMd5Sum.lnk" "$INSTDIR\winMd5Sum.exe" "" "$INSTDIR\winMd5Sum.exe" 0
SectionEnd


; == send to ==
Section "Put In Send To Menu"
  ReadRegStr $0 HKCU "Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" "SendTo"
  CreateShortCut "$0\winMd5Sum.lnk" "$INSTDIR\winMd5Sum.exe" "" "$INSTDIR\winMd5Sum.exe" 0
SectionEnd


; == desktop ==
Section /o "Create Desktop Icon"
  SetOutPath $INSTDIR
  CreateShortCut "$DESKTOP\winMd5Sum.lnk" "$INSTDIR\winMd5Sum.exe" "" "$INSTDIR\winMd5Sum.exe" 0
SectionEnd 


; == quick lauch ==
Section /o "Create Quick Launch Icon"
  SetOutPath $INSTDIR
  CreateShortCut "$QUICKLAUNCH\winMd5Sum.lnk" "$INSTDIR\winMd5Sum.exe" "" "$INSTDIR\winMd5Sum.exe" 0
SectionEnd 


; == source code ==
Section /o "Install Source Code"
  SetOutPath "$INSTDIR\Source Code"
  File "..\version.ini"
  File "..\winMd5Sum.vcproj"
  File "..\winMd5Sum.sln"
  SetOutPath "$INSTDIR\Source Code\Source"
  File "..\Source\*.*"
  SetOutPath "$INSTDIR\Source Code\Install"
  File *.nsi
  File *.ico
  File *.txt
SectionEnd


UninstallText "This will uninstall winMd5Sum. Hit next to continue."

; special uninstall section.
Section "Uninstall"
  ReadRegStr $0 HKCU "Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" "SendTo"
  ; remove files
  Delete $INSTDIR\*.*

  ; remove the source code
  Delete "$INSTDIR\Source Code\*.*"
  Delete "$INSTDIR\Source Code\Source\*.*"
  Delete "$INSTDIR\Source Code\Install\*.*"
  Delete "$INSTDIR\Source Code\Debug\*.*"
  Delete "$INSTDIR\Source Code\Release\*.*"

  ; remove shortcuts, if any.
  Delete "$SMPROGRAMS\winMd5Sum\*.*"
  Delete "$0\winMd5Sum.lnk"
  Delete "$QUICKLAUNCH\winMd5Sum.lnk"
  Delete "$DESKTOP\winMd5Sum.lnk"

  ; remove directories used.
  RMDir "$INSTDIR\Source Code\Source"
  RMDir "$INSTDIR\Source Code\Install"
  RMDir "$INSTDIR\Source Code\Debug"
  RMDir "$INSTDIR\Source Code\Release"
  RMDir "$INSTDIR\Source Code"
  RMDir "$SMPROGRAMS\winMd5Sum"
  RMDir "$INSTDIR"
SectionEnd

