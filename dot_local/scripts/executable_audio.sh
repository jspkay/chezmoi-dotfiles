#!/usr/bin/env bash

die() {
  # $1 is the reason
  echo $1 
  exit 1
}

which pactl > /dev/null
if [[ $? -ne 0 ]]
then
  die "pactl not found!"
fi

which pamixer > /dev/null
if [[ $? -ne 0 ]]
then
  die "pamixer not found!"
fi

MAX=130
FTH=10 # fine threshold is 10. Under this value, there is finer control

current=$(pamixer --get-volume)
ismute=$(pamixer --get-mute)

if [[ $1 == plus ]]
then 
  if [[ $current -ge $MAX ]] 
  then 
    pactl set-sink-volume @DEFAULT_SINK@ ${MAX}%
  elif [[ $current -lt $FTH ]]
  then 
    pactl set-sink-volume @DEFAULT_SINK@ +1%
  else
    pactl set-sink-volume @DEFAULT_SINK@ +5%
  fi

  if [[ $ismute ]] 
  then 
    pactl set-sink-mute @DEFAULT_SINK@ no
  fi
elif [[ $1 == minus ]]
then 
  if [[ $current -le $(($FTH + 1)) ]]
  then 
    pactl set-sink-volume @DEFAULT_SINK@ -1%
  else
    pactl set-sink-volume @DEFAULT_SINK@ -5%
  fi 
elif [[ $1 == "toggleMute" ]] 
then 
  pactl set-sink-mute @DEFAULT_SINK@ toggle
else
  die "$1 not recognized"
fi


