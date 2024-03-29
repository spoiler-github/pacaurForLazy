#!/bin/sh
#
# !!! Massage from spoiler-github !!!
# It's modificated version of script for automatic installing of pacaur
# I'm just add part which installing auracle-git, jq, and onigurama
# This three packages need for installing too
# Also remove massage about losting maintainer
# Because now pacaur have maintainer again (thanks for E5ten)
# 
#
# !!! Massage by original author !!!
# If you are new to arch, I encourage you to at least read and understand what
# this script does befor blindley running it.
# That's why I didn't make a one-liner out of it so you have an easier time
# reading and understanding it :)
#
# This scripts purpose is purly to save you a few seconds on your new installation.
#
# Enjoy your time on an awesome system. Arch FTW!

# Run the following from a terminal to install pacaur:
# $ curl -s https://gist.githubusercontent.com/Tadly/0e65d30f279a34c33e9b/raw/pacaur_install.sh | bash
#
# In case you can't copy&paste you may use this shortend version. Keep in mind that goo.gl
# does tracking and analytics. You have been warned :)
# $ curl -Ls https://goo.gl/cF2iJy | bash
#
# Aforementioned statistics are public and can be accesed here (If you're interested):
# https://goo.gl/#analytics/goo.gl/QYfPju/all_time


# Make sure our shiny new arch is up-to-date
echo "Checking for system updates..."
sudo pacman -Syu

# Create a tmp-working-dir and navigate into it
mkdir -p /tmp/pacaur_install
cd /tmp/pacaur_install

# If you didn't install the "base-devel" group,
# we'll need those.
sudo pacman -S binutils make gcc fakeroot pkg-config --noconfirm --needed

# Install pacaur dependencies from arch repos
sudo pacman -S expac yajl git meson gtest gmock jq oniguruma --noconfirm --needed

# Install "auracle-git" from AUR

if [ ! -n "$(pacman -Qs auracle-git)" ]; then
    curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=auracle-git
    makepkg PKGBUILD --install --needed
fi

# Install "cower" from AUR
if [ ! -n "$(pacman -Qs cower)" ]; then
    curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cower
    makepkg PKGBUILD --skippgpcheck --install --needed
fi

# Install "pacaur" from AUR
if [ ! -n "$(pacman -Qs pacaur)" ]; then
    curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=pacaur
    makepkg PKGBUILD --install --needed
fi

# Clean up...
cd ~
rm -r /tmp/pacaur_install
