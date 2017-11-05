#!/bin/bash
current_uid=`tail -n 1 /etc/passwd | awk -F ':' '{print $3}'`
let 'nextid=current_uid+1'
echo $nextid
