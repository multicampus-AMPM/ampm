#!/usr/bin/env bash

# start FTP server as daemon
/usr/sbin/vsftpd /etc/vsftpd.conf &

# start FTP && MLflow tracking server
 mlflow server \
    --backend-store-uri sqlite:////mlflow/mlflow.db \
    --default-artifact-root ftp://mlflow:mlflow@model-repository/mlflow/artifacts \
    --host 0.0.0.0 \
    --port 5000