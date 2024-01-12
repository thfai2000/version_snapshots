#!/bin/bash

set -e

# Function to update the version and artifact path based on the name
update_yaml() {
  local yaml_file="$1"
  local name="$2"
  local version="$3"
  local artifact_path="$4"

  if [[ ! -f "$yaml_file" ]]; then
    echo "name: $name" > "$yaml_file"
    echo "version: $version" >> "$yaml_file"
    echo "artifact_path: $artifact_path" >> "$yaml_file"
  else
    if ! yq eval --exit-status 'select(.name == "'"$name"'")' "$yaml_file"; then
      echo "name: $name" >> "$yaml_file"
      echo "version: $version" >> "$yaml_file"
      echo "artifact_path: $artifact_path" >> "$yaml_file"
    else
      yq eval --inplace 'select(.name == "'"$name"'") | .version = "'"$version"'" | .artifact_path = "'"$artifact_path"'"' "$yaml_file"
    fi
  fi
}

# Usage: ./update_yaml_script.sh <yaml_folder> <name> <version> <artifact_path>
yaml_folder="$1"
name="$2"
version="$3"
artifact_path="$4"

update_yaml "$yaml_folder/latest.yaml" "$name" "$version" "$artifact_path"