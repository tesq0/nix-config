pkgs:

with pkgs; [
  
    man-pages

    numix-cursor-theme
    numix-icon-theme
    numix-gtk-theme

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
    redshift
    cifs-utils
    libnotify
    jmtpfs
    pamixer
    patchelf
    youtube-dl
    killall
    tree
    imagemagick
    poppler_utils
    dos2unix
    nox
    isync

		# Tags
    pythonPackages.pygments
    global
    ctags

    # Multimedia
    qrencode

    # Applications
    htop
    llpp
    w3m
    atool

    file
    (xdg-utils.override { mimiSupport = true; })
]
