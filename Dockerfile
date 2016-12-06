FROM phusion/baseimage:0.9.19
MAINTAINER WangYan <i@wangyan.org>

RUN mkdir -p /opt/seafile
WORKDIR /opt/seafile

RUN apt-get -y update && apt-get -y install wget apparmor\
    sudo pwgen net-tools mysql-client libmysqlclient-dev \
    python2.7 libpython2.7 python-setuptools python-imaging \
    python-ldap python-mysqldb python-memcache python-urllib3

# Seafile Config
RUN wget https://raw.githubusercontent.com/Guochengjie/ubuntu-ssh/master/seafile_ubuntu%206.0.2
RUN chmod +x seafile*
RUN ./seafile*

# Expose Ports
EXPOSE 8082
EXPOSE 80
EXPOSE 443
EXPOSE 8000
EXPOSE 11211

# APT Clean
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ./nginx_signing.key

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/sbin/my_init"]
