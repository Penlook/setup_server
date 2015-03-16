# Database server

function install {
	sudo chmod +x ./modules/$1.sh
	./modules/$1.sh
}

install tools
install gcc
install redis
install mongo
install mysql
