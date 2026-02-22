#!/usr/bin/env bash
# install.sh — Install apps, set up symlinks, and configure the environment.
# Equivalent to pwsh/install.ps1.

set -euo pipefail

# ─── Defaults ─────────────────────────────────────────────────────────────────
DRY_RUN=false
OVERRIDE=false

# ─── Usage ────────────────────────────────────────────────────────────────────
usage() {
    cat <<EOF

Usage:
  ./install.sh [--dry-run] [--override] [--help]

Options:
  --dry-run    Show what would be done, but don't make changes.
  --override   Overwrite existing files when creating symlinks.
  --help       Show this help message.

EOF
    exit 0
}

# ─── Parse arguments ──────────────────────────────────────────────────────────
while [[ $# -gt 0 ]]; do
    case "$1" in
        --dry-run)  DRY_RUN=true; shift ;;
        --override) OVERRIDE=true; shift ;;
        --help|-h)  usage ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
done

# ─── Resolve paths ────────────────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# ─── Source shared setup ──────────────────────────────────────────────────────
# shellcheck source=setup.sh
source "$SCRIPT_DIR/setup.sh"


# ─── Sync repository ─────────────────────────────────────────────────────────
echo "[install.sh] Syncing repository..."
sync_repo "master" "$DRY_RUN"

# ─── Install / update apps ───────────────────────────────────────────────────
echo "[install.sh] Installing or updating apps..."
check_apps "$DRY_RUN"

# ─── Set up symlinks ─────────────────────────────────────────────────────────
echo "[install.sh] Setting up symlinks..."
setup_symlinks "$REPO_ROOT" "$HOME" "$DRY_RUN" "$OVERRIDE"

echo "[install.sh] Done."
