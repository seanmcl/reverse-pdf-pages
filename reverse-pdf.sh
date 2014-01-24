#!/bin/bash

function usage {
    echo "Usage: $0 FILE"
}

if (( $# != 1 )); then
    usage
    exit 1
fi

file=$1; shift
name=$(basename -s ".pdf" $file)
template_head=${name}___split___
template=${template_head}%05d.pdf

pdftk $file burst output $template
files=$(ls $template_head* | sort -r)
pdftk $files cat output ${name}-rev.pdf
rm -f $files doc_data.txt
