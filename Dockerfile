FROM fluent/fluentd-kubernetes-daemonset:elasticsearch
MAINTAINER Timothy Clarke <ghtimothy@timothy.fromnz.net>

WORKDIR /home/fluent

RUN set -ex \
    && apk add --no-cache --virtual .build-deps \
        build-base \
        ruby-dev \
        libffi-dev \
        && gem uninstall remote_syslog_logger \
        && gem install fluent-plugin-concat fluent-plugin-kubernetes_remote_syslog fluent-plugin-logzio remote_syslog_sender \
        && sed 's/type/@type/g' -i /fluentd/etc/kubernetes.conf \
        && sed 's/RemoteSyslogLogger/RemoteSyslogSender/g' -i /usr/lib/ruby/gems/2.3.0/gems/fluent-plugin-kubernetes_remote_syslog-0.3.5/lib/fluent/plugin/out_kubernetes_remote_syslog.rb \
        && apk del .build-deps \
        && gem sources --clear-all \
        && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem
