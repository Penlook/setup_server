# Development server

function install {
	sudo chmod +x ./modules/$1.sh
	./modules/$1.sh
}

install tools
install gcc
install go
install python
install redis
install mongo
install mysql
install php
install nginx
install phpunit
install phalcon
install zephir
