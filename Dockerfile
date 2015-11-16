FROM docker.io/openshift/base-centos7:latest
MAINTAINER Udo Urbantschitsch udo@urbantschitsch.com

LABEL io.openshift.tags java,java18,kibana,kibana42
LABEL io.k8s.description Kibana Image
LABEL io.openshift.expose-services 5601/tcp:http

ENV KIBANA_HOME "/opt/kibana"


RUN cd $HOME \
    && echo $KIBANA_HOME \
    && yum update -y \
    && curl -O https://download.elastic.co/kibana/kibana/kibana-4.2.0-linux-x64.tar.gz \
    && tar xzf kibana-4.2.0-linux-x64.tar.gz \
    && mv -v kibana-4.2.0-linux-x64 $KIBANA_HOME \
    
    && yum clean all \
    && rm -f *.tar.gz \
    && chmod -R 777 /opt

COPY container-files /

ENV ELASTIC_CLUSTER localhost

EXPOSE 5601

RUN useradd elastic && chmod -R 777 /opt

USER elastic

ENTRYPOINT /docker-entrypoint.sh
