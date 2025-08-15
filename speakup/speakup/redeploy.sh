#!/bin/bash

# Redeploy Script for Speak Up NGO Website
# Auto-clones repo if missing
# Usage: ./redeploy.sh

PROJECT_DIR="speakup"
GIT_REPO="https://github.com/YOUR_USERNAME/speakup.git"  # <-- Change to your repo URL

echo "🚀 Redeploying Speak Up website to Vercel..."

# 1. Install Vercel CLI if missing
if ! command -v vercel &> /dev/null; then
    echo "📦 Installing Vercel CLI..."
    npm install -g vercel
fi

# 2. Clone repo if missing
if [ ! -d "$PROJECT_DIR" ]; then
    echo "📂 Project directory '$PROJECT_DIR' not found. Cloning from GitHub..."
    git clone "$GIT_REPO" "$PROJECT_DIR"
fi

# 3. Go into project directory
cd "$PROJECT_DIR" || exit

# 4. Deploy to production
vercel --prod --yes

echo "✅ Redeploy complete!"
