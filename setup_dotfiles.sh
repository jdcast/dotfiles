#!/usr/bin/env bash
#
# Dot-files bootstrap script (user-only Go PATH + instant-markdown-d + TPM support)
# Now pointing at “dotfiles” instead of “config-files”
#
# Usage:  ./setup_dotfiles.sh <machine-specific-folder>
# Example: ./setup_dotfiles.sh orin6-warp-whoi

set -euo pipefail
IFS=$'\n\t'

info(){ printf "\e[1;34m[INFO]\e[0m  %s\n" "$*"; }
warn(){ printf "\e[1;33m[WARN]\e[0m  %s\n" "$*"; }
fail(){ printf "\e[1;31m[FAIL]\e[0m  %s\n" "$*" >&2; exit 1; }

# ────────── Privilege management ────────────────────────────
(( EUID == 0 )) && SUDO="" || SUDO="sudo"

# ─────────────────────── Arguments ──────────────────────────
MACHINE_DIR="${1:-}"
if [[ -z "$MACHINE_DIR" ]]; then
  warn "No machine-specific folder given; only 'common' will be stowed."
fi

DOT_REPO="git@github.com:jdcast/dotfiles.git"
DOT_PATH="$HOME/dotfiles"

# ── stow helper: choose local→repo or repo on conflicts ─────────
stow_pkg(){
  local pkg=$1 sim file choice
  info "Stowing '$pkg'…"
  sim=$(mktemp)
  if stow -d "$DOT_PATH" -t "$HOME" -nv "$pkg" >"$sim" 2>&1; then
    stow -d "$DOT_PATH" -t "$HOME" "$pkg"
    rm -f "$sim"
    return
  fi

  mapfile -t conflicts < <(grep -E 'existing target.*: ' "$sim" | sed -E 's/.*: (.+)$/\1/')
  rm -f "$sim"

  for file in "${conflicts[@]}"; do
    while true; do
      printf "\nConflict: %s\n" "$file"
      read -p "  (l)ocal→repo or (r)epo? " choice
      case "$choice" in
        [Ll]* )
          mkdir -p "$(dirname "$DOT_PATH/$pkg/$file")"
          cp -a "$HOME/$file" "$DOT_PATH/$pkg/$file"
          rm -rf "$HOME/$file"
          break
          ;;
        [Rr]* )
          rm -rf "$HOME/$file"
          break
          ;;
        * ) echo "Enter 'l' or 'r'." ;;
      esac
    done
  done

  info "Re-running stow for '$pkg'…"
  stow -d "$DOT_PATH" -t "$HOME" "$pkg"
}

# ──────────────────────────── Install base packages ───────────────────────────
info "Adding Vim PPA and updating apt…"
$SUDO add-apt-repository -y ppa:jonathonf/vim
$SUDO apt-get update

info "Installing prerequisites: vim, tmux, cmake, build-essential, default-jdk, python3-dev, nodejs, npm, stow, curl, git"
$SUDO apt-get install -y \
  vim tmux cmake build-essential default-jdk python3-dev \
  nodejs npm stow curl git

# ─────────────────── instant-markdown-d for Vim ───────────────────────────────
info "Installing instant-markdown-d via npm..."
$SUDO npm install -g instant-markdown-d

# ─────────────────── Install Go (user-only PATH) ──────────────────────────────
GO_ROOT=/usr/local/go
if [[ -x $GO_ROOT/bin/go ]]; then
  info "Go already installed at $GO_ROOT"
else
  info "Fetching latest Go version…"
  RAW_VER=$(curl -fsSL https://go.dev/VERSION?m=text)
  GO_VER=$(echo "$RAW_VER" | grep -Eo '^go[0-9]+\.[0-9]+(\.[0-9]+)?') \
    || fail "Cannot parse Go version from '$RAW_VER'"

  ARCH=$(uname -m)
  case "$ARCH" in
    x86_64) GO_ARCH="linux-amd64" ;;
    aarch64) GO_ARCH="linux-arm64" ;;
    *) fail "Unsupported arch: $ARCH" ;;
  esac

  TAR="${GO_VER}.${GO_ARCH}.tar.gz"
  info "Downloading $TAR…"
  curl -LO "https://go.dev/dl/$TAR"

  info "Installing Go…"
  $SUDO rm -rf "$GO_ROOT"
  $SUDO tar -C /usr/local -xzf "$TAR"
  rm "$TAR"
fi

# ─── Ensure Go on live PATH and persist in ~/.bashrc ───────────────────────────
export PATH=/usr/local/go/bin:$PATH
info "Go on PATH: $(go version)"

BASHRC="$HOME/.bashrc"
GO_LINE='export PATH=$PATH:/usr/local/go/bin'
if ! grep -qxF "$GO_LINE" "$BASHRC"; then
  info "Appending Go PATH to ~/.bashrc"
  echo "$GO_LINE" >> "$BASHRC"
fi

# ─────────────────── Clone or update dotfiles repo ────────────────────────────
if [[ -d $DOT_PATH/.git ]]; then
  info "Updating dotfiles repo…"
  git -C "$DOT_PATH" pull --ff-only
else
  info "Cloning dotfiles into $DOT_PATH…"
  git clone --recursive "$DOT_REPO" "$DOT_PATH"
fi
info "Updating git submodules…"
git -C "$DOT_PATH" submodule update --init --recursive

# ──────────────────── Build YouCompleteMe ────────────────────────────────────
YCM="$DOT_PATH/common/.vim/bundle/YouCompleteMe"
if [[ -d $YCM ]]; then
  info "Building YouCompleteMe…"
  python3 "$YCM/install.py" --all
else
  warn "YouCompleteMe missing; skipping."
fi

# ───────────────────────────── Stow configs ─────────────────────────────────
stow_pkg common
if [[ -n $MACHINE_DIR && -d $DOT_PATH/$MACHINE_DIR ]]; then
  stow_pkg "$MACHINE_DIR"
elif [[ -n $MACHINE_DIR ]]; then
  warn "Machine-specific dir '$MACHINE_DIR' not found; skipping."
fi

# ─────────────────── Vim & tmux final setup ─────────────────────────────────
info "Installing Vim plugins…"
vim +PluginInstall +qall

# Ensure TPM exists so setup_tmux.sh succeeds
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [[ ! -d "$TPM_DIR" ]]; then
  info "Installing tmux plugin manager (tpm)…"
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

TMUX_SCRIPT="$DOT_PATH/setup_tmux.sh"
if [[ -x $TMUX_SCRIPT ]]; then
  info "Running setup_tmux.sh…"
  "$TMUX_SCRIPT"
else
  warn "No setup_tmux.sh; skipping."
fi

info "Reloading tmux config if running…"
tmux source-file "$HOME/.tmux.conf" || true

info "🎉 Bootstrap complete!  Run 'source ~/.bashrc' or open a new shell to pick up Go and instant-markdown-d."
