#!/bin/bash
#echo all params are $@
#echo username is `whoami`
blockname=sychen
if [ `whoami` != $blockname ]
then
	matlab $@
else
	echo entering pseudo matlab mode
fi	
