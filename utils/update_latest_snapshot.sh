#!/bin/bash

# Function to update the version and artifact path based on the name

yaml_file="$1/latest.yaml"
name="$2"
version="$3"
commit_sha="$4"
artifact_path="$5"

if [[ ! -f "$yaml_file" ]]; then
  echo "name: $name" > "$yaml_file"
  echo "version: $version" >> "$yaml_file"
  echo "commit_sha: $commit_sha" >> "$yaml_file"
  echo "artifact_path: $artifact_path" >> "$yaml_file"
else
  if ! yq eval --exit-status 'select(.name == "'"$name"'")' "$yaml_file"; then
    echo "name: $name" >> "$yaml_file"
    echo "version: $version" >> "$yaml_file"
    echo "commit_sha: $commit_sha" >> "$yaml_file"
    echo "artifact_path: $artifact_path" >> "$yaml_file"
  else
    yq eval --inplace 'select(.name == "'"$name"'") | .version = "'"$version"'" | .commit_sha = "'"$commit_sha"'" | .artifact_path = "'"$artifact_path"'"' "$yaml_file"
  fi
fi