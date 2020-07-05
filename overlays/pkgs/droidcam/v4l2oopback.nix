{ stdenv, fetchFromGitHub, kernel, kmod }:

stdenv.mkDerivation rec {

  version = "d887a3aeb3b158825878005c802136ff849c70ec";

  name = "v4l2loopback-droidcam-${version}-${kernel.version}";

  src = fetchFromGitHub {
    owner = "aramg";
    repo = "droidcam";
    rev = "d887a3aeb3b158825878005c802136ff849c70ec";
    sha256 = "1qxfw6j21f686daqf72z0y16p7vlbg4vff58hv0i59pqk5qw3sfx";
  };

  hardeningDisable = [ "format" "pic" ];

  preBuild = ''
    cd linux/v4l2loopback
    substituteInPlace Makefile --replace "modules_install" "INSTALL_MOD_PATH=$out modules_install"
    export PATH=${kmod}/sbin:$PATH
  '';

  nativeBuildInputs = kernel.moduleBuildDependencies;
  buildInputs = [ kmod ];

  makeFlags = [
    "KERNELRELEASE=${kernel.modDirVersion}"
    "KERNEL_DIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];

  meta = with stdenv.lib; {
    description = "A kernel module to create V4L2 loopback devices for droidcam";
    homepage = "https://github.com/aramg/droidcam";
    license = licenses.gpl2;
    maintainers = [ maintainers.tesq0 ];
    platforms = platforms.linux;
  };
}
