from sys import argv
from string import Template
import re

vsftpd_service_template='''
[Unit]
Description=Remote desktop service (VNC)
After=syslog.target network.target

[Service]
Type=forking
# Clean any existing files in /tmp/.X11-unix environment
ExecStartPre=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'
ExecStart=/usr/sbin/runuser -l ${user} -c "/usr/bin/vncserver %i"
PIDFile=/home/${user}/.vnc/%H%i.pid
ExecStop=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'

[Install]
WantedBy=multi-user.target

'''

def extract_uid(uid_raw):
	res = re.search('(\d+)',uid_raw)
	if res is None:
		return
	uid = int(res.group()) - 1000
	print(uid)
	return

def make_vncserver_conf(username):
	print(Template(vsftpd_service_template).substitute(user=username))

if __name__ == '__main__':
	'''uid uidstring | vncserver uname'''
	if len(argv) != 3:
		exit(0)
	else:
		if argv[1]=='uid':
			extract_uid(argv[2])
		elif argv[1]=='vncserver':
			make_vncserver_conf(argv[2])

		
