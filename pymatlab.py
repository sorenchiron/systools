#!/bin/python3
from time import sleep
def welcome():
	banner="""MATLAB is selecting SOFTWARE OPENGL rendering.

                            < M A T L A B (R) >
                  Copyright 1984-2016 The MathWorks, Inc.
                   R2016b (9.1.0.441655) 64-bit (glnxa64)
                             September 7, 2016


To get started, type one of these: helpwin, helpdesk, or demo.
For product information, visit www.mathworks.com."""
	print(banner)

def repl():
	linecount=0
	line='ENV="MATLAB"'
	while line.strip() not in ['quit','exit']:	
		ret=None
		if '=' in line:
			ret=exec(line)
		else:
			ret=eval(line)
			print(ret)
		linecount+=1
		line=input('>>')


if __name__ == '__main__':
        sleep(1.5)
        welcome()
        sleep(1)
        repl()
