FROM centos:centos7
LABEL maintainer="usapdevops <usapdevops@atmecs.com>"

ENV nginxversion="1.12.2-1" \
    os="centos" \
    osversion="7" \
    elversion="7_4"

RUN yum install -y wget openssl sed &&\
    yum -y autoremove &&\
    yum clean all &&\
    mkdir -p /usr/local/nginx/html/ &&\
    mkdir -p /var/log/nginx/ &&\
    mkdir -p /var/cache/nginx/ &&\
    mkdir -p /etc/nginx &&\
    chmod -R 777 /var/log/nginx /var/cache/nginx/ &&\
    chmod -R 644 /etc/nginx/ &&\
    wget http://nginx.org/packages/$os/$osversion/x86_64/RPMS/nginx-$nginxversion.el$elversion.ngx.x86_64.rpm &&\
    rpm -iv nginx-$nginxversion.el$elversion.ngx.x86_64.rpm &&\
    sed -i '1i\
    daemon off;\
    ' /etc/nginx/nginx.conf
COPY  lalapeden /usr/share/nginx/html/

CMD ["nginx"]