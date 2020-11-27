FROM centos:7
MAINTAINER ijoseibh19@gmail.com
ENV DOCROOT=/var/www/html
RUN yum install -y --disableplugin=subscription-manager httpd && \
    yum clean all --disableplugin=subscription-manager -y && \

# COPY src/ ${DOCROOT}/

# This stuff is needed to ensure a clean start
RUN rm -rf /run/httpd && mkdir /run/httpd

EXPOSE 8080

LABEL io.openshift.expose-services="8080:http"

LABEL io.k8s.description="A basic Apache HTTP Server child image, uses ONBUILD" \
      io.k8s.display-name="Apache HTTP Server" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="apache, httpd"

RUN sed -i "s/Listen 80/Listen 8080/g" /etc/httpd/conf/httpd.conf

RUN chgrp -R 0 /var/log/httpd /var/run/httpd && \
    chmod -R g=u /var/log/httpd /var/run/httpd

USER 1001
# Launch httpd
CMD /usr/sbin/httpd -DFOREGROUND
