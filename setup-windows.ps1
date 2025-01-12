#Requires -RunAsAdministrator

$ProgressPreference = 'SilentlyContinue'

choco install keybase --yes --force
choco install googlechrome --yes --force
choco install steam --yes --force
choco install slack --yes --force
choco install discord --yes --force
choco install powertoys --yes --force
choco install notion --yes --force

# Install 1password
$ONE_PASSWORD="$HOME\Downloads\1PasswordSetup-latest.exe"
Invoke-WebRequest -Uri https://downloads.1password.com/win/1PasswordSetup-latest.exe -OutFile $ONE_PASSWORD
Start-Process -Wait -FilePath $ONE_PASSWORD -NoNewWindow -PassThru # Need Confirm

# Install Kakaotalk
$KAKAO_TALK = "$HOME\Downloads\KakaoTalk_Setup.exe"
Invoke-WebRequest -Uri https://app-pc.kakaocdn.net/talk/win32/KakaoTalk_Setup.exe -OutFile $KAKAO_TALK
Start-Process -Wait -FilePath $KAKAO_TALK -ArgumentList "/S"

# Install Development Tools
choco install git --yes --force
choco install gnupg --yes --force
choco install vscode --yes --force
choco install docker-desktop --yes --force
choco install visualstudio2022professional --yes --force `
    --package-parameters "--add Microsoft.VisualStudio.Workload.NetWeb --add Microsoft.VisualStudio.Workload.NetCoreTools --includeRecommended --passive --locale ko-KR"
choco install nodejs-lts --yes --force
choco install golang --yes --force
choco install python --yes --force
choco install kubernetes-cli --yes --force
choco install postman --yes --force
choco install vault --yes --force
choco install packer --yes --force
choco install terraform --yes --force
choco install microsoft-windows-terminal --yes --force

# Install Fonts
choco install firacode --yes --force
choco install firacodenf --yes --force

# Install AWS CLI2
msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi /qn+

# Install teleport

# Config git
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mnthe/dev-env-provisioning/main/.gitconfig" -OutFile $env:USERPROFILE\.gitconfig

# Config Powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
Install-PackageProvider -Name NuGet -Force
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1')) # Install oh-my-posh
Install-Module posh-git -Scope CurrentUser -Force
Install-Module PSKubectlCompletion -Scope CurrentUser -Force
mkdir -p "$HOME\.oh-my-posh\themes\"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mnthe/dev-env-provisioning/main/.oh-my-posh/themes/default.json" -OutFile "$HOME\.oh-my-posh\themes\default.json"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/mnthe/dev-env-provisioning/main/powershell_profile.ps1" -OutFile $profile

# Install WSL2 (https://docs.microsoft.com/ko-kr/windows/wsl/install-win10)

## 1. Linux용 Windows 하위 시스템 사용 (https://docs.microsoft.com/ko-kr/windows/wsl/install-manual#step-1---enable-the-windows-subsystem-for-linux)
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
## 3. Virtual Machine 기능 사용 (https://docs.microsoft.com/ko-kr/windows/wsl/install-manual#step-3---enable-virtual-machine-feature)
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
## 4. Linux 커널 업데이트 패키지 다운로드 (https://docs.microsoft.com/ko-kr/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package)
msiexec.exe /i https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi
## 5. WSL 2를 기본 버전으로 설정 (https://docs.microsoft.com/ko-kr/windows/wsl/install-manual#step-5---set-wsl-2-as-your-default-version)
wsl --set-default-version 2
## 6. 선택한 Linux 배포 설치 (https://docs.microsoft.com/ko-kr/windows/wsl/install-manual#step-6---install-your-linux-distribution-of-choice)
curl.exe -L -o ubuntu.appx https://aka.ms/wslubuntu
Add-AppxPackage .\ubuntu.appx 

# Enable Sandbox
Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -All -Online
