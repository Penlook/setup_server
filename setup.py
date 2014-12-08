#!/usr/bin/env python
branch = 'master'
git = 'https://github.com/Penlook/setup_server/archive/' + branch + '.zip'
folder_name = 'server-' + branch
database_folder = 'database-manager'

modules = [
    'tools',
    'node',
    'memcached',
    'php',
    'phalcon',
    'zephir',
    'mongo',
    'redis',
    'varnish',
    'haproxy',
    'proftpd',
    'less',
    'coffee',
    'phpunit',
    'mysql',
    'nginx',
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

tmp = '/tmp'

paths = {
    'package': path.realpath(tmp)+ '/' + folder_name,
    'module': path.realpath(tmp)+'/'+ folder_name +'/modules',
    'config': path.realpath(tmp)+'/' + folder_name + '/config',
    'host': '/home',
}

def run(cmd):
    system(cmd)

def res(file_name):
    return paths['config'] + '/' + file_name

def copy(file, destination):
    return 'cp -r ' + file + ' ' + destination

def create(folder):
    return 'mkdir -p ' + folder

def delete(file):
    return 'rm -rf ' + file

def yum(names):
    return 'yum install -y ' + names

configs = {
    'php': [
        copy(res('php.ini'), '/etc/php.ini'),
        delete('/etc/php.d/json.ini'),
        copy(res('yaml.ini'), '/etc/php.d/yaml.ini')
    ],
    'nginx': [
        copy(res('nginx.conf'), '/etc/nginx/nginx.conf'),
        copy(res('nginx_default.conf'), '/etc/nginx/conf.d/default.conf')
    ],
    'phalcon': [
        copy(res('phalcon.ini'), '/etc/php.d/phalcon.ini')
    ],
    'proftpd': [
        copy(res('proftpd.conf'), '/etc/proftpd.conf'),
        "sed -i 's,\r,,;s, *$,,' /etc/proftpd.conf"
        'setenforce 0',
        'useradd ' + ftp['username'],
        'echo "' + ftp['username'] + ':' + ftp['password'] + '" | chpasswd',
        'chown ' + ftp['username'] + ':root ' + paths['host'] + '/' + app['app'] + ' -R ',
    ],
    'mongo':[
        copy(res('mongo.ini'), '/etc/php.d/mongo.ini')
    ],
    'redis':[
        copy(res('redis.ini'), '/etc/php.d/redis.ini')
    ],
    'app': [
        'TMP=`pwd`',
        delete(paths['host'] + '/' + app['app']),
        'phalcon create-project ' + app['app'],
        'chown ' + ftp['username'] + ':root ' + app['app'] + ' -R',
        'mv ./' + app['app'] + ' ' + paths['host'] + '/' + app['app'],
        'chmod -R a+w ' + paths['host'] + '/' + app['app'] + '/app/cache',
        'cd $TMP',
        copy(res('zep'), '/usr/bin/zep')
    ],
}


def load():
    run('cd ' + tmp)
    run(yum('unzip wget'))
    run('wget ' + git + ' -O ' + folder_name + '.zip')
    run(delete('./' + folder_name))
    run('unzip ./' + folder_name)
    run(delete(folder_name + '.zip'))
    run(copy(res('mongo.repo'), '/etc/yum.repos.d/mongodb.repo'))
    run('chmod +x ./' + folder_name + '/modules/*')
    run(delete('./' + database_folder))
    run(create('/var/www'))
    run(copy('./' + folder_name + '/' + database_folder, ' /var/www/' + database_folder))


def main():
    load()
    run('cd ' + tmp)

    for module in modules:
        module_path = paths['module'] + '/' + module + '.sh'
        run('sh '+module_path)
        if module in configs.keys():
            for cmd in configs[module]:
                run(cmd)

    run('chmod +x ' + paths['package'] + '/service.py')
    run('chmod +x ' + paths['module'] + '/freemem.sh')

    run('mv ' + paths['package'] + '/service.py /usr/bin/app')
    run('mv ' + paths['module'] + '/freemem.sh /usr/bin/clean')
    run('rm -rf '+ tmp + '/*')
    run('app start')

main()
