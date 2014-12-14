#!/bin/bash

echo "Record..."
parec --file-format=flac --rate=16000 /tmp/speech.flac & sleep 5 && kill $!;

echo "Voice analysis..."
wget -q -U "Mozilla/5.0" --post-file /tmp/speech.flac --header="Content-Type: audio/x-flac; rate=16000" -O - "http://www.google.com/speech-api/v1/recognize?lang=ru-RU&client=chromium" > /tmp/speech.ret

cat /tmp/speech.ret | sed 's/.*utterance":"//' | sed 's/","confidence.*//' > /tmp/speech.txt

TEXT="$(cat /tmp/speech.txt)"

rm /tmp/speech.*

echo $TEXT

case "$TEXT" in
	"включить радио" ) audacious -t;;
	"выключить радио" ) audacious -t;;
	"дата" ) notify-send "$(/bin/date)";;
esac
