#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

declare -A works

echo -e "${BLUE}Reading works-list.txt file...${NC}";
while IFS=' ' read -r name url || [ -n "$name" ]; do
  works[$name]="$url"
done < works-list.txt

tmpBase='works-tmp'
worksBase='works'

mkdir -p "$tmpBase" "$worksBase"

echo -e "${BLUE}Checking and adding missing submodules in $tmpBase...${NC}"
for work in "${!works[@]}"; do
  tmpPath="$tmpBase/$work"
  destPath="$worksBase/$work"

  if [ ! -d "$tmpPath" ]; then
    echo -e "${BLUE}Adding submodule $work to $tmpBase...${NC}"
    git submodule add -f "${works[$work]}" "$tmpPath"
    echo -e "${GREEN}Submodule $work added successfully to $tmpPath.${NC}"
  else
    echo -e "${YELLOW}Submodule $work already exists in $tmpBase.${NC}"
  fi
done

echo -e "${BLUE}Uploading all submodules in $tmpBase to latest remote commits...${NC}"
git submodule update --remote --merge
echo -e "${GREEN}Submodules has been successfully updated to latest remote commits.${NC}"

echo -e "${BLUE}Synchronizing submodules content from $tmpBase to $worksBase...${NC}"
for work in "${!works[@]}"; do
  src="$tmpBase/$work"
  dest="$worksBase/$work"

  if [ -d "$src" ]; then
    mkdir -p "$dest"
    rsync -av --delete --exclude='.git' "$src/" "$dest/"
    echo -e "${GREEN}Synchronized submodule $work successfully.${NC}"
  else
    echo -e "${RED}Warning: $src does not exist, skipping synchronization!${NC}"
  fi
done

echo -e "${BLUE}Staging changes in $worksBase...${NC}"
git add "$worksBase/"
echo -e "${GREEN}Changes staged.${NC}"

echo -e "${BLUE}Committing changes...${NC}"
if git commit -m "Sync latest updates from submodules to works/ directory."; then
  echo -e "${GREEN}Changes committed.${NC}"
else
  echo -e "${RED}Nothing to commit.${NC}"
fi

echo -e "${GREEN}done.${NC}"