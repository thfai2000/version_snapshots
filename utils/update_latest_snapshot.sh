#!/bin/bash

# Function to update the version and artifact path based on the name
script_path=$(readlink -f "$0")
# Extract the folder path
folder_path=$(dirname "$script_path")

yaml_file="$1/latest.yaml"
name="$2"
version="$3"
commit_sha="$4"
artifact_path="$5"
last_modified_time=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

if [[ ! -f "$yaml_file" ]]; then
  echo "case1 - create file"
  echo "- name: $name" > "$yaml_file"
  echo "  version: $version" >> "$yaml_file"
  echo "  commit_sha: $commit_sha" >> "$yaml_file"
  echo "  artifact_path: $artifact_path" >> "$yaml_file"
  echo "  last_modified_time: $last_modified_time" >> "$yaml_file"

else
  text=$( $folder_path/yq '.[] | select(.name == "'$name'")' "$yaml_file")

  if [ -z "$text" ]; then
    echo "case2 - added new record"
    echo "- name: $name" >> "$yaml_file"
    echo "  version: $version" >> "$yaml_file"
    echo "  commit_sha: $commit_sha" >> "$yaml_file"
    echo "  artifact_path: $artifact_path" >> "$yaml_file"
    echo "  last_modified_time: $last_modified_time" >> "$yaml_file"
  else

    echo "case3 - update existing record"
    $folder_path/yq --inplace 'map(select(.name == "'$name'") |= . + {
      "version": "'$version'",
      "commit_sha": "'$commit_sha'",
      "artifact_path": "'$artifact_path'",
      "last_modified_time": "'$last_modified_time'"
    })' "$yaml_file"

  fi
fi

