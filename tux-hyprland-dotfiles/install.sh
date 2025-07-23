#!/bin/bash

set -e  # 發生錯誤時終止


## 🛠️ 安裝必要套件（使用 yay）
echo "🔧 Installing required packages..."
yay -S --needed \
  hyprland kitty \
  hyprpaper hyprpanel hyprmenu \
  fish 

## 🎯 建立配置資料夾
mkdir -p ~/.config/hypr
mkdir -p ~/.config/kitty
mkdir -p ~/.config/hyprpanel
mkdir -p ~/.config/hyprpaper
mkdir -p ~/.config/hyprmenu
mkdir -p ~/.config/fish

## 🔗 建立 symlinks
echo "🔗 Linking configs..."

cp ./hypr/* ~/.config/hypr/
cp ./kitty/* ~/.config/kitty/
cp ./hyprpanel/* ~/.config/hyprpanel
cp ./hypr/hyprpaper/* ~/.config/hyprpaper/
cp ./hyprmenu/* ~/.config/hyprmenu/
cp ./fish/* ~/.config/fish/

## 🐟 設定 fish 為預設 shell
echo "🎣 Setting fish as default shell..."
chsh -s /usr/bin/fish

## 🧹 清除暫存資料夾
rm -rf "$pwd"

echo "✅ Dotfiles installed successfully! Please reload Hyprland or reboot."

