#!/bin/bash

update_system() {
    yes | sudo pacman -Syu
    echo "[+] System is up to date!"
}

install_polybar() {
    if git clone https://github.com/bunnyhop-dev/Dotfiles; then
        cd Dotfiles || exit 1
        mkdir -p ~/.config/polybar
        cp -r polybar/ ~/.config/polybar/ && polybar dejavolf &
        sleep 1
        echo "[+] Polybar installed!"
    else
        echo "[!] Install Dotfiles Error"
    fi
}

install_alacritty() {
    sudo pacman -S alacritty --noconfirm
    cp -r alacritty/ ~/.config/alacritty/
    sleep 1
    echo "[+] Alacritty installed!"
}

install_fonts() {
    sudo pacman -S ttf-dejavu ttf-font-awesome ttf-hack-nerd --noconfirm
    fc-cache -fv
    echo "[+] Fonts installed!"
}

install_packages() {
    sudo pacman -S fastfetch thunar fontforge polybar alacritty nvim --noconfirm
    echo "[+] Packages installed!"
}

install_config() {
  sleep 3
  cp -r alacritty/ nvim/ pip/ polybar/ ~/.config && cp -r scripts ~/scripts
  cp .bashrc .nanorc ~/ && source ~/.bashrc
  cp .spectrwm.conf ~/ && chmod +x ~/.spectrwm.conf
  cd ~/ && touch .xprofile && "echo (sleep 2 && polybar dejavolf &)" >> ~/.xprofile && chmod +x ~/.xprofile
  echo "[+] Configs installed! :)"
}

figlet -f smslant BLACKARCH
echo "[!] DE: spectrwm!"
sleep 2

echo -e "[!] Do you want to update and upgrade system? (Y/N): "
read -r system
if [[ "$system" == "Y" || "$system" == "y" ]]; then
    update_system
fi

echo -e "[!] Do you want to install needed packages(polybar, alacritty, fastfetch, thunar, fontforge, nvim)? (Y/N): "
read -r packages
if [[ "$packages" == "Y" || "$packages" == "y" ]]; then
    install_packages
fi

echo -e "[!] Do you want to install polybar config? (Y/N): "
read -r polybar
if [[ "$polybar" == "Y" || "$polybar" == "y" ]]; then
    install_polybar
fi

echo -e "[!] Do you want to install Alacritty config? (Y/N): "
read -r alacritty
if [[ "$alacritty" == "Y" || "$alacritty" == "y" ]]; then
    install_alacritty
fi

echo -e "[!] Do you want to install needed fonts? (Y/N): "
read -r fonts
if [[ "$fonts" == "Y" || "$fonts" == "y" ]]; then
    install_fonts
fi

echo -e "[!] Do you want to install (spectrwm.conf, bashrc, nanorc) config? (Y/N): "
read -r config
if [[ "$config" == "Y" || "$config" == "y" ]]; then
  install_config
fi

echo "[+] Install Completed!\n###Reboot recommended"

