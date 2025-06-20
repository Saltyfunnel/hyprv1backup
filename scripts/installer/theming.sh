#!/bin/bash

# Get the directory of the current script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source helper functions
source "$SCRIPT_DIR/helper.sh"

log_message "Installation started for theming section"
print_info "\nStarting theming setup..."

# Install GTK & Qt theming tools
run_command "pacman -S --noconfirm nwg-look" "Install nwg-look for GTK theme management" "yes"
run_command "pacman -S --noconfirm qt5ct qt6ct kvantum" "Install qt5ct, qt6ct, and Kvantum theme engine" "yes"

# Extract and install GTK theme and icon theme
run_command "tar -xvf /home/$USERNAME/hyprv2/assets/themes/Catppuccin-Mocha.tar.xz -C /usr/share/themes/" "Install Catppuccin-Mocha GTK theme" "yes"
run_command "tar -xvf /home/$USERNAME/hyprv2/assets/icons/Tela-circle-dracula.tar.xz -C /usr/share/icons/" "Install Tela Circle Dracula icon theme" "yes"

# Kvantum theme via yay
run_command "yay -S --sudoloop --noconfirm kvantum-theme-catppuccin-git" "Install Catppuccin Kvantum theme from AUR" "yes" "no"

# Copy Kitty terminal theme
run_command "cp -r /home/$USERNAME/hyprv2/configs/kitty /home/$USERNAME/.config/" "Copy Catppuccin Kitty config" "yes" "no"

# Copy wlogout theme assets
run_command "mkdir -p /home/$USERNAME/.config/wlogout && cp -r /home/$USERNAME/hyprv2/assets/wlogout/* /home/$USERNAME/.config/wlogout/" "Copy wlogout assets" "yes"
run_command "chown -R $USERNAME:$USERNAME /home/$USERNAME/.config/wlogout" "Fix wlogout permissions" "no"

# Post-install usage instructions
print_info "\nPost-installation instructions:"
print_bold_blue "Set your themes and icons manually:"
echo "   - Run 'nwg-look' to set your GTK theme and icon theme"
echo "   - Use 'kvantummanager' to apply Catppuccin in Kvantum"
echo "   - Use 'qt6ct' to apply icons for Qt6 apps"

echo "------------------------------------------------------------------------"
print_success "🎨 Theming setup completed successfully."

