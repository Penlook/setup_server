#!/bin/bash
yum install -y erlang
sudo rpm --import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
sudo yum install rabbitmq-server--1.noarch.rpm
git clone git://github.com/joemiller/joemiller.me-intro-to-sensu.git
cd joemiller.me-intro-to-sensu/
./ssl_certs.sh clean
./ssl_certs.sh generate
mkdir /etc/rabbitmq/ssl
cp server_key.pem /etc/rabbitmq/ssl/
cp server_cert.pem /etc/rabbitmq/ssl/
cp testca/cacert.pem /etc/rabbitmq/ssl/
[
    {rabbit, [
    {ssl_listeners, [5671]},
    {ssl_options, [{cacertfile,"/etc/rabbitmq/ssl/cacert.pem"},
                   {certfile,"/etc/rabbitmq/ssl/server_cert.pem"},
                   {keyfile,"/etc/rabbitmq/ssl/server_key.pem"},
                   {verify,verify_peer},
                   {fail_if_no_peer_cert,true}]}
  ]}
].
rabbitmq-plugins enable rabbitmq_management
/sbin/chkconfig rabbitmq-server on
/etc/init.d/rabbitmq-server start
rabbitmqctl add_vhost /penlook
rabbitmqctl add_user penlook penlook
rabbitmqctl set_permissions -p /penlook penlook ".*" ".*" ".*"
