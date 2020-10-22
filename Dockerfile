FROM centos:8

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH;

RUN set -eux; \
    dnf -y install openssl-devel; \
    dnf -y groupinstall 'Development Tools'; \
	curl -o /tmp/install_rust.sh https://sh.rustup.rs; \
	sh /tmp/install_rust.sh -y --default-toolchain stable;

RUN set -eux; \
    cargo install cargo-rpm;

ENV PATH=/usr/local/bin:/root/.cargo/bin:$PATH \
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig \
    LD_LIBRARY_PATH=$PREFIX

RUN dnf -y install rpm-build
RUN dnf -y install systemd-rpm-macros

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
