#!/bin/bash
sudo pear channel-discover pear.phpunit.de

sudo pear channel-discover pear.symfony-project.com

sudo pear channel-discover pear.symfony.com

sudo pear channel-discover components.ez.no

sudo pear install --alldeps phpunit/PHPUnit
