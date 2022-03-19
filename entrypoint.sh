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

if [[ "$format" == "beamer" || "$format" == "latex" ]]; then
    ext="tex"
fi

if [[ "$format" == "html4" || "$format" == "html5" || "$format" == "revealjs" ]]; then
    ext="html"
fi

if [[ "$format" == "docx" || "$format" == "pptx" || "$format" == "html" ]]; then
    ext="$format"
fi


while IFS= read -r f; do
  if [[ -z "$f" ]]; then
    continue
  fi

  echo "::group::Compiling $f..."

  if [[ ! -f "$f" ]]; then
    echo "File '$f' cannot be found."
  fi

  target=${f/.*/.${ext}}

  $PANDOC_EXEC -t $format ${options} -o ${target} $f

  echo "::endgroup::"
  
done <<< "$source_files"
