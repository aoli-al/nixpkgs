{
  lib,
  awesomeversion,
  buildPythonPackage,
  envoy-utils,
  fetchFromGitHub,
  httpx,
  lxml,
  orjson,
  poetry-core,
  pyjwt,
  pytest-asyncio,
  pytest-cov-stub,
  pytestCheckHook,
  pythonOlder,
  respx,
  syrupy,
  tenacity,
}:

buildPythonPackage rec {
  pname = "pyenphase";
  version = "1.26.0";
  pyproject = true;

  disabled = pythonOlder "3.11";

  src = fetchFromGitHub {
    owner = "pyenphase";
    repo = "pyenphase";
    tag = "v${version}";
    hash = "sha256-Qr+F19J1JYazofriDWODDbDEYlUZAKv/4TVwoIRj5Rg=";
  };

  pythonRelaxDeps = [ "tenacity" ];

  build-system = [ poetry-core ];

  dependencies = [
    awesomeversion
    envoy-utils
    httpx
    lxml
    orjson
    pyjwt
    tenacity
  ];

  nativeCheckInputs = [
    pytest-asyncio
    pytest-cov-stub
    pytestCheckHook
    respx
    syrupy
  ];

  disabledTestPaths = [
    # Tests need network access
    "tests/test_retries.py"
  ];

  pythonImportsCheck = [ "pyenphase" ];

  meta = with lib; {
    description = "Library to control enphase envoy";
    homepage = "https://github.com/pyenphase/pyenphase";
    changelog = "https://github.com/pyenphase/pyenphase/blob/${src.tag}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ fab ];
  };
}
