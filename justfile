set windows-shell := ["powershell"]
set shell := ["bash", "-cu"]

_default:
  just --list -u

setup:
  @rusty-hook init
  @echo "Setup complete ✅"

precommit:
  cargo check
  just check-typos
  just fmt
  just test
  just lint

check-typos:
  typos .

fmt:
  cargo fmt --all -- --emit=files
  taplo fmt
  cargo shear --fix
  taplo format

test:
  cargo nextest run

lint:
  cargo fmt --all -- --check
  cargo clippy -- --deny warnings
  cargo shear
  taplo format --check
