#!/bin/bash
#usage:
#start with your awesome
while inotifywait -e create -e moved_to ~/.mail/{gmail,work}/inbox/new/; do
    notify-send -i /usr/share/icons/Humanity/status/48/dialog-info.svg "You've got a new mail."
    #on x230i, can't turn thinklight on, only off....bug?
    aplay -q ~/.mybashscripts/mail.wav
done
