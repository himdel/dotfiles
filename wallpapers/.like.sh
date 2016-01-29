#!/bin/bash
if [ "$#" -ge 1 ]; then
	file="$1"
else
	file=`cat ~/.fvwm/preferences/LastChoosenWallpaper | cut -d\' -f2`
fi
if ! [ -e "$file" ]; then
	echo "no files (can't detect wallpaper?)" 1>&2
	exit 1
fi

md5=`md5sum "$file" | awk '{ print $1 }'`
echo md5 = "$md5"

cd `dirname "$0"`
db='.likes.sqlite3'
if ! [ -f "$db" ]; then
	# create db
	(echo "CREATE TABLE [likes] ("
	 echo "    [md5] VARCHAR(32) NOT NULL,"
	 echo "    [likes] INTEGER NOT NULL DEFAULT 0,"
	 echo "    PRIMARY KEY ([md5])"
	 echo ");"
	) | sqlite3 "$db"
fi

echo -n 'likes = '
(echo 'INSERT OR IGNORE INTO [likes] ([md5]) VALUES ("'"$md5"'");'
 echo 'UPDATE [likes] SET likes = likes + 1 WHERE [md5] = "'"$md5"'";'
 echo 'SELECT [likes] FROM [likes] WHERE [md5] = "'"$md5"'";') | sqlite3 "$db"
