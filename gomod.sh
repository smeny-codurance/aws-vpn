#!/bin/bash
set -eu

touch go.mod

REPOSITORY_NAME=$(basename $(pwd | xargs dirname))
PROJECT_NAME=$(basename $(pwd))

CONTENT=$(cat <<-EOD
module github.com/${REPOSITORY_NAME}/${PROJECT_NAME}
EOD
)

echo "$CONTENT" > go.mod
