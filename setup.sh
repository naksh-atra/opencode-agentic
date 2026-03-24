#!/bin/bash
# opencode-agentic setup script
# Usage: ./setup.sh [project-path]
# Defaults to current directory if no path provided

set -e

PROJECT_PATH="${1:-.}"

echo "Setting up opencode-agentic for: $(basename "$PROJECT_PATH")"

# Copy .opencode directory
if [ -d "$PROJECT_PATH/.opencode" ]; then
    echo "⚠️  .opencode already exists in $PROJECT_PATH"
    read -p "Overwrite? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 1
    fi
    rm -rf "$PROJECT_PATH/.opencode"
fi

echo "📁 Copying .opencode/ to $PROJECT_PATH/"
cp -r "$(dirname "$0")/.opencode" "$PROJECT_PATH/"

# Replace PROJECT_NAME placeholder with actual project name
PROJECT_NAME=$(basename "$(realpath "$PROJECT_PATH")")
cd "$PROJECT_PATH/.opencode/memory"

if [ -f "MEMORY.md" ]; then
    sed -i.bak "s/PROJECT_NAME/$PROJECT_NAME/g" MEMORY.md && rm MEMORY.md.bak
    echo "✅ Memory file created: memory/MEMORY.md"
fi

cd - > /dev/null

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "  1. cd $PROJECT_PATH"
echo "  2. Open in OpenCode"
echo "  3. Run /learn to add your first context"
