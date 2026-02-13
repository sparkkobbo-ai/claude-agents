#!/usr/bin/env bash
# claude-agents setup script
# Copies knowledge templates to knowledge/ for project-specific customization.
#
# Usage:
#   ./setup.sh              # Interactive - copies all templates
#   ./setup.sh --force      # Overwrite existing knowledge files
#   ./setup.sh --list       # Show available templates

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="$SCRIPT_DIR/templates/knowledge"
KNOWLEDGE_DIR="$SCRIPT_DIR/knowledge"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

if [[ "${1:-}" == "--list" ]]; then
    echo -e "${CYAN}Available knowledge templates:${NC}"
    for tmpl in "$TEMPLATES_DIR"/*.md; do
        name=$(basename "$tmpl")
        echo "  $name"
    done
    exit 0
fi

FORCE=false
if [[ "${1:-}" == "--force" ]]; then
    FORCE=true
fi

# Create knowledge directory
mkdir -p "$KNOWLEDGE_DIR"

echo -e "${CYAN}claude-agents setup${NC}"
echo "Copying knowledge templates for project customization..."
echo ""

copied=0
skipped=0

for tmpl in "$TEMPLATES_DIR"/*.md; do
    name=$(basename "$tmpl")
    dest="$KNOWLEDGE_DIR/$name"

    if [[ -f "$dest" ]] && [[ "$FORCE" != true ]]; then
        echo -e "  ${YELLOW}SKIP${NC}  $name (already exists, use --force to overwrite)"
        skipped=$((skipped + 1))
    else
        cp "$tmpl" "$dest"
        echo -e "  ${GREEN}COPY${NC}  $name"
        copied=$((copied + 1))
    fi
done

echo ""
echo -e "${GREEN}Done!${NC} Copied $copied, skipped $skipped."
echo ""
echo "Next steps:"
echo "  1. Edit files in knowledge/ to match your project"
echo "  2. Remove any agent YAMLs in agents/ that don't apply"
echo "  3. Knowledge files are gitignored - they stay local"
echo ""
echo "Knowledge directory: $KNOWLEDGE_DIR"
