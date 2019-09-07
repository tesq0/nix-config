pkgs:

with pkgs; [
  
  	direnv
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
    emacs
    firefox
    llpp
]
