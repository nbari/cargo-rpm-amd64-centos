# cargo-rpm-amd64-centos

## Inputs

`cmd` - The command to be executed inside the container. Defaults to `cargo rpm build -v`

## Outputs

None, besides the `rpm` package that is built. The built `.rpm` will be located in:

    target/release/rpmbuild/RPMS/x86_64/<RPM>

## Example Usage

```yaml
name: build

on:
  push:
    tags:
    - '*'

env:
    CARGO_TERM_COLOR: always

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Rust Cargo Rpm Package Build (amd64, centos8)
      id: rpm_build
      uses: nbari/cargo-rpm-amd64-centos@1.0.1
      with: # https://crates.io/crates/httpwsrep
        cmd: cargo rpm build -o httpwsrep.rpm

    - name: Create Release
      id: create_release
      uses: actions/create-release@latest
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }} # This token is provided by Actions, you do not need to create your own token
      with:
        tag_name: ${{ github.ref }}
        release_name: Release ${{ github.ref }}
        body: |
            Changes in this Release
            - Create RPM
            - Upload Source RPM
        draft: false
        prerelease: false

    - name: Display structure of downloaded files
      run: ls -R

    - name: Upload a Release Asset
      uses: actions/upload-release-asset@v1
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      with:
        upload_url: ${{ steps.create_release.outputs.upload_url }}
        asset_path: httpwsrep.rpm
        asset_name: httpwsrep.rpm
        asset_content_type: application/octet-stream
```