FROM python:3.9-slim
COPY ./requirements.txt /home/
RUN apt-get update && apt-get install -y vsftpd && pip install --no-cache-dir --requirement /home/requirements.txt
RUN useradd -m -d /mlflow mlflow && echo 'mlflow:mlflow' | chpasswd && mkdir -p /mlflow/artifacts && chown -R mlflow:mlflow /mlflow && mkdir -p /var/share/empty
EXPOSE 21 21000-21010
COPY ./vsftpd.conf /etc/vsftpd.conf
COPY ./run-tracking-server.sh /home/
CMD ["bash", "/home/run-tracking-server.sh"]