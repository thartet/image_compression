#!/bin/bash

# Copyright (C) 2023 thartet https://github.com/thartet
# This script is used to reduce the image size and optimize the number of colors of the image.

function pngTreatment {

    name=$(echo "$1" | sed 's/\.png$//')
    color_number=$(identify -format %k "$1")

    if [ $color_number -gt 256 ]
    then
        # Reduce the number of colors in the PNG using pngquant
        pngquant --quality=0-100 --force --speed=1 --strip --output "/tmp/coloured_$1" --verbose 256 -- "$1" 
    fi
    
    # Reduce the file size of the picture using ImageMagick
    convert "/tmp/coloured_$1" -strip -quality 65% "reduced_$name.webp"

    # Remove the png file
    rm "/tmp/coloured_$1"
    echo "Reduction of $1 complete. The new file is reduced_$name.webp"

}

function jpgTreatment {
    name=$(echo "$1" | sed 's/\.jpg$//')
    color_number=$(identify -format %k "$1")

    if [ $color_number -gt 256 ]
    then
        #Reduce the number of colors in the PNG using ImageMagick
        convert "$1" -strip -posterize 256 "/tmp/coloured_$1"
    fi

    # Reduce the file size of the picture using ImageMagick
    convert "/tmp/coloured_$1" -strip -quality 65% "reduced_$name.webp"

    # Remove the jpeg file
    rm "/tmp/coloured_$1"
    echo "Reduction of $1 complete. The new file is reduced_$name.webp"
}

function webpTreatment {
    name=$(echo "$1" | sed 's/\.webp$//')
    color_number=$(identify -format %k "$1")

    if [ $color_number -gt 256 ]
    then
        #Reduce the number of colors in the webp using ImageMagick
        convert "$1" -strip -posterize 256 "/tmp/coloured_$1"
    fi

    # Reduce the file size of the picture using ImageMagick
    convert "/tmp/coloured_$1" -strip -quality 65% "reduced_$name.webp"
    rm "/tmp/coloured_$1"
    echo "Reduction of $1 complete. The new file is reduced_$name.webp"
}

# Check the number of arguments
if [ $# -ne 1 ]
then
    echo "The number of arguments is not correct"
    exit 1
fi

# Help message
if [ $1 == "-h" ]
then
    echo "This script is used to reduce the image size and optimize the number of colors of the image."
    echo "Usage: img2.sh <file>"
    echo "Supported types are: .png, .jpeg, .webp, .svg"
    exit 0
fi

# Check if the file exists
if [ ! -f $1 ]
then
    echo "The file does not exist"
    exit 1
fi

# Treat the file according to its extension
case $(file --extension -b $1) in

    "png") pngTreatment $1;;

    "jpeg/jpg/jpe/jfif") jpgTreatment $1;;

    "webp") webpTreatment $1;;

    "svg") echo "The file is a svg file. No treatment is needed.";return 0;;

    *) echo "The type of your file is not supported. \n Supported types are: .png, .jpeg, .webp, .svg";return 1;;

esac

# Calculate the pourcentage of reduction
old_size=$(stat -c%s "$1")
new_size=$(stat -c%s "reduced_$name.webp")

echo "The old size is $old_size"
echo "The new size is $new_size"

percentage=$((($old_size-$new_size)*100/$old_size))
echo "The file size has been reduced by $percentage%"