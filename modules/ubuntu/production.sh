# Production server

function install {
	sudo chmod +x ./modules/$1.sh
	./modules/$1.sh
}

install tools
install gcc
install go
install python
install php
install nginx
