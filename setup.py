#!/usr/bin/env python
git = 'https://github.com/Penlook/setup_server/archive/development.zip'
folder_name = 'server-development'
database_folder = 'database-manager'

modules = [
    'tools', 
    'node', 
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
    'nginx', #ok v
    'app',
    'freemem',
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
    'package': path.realpath(tmp)+ '/' + folder_name,
    'module': path.realpath(tmp)+'/'+ folder_name +'/modules',
    'config': path.realpath(tmp)+'/' + folder_name + '/config',
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
        'cp -r '+res('db.conf') + ' /etc/nginx/conf.d/db.conf'
    ],
    'phalcon': [
        'cp -r '+res('phalcon.ini') + ' /etc/php.d/phalcon.ini'
    ],
    'proftpd': [
        'cp -r '+res('proftpd.conf') + ' /etc/proftpd.conf', 
        "sed -i 's,\r,,;s, *$,,' /etc/proftpd.conf", 
        'setenforce 0',
        'useradd '+ftp['username'], 
        'echo "'+ftp['username']+':'+ftp['password']+'" | chpasswd',
        'chown '+ftp['username']+':'+ftp['username']+' '+paths['host']+'/'+app['app']+' -R ',
    ], 
    'mongo':[
        'cp -r '+res('mongo.ini') + ' /etc/php.d/mongo.ini'
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
    run('wget '+git+' -O ' + folder_name + '.zip')
    run('rm -rf ./' + folder_name)
    run('unzip ./' + folder_name)
    run('rm -rf ' + folder_name + '.zip')
    run('cp -r '+res('mongo.repo')+' /etc/yum.repos.d/mongodb.repo')
    run('chmod +x ./' + folder_name + '/modules/*')
    run('rm -rf /var/www/' + database_folder)
    run('cp -r ./' + folder_name + '/' + database_folder + ' /var/www/' + database_folder)



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
    run('rm -rf '+tmp+'/' + folder_name)

main()
