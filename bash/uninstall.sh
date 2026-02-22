#!/usr/bin/env bash
# uninstall.sh — Uninstall apps and remove symlinks.
# Equivalent to pwsh/uninstall.ps1.

set -euo pipefail

# ─── Defaults ─────────────────────────────────────────────────────────────────
DRY_RUN=false

# ─── Usage ────────────────────────────────────────────────────────────────────
usage() {
    cat <<EOF

Usage:
  ./uninstall.sh [--dry-run] [--help]

Options:
  --dry-run   Show what would be done, but don't make changes.
  --help      Show this help message.

EOF
    exit 0
}

# ─── Parse arguments ──────────────────────────────────────────────────────────
while [[ $# -gt 0 ]]; do
    case "$1" in
        --dry-run)  DRY_RUN=true; shift ;;
        --help|-h)  usage ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
done

# ─── Resolve paths ────────────────────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ─── Source shared setup ──────────────────────────────────────────────────────
# shellcheck source=setup.sh
source "$SCRIPT_DIR/setup.sh"


# ─── Remove symlinks ─────────────────────────────────────────────────────────
echo "[uninstall.sh] Removing symlinks..."
remove_symlinks "$HOME" "$DRY_RUN"

# ─── Uninstall apps ──────────────────────────────────────────────────────────
echo "[uninstall.sh] Uninstalling apps..."
uninstall_apps "$DRY_RUN"

echo "[uninstall.sh] Uninstall complete."
