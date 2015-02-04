#!/bin/bash
sudo yum install -y erlang
sudo rpm --import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
sudo yum install rabbitmq-server--1.noarch.rpm
sudo git clone git://github.com/joemiller/joemiller.me-intro-to-sensu.git
cd joemiller.me-intro-to-sensu/
sudo ./ssl_certs.sh clean
sudo ./ssl_certs.sh generate
sudo mkdir /etc/rabbitmq/ssl
sudo cp server_key.pem /etc/rabbitmq/ssl/
sudo cp server_cert.pem /etc/rabbitmq/ssl/
sudo cp testca/cacert.pem /etc/rabbitmq/ssl/
cd /etc/rabbitmq/
sudo touch rabbitmq.config &&  sudo chmod a+w+x rabbitmq.config
echo "[
    {rabbit, [
    {ssl_listeners, [5671]},
    {ssl_options, [{cacertfile,"/etc/rabbitmq/ssl/cacert.pem"},
                   {certfile,"/etc/rabbitmq/ssl/server_cert.pem"},
                   {keyfile,"/etc/rabbitmq/ssl/server_key.pem"},
                   {verify,verify_peer},
                   {fail_if_no_peer_cert,true}]}
  ]}
]." >> rabbitmq.config
sudo rabbitmq-plugins enable rabbitmq_management
sudo /sbin/chkconfig rabbitmq-server on
sudo /etc/init.d/rabbitmq-server start
sudo rabbitmqctl add_vhost /penlook
sudo rabbitmqctl add_user penlook penlook
sudo rabbitmqctl set_permissions -p /penlook penlook ".*" ".*" ".*"
