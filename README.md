![nixbook os logo](https://github.com/user-attachments/assets/8511e040-ebf0-4090-b920-c051b23fcc9c)

**Convert your old computer (even chromebook) to a user friendly, lightweight, durable, and auto updating operating system build on top of NixOS.**

The goal is to create a "chromebook like" unbreakable computer for a basic dev enviroment

---
Full video walk through of converting from Windows to Nixbook is now live here:

<https://youtu.be/izvVjfqd5j8?si=ZJAdBZRsQO38YIy5>

my project is froked from nixbook by mkellyxp
---

### My **nixbook** version with a tiling window manager:
my Base System is a **ThinkPad E440** with i3 2.4 GHz and 8GB ram
- configured i3 desktop and brave browser base
- Zoom, and Libreoffice installed by default flathub enabled out of the box.
- Automatic weekly OS updates with 4 weeks of roll backs
- Daily flatpak updates
- vscode and some estensions
- docker
- oracle cli
- ghostty
- zsh

*** work in progress ***

---

### will work to fix any issues with 


- the i3 configuration
- have vscode work well with docker
- a nice looking console for zsh
- update screen shots with my own desktop

---

all images thanks to [mkellyxp](https://github.com/mkellyxp/nixbook) creator of nixbook 

---

## Step 1:  Install NixOS, and choose the No Desktop option.

![Screenshot from 2024-10-12 10-24-21 - thanks to mkellyxp](https://github.com/user-attachments/assets/865760ec-fcd1-4133-be35-5fb5cf0e6638)


## Step 2:  Enable unfree software

![Screenshot from 2024-10-12 10-24-31 - thanks to mkellyxp](https://github.com/user-attachments/assets/77b02843-4c3e-409c-82dc-7579578b2582)


## Step 3:  Format your drive however you like (erase disk, swap, no hibernate)

![Screenshot from 2024-10-12 10-24-44 - thanks to mkellyxp](https://github.com/user-attachments/assets/968111d9-c018-4be5-8aaa-ee5c647b2617)


## Step 4:  Reboot, login, and connect to wifi, then hit ESC

```
nmtui
```


## Step 5:  Go to /etc and nix-shell git
```
cd /etc/
nix-shell -p git https://github.com/salamcast/nixbook-tile.git
```


## Step 6:  Clone the nixbook repo  (make sure you run as sudo and you're in /etc!)
```
sudo git clone 
```

## Step 7:  Run the install script (run this with NO sudo)
```
cd nixbook-tile
./install-i3.sh
```

## Step 8:  Enjoy nixbook!

You can always manually run updates by running **Update and Reboot** in the menu.

If you want to completely reset this nixbook, wipe off your personal data to give it to someone else, or start fresh, run **Powerwash** from the menu.

---

Notes:
- The Nix channel will be updated from this git config once tested, and will auto apply to your machine within a week
- Simply reboot for OS updates to apply.
- Don't modify the .nix files in this repo, as they'll get overwritten on update.  If you want to customize, put your nix changes directly into /etc/nixos/configuration.nix


![Screenshot from 2024-10-12 10-40-07](https://github.com/user-attachments/assets/3540074a-e11e-4a88-a812-4ef3d4c83f0b)

![Screenshot from 2024-10-12 10-40-36](https://github.com/user-attachments/assets/6f62f3da-4a4c-464a-b75b-2046ff4d9162)


---

This is a passion project of mine, that I'm using for friends, family, and my local community at large.  If you have any feedback or suggestions, please feel free to open an issue, pull request or just message me.

---

If at any point you're having issues with your nixbook-tile not updating, check the auto-update-config service by running 

```
sudo systemctl status auto-update-config
```

If it shows any errors, go directly to /etc/nixbook-tile and run

```
sudo git pull --rebase
```

Then you can start the autoupdate service again by running

```
sudo systemctl status auto-update-config
```
