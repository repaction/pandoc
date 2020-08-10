#!/usr//bin/env bash

set -e

source_files="${1}"
format="${2}"
options="${3}"

if [[ -z "$source_files" ]]; then
  echo "Input 'source_files' is missing."
fi

if [[ -z "$options" ]]; then
  echo "Input 'options' is empty."
fi

PANDOC_EXEC=$(which pandoc)

while IFS= read -r f; do
  if [[ -z "$f" ]]; then
    continue
  fi

  echo "Compiling $f..."

  if [[ ! -f "$f" ]]; then
    echo "File '$f' cannot be found."
  fi

  if [[ "$format" == "beamer" || "$format" == "tex" ]]; then
      target=${f/.*/.tex}
  fi

  $PANDOC_EXEC -t $format ${options} -o ${target} $f
done <<< "$source_files"
