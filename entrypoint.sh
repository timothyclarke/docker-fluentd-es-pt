#!/bin/sh
# Use a config map in k8s to set the fluent.conf
set -e

exec fluentd -c /fluentd/etc/${FLUENTD_CONF} -p /fluentd/plugins --gemfile /fluentd/Gemfile ${FLUENTD_OPT}
