{ buildPythonPackage
, fetchPypi
, flask
}:

buildPythonPackage rec {
  pname = "flask-basicauth";
  version = "0.2.0";

  src = fetchPypi {
    inherit version;
    pname = "Flask-BasicAuth";
    sha256 = "1zq1spkjr4sjdnalpp8wl242kdqyk6fhbnhr8hi4r4f0km4bspnz";
  };

  propagatedBuildInputs = [ flask ];

  meta = {
    homepage = https://pypi.org/project/Flask-BasicAuth/;
    description = "HTTP basic access authentication for Flask";
  };
}
