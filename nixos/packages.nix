pkgs:

with pkgs; [
  
    man-pages

    numix-cursor-theme
    numix-icon-theme
    numix-gtk-theme

    # x11 utils
    xsel
    xclip
    xorg.xwininfo
    xorg.xdpyinfo
    xorg.xev
    wmctrl
    xorg.xmodmap
    xcape
    dunst
    gksu
    xdotool
    dragon-drop

    glxinfo

    # Disk
    ntfs3g
    gparted
    
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
    dos2unix
    maim
    slop
    nox
    isync

		# Tags
    python36Packages.pygments
    global
    ctags

    # Multimedia
    feh
    qrencode
    mpv
    vlc

    # Applications
    st
    mu
    rofi-unwrapped
    mypaint
    htop
    pass
    llpp
    # ueberzug
    w3m
    atool

    (xdg-utils.override { mimiSupport = true; })
]
