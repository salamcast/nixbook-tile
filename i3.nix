{ config, pkgs, ... }:
let
  nixChannel = "https://nixos.org/channels/nixos-24.11"; 

  ## Notify Users Script
  notifyUsersScript = pkgs.writeScript "notify-users.sh" ''
    set -eu

    title="$1"
    body="$2"

    users=$(${pkgs.systemd}/bin/loginctl list-sessions --no-legend | ${pkgs.gawk}/bin/awk '{print $1}' | while read session; do
      loginctl show-session "$session" -p Name | cut -d'=' -f2
    done | sort -u)

    for user in $users; do
      ${pkgs.sudo}/bin/sudo -u "$user" \
        DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u "$user")/bus" \
        ${pkgs.libnotify}/bin/notify-send "$title" "$body"
    done
  '';

  ## Update Git and Channel Script
  updateGitScript = pkgs.writeScript "update-git.sh" ''
    set -eu
    
    # Update nixbook configs
    ${pkgs.git}/bin/git -C /etc/nixbook-tile reset --hard
    ${pkgs.git}/bin/git -C /etc/nixbook-tile clean -fd
    ${pkgs.git}/bin/git -C /etc/nixbook-tile pull --rebase

    currentChannel=$(${pkgs.nix}/bin/nix-channel --list | ${pkgs.gnugrep}/bin/grep '^nixos' | ${pkgs.gawk}/bin/awk '{print $2}')
    targetChannel="${nixChannel}"

    if [ "$currentChannel" != "$targetChannel" ]; then
      ${pkgs.nix}/bin/nix-channel --add "$targetChannel" nixos
      ${pkgs.nix}/bin/nix-channel --update
    fi
  '';

in
{
  zramSwap.enable = true;
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  # Enable the X11 windowing system.
  
  services.xserver = {
    enable = true;   
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        polybarFull
        #i3status
        i3-open-next-ws
 	      i3lock
	      i3blocks
        rofi
     ];

    };
  };
  
  services.displayManager.defaultSession = "xfce+i3";
  environment.xfce.excludePackages = with pkgs.xfce; [
    mousepad
    parole
    ristretto
    xfce4-appfinder
   # xfce4-notifyd
   # xfce4-screenshooter
   # xfce4-session
   # xfce4-settings
   # xfce4-taskmanager
    xfce4-terminal 
  ];

  programs.dconf.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  environment.systemPackages = with pkgs; [
    openssh
    exfatprogs
    ntfs3g
 	  wget
    zsh
	  vim
	  curl
    git
    gh
    libnotify
    gawk
    gnugrep
    pulseaudio
    sudo
    parted
    gnome-software
    #xfce.xfce4-screenshooter
    flatpak
    xdg-desktop-portal
    xdg-desktop-portal-xapp
    system-config-printer
	  neofetch
	  xfce.thunar
	  htop
	  feh
	  lxappearance
	  zip
    p7zip
	  jq
	  unzip
    ghostty
    kitty
    docker
    docker-compose
    brave
    #thunderbird-latest-bin
    filezilla
    vscode
    sqlcl
    oracle-instantclient
    arandr
    synergy
    sane-airscan
    font-awesome
    nerdfonts
    #cage
    #waydroid
  ];

  services.flatpak.enable = true;

  xdg.portal.enable = true;
  xdg.portal.xdgOpenUsePortal = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-xapp
  ];
  xdg.portal.config.common.default = [ "xapp" ];

  virtualisation.docker.enable = true;
  virtualisation.waydroid.enable = true;

programs.zsh.enable = true;

  nix.gc = {
    automatic = true;
    dates = "Mon 3:40";
    options = "--delete-older-than 30d";
  };
  
  # Auto update config, flatpak and channel
  systemd.timers."auto-update-config" = {
  wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "Tue..Sun";
      Persistent = true;
      Unit = "auto-update-config.service";
    };
  };

  systemd.services."auto-update-config" = {
    script = ''
      set -eu

      ${updateGitScript}

      # Flatpak Updates
      ${pkgs.coreutils-full}/bin/nice -n 19 ${pkgs.util-linux}/bin/ionice -c 3 ${pkgs.flatpak}/bin/flatpak update --noninteractive --assumeyes
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      Restart = "on-failure";
      RestartSec = "30s";
    };

    after = [ "network-online.target" "graphical.target" ];
    wants = [ "network-online.target" ];
  };

  # Auto Upgrade NixOS
  systemd.timers."auto-upgrade" = {
  wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "Mon";
      Persistent = true;
      Unit = "auto-upgrade.service";
    };
  };

  systemd.services."auto-upgrade" = {
    script = ''
      set -eu
      export PATH=${pkgs.nixos-rebuild}/bin:${pkgs.nix}/bin:${pkgs.systemd}/bin:${pkgs.util-linux}/bin:${pkgs.coreutils-full}/bin:$PATH
      export NIX_PATH="nixpkgs=${pkgs.path} nixos-config=/etc/nixos/configuration.nix"

      ${updateGitScript}

      ${notifyUsersScript} "Starting System Updates" "System updates are installing in the background.  You can continue to use your computer while these are running."
            
      ${pkgs.coreutils-full}/bin/nice -n 19 ${pkgs.util-linux}/bin/ionice -c 3 ${pkgs.nixos-rebuild}/bin/nixos-rebuild boot --upgrade

      # Fix for zoom flatpak
      ${pkgs.flatpak}/bin/flatpak override --env=ZYPAK_ZYGOTE_STRATEGY_SPAWN=0 us.zoom.Zoom

      ${notifyUsersScript} "System Updates Complete" "Updates are complete!  Simply reboot the computer whenever is convenient to apply updates."
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      Restart = "on-failure";
      RestartSec = "30s";
    };

    after = [ "network-online.target" "graphical.target" ];
    wants = [ "network-online.target" ];
  };
  networking.usePredictableInterfaceNames = false;
}

# Notes
#
# To reverse zoom flatpak fix:
#   flatpak override --unset-env=ZYPAK_ZYGOTE_STRATEGY_SPAWN us.zoom.Zoom
