#!/bin/sh
# Builds the static site into dist/ from src/, applying the toggles in site.env.
# POSIX sh — runs on the host or inside the alpine build stage of the Dockerfile.
set -eu

cd "$(dirname "$0")"
. ./site.env

rm -rf dist
mkdir -p dist
cp -r src/fonts dist/fonts
cp src/styles.css dist/styles.css

# Drop each <!--IF:FLAG-->…<!--ENDIF:FLAG--> block whose flag is not "true",
# then strip the marker comments themselves from the kept blocks.
apply_flag() {
    flag=$1 value=$2
    if [ "$value" = "true" ]; then
        sed -e "/<!--IF:$flag-->/d" -e "/<!--ENDIF:$flag-->/d"
    else
        sed "/<!--IF:$flag-->/,/<!--ENDIF:$flag-->/d"
    fi
}

apply_flag SHOW_AVAILABILITY "$SHOW_AVAILABILITY" < src/index.html \
    | apply_flag SHOW_LAB "$SHOW_LAB" \
    | apply_flag SHOW_WRITING "$SHOW_WRITING" \
    | sed "s/{{AVAILABILITY_DATE}}/$AVAILABILITY_DATE/" \
    > dist/index.html

if grep -qE '<!--(IF|ENDIF):|\{\{' dist/index.html; then
    echo "build.sh: unresolved markers remain in dist/index.html" >&2
    exit 1
fi

echo "Built dist/ (SHOW_AVAILABILITY=$SHOW_AVAILABILITY, AVAILABILITY_DATE=$AVAILABILITY_DATE, SHOW_LAB=$SHOW_LAB, SHOW_WRITING=$SHOW_WRITING)"
