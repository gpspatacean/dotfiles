#!/usr/bin/env bash
# setup.sh — Shared functions and configuration for bash install/uninstall scripts.
# Sourced by install.sh and uninstall.sh.

set -euo pipefail

# ─── Application Map ──────────────────────────────────────────────────────────
# Associative array: command name -> apt package name.
# Use "-" if the package requires a custom install (e.g. oh-my-posh).
declare -A APP_MAP=(
    ["oh-my-posh"]="-"
    ["fzf"]="-"
    ["zoxide"]="-"
    ["eza"]="-"
    ["bat"]="bat"
    ["yazi"]="-"
    ["rg"]="ripgrep"
    ["lazygit"]="-"
)

# ─── Symlinks Map ─────────────────────────────────────────────────────────────
# Associative array: source (relative to repo root) -> target (relative to $HOME).
# Bash-specific dotfiles + shared .config directories.
declare -A SYMLINKS_MAP=(
    ["customized_atomic.omp.json"]=".config/customized_atomic.omp.json"
    [".config/bat"]=".config/bat"
    [".config/fzf"]=".config/fzf"
    [".config/git"]=".config/git"
    [".config/lazygit"]=".config/lazygit"
    [".config/nvim"]=".config/nvim"
    [".config/rg"]=".config/rg"
    [".config/tmux"]=".config/tmux"
    [".config/yazi"]=".config/yazi"
    ["bash/.bashrc"]=".bashrc"
    ["bash/.bash_aliases"]=".bash_aliases"
    ["bash/.inputrc"]=".inputrc"
)

