{ stdenv, buildPythonPackage, fetchPypi
, numpy, scipy, six, paramz, nose, matplotlib, cython }:

buildPythonPackage rec {
  pname = "GPy";
  version = "1.8.5";
  name  = "${pname}-${version}";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1562e34629192f209273f454e41614a127c6ef04144cd0eb5992d484721d55d3";
  };

  # running tests produces "ImportError: cannot import name 'linalg_cython'"
  # even though Cython has run
  checkPhase = "nosetests -d";
  doCheck = false;

  checkInputs = [ nose ];

  buildInputs = [ cython ];

  propagatedBuildInputs = [ numpy scipy six paramz matplotlib ];

  meta = with stdenv.lib; {
    description = "Gaussian process framework in Python";
    homepage = https://sheffieldml.github.io/GPy;
    license = licenses.bsd3;
    maintainers = with maintainers; [ bcdarwin ];
  };
}
