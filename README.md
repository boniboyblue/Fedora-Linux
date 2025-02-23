 # My Fedora Workstation Setup

## RPM Fusion
Fedora has disabled the repositories for a lot of free and non-free .rpm packages by default. Follow this if you want to use non-free software like Steam, Discord and some multimedia codecs etc. As a general rule of thumb it is advised to do this to get access to many mainstream useful programs. 
```
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```
Also while you're at it, install app-stream metadata by
```
sudo dnf group upgrade core
```
```
sudo dnf4 group update core
```
  

## Update 
```
sudo dnf offline-upgrade download --assumeyes
sudo dnf offline-upgrade reboot
```

## Firmware
If your system supports firmware update delivery through lvfs, update your device firmware by:
```
sudo fwupdmgr refresh --force
sudo fwupdmgr get-devices # Lists devices with available updates.
sudo fwupdmgr get-updates # Fetches list of available updates.
sudo fwupdmgr update
```

## Media Codecs
Install these to get proper multimedia playback.
````
sudo dnf swap 'ffmpeg-free' 'ffmpeg' --allowerasing # Switch to full FFMPEG.
sudo dnf4 group upgrade multimedia
sudo dnf upgrade @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin # Installs gstreamer components. Required if you use Gnome Videos and other dependent applications.
sudo dnf group install -y sound-and-video # Installs useful Sound and Video complement packages.
````

## H/W Video Acceleration
Helps decrease load on the CPU when watching videos online by alloting the rendering to the dGPU/iGPU. Quite helpful in increasing battery backup on laptops.

### H/W Video Decoding with VA-API 
```
sudo dnf install ffmpeg-libs libva libva-utils
```

<details>
<summary>Intel</summary>
 
If you have a recent Intel chipset (5th Gen and above) after installing the packages above., Do:
```
sudo dnf swap libva-intel-media-driver intel-media-driver --allowerasing
```
```
sudo dnf install libva-intel-driver
```
</details>

### OpenH264 for Firefox
```
sudo dnf install -y openh264 gstreamer1-plugin-openh264 mozilla-openh264
```
```
sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1
```
After this enable the OpenH264 Plugin in Firefox's settings.

## EasyEffects
To be filled.

## Set Hostname
```
hostnamectl set-hostname YOUR_HOSTNAME
```

## Default Firefox start page 
The tweak below will make the start page the default firefox start page instead of [this](https://fedoraproject.org/start)
```
sudo rm -f /usr/lib64/firefox/browser/defaults/preferences/firefox-redhat-default-prefs.js
```

## Optimizations
The tips below can allow you to squeeze out a little bit more performance from your system. 

### Disable Gnome Software from Startup Apps
Gnome software autostarts on boot for some reason, even though it is not required on every boot unless you want it to do updates in the background, this takes at least 100MB of RAM upto 900MB (as reported anecdotically). You can stop it from autostarting by:
```
sudo rm /etc/xdg/autostart/org.gnome.Software.desktop
```

## Gnome Extensions
Caffine
```
sudo dnf install gnome-shell-extension-caffeine
```
Alphabetical App Grid
```
gdbus call --session \
           --dest org.gnome.Shell.Extensions \
           --object-path /org/gnome/Shell/Extensions \
           --method org.gnome.Shell.Extensions.InstallRemoteExtension \
           "AlphabeticalAppGrid@stuarthayhurst"
```

## Theming

### GTK Themes Dark Mode Theme
```
sudo dnf install adw-gtk3-theme
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark' && gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
```

### Use themes in Flatpaks
```
sudo flatpak override --filesystem=$HOME/.themes && sudo flatpak override --env=GTK_THEME=my-theme
```
