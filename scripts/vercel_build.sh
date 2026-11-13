#!/bin/bash
set -e

echo "=== LogiFlow Vercel Build Step ==="

# Check if Flutter SDK is cached or clone stable
if [ ! -d "$HOME/flutter" ]; then
  echo "Cloning Flutter SDK (stable branch)..."
  git clone https://github.com/flutter/flutter.git --depth 1 -b stable "$HOME/flutter"
else
  echo "Using existing Flutter SDK..."
fi

export PATH="$HOME/flutter/bin:$PATH"

flutter doctor -v
flutter config --no-analytics

echo "Building Flutter Web release..."
flutter build web --release

echo "=== Build Complete! Output is at build/web ==="
