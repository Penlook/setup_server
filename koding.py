#!/usr/bin/env python
branch = 'koding'
git = 'https://github.com/penlook/server/archive/' + branch + '.zip'
folder_name = 'server-' + branch
database_folder = 'database-manager'

modules = [
    #'tools',
    #'node',
    #'php',
    #'ruby',
    #'java',
    #'go',
    #'python',
    #'memcached',
    #'phalcon',
    #'zephir',
    #'mongo',
    #'redis',
    #'varnish',
    #'haproxy',
    #'proftpd',
    #'phpunit',
    #'mysql',
    #'nginx',
    #'app',
    'ssh',
]

app = {
    'app': 'test'
}

account = {
    'username': 'test',
    'password': '123456789'
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

def move(file, destination):
    return 'mv ' + file + ' ' + destination

def create(folder):
    return 'mkdir -p ' + folder

def delete(file):
    return 'rm -rf ' + file

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
        "sed -i 's,\r,,;s, *$,,' /etc/proftpd.conf",
        'setenforce 0',
        'useradd ' + account['username'],
        'echo "' + account['username'] + ':' + account['password'] + '" | chpasswd',
        'chown ' + account['username'] + ':root ' + paths['host'] + '/' + app['app'] + ' -R ',
    ],
    'mongo':[
        copy(res('mongo.ini'), '/etc/php.d/mongo.ini'),
        delete('/var/lib/mongo/mongod.lock'),
        'pkill mongo',
        'sudo -u mongod mongod -f /etc/mongod.conf --repair'
    ],
    'redis':[
        copy(res('redis.ini'), '/etc/php.d/redis.ini')
    ],
    'app': [
        delete(paths['host'] + '/' + app['app']),
        'phalcon create-project ' + app['app'],
        'chown ' + account['username'] + ':root ' + app['app'] + ' -R',
        'mv ./' + app['app'] + ' ' + paths['host'] + '/' + app['app'],
        'chmod -R a+w ' + paths['host'] + '/' + app['app'] + '/app/cache',
    ],
    'ssh': [
        copy(res('sshd_config'), '/etc/ssh/sshd_config')
    ]
}

def load():
    chdir(tmp)
    run('wget ' + git + ' -O ' + folder_name + '.zip')
    run(delete('./' + folder_name))
    run('unzip ./' + folder_name)
    run(delete(folder_name + '.zip'))
    run('chmod +x ./' + folder_name + '/modules/*')
    run(delete('./' + database_folder))
    #run(create('/var/www'))
    #run(copy('./' + folder_name + '/' + database_folder, ' /var/www/' + database_folder))

def main():
    load()
    chdir(tmp)

    # Configuration for components
    for module in modules:
        module_path = paths['module'] + '/' + module + '.sh'
        run('sh '+module_path)
        if module in configs.keys():
            for cmd in configs[module]:
                run(cmd)

    # Clean up installer
    run(delete(tmp + '/*'))

main()
