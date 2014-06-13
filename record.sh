#!/bin/bash
#usage: sudo /home/pi/Desktop/record.sh [n] 2>&1 |tee -a /var/www/recordings/recorder_sh_log.txt
#[n] is the ID of the radio program (first argument of the script)

function record {
echo $(date +"%F") $(date +"%T") "Setting date variables..."
# Set the date stuff
mydate=$(date +"%F")
mytime=$(date +"%T")
myyear=$(date +"%Y")

echo $(date +"%F") $(date +"%T") "Erasing temporary files..."
echo $(rm $tempfolder/*.* -f)

echo $(date +"%F") $(date +"%T") "Will begin recording now."

# If it's Plog, record using filenames. Else, record a single file
if [ $files == 1 ]; then
echo "Recording by files..."
streamripper "$url" -d "$tempfolder" -s -u "WinampMPEG/5.0" -l 1800
movetemp
else
echo "No files for you, sucker!"
streamripper "$url" -u "WinampMPEG/5.0" -a -A -d "$tempfolder" -s -l "$proglen" -i
fi
}


function movetemp() {
#Relocates temporary files
echo $(date +"%F") $(date +"%T") "Relocating temporary files."
rm $tempfolder/*.cue -f
mv $tempfolder/*.* $dest
}

#SetFolders
dirRecords=/var/www/recordings
#dirRecords=/home/pi/recordings
tempfolder=$dirRecords/Temp
logfile=$dirRecords/record_log.txt

echo $(date +"%F") $(date +"%T") "Setting a stream..."

case $1 in
1) # Cultura general (1)
proglen=1800
url="http://959Camarafm.serverroom.us/;stream.nsv"
dest=$dirRecords/CulturaGeneral
title="Cultura General"
stid=1
station="Cámara FM"
files=0
record
;;
2) # La otra historia (2)
proglen=3600
url="http://streaming.radiobolivarianavirtual.com:7630/;stream.nsv"
dest=$dirRecords/OtraHistoria
title="La Otra Historia"
station="Radio Bolivariana"
stid=2
files=0
record
;;
3) # Plog (3)
proglen=3600
url="http://95.81.146.2/3267/coke-colombia/coke-colombia.mp3"
dest=$dirRecords/CocaCola
title="Plog"
station="Coca-Cola FM"
stid=3
files=0
record
;;
4) # Notas de jazz (4)
proglen=3570
url="http://959Camarafm.serverroom.us/;stream.nsv"
dest=$dirRecords/NotasdeJazz
title="Notas de Jazz"
stid=1
station="Cámara FM"
files=0
record
;;
esac


#Set Tags
echo $(date +"%F") $(date +"%T") "Recording finished. Setting ID3 tags..."

lastmp3=$(ls -c $tempfolder/*.mp3 | head -1)

id3v2 --id3v1-only --song "$title ($mydate)" --artist "$station" --album "$title" --year "$myyear" "$lastmp3"

movetemp

echo $(date +"%F") $(date +"%T") "All done."

#Log
echo $(date +"%F") $(date +"%T") $title $station >> $logfile

#Insert into database
mysql --user=root --password=delekt06 recordings --execute "INSERT INTO recordings.recordings (id, filename, programme, station, folder, date, time, comments) VALUES (NULL, '$lastmp3', '$1', '$stid', '$dest', '$mydate', '$mytime', '');"

#MailNotification

datenow=$(date +"%F")
timenow=$(date +"%T")

#PATH=/bin:/usr/bin:/sbin:/usr/sbin

RECIPIENTNAME="Lucas"
RECIPIENTADDR=delectomorfo@gmail.com
SENDER="\"Your Raspberry Pi\" <lucas@delectomorfo.com>"

python /home/pi/scripts/sendmail.py %datenow% %timenow% > /dev/null


#TMPFILE=`mktemp`
#echo "To: \"$RECIPIENTNAME\" $RECIPIENTADDR" > $TMPFILE
#echo "From: $SENDER" >> $TMPFILE
#echo "Subject: \"Recording of $title finished at $datenow, $timenow\"" >> $TMPFILE
#nm-tool >> $TMPFILE
#cat $TMPFILE  | ssmtp $RECIPIENTADDR
#rm $TMPFILE


:<<'END'


(
echo "From: lucas@delectomorfo.com "
echo "To: delectomorfo@gmail.com "
echo "MIME-Version: 1.0"
echo "Content-Type: multipart/alternative; " 
echo ' boundary="delectomorfo.com"' 
echo "Subject: Recording of $title finished at $datenow, $timenow" 
echo "" 
echo "This is a MIME-encapsulated message" 
echo "" 
echo "--delectomorfo.com" 
echo "Content-Type: text/html" 
echo "" 
echo "<html> 
<head>
<title>HTML E-mail</title>
</head>
<body>
Yay! I have finished recording <b>$title</b> by <b>$station</b> at <b> $datenow, $timenow</b>.<br />Here's a link to <a href=\"http://192.168.0.80/recordings/\">the server.</a>
</body>
</html>"
echo "--delectomorfo.com"
) | sendmail -t

END

echo "Mail sent."

#old mailing info:

#body="Yay! I have finished recording <b>$title</b> by <b>$station</b> at <b> $datenow, $timenow</b>.<br />Here's a link to <a href=\"http://192.168.0.80/recordings/\">the server.</a>"
#subject="Recording of $title finished at $datenow, $timenow"
#email="delectomorfo@gmail.com"

#echo $body | mail -s $subject -a "Content-Type: text/html" $email

echo ---------------

exit
