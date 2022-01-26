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

    # Disk
    ntfs3g
    
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
    pamixer
    patchelf
    youtube-dl
    killall
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
    pythonPackages.pygments
    global
    ctags

    # Multimedia
    feh
    qrencode

    # Applications
    st
    mu
    rofi-unwrapped
    mypaint
    htop
    pass
    llpp
    ranger
    # ueberzug
    w3m
    atool

    # (xdg-utils.override { mimiSupport = true; })
]
