#!/bin/bash

# Get the directory of the current script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source helper file
source "$SCRIPT_DIR/helper.sh"

log_message "Installation started for prerequisites section"
print_info "\nStarting prerequisites setup..."

run_command "pacman -Syyu --noconfirm" "Update package database and upgrade packages (Recommended)" "yes"

if run_command "pacman -S --noconfirm --needed git base-devel" "Install YAY (Must)/Breaks the script" "yes"; then
    run_command "git clone https://aur.archlinux.org/yay.git && cd yay" "Clone YAY (Must)/Breaks the script" "no" "no"
    run_command "makepkg --noconfirm -si && cd .." "Build YAY (Must)/Breaks the script" "no" "no"
fi
run_command "pacman -S --noconfirm pipewire wireplumber pamixer brightnessctl" "Configuring audio and brightness (Recommended)" "yes"

run_command "pacman -S --noconfirm ttf-cascadia-code-nerd ttf-cascadia-mono-nerd ttf-fira-code ttf-fira-mono ttf-fira-sans ttf-firacode-nerd ttf-iosevka-nerd ttf-iosevkaterm-nerd ttf-jetbrains-mono-nerd ttf-jetbrains-mono ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono" "Installing Nerd Fonts and Symbols (Recommended)" "yes"

run_command "pacman -S --noconfirm sddm && systemctl enable sddm.service" "Install and enable SDDM (Recommended)" "yes"

# Detect NVIDIA card and install drivers
if lspci -k | grep -EA3 'VGA|3D|Display' | grep -i nvidia > /dev/null; then
    print_info "NVIDIA graphics card detected. Installing NVIDIA drivers."
    run_command "pacman -S --noconfirm nvidia nvidia-utils nvidia-settings lib32-nvidia-utils opencl-nvidia" "Install NVIDIA Drivers, Utilities, and Settings" "yes"
else
    print_info "No NVIDIA graphics card detected. Skipping NVIDIA driver installation."
fi

run_command "pacman -S --noconfirm firefox" "Install Firefox Browser" "yes"

run_command "pacman -S --noconfirm thunar thunar-archive-plugin thunar-volman tumbler gvfs" "Installs Thunar File Manager plus plugins" "yes"

run_command "pacman -S --noconfirm kitty" "Install Kitty (Recommended)" "yes"

run_command "pacman -S --noconfirm nano" "Install nano" "yes"

run_command "pacman -S --noconfirm code" "Install VS Code" "yes"

run_command "pacman -S --noconfirm fastfetch" "Install fastfetch" "yes"

run_command "pacman -S --noconfirm starship" "Install starship" "yes"

run_command "pacman -S --noconfirm tar" "Install tar for extracting files (Must)/needed for copying themes" "yes"

echo "------------------------------------------------------------------------"
