#!/bin/bash

yaml_folder="$1"
snapshot_name="$2"
rc_number="2"

destination_file="$yaml_folder/$snapshot_name.yaml"

while [[ -e "$destination_file" ]]; do
  postfix="RC$((rc_number++))"
  destination_file="$yaml_folder/${snapshot_name}_${postfix}.yaml"

  echo "Test file - $destination_file"
done

echo "Creating file - $destination_file"
cp "$yaml_folder/latest.yaml" "$destination_file"