#!/bin/bash

# Usage: ./tag-release.sh [patch|minor|major]
# Example: ./tag-release.sh patch

VERSION_TYPE=$1

if [[ -z "$VERSION_TYPE" ]]; then
  echo "❌ Please provide a version type: patch, minor, or major"
  exit 1
fi

# Extract current version from composer.json
CURRENT_VERSION=$(jq -r .version composer.json)
IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"

# Bump version
case $VERSION_TYPE in
  patch)
    PATCH=$((PATCH + 1))
    ;;
  minor)
    MINOR=$((MINOR + 1))
    PATCH=0
    ;;
  major)
    MAJOR=$((MAJOR + 1))
    MINOR=0
    PATCH=0
    ;;
  *)
    echo "❌ Invalid version type: $VERSION_TYPE"
    exit 1
    ;;
esac

NEW_VERSION="${MAJOR}.${MINOR}.${PATCH}"

# Update composer.json
jq --arg version "$NEW_VERSION" '.version = $version' composer.json > composer.tmp.json && mv composer.tmp.json composer.json

# Commit and tag
git add .
read -p "Enter commit message [Release v$NEW_VERSION]: " COMMIT_MSG
COMMIT_MSG=${COMMIT_MSG:-Release v$NEW_VERSION}
git commit -m "$COMMIT_MSG"
git tag "v$NEW_VERSION"
git push origin main
git push origin "v$NEW_VERSION"

echo "✅ Released v$NEW_VERSION"