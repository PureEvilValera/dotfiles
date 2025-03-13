

artist_offset=25
title_offset=40

artist=$(playerctl metadata artist)
title=$(playerctl metadata title)

if [ ${#title} != 0 ]
then
	if [ ${#artist} -gt $artist_offset ]
	then
		artist=$(echo $artist | cut -c1-$artist_offset)
		artist=$(echo $artist'...')
	fi
	if [ ${#title} -gt $title_offset ]
	then
		title=$(echo $title | cut -c1-$title_offset)
		title=$(echo $title'...')
	fi
	echo $artist - $title
fi
