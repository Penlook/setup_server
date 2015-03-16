#!/bin/bash
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
setup_main() {
	cd modules
	if  [ `type -t setup_$1`"" == 'function' ]
	then
		if [ ! -e $2 ]
		then
			#setup_$1 "${@:2}"
			setup_ubuntu "${@:2}"
		else
			setup_help
		fi
	else
		echo "Currently, Your OS is not supported !"
	fi
}

setup_koding() {
	if [ "$1" == "development" ]
	then
		sudo chmod +x ./koding.sh
		./koding.sh
	else
		echo "Mode $1 is not supported"
	fi
}

# Production mode
setup_ubuntu() {

	MODE_FILE="./ubuntu/$1.sh"

	if [ -f $MODE_FILE ]
	then
		sudo chmod +x $MODE_FILE
		$MODE_FILE "${@:1}"
		return
	fi

	echo "Mode $1 is not supported"
}

setup_help() {
	echo
	echo "Usage: penlook setup <type>"
	echo "Types:"
    echo
    echo "  development  Development Environment"
    echo "  production   Production Environment"
    echo "  database     Database Server"
    echo
}

setup_main $@

