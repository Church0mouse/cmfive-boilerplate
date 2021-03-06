#!/bin/bash

#setup for XDebug
	
if ping -c 1 host.docker.internal; then INTERNAL_HOST_IP=host.docker.internal; \
	else	if ping -c 1 docker.for.mac.localhost; then INTERNAL_HOST_IP=docker.for.mac.localhost; \
	else		if ping -c 1 docker.for.win.localhost; then INTERNAL_HOST_IP=docker.for.win.localhost; \
	else INTERNAL_HOST_IP=$(ip route show default | awk '/default/ {print $3}'); fi; fi; fi;
	
echo "zend_extension=xdebug.so" > /etc/php/7.2/fpm/conf.d/20-xdebug.ini \
	&& echo "[xdebug]" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini \
	&& echo "xdebug.remote_enable=1" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini \
	&& echo "xdebug.remote_host=${INTERNAL_HOST_IP}" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini \
	&& echo "xdebug.remote_connect_back=0" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini \
	&& echo "xdebug.remote_autostart=1" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini \
	&& echo "xdebug.remote_handler=dbgp" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini \
	&& echo "xdebug.max_nesting_level=250" >> /etc/php/7.2/fpm/conf.d/20-xdebug.ini 

	  
supervisord -n -c /etc/supervisord.conf
