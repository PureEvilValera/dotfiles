---
name: pkgbuild
description: Use when writing, editing, or reviewing an Arch Linux PKGBUILD (including Rust, Python, VCS/-git packages, and .SRCINFO). Covers required variables, build/package functions, cargo/Rust specifics (frozen vs stale offline cache), VCS pkgver(), git-source checkout paths, checksums, and namcap verification.
---

# PKGBUILD (Arch Linux packaging)

Reference for writing PKGBUILDs. Sources: ArchWiki
[PKGBUILD](https://wiki.archlinux.org/title/PKGBUILD),
[Rust package guidelines](https://wiki.archlinux.org/title/Rust_package_guidelines),
[VCS package guidelines](https://wiki.archlinux.org/title/VCS_package_guidelines).
Verify every flag against the current wiki before building a non-standard package.

## Required variables

- `pkgname` — lowercase letters/digits/`@._+-`, no leading `-`/`.`; usually = binary name.
- `pkgver` — upstream version, NO hyphen (replace with `_`). Bump on new upstream release.
- `pkgrel` — integer starting at 1; bump when the PKGBUILD changes without a `pkgver` change; reset to 1 on a new release.
- `arch` — `('x86_64')` for binaries; `('any')` for architecture-independent packages (scripts/fonts).
- `license` — SPDX identifier, e.g. `license=('MIT')`. Strongly recommended. For a custom license — `custom:name` + install the file to `/usr/share/licenses/$pkgname/`.

Conventional variable order: `pkgname, pkgver, pkgrel, pkgdesc, url, license, makedepends, depends, arch, source, sha256sums` (or `b2sums`). Order is not required, just convention.

## Dependencies

- `depends` — needed at build AND runtime. List ALL direct first-level deps, even if already pulled in transitively.
- `makedepends` — build-only. Do NOT include `base-devel` (implied by makepkg).
- `checkdepends` — only for `check()` (tests).
- `optdepends` — optional; format `'package: what it enables'`.
- Architecture-specific variants: `depends_x86_64=()`, `source_x86_64=()`, etc.

## source and checksums

- `source=()` — URLs or local file names. Format: `'unique_name::URL'` (uniqueness is required, SRCDEST is shared).
- The checksum array must match `source` 1:1: `sha256sums=()`, `b2sums=()` (preferred), `sha512sums=()`, etc.
- Generate/update with `updpkgsums` (pacman-contrib) or `makepkg -g >> PKGBUILD`.
- Use the STRONGEST sum published upstream: `b2 > sha512 > sha384 > sha256 > sha224 > sha1 > md5`.

## Standard functions

```sh
prepare() { :; }   # patches, cargo fetch, manual unpacking
build()   { :; }   # compilation
check()   { :; }   # tests (runs with --check)
package() { :; }   # install files into "$pkgdir"
```

`package()` is mandatory; the rest are optional. `pkgdir`/`srcdir`/`startdir` are set by makepkg.

## Rust project (binary crate)

```sh
pkgname=my-tool            # = binary name, no version
makedepends=('cargo')      # rust throttles cargo+rustc
arch=('x86_64')            # binaries are architecture-dependent
source=("$pkgname-$pkgver.tar.gz::https://static.crates.io/crates/$pkgname/$pkgname-$pkgver.crate")

prepare() {
  export RUSTUP_TOOLCHAIN=stable
  cargo fetch --locked --target "$(rustc -vV | sed -n 's/host: //p')"
}

build() {
  export RUSTUP_TOOLCHAIN=stable
  export CARGO_TARGET_DIR=target
  cargo build --frozen --release --all-features
}

check() {
  export RUSTUP_TOOLCHAIN=stable
  cargo test --frozen --all-features
}

package() {
  install -Dm0755 -t "$pkgdir/usr/bin/" "target/release/$pkgname"
}
```

Key cargo flags:

- `--locked` / `--frozen` — stick to `Cargo.lock`, no network updates. `--frozen = --locked --offline`: the resolver sees ONLY the local sparse index cache (`~/.cargo/registry/index/*/.cache`). If the cache is older than a locked version, the build fails with `candidate versions found which didn't match` even though the version exists upstream. Fix: `cargo fetch --locked` in `prepare()`/`build()`.
- `--release`, `--all-features` (or `--features f1,f2`).
- `CARGO_TARGET_DIR=target` — output in a local `target/`, not `~/.cargo`.
- `RUSTUP_TOOLCHAIN=stable` — fixes builds outside chroot with a broken rustup default.

Notes:

- Rust binaries statically link most dependencies -> `depends` empty or just `glibc`/`libgcc`.
- LTO can break crates with native C/C++ (`ring` etc.): disable LTO or unbundle `-sys` crates via `*_NO_VENDOR=1` / `*_USE_PKG_CONFIG=1`.
- Workspace: `[workspace]` in Cargo.toml -> `cargo test --workspace`.
- Do not run tests with `--release` (optimizations disable `debug_assert!`/overflow checks).

## VCS / -git packages

- Name suffix: `pkgname=foo-git` (or `-svn`, `-hg`, `-bzr`), except when pinning a specific release.
- `source=('foo::git+https://example.org/foo.git')` — `vcs+` where the VCS type is not visible from the URL; `folder::` sets the local directory name.
- `#branch=`, `#tag=`, `#commit=` — fragments for a specific branch/tag/commit.
- `sha256sums=('SKIP')` — volatile sources (except `#tag`/`#commit`, then `makepkg -g` works).
- Add the VCS tool itself to `makedepends` (`git`, `svn`, ...).
- Versioning: `RELEASE.rREVISION`; without releases/tags — `rREVISION`. The `r` separator matters for monotonicity.
- `pkgver()` — auto-bump. For git use a subshell with `set -o pipefail`, otherwise the fallback does NOT trigger and `pkgver` becomes empty:

  ```sh
  pkgver() {
    cd "$pkgname"
    ( set -o pipefail
      git describe --long --tags --abbrev=7 2>/dev/null \
        | sed 's/\([^-]*-g\)/r\1/;s/-/./g' \
        || printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short=7 HEAD)"
    )
  }
  ```

  Trap: without `pipefail` the status of `git describe | sed` equals the status of `sed`; with no tags `git describe` fails but `sed` on empty input returns 0 -> `||` never fires -> makepkg fails with `pkgver is not allowed to be empty`.
- `provides`/`conflicts` to parallel a stable package: `provides=("foo=${pkgver}")`, `conflicts=('foo')`. Avoid `replaces=()`.
- Do not use `pkgver` in the `folder` field (it changes inside `pkgver()`).

## makepkg traps (mandatory reading)

- **Never run `makepkg` in the project source root.** By default `SRCDEST`/`srcdir` = current directory -> makepkg clones the source into `./pkgname/` and unpacks into `./src/`, littering the real source tree. Build in a clean directory: `mkdir /tmp/pkg && cp PKGBUILD /tmp/pkg/ && cd /tmp/pkg && makepkg -si`.
- **A git-source checkout lands in `$srcdir/$_pkgbase`, NOT in `$srcdir` directly.** First line of `build()`/`package()`: `cd "$_pkgbase"`.
- **`build()`/`package()` run in `$srcdir`**, NOT in the directory containing the PKGBUILD. Local files not in the source archive are invisible via relative paths -> `install: cannot stat 'LICENSE'`. Options: (a) commit the file upstream, (b) add it as a separate `source=()` entry with a checksum, (c) use `"$startdir/LICENSE"`.
- **`makepkg -si` requires sudo** — in non-interactive sessions/agents: `makepkg -f`, then hand the user `sudo pacman -U /tmp/pkg/*.pkg.tar.zst`.

## Verification

- `namcap PKGBUILD` and `namcap name.pkg.tar.zst`.
- `shellcheck --shell=bash --exclude=SC2034,SC2154,SC2164 PKGBUILD`.
- `makepkg --printsrcinfo` — generate `.SRCINFO` (for AUR).
- Syntax check without building: `bash -n PKGBUILD`.
- For Rust: run the exact `build()` command locally (`cargo build --frozen --release`).

Prototypes: `/usr/share/pacman/PKGBUILD.proto`, `/usr/share/pacman/PKGBUILD-vcs.proto`.

## Checklist for a new package

1. Identify upstream: binary name, version, source (crates.io / GitHub tarball / git), license, deps.
2. Fill in required variables + source/checksums.
3. Write `prepare()`/`build()`/`check()`/`package()` for the project type (Rust -> see above).
4. `updpkgsums` for tarball sources (not VCS).
5. `namcap` + `shellcheck` + `bash -n`.
6. `makepkg -si` (or `--printsrcinfo` for AUR + `.SRCINFO`).