# ─── Install / Update a single app ────────────────────────────────────────────
install_or_update_app() {
    local cmd="$1"
    local pkg="$2"
    local dry_run="${3:-false}"

    # oh-my-posh: always install/update via its own installer script
    if [[ "$cmd" == "oh-my-posh" ]]; then
        if command -v oh-my-posh &>/dev/null; then
            echo "'oh-my-posh' found. Attempting to update..."
        else
            echo "'oh-my-posh' not found. Installing..."
        fi
        if [[ "$dry_run" == "true" ]]; then
            echo "[Dry-Run] Would run: curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin"
            echo "[Dry-Run] Would run: ~/.local/bin/oh-my-posh font install meslo"
        else
            curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin
            ~/.local/bin/oh-my-posh font install meslo
        fi
        return
    fi

    # fzf: always install/update via its own installer script
    if [[ "$cmd" == "fzf" ]]; then
        if command -v fzf &>/dev/null; then
            echo "'fzf' found. Attempting to update..."
        else
            echo "'fzf' not found. Installing..."
        fi
        if [[ "$dry_run" == "true" ]]; then
            echo "[Dry-Run] Would run: wget -c https://github.com/junegunn/fzf/releases/download/v0.68.0/fzf-0.68.0-linux_amd64.tar.gz -O- | tar xz
            mv fzf ~/.local/bin/
            "
        else
            wget -c https://github.com/junegunn/fzf/releases/download/v0.68.0/fzf-0.68.0-linux_amd64.tar.gz -O- | tar xz
            mv fzf ~/.local/bin/
        fi
        return
    fi

    # zoxide: always install/update via its own installer script
    if [[ "$cmd" == "zoxide" ]]; then
        if command -v zoxide &>/dev/null; then
            echo "'zoxide' found. Attempting to update..."
        else
            echo "'zoxide' not found. Installing..."
        fi
        if [[ "$dry_run" == "true" ]]; then
            echo "[Dry-Run] Would run: curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh"
        else
            curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
        fi
        return
    fi

    # eza: always install/update via its own installer script
    if [[ "$cmd" == "eza" ]]; then
        if command -v eza &>/dev/null; then
            echo "'eza' found. Attempting to update..."
        else
            echo "'eza' not found. Installing..."
        fi
        if [[ "$dry_run" == "true" ]]; then
            echo "[Dry-Run] Would run:
            wget -c https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz -O - | tar xz
            chmod +x eza
            # sudo chown $USER:$USER eza
            mv eza ~/.local/bin
            "
        else
            wget -c https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz -O - | tar xz
            chmod +x eza
            mv eza ~/.local/bin
        fi
        return
    fi

    # yazi: always install/update via its own installer script
    if [[ "$cmd" == "yazi" ]]; then
        if command -v eza &>/dev/null; then
            echo "'yazi' found. Attempting to update..."
        else
            echo "'yazi' not found. Installing..."
        fi
        if [[ "$dry_run" == "true" ]]; then
            echo "[Dry-Run] Would run:
            wget -c https://github.com/sxyazi/yazi/releases/download/v26.1.22/yazi-x86_64-unknown-linux-gnu.zip
            unzip yazi-x86_64-unknown-linux-gnu.zip
            chmod +x yazi-x86_64-unknown-linux-gnu/yazi
            mv yazi-x86_64-unknown-linux-gnu/yazi ~/.local/bin
            rm -rf yazi-x86_64-unknown-linux-gnu
            "
        else
            wget -c https://github.com/sxyazi/yazi/releases/download/v26.1.22/yazi-x86_64-unknown-linux-gnu.zip
            unzip yazi-x86_64-unknown-linux-gnu.zip
            chmod +x yazi-x86_64-unknown-linux-gnu/yazi
            mv yazi-x86_64-unknown-linux-gnu/yazi ~/.local/bin
            rm -rf yazi-x86_64-unknown-linux-gnu yazi-x86_64-unknown-linux-gnu.zip
        fi
        return
    fi

    # lazygit: always install/update via its own installer script
    if [[ "$cmd" == "lazygit" ]]; then
        if command -v lazygit &>/dev/null; then
            echo "'lazygit' found. Attempting to update..."
        else
            echo "'lazygit' not found. Installing..."
        fi
        if [[ "$dry_run" == "true" ]]; then
            echo "[Dry-Run] Would run:
            wget -c https://github.com/jesseduffield/lazygit/releases/download/v0.59.0/lazygit_0.59.0_linux_x86_64.tar.gz -O- | tar xz --one-top-level=lg
            mv lg/lazygit ~/.local/bin
            rm -rf lg
            "
        else
            wget -c https://github.com/jesseduffield/lazygit/releases/download/v0.59.0/lazygit_0.59.0_linux_x86_64.tar.gz -O- | tar xz --one-top-level=lg
            mv lg/lazygit ~/.local/bin
            rm -rf lg
        fi
        return
    fi

    if [[ "$pkg" == "-" ]]; then
        echo "'$cmd': no apt package available. Skipping."
        return
    fi

    if command -v "$cmd" &>/dev/null; then
        echo "'$cmd' found. Attempting to update..."
        if [[ "$dry_run" == "true" ]]; then
            echo "[Dry-Run] Would run: sudo apt-get install --only-upgrade -y $pkg"
        else
            sudo apt-get install --only-upgrade -y "$pkg"
        fi
    else
        echo "'$cmd' not found. Installing..."
        if [[ "$dry_run" == "true" ]]; then
            echo "[Dry-Run] Would run: sudo apt-get install -y $pkg"
        else
            sudo apt-get install -y "$pkg"
        fi
    fi
}

# ─── Uninstall a single app ───────────────────────────────────────────────────
uninstall_app() {
    local cmd="$1"
    local pkg="$2"
    local dry_run="${3:-false}"

    # oh-my-posh: remove the binary manually
    if [[ "$cmd" == "oh-my-posh" ]]; then
        local omp_bin
        omp_bin="$(command -v oh-my-posh 2>/dev/null || true)"
        if [[ -n "$omp_bin" ]]; then
            echo "'oh-my-posh' found at '$omp_bin'. Attempting to remove..."
            if [[ "$dry_run" == "true" ]]; then
                echo "[Dry-Run] Would run: rm -f '$omp_bin'"
            else
                rm -f "$omp_bin"
                echo "'oh-my-posh' removed."
            fi
        else
            echo "'oh-my-posh' not found. Skipping uninstall."
        fi
        return
    fi

    if [[ "$pkg" == "-" ]]; then
        echo "'$cmd': no apt package available. Skipping."
        return
    fi

    if command -v "$cmd" &>/dev/null; then
        echo "'$cmd' found. Attempting to uninstall..."
        if [[ "$dry_run" == "true" ]]; then
            echo "[Dry-Run] Would run: sudo apt-get remove -y $pkg"
        else
            sudo apt-get remove -y "$pkg"
        fi
    else
        echo "'$cmd' not found. Skipping uninstall."
    fi
}

