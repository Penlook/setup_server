#!/usr/bin/env python

from os import system
from sys import *

if len(argv) >= 2:
    pass
else:
    print 'stop | start | restart | status'
    exit()

status = argv[1]

services = [
    'php-fpm',
    'nginx',
    'mongod',
    'redis',
    'mysql',
    #'memcached',
    #'varnish',
    #'haproxy',
    'proftpd'
]


def run(cmd):
    system(cmd)


# Pre-process
run('setenforce 0')

for service_name in services:
    cmd = 'service ' + service_name + ' ' + status
    run(cmd)