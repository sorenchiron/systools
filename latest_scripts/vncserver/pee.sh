#!/bin/sh
vnc_tools_path=/usr/local/vncserver
name=`whoami`
uid_raw=`cat /etc/passwd | grep ${name}`
echo `vncserver -list`
echo 'if there is vncprocess running, please stop them first'
echo 'to halt this program, please press Ctrl+C'
echo 'press anykey to continue'
read anykey

if [ -f ~/.Xauthority ]
then
echo '~/.Xauthority exists...pass'
else
touch ~/.Xauthority
fi

if [ -d ~/.vnc ]
then
echo 'vnc exists...pass'
rm ~/.vnc/localhost*
rm ~/.vnc/passwd
else
mkdir ~/.vnc
cp ${vnc_tools_path}/xstartup ~/.vnc/
fi

if [ -f ~/.Xresources ]
then
echo 'Xresources exists...pass'
else
cp ${vnc_tools_path}/.Xresources ~/
fi

uid=`python3 ${vnc_tools_path}/vnc_gen.py uid "${uid_raw}"`
vnc_port=5900
let "vnc_port+=uid"

echo "your uid-offset is ${uid}"
echo '...'
echo '...'
echo '...'
echo '==========Please Notice=========='
echo 'If this is the first time you run this guide'
echo 'Please remember the following commands'
echo 'You may need to use them some day.'
echo "[1]run this only once >pee"
echo "[2]then, setup your VNC-login password"
echo "[3]to close vnc />systemctl stop vncserver@:${uid}.service"
echo "[4]to start vnc />systemctl start vncserver@:${uid}.service"
echo "[5]to see your private vnc-port, run />vncserver -list"
echo "[6]use 5900+YourPort as vnc address, like 10.214.164.248:5905"
echo '================================='

vnc_profile_name="vncserver@:${uid}.service"

vnc_profiles_path=/etc/systemd/system

if [ -f ${vnc_profiles_path}/${vnc_profile_name} ]
then
	echo "WARNING: ${vnc_profile_name} already exists!"
	echo "removing them..."
	sudo rm ${vnc_profiles_path}/${vnc_profile_name}
fi
python3 ${vnc_tools_path}/vnc_gen.py vncserver ${name} >~/.vnc/tmp
sudo cp ~/.vnc/tmp ${vnc_profiles_path}/${vnc_profile_name}
rm ~/.vnc/tmp

echo 'setting up...'

vncserver ":${uid}"
vncserver -kill ":${uid}"
sudo systemctl start "vncserver@:${uid}.service"

echo 'Territory Marked!'
echo 'Nice pee.'


