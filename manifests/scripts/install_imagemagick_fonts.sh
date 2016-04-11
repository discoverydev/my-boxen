#! /bin/bash

find_imagemagick_version () {
    ls -l "$CELLAR_ROOT/imagemagick" | grep "^d" | rev | cut -d " " -f 1 | rev | tail -n 1
}

FONT_DIRS="/System/Library/Fonts /Library/Fonts"

TYPE_GEN="/opt/boxen/repo/manifests/scripts/type_gen"

CELLAR_ROOT="/opt/boxen/homebrew/Cellar"
IMAGE_MAGICK_VERSION=$(find_imagemagick_version)
IMAGE_MAGICK_HOME="$CELLAR_ROOT/imagemagick/$IMAGE_MAGICK_VERSION"
IM_CONFIG="$IMAGE_MAGICK_HOME/etc/ImageMagick-6"
IM_SYSTEM_TYPE_XML="$IM_CONFIG/type.xml"
IM_LOCAL_TYPE_XML="$IM_CONFIG/local-type.xml"

if [[ $(grep local-type\.xml "$IM_SYSTEM_TYPE_XML") != "" ]]; then
    exit 0
fi

find $FONT_DIRS -name "*.[to]tf" | "$TYPE_GEN" -f - > "$IM_LOCAL_TYPE_XML"

sed -i bak '\#</typemap>#i \
   <include file=\"local-type.xml"/>\
' "$IM_SYSTEM_TYPE_XML"
