#!/usr/bin/env python
# +--------------------------------------------------------------------------+
# | Penlook Project                                                          |
# +--------------------------------------------------------------------------+
# | Copyright (c) 2015 Penlook Development Team                              |
# +--------------------------------------------------------------------------+
# |                                                                          |
# | This program is free software: you can redistribute it and/or modify     |
# | it under the terms of the GNU Affero General Public License as           |
# | published by the Free Software Foundation, either version 3 of the       |
# | License, or (at your option) any later version.                          |
# |                                                                          |
# | This program is distributed in the hope that it will be useful, but	     |
# | WITHOUT ANY WARRANTY; without even the implied warranty of               |
# | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            |
# | GNU Affero General Public License for more details.                      |
# |                                                                          |
# | You should have received a copy of the GNU Affero General Public License |
# | along with this program.  If not, see <http://www.gnu.org/licenses/>.    |
# |                                                                          |
# +--------------------------------------------------------------------------+
# |   Author: Loi Nguyen  <loint@penlook.com>                                |
# +--------------------------------------------------------------------------+


import os

# Execute bash command as root permission
# @param string cmd
def run(cmd):
	os.system("sudo " + cmd)

# Create empty file can be written
# @param string file
def mkfile(file):
	run("touch " + file)
	run("chmod a+w " + file)

# Create folder can be written
# @param string file
def mkdir(directory):
	run("mkdir -p " + directory)
	written(directory)

# Copy a file from target to destination
# Allow override without confirmation
# @param string target
# @param string destination
def copy(target, destination):
	run("cp -rf " + target + " " + destination)

# Delete file and directory
# @param string target
# @param string destination
def delete(target):
	run("rm -rf " + target)

# Move file or directory
# @param string target
# @param string destination
def move(target, destination):
	copy(target, destination)
	delete(target)

def runnable(target):
	run("chmod +x " + file)

def writable(target):
	run("chmod a+w " + target + " -R")

