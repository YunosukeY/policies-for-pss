# Conftest Policies for Pod Security Standards

[![ci](https://github.com/YunosukeY/policies-for-pss/actions/workflows/ci.yaml/badge.svg?branch=master&event=push)](https://github.com/YunosukeY/policies-for-pss/actions/workflows/ci.yaml)
![Coverage](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/YunosukeY/0c2e618c502912eff6e83e26b24e5c82/raw/opa-coverage-badge.json)

Implementing Pod Security Standards as Conftest Policy.

[Pod Security Standards | Kubernetes](https://kubernetes.io/docs/concepts/security/pod-security-standards/)

## Examples

### With an unsafe manifest

```sh
$ conftest test example/unsafe.yaml
FAIL - example/unsafe.yaml - main - container nginx in Deployment/nginx-deployment allows privilege escalation
FAIL - example/unsafe.yaml - main - container nginx in Deployment/nginx-deployment doesn't drop "ALL" capability
FAIL - example/unsafe.yaml - main - container nginx in Deployment/nginx-deployment must be set seccomp profile
FAIL - example/unsafe.yaml - main - container nginx in Deployment/nginx-deployment runs as root
FAIL - example/unsafe.yaml - main - pod in Deployment/nginx-deployment must be set seccomp profile
FAIL - example/unsafe.yaml - main - pod in Deployment/nginx-deployment runs as root

17 tests, 11 passed, 0 warnings, 6 failures, 0 exceptions
```

### With a safe manifest

```sh
$ conftest test example/safe.yaml

17 tests, 17 passed, 0 warnings, 0 failures, 0 exceptions
```

## Usage

```sh
$ conftest test --update https://raw.githubusercontent.com/YunosukeY/policies-for-pss/master/policy/deny.rego <file-to-test>
```
