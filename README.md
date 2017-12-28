# fluentd-kubernetes-daemonset
Container is based off the elastic search one, but with syslog bits added for papertrail
[Papertrail FluentD logger](https://help.papertrailapp.com/kb/configuration/configuring-centralized-logging-from-kubernetes/#fluentd)

```bash
$ sudo -u fluent gem install fluent-plugin-kubernetes_remote_syslog
```

Build with something like
```bash
$ docker build -t fluentd-es-pt:latest .
```

