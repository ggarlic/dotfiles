#!/bin/bash

LANG=en_US.UTF-8

TODAY=$(expr `date +'%d'` + 0)
MONTH=`date +'%m'`
YEAR=`date +'%Y'`

(
    echo '^bg(#121212)^fg(#80A673)'`date +'%A %d'` \
    # current month, hilight header and today
    cal | sed -re "s/^(.*[A-Za-z][A-Za-z]*.*)$/^fg(#B23308)^bg(#121212)\1/;s/(^|[ ])($TODAY)($|[ ])/\1^bg(#B23308)^fg(#121212)\2^fg(#F2EDD7)^bg(#121212)\3/"
    # next month, hilight header
    [ $MONTH -eq 12 ] && YEAR=`expr $YEAR + 1`
    cal `expr \( $MONTH + 1 \) % 12` $YEAR | sed -e 's/^\(.*[A-Za-z][A-Za-z]*.*\)$/^fg(#B23308)^bg(#121212)\1/'
    sleep 8
) | dzen2 -fg '#F2EDD7' -bg '#121212' -fn '-xos4-terminus-medium-*-*-*-14-*-*-*-*-*-iso8859-15' -xs 1 -x 1200 -y 15 -w 166 -l 16 -sa l -e 'button3=exit;onstart=uncollapse;'-

