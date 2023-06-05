# OpenCV-Pi-Installer

OpenCV-Pi-Installer 是一個專門為 Raspberry Pi 32位元作業系統設計的 OpenCV 4.7.0 安裝腳本。

## 特性

- 安裝 OpenCV 4.7.0。
- 自動安裝所有依賴項。
- 檢查並自動配置適當的 swap 大小。

## oneshot 尚未測試

```
sudo wget https://raw.githubusercontent.com/Oliver0804/OpenCV-Pi-Installer/main/install_opencv.sh && sudo chmod +x install_opencv.sh && sudo bash install_opencv.sh

```

## 使用方法

1. 克隆此 GitHub 專案：

```bash
git clone https://github.com/oliver0804/OpenCV-Pi-Installer.git
```
2. 給予腳本執行權限：
```bash
cd OpenCV-Pi-Installer
chmod +x install_opencv.sh
```
3. 執行腳本：
```bash
./install_opencv.sh
```

## 注意事項
此腳本在安裝過程中需要進行一些更改，例如調整 swap 大小。請在使用前確保您瞭解這些更改。

請注意，此腳本需要超級使用者權限（sudo）來運行，因為它涉及到軟體的安裝以及系統設定的更改。

## 貢獻
我們非常歡迎貢獻！請隨時提交 pull requests 來改進這個專案。


希望這對您有所幫助！請隨時讓我知道如果您有任何其他問題或需求。



