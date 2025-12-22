#!/bin/bash

LIST=($HOME/Pictures/wallpapers/*)
# echo "LIST has lengtht ${#LIST[@]}"
IMAGE=${LIST[$RANDOM % ${#LIST[@]}]}
echo $IMAGE

# We have the current file
# and the file we are just seeing: the next image is generated at lock time
file="$HOME/tmp/wallpaper-lock.png"
oldfile="$HOME/tmp/wallpaper-lock-last-seen.png"

echo $file
# we lock the laptop
swaylock --image $file "$@" &
# And the we wait for swaylock to read $file
# properly. 100ms should be enough
sleep 0.1
# At this point, we take the file we are using
# as a lockscreen, and we make it available for
# inspection later on.
mv $file $oldfile

# we take the width of the image
width=$(identify -ping -format "%w" $IMAGE)
# echo $width
# radius=$(echo "$width * 0.2" | bc | cut -d'.' -f1)
# we compute sigma based on the witdh
sigma=$(echo "$width / 250" | bc | cut -d'.' -f1)
blur=$HOME/builds/FastGaussianBlur/fastblur
# we actually blur the image and make it available
# for the next lock
$blur $IMAGE $file $sigma
notify-send "Background Image" "New Background Image is ready to be processed!"
