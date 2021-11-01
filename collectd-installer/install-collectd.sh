#!/usr/bin/env bash

# to avoid to run this script multiple times
if [ "${MODE}" != 'install' ]
then
    echo "assuming installation already done"
    exit 0
fi

# install packages
yum -y install openssh-clients sshpass

# set the variables
if [ "${OS}" == "centos" ]
then
    PKG='yum -y install collectd collectd-smart'
    CONF='/etc/collectd.conf'
elif [ "${OS}" == "ubuntu" ]
then
    PKG='apt-get -y install collectd libatasmart-dev'
    CONF='/etc/collectd/collectd.conf'
else
    echo "No supported OS found : OS="${OS}
    exit 1
fi
COPYFILE='collectd.conf.'${OS}

# register the public key into the host machine
mkdir ~/.ssh
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa
mkdir /home/.ssh
cp -ra ~/.ssh/id_rsa.pub /home/.ssh/
mv /home/.ssh/id_rsa.pub /home/.ssh/authorized_keys
sshpass -p ${PASS} scp -o StrictHostKeyChecking=no -r /home/.ssh/ ${USER}@127.0.0.1:~/

# installation
if [ "${OS}" == "centos" ]
then
    ssh ${USER}@127.0.0.1 'echo '${PASS}' | sudo -S yum -y install epel-release'
    ssh ${USER}@127.0.0.1 'echo '${PASS}' | sudo -S yum repolist'
fi
ssh ${USER}@127.0.0.1 'echo '${PASS}' | sudo -S '${PKG}
sshpass -p ${PASS} scp -o StrictHostKeyChecking=no /home/${COPYFILE} ${USER}@127.0.0.1:~/${COPYFILE}
ssh ${USER}@127.0.0.1 'echo '${PASS}' | sudo -S mv -f ~/'${COPYFILE}' '${CONF}
ssh ${USER}@127.0.0.1 'echo '${PASS}' | sudo -S chown root:root '${CONF}
ssh ${USER}@127.0.0.1 'echo '${PASS}' | sudo -S systemctl enable collectd'
ssh ${USER}@127.0.0.1 'echo '${PASS}' | sudo -S systemctl restart collectd'
ssh ${USER}@127.0.0.1 'rm -rf ~/.ssh/authorized_keys'
