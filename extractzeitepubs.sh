#!/bin/sh
#
# Generate a folder with rss feed from mails with attachments.
#
# Optimized for the online abo of the german newspaper Die Zeit.
#

tmp_dir='/tmp/extractzeitepubs'

# The maildir folder contianing the mailings from zeit.de.
source_dir='/home/YOURUSERNAME/Maildir/.INBOX.presse.zeit/cur'

# A folder accessible for your webserver.
target_dir='/home/YOURUSERNAME/public_html/.diezeit/'

# It is recommended to use some kind of authentication for the rss feed,
# e.g. http basic auth. If you use http basic auth you should add a URL with
# credentials to the feed.
target_url='https://YOURDOMAIN/.diezeit/'
target_url='https://YOURUSERNAME:YOURPASSWORD@YOURDOMAIN/.diezeit/'



[ "$(ls -A $source_dir)" ] || exit 0

mkdir $tmp_dir

for i in `ls $source_dir` ; do
	`dirname $0`/mimedecode.pl $source_dir/$i $tmp_dir
	rm $source_dir/$i
done

mv $tmp_dir/*.epub $target_dir
rm -R $tmp_dir

`dirname $0`/genrssfeed.sh $target_dir $target_url > $target_dir/rss.xml
