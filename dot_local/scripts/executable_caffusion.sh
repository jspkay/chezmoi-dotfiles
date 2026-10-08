#!/bin/bash

# set -x

PIDFILE="/tmp/caffusion"
NS_FLAGS='-u low'

# If this file exists, then we kill it
# that activates caffeine
# And we exit
if [ -e $PIDFILE ]
then
  swayidlePID=$(cat $PIDFILE)
  echo "killing infusion with PID $swayidlePID"
  kill $swayidlePID
  notify-send $NS_FLAGS "Caffeine" "[caffusion] Caffeine is activated\nThe laptop won't go to sleep"
  rm $PIDFILE
  exit 0
fi
 
# otherwise, we spawn a new infusion job
swayidle -w \
       timeout 300 'swaylock -f -c 000000' \
       timeout 600 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"' \
       before-sleep 'swaylock -f -c 000000' &
disown

swayidlePID=$!
echo "activating infusion with PID $swayidlePID"
echo $swayidlePID > $PIDFILE
notify-send $NS_FLAGS "Infusion" "[caffusion] Infusion is activated\nLock after 5 minutes, sleep after 10 minutes"

# unset -x 
