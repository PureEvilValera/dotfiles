#!/bin/bash

artist_offset=25
title_offset=40

artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)

if [ -n "$title" ]; then
  if [ -n "$artist" ]; then
   if [ ${#artist} -gt $artist_offset ]; then
     artist=$(echo "$artist" | cut -c1-$artist_offset)
     artist="$artist..."
   fi
  fi

  if [ ${#title} -gt $title_offset ]; then
    title=$(echo "$title" | cut -c1-$title_offset)
    title="$title..."
  fi
  
  if [ -n "$artist" ]; then
    echo "$artist - $title"
  else
    echo "$title"
  fi
fi

exit 0
