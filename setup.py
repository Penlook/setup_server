#!/usr/bin/env python
git = 'https://github.com/loint/setup/archive/master.zip'

modules = [
    'tools', #ok
    'node', #ok v
    'nginx', #ok v
    'memcached', #ok v
    'php', #ok v
    'phalcon', #ok v
    'zephir', #ok v
    'mongo', #ok v   
    'redis', #ok v
    'varnish', #ok v
    'haproxy', #ok v
    'proftpd', #ok v
    'less', #ok v
    'coffee', #ok v
    'phpunit',
    'mysql', #ok
    'app',
    'freemem',
    #phpunit, coffee - not yet,
]

app = {
    'app': 'sample'
}

ftp = {
    'username': 'sample',
    'password': '12345'
}

from os import *

tmp = path.abspath(curdir)

paths = {
    'package': path.realpath(tmp)+'/setup-master',
    'module': path.realpath(tmp)+'/setup-master/modules',
    'config': path.realpath(tmp)+'/setup-master/config',
    'host': '/home',
}

def res(file_name): 
    return paths['config'] + '/' + file_name

configs = {
    'php': [
        'cp -r '+res('php.ini') + ' /etc/php.ini',
        'rm -rf /etc/php.d/json.ini',
        'cp -r '+res('yaml.ini') + ' /etc/php.d/yaml.ini', 
    ],
    'nginx': [
        'cp -r '+res('nginx.conf') + ' /etc/nginx/nginx.conf',
        'cp -r '+res('nginx_default.conf') + ' /etc/nginx/conf.d/default.conf'
    ],
    'phalcon': [
        'cp -r '+res('phalcon.ini') + ' /etc/php.d/phalcon.ini'
    ],
    'vsftp': [
        'cp -r '+res('vsftpd.conf') + ' /etc/proftpd.conf', 
        "sed -i 's,\r,,;s, *$,,' /etc/proftpd.conf", 
        'setenforce 0',
        'useradd '+ftp['username'], 
        'echo "'+ftp['username']+':'+ftp['password']+'" | chpasswd',
        'chown '+ftp['username']+':'+ftp['username']+' '+paths['host']+'/'+app['app']+' -R ',
    ], 
    'redis':[
        'cp -r '+res('redis.ini') + ' /etc/php.d/redis.ini'
    ],
    'app': [
        'TMP=`pwd`',
        'rm -rf '+paths['host']+'/'+app['app'],
        'phalcon create-project '+app['app'],
        'chown '+ftp['username']+':'+ftp['username']+' '+app['app']+' -R',  
        'mv ./'+app['app']+' '+paths['host']+'/'+app['app'],
        'chmod -R a+w '+paths['host']+'/'+app['app']+'/app/cache',
        'cd $TMP',
    ],
}


def run(cmd):
    system(cmd)


def load():
    run('cd '+tmp)
    run('yum install -y unzip wget')
    run('wget '+git+' -O setup-master.zip')
    run('rm -rf ./setup-master')
    run('unzip ./setup-master.zip')
    run('rm -rf setup-master.zip')
    run('cp -r '+res('mongo.repo')+' /etc/yum.repos.d/mongodb.repo')
    run('chmod +x ./setup-master/modules/*')


def main():
    load()
    run('cd '+tmp)

    for module in modules:
        module_path = paths['module'] + '/' + module+'.sh'
        run('sh '+module_path)
        if module in configs.keys():
            for cmd in configs[module]:
                run(cmd)

    run('chmod +x '+paths['package'] + '/service.py')
    run('mv '+paths['package'] + '/service.py /usr/bin/app')
    run('rm -rf '+tmp+'/setup-master')

main()
