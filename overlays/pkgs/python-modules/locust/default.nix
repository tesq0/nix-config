{ buildPythonPackage
, fetchFromGitHub
, mock
, unittest2
, msgpack
, requests
, flask
, flask-basicauth
, gevent
, pyzmq
}:

buildPythonPackage rec {
  pname = "locust";
  version = "1.3.0";

  src = fetchFromGitHub {
    owner = "locustio";
    repo = "locust";
    rev = version;
    sha256 = "0y8hg8rnvfll13m4brdcygrqw6jqalhfsqz9msmsmcz6kg6zih04";
  };

  propagatedBuildInputs = [ msgpack requests flask flask-basicauth gevent pyzmq ];
  buildInputs = [ mock unittest2 ];

  meta = {
    homepage = https://locust.io/;
    description = "A load testing tool";
  };
}
