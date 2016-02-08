#!/usr/bin/zsh
#
# Generates a rss file for a folder with epubs of the german newspaper Die Zeit.
#
# Usage
#   genrssfeed.sh <SOURCE_DIRECTORY> <PUBLIC_URL_FOR_DIRECTORY> > $target_dir/rss.xml

baseurl=$2
cd $1

echo '<?xml version="1.0" encoding="utf-8"?>'
echo '<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">'
echo '<channel>'
echo '	<atom:link href="'$baseurl'rss.xml" rel="self" type="application/rss+xml" />'
echo '	<title>Die Zeit E-Paper RSS-Feed</title>'
echo '	<link>https://premium.zeit.de/</link>'
echo '	<description />'

j=0
for i in `find . -type f -name "*.epub" -printf "%C@ %p\n" | sort -rn | head -n 15 | cut -d ' ' -f 2`
do ;
	j=`expr $j + 1`
	if [ $j -gt 15 ]
	then ;
		break
	fi

	echo "	<item>
		<title>Die Zeit "`echo $i | sed 's/.*-\([0-9]*\)-\([0-9]*\)..*/\1 \2/'`" E-Paper</title>
		<link>$baseurl$i</link>
		<guid>$baseurl$i.guid</guid>
		<pubDate>"`date -Rr $i`"</pubDate>
	</item>"
done

echo '</channel>'
echo '</rss>'
