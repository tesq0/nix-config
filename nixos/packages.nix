pkgs:

with pkgs; [

  	docker-compose

    man-pages

    # x11 utils
    xsel
    xclip
    xorg.xwininfo
    xorg.xdpyinfo
    xorg.xev
    xorg.xmodmap
    xcape
    dunst
    gksu

    glxinfo

    # Disk
    ntfs3g
    gparted

    # Framework
    nodejs

    # Utils
    p7zip
    fzf
    fd
    ripgrep
    nnn
    git
    git-lfs
    wget
    udevil
    redshift
    cifs-utils
    libnotify
    lxappearance
    jmtpfs
    lxappearance
    pamixer
    patchelf
    youtube-dl
    killall
    irony-server
    tree
    scrot
    imagemagick
    poppler_utils

		# Tags
    python36Packages.pygments
    global
    ctags

    # Multimedia
    feh
    mpv
    vlc

    # Applications
    rxvt_unicode
    rofi-unwrapped
    mypaint
    htop
    keepassx-community
    emacs
    dolphin
    remmina
    chromium
    firefox
    tor-browser-bundle-bin
    qbittorrent
    zathura
    slack

]
