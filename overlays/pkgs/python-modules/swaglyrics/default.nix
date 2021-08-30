{ lib, buildPythonApplication, fetchPypi, colorama, flask, flask-cors, requests, unidecode, SwSpotify, beautifulsoup4 }:

buildPythonApplication rec {
  pname = "swaglyrics";
  version = "1.1.2";

  propagatedBuildInputs = [ colorama flask flask-cors requests unidecode SwSpotify beautifulsoup4 ];
  
  # src = /home/mikus/Projects/SwagLyrics-For-Spotify;
  src = fetchPypi {
    inherit pname version;
    sha256 = "0vksm4drqsmkfyq337062k2mrr0yq52j267bfv695zx320f6ag2l";
  };
  
  doCheck = false;

}