# ─── Batch operations ─────────────────────────────────────────────────────────
check_apps() {
    local dry_run="${1:-false}"
    for cmd in "${!APP_MAP[@]}"; do
        install_or_update_app "$cmd" "${APP_MAP[$cmd]}" "$dry_run"
    done
}

uninstall_apps() {
    local dry_run="${1:-false}"
    for cmd in "${!APP_MAP[@]}"; do
        uninstall_app "$cmd" "${APP_MAP[$cmd]}" "$dry_run"
    done
}

# ─── Symlink Management ──────────────────────────────────────────────────────
create_symlink() {
    local source="$1"
    local target="$2"
    local dry_run="${3:-false}"
    local override="${4:-false}"

    if [[ -e "$target" || -L "$target" ]]; then
        if [[ "$override" == "true" ]]; then
            local timestamp
            timestamp="$(date +%Y%m%d_%H%M%S)"
            local backup_path="${target}.bak.${timestamp}"
            echo "Target '$target' already exists. Backing up to '$backup_path'."
            if [[ "$dry_run" == "true" ]]; then
                echo "[Dry-Run] Would run: mv '$target' '$backup_path'"
            else
                mv "$target" "$backup_path"
            fi
        else
            echo "Target '$target' already exists. Skipping (use --override to replace)."
            return
        fi
    fi

    # Ensure parent directory exists
    local parent_dir
    parent_dir="$(dirname "$target")"
    if [[ ! -d "$parent_dir" ]]; then
        if [[ "$dry_run" == "true" ]]; then
            echo "[Dry-Run] Would run: mkdir -p '$parent_dir'"
        else
            mkdir -p "$parent_dir"
        fi
    fi

    echo "Creating symlink: '$target' -> '$source'"
    if [[ "$dry_run" == "true" ]]; then
        echo "[Dry-Run] Would run: ln -s '$source' '$target'"
    else
        ln -s "$source" "$target"
    fi
}

setup_symlinks() {
    local source_dir="$1"
    local target_dir="$2"
    local dry_run="${3:-false}"
    local override="${4:-false}"

    for key in "${!SYMLINKS_MAP[@]}"; do
        local source="${source_dir}/${key}"
        local target="${target_dir}/${SYMLINKS_MAP[$key]}"
        create_symlink "$source" "$target" "$dry_run" "$override"
    done
}

remove_symlinks() {
    local target_dir="$1"
    local dry_run="${2:-false}"

    for key in "${!SYMLINKS_MAP[@]}"; do
        local target="${target_dir}/${SYMLINKS_MAP[$key]}"
        if [[ -L "$target" ]]; then
            echo "Removing symlink: '$target'"
            if [[ "$dry_run" == "true" ]]; then
                echo "[Dry-Run] Would run: rm '$target'"
            else
                rm "$target"
            fi
        elif [[ -e "$target" ]]; then
            echo "Target '$target' exists but is not a symlink. Skipping."
        else
            echo "Target '$target' does not exist. Skipping."
        fi
    done
}

# ─── Repository Sync ─────────────────────────────────────────────────────────
sync_repo() {
    local branch="${1:-master}"
    local dry_run="${2:-false}"

    local script_dir
    script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    echo "Syncing repository at '$script_dir' with branch '$branch'..."
    if [[ "$dry_run" == "true" ]]; then
        echo "[Dry-Run] Would run: cd '$script_dir' && git fetch --all && git checkout $branch && git pull origin $branch"
    else
        local original_dir
        original_dir="$(pwd)"
        cd "$script_dir"
        git fetch --all
        git checkout "$branch"
        git pull origin "$branch"
        cd "$original_dir"
    fi
}
