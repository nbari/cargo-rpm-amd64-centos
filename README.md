# cargo-rpm-amd64-centos

## Inputs

`cmd` - The command to be executed inside the container. Defaults to `cargo rpm build -v`

## Outputs

None, besides the `rpm` package that is built. The built `.rpm` will be located in `target/release/rpmbuild/RPMS/x86_64/<RPM>`.

## Example Usage

```yaml
name: RPM Static Build

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: Rust Cargo Rpm Package Build (amd64, centos8)
      uses: nbari/cargo-rpm-amd64-centos@1.0.0
```