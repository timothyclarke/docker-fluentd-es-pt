# Kubernetes chart for customized fluentd config

While there are plenty of fluent charts at [Kubernetes/charts](https://github.com/kubernetes/charts)
They all have their own different uses. This one is primarily an example

## Introduction

This chart deploys [Fluentd](https://www.fluentd.org/) with support for an [ELK stack](https://www.elastic.co/webinars/introduction-elk-stack) eg [logz.io](https://logz.io/) and/or a [Syslog server](https://tools.ietf.org/html/rfc5424) eg [Papertrail](https://papertrailapp.com/)


## Prerequisites

- Kubernetes 1.4+ with Beta APIs enabled

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm install --name my-release .
```

The command deploys a the fluent daemonset on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.
Please note the default install probably won't do much as the defaults do not emit logs


> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the Fluent chart and their default values.
Note most of this works heavily into the [ConfigMap](#configmap)

| Parameter                      | Description                                  | Default                                         |
| -------------------------------| ---------------------------------------------| ------------------------------------------------|
| `image`                        | Fluentd daemon image                         | `timothyclarke/docker-fluentd-es-pt:{VERSION}`  |
| `imagePullPolicy`              | Image pull policy                            | `IfNotPresent`                                  |
| `<podtype>`                    | App type, eg ingress, wordpress, catchall    | `{}`                                            |
| `<podtype>.enabled`            | Should logging from a pod type be enabled    | `false`                                         |
| `<podtype>.<subtype>`          | Log provider type eg elastic, syslog         | `{}`                                            |
| `<podtype>.<subtype>.<key>`    | Config key for above, eg host, api token etc | `{}`                                            |


While you could specify the above on the command like, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
$ helm install --name my-release -f values.yaml .
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## ConfigMap
Most of the config is driven through the config maps. I've split into 4 parts.
The first two should be edited. The last two are probably best left as is.
* filters.conf - Place where some customised filters and tags are added.
* destinations.conf - Using the copy plugin from kubernetes we have the ability to send the same logs to multiple destinations,
* fluent.conf - The main config file. This one just includes the other files
* kubernetes.conf - Stock / Standard file which tails the logs and adds some tags

Note through the destinatons.conf I have switched to TCP logging
