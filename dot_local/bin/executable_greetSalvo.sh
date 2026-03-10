#/usr/bin/env bash
styles=(emboss future pagga smblock smbraille smmono9)
style=${styles[ $RANDOM % ${#styles[@]} ]}
toilet "Hello Salvo!"
