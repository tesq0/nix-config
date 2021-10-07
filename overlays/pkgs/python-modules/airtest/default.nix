{ buildPythonPackage
, fetchPypi
, opencv4
, scikit-build
, cmake
}:

let
  opencv-contrib-python = buildPythonPackage rec {
    pname = "opencv-contrib-python";
    version = "4.5.3.56";
    src = fetchPypi {
      inherit version;
      pname = "opencv-contrib-python";
      sha256 = "sha256-wUozMNNHaPn//IUgZqCow9p+1CIPT1S85c5/rj7OlhM=";
    };
    nativeBuildInputs = [ cmake ];
    # buildInputs = [ cmake ];
    propagatedBuildInputs = [ scikit-build ];
  };
in
buildPythonPackage rec {
  pname = "airtest";
  version = "1.2.2";

  src = fetchPypi {
    inherit version;
    pname = "airtest";
    sha256 = "sha256-d1sDVX1uiEtA2T1/tHFkRT+rCiHrL9WwIGz3pwNrMXA=";
  };

  propagatedBuildInputs = [ opencv-contrib-python ];
}
