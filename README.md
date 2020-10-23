# cargo-rpm-amd64-centos

## Inputs

`cmd` - The command to be executed inside the container. Defaults to `cargo rpm build -v`

## Outputs

None, besides the `rpm` package that is built. The built `.rpm` will be located in:

    target/release/rpmbuild/RPMS/x86_64/<RPM>

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
      id: rpm_build
      uses: nbari/cargo-rpm-amd64-centos@1.0.2

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

    - name: Upload a Release Asset
      uses: actions/upload-release-asset@v1
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      with:
        upload_url: ${{ steps.create_release.outputs.upload_url }} # This pulls from the CREATE RELEASE step above, referencing it's ID to get its outputs object, which include a `upload_url`. See this blog post for more info: https://jasonet.co/posts/new-features-of-github-actions/#passing-data-to-future-steps
        asset_path: ${{ steps.rpm_build.outputs.source_rpm_path }}
        asset_name: ${{ steps.rpm_build.outputs.source_rpm_name }}
        asset_content_type: ${{ steps.rpm_build.outputs.rpm_content_type }}
```