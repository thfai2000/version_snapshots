#!/bin/bash

yaml_folder="$1"
snapshot_name="$2"
postfix="1"

destination_file="$yaml_folder/$snapshot_name.yaml"

while [[ -e "$destination_file" ]]; do
  postfix="RC$((postfix + 1))"
  destination_file="$yaml_folder/${snapshot_name}_${postfix}.yaml"
done

cp "$yaml_folder/latest.yaml" "$destination_file"
