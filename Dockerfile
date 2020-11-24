FROM registry.access.redhat.com/ubi8/ubi:8.0
MAINTAINER Red Hat Training <training@redhat.com>
ENV DOCROOT=/tmp/src
RUN yum install -y python3 python3-pip && \
    pip3 install --upgrade pip && \
    pip3 install --upgrade virtualenv && \
    yum clean all && \
    mkdir $DOCROOT && \
    cd $DOCROOT && \
    virtualenv my_env_total -p python3 && \
    source /tmp/src/my_env_total/bin/activate && \
    pip install --use-feature=2020-resolver --upgrade flask PyMySQL psycopg2-binary
    chgrp -R 0 $DOCROOT && \
    chmod -R g=u $DOCROOT
COPY app.py $DOCROOT
# This stuff is needed to ensure a clean start
LABEL io.openshift.expose-services="8080:http"
LABEL io.k8s.description="A basic Apache HTTP Server child image, uses ONBUILD" \
      io.k8s.display-name="Apache HTTP Server" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="apache, httpd"
EXPOSE 8080
USER 1001
# Launch httpd
WORDIR $DOCROOT
ENTRYPOINT ['python3']
CMD ['app.py']
