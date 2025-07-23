#!/bin/bash

set -e

# 📦 Path to your dotfiles repository (auto-detect current folder)
DOTFILES_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# 🌍 Detect distro
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
else
    echo "❌ Unable to detect your distribution."
    exit 1
fi

echo "🧠 Detected distro: $DISTRO"

# 🛠️ Install required packages
case "$DISTRO" in
  arch | endeavouros)
    echo "🔧 Installing packages via yay..."
    yay -S --needed hyprland kitty hyprpaper hyprpanel hyprmenu fish
    ;;

  ubuntu | debian)
    echo "🔧 Installing base packages via apt..."
    sudo apt update
    sudo apt install -y kitty fish git curl
    echo "⚠️ Hyprland-related apps may need to be compiled manually or installed via PPA/Flatpak."
    ;;

  fedora)
    echo "🔧 Installing via dnf..."
    sudo dnf install -y kitty fish git curl
    echo "⚠️ Hyprland components need to be manually built or installed via COPR."
    ;;

  rhel | centos)
    echo "🔧 Installing base tools..."
    sudo dnf install -y kitty fish git curl
    echo "⚠️ Hyprland suite recommended via Flatpak or manual build."
    ;;

  opensuse*)
    echo "🔧 Installing via zypper..."
    sudo zypper install -y kitty fish git curl
    echo "⚠️ Hyprland recommended via GitHub source build or Flatpak."
    ;;

  nixos)
    echo "🔧 Installing via nix-env..."
    nix-env -iA nixpkgs.git nixpkgs.kitty nixpkgs.fish
    echo "⚠️ For Hyprland, use flakes or overlay method."
    ;;

  *)
    echo "❌ Unsupported distro: $DISTRO"
    exit 1
    ;;
esac

# 📁 Create config folders
mkdir -p ~/.config/{hypr,kitty,hyprpanel,hyprpaper,hyprmenu,fish}

# 🔗 Copy config files
echo "🔗 Deploying dotfiles..."

cp -r "$DOTFILES_DIR/hypr/"*             ~/.config/hypr/
cp -r "$DOTFILES_DIR/hypr/hyprpaper/"*   ~/.config/hyprpaper/
cp -r "$DOTFILES_DIR/kitty/"*            ~/.config/kitty/
cp -r "$DOTFILES_DIR/hyprpanel/"*        ~/.config/hyprpanel/
cp -r "$DOTFILES_DIR/hyprmenu/"*         ~/.config/hyprmenu/
cp -r "$DOTFILES_DIR/fish/"*             ~/.config/fish/

# 🐟 Set Fish as default shell
echo "🎣 Setting Fish shell..."
chsh -s "$(which fish)"

echo "✅ Dotfiles installed successfully! Please restart Hyprland or reboot your system."


