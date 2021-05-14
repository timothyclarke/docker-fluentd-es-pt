FROM fluent/fluentd-kubernetes-daemonset:elasticsearch
MAINTAINER Timothy Clarke <ghtimothy@timothy.fromnz.net>

USER root
WORKDIR /fluentd
COPY --chown=0:0 entrypoint.sh /fluentd/entrypoint.sh

RUN set -ex \
    && apk add --no-cache --virtual .build-deps \
        build-base \
        ruby-dev \
        libffi-dev \
    && gem uninstall remote_syslog_logger \
    && gem install fluent-plugin-concat fluent-plugin-kubernetes_remote_syslog fluent-plugin-logzio remote_syslog_sender fluent-plugin-gelf-hs fluent-plugin-record-modifier \
    && sed 's#path /var/log/containers/\*.log#path /var/log/containers/\*.log\n  exclude_path ["/var/log/containers/\*luentd\*"]#g' -i /fluentd/etc/kubernetes.conf \
    && apk del .build-deps \
    && gem sources --clear-all \
    && chmod +x /fluentd/entrypoint.sh \
    && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

ENTRYPOINT ["/fluentd/entrypoint.sh"]
