#!/bin/sh

_term() {
  echo "Caught SIGTERM signal!"
}

trap _term SIGTERM

echo "Killing sh..."
killall sh
echo "Killing python..."
killall python
echo "Entering bootloader mode..."
./bootloader.py
echo "Programming..."

until lpc21isp $1 /dev/ttyS0 115200 12000
do
    echo "Retrying in 5..."
    sleep 5
done
