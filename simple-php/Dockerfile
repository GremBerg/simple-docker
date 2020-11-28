FROM centos:7
MAINTAINER joseibh19@gmail.com
ENV DOCROOT=/var/www/html
RUN yum install -y --disableplugin=subscription-manager httpd php && \
    yum clean all --disableplugin=subscription-manager -y

# COPY src/ ${DOCROOT}/

# This stuff is needed to ensure a clean start
RUN rm -rf /run/httpd && mkdir /run/httpd

EXPOSE 8080

LABEL io.openshift.expose-services="8080:http"

LABEL io.k8s.description="A basic Apache HTTP and PHP Server child image, uses ONBUILD" \
      io.k8s.display-name="Apache HTTP and PHP Server" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="apache, httpd, php"

RUN sed -i "s/Listen 80/Listen 8080/g" /etc/httpd/conf/httpd.conf && \
    sed -E -i -e 's/DirectoryIndex (.*)$/DirectoryIndex index.php \1/g' /etc/httpd/conf/httpd.conf && \
    chgrp -R 0 /var/log/httpd /var/run/httpd && \
    chmod -R g=u /var/log/httpd /var/run/httpd

USER 1001
# Launch httpd
CMD /usr/sbin/httpd -DFOREGROUND
