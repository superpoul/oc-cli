FROM centos:7
RUN yum -y install epel-release openssh-clients openssh-server
RUN yum -y install git python-pip java-1.8.0-openjdk
RUN echo "root:1q2w3e" | chpasswd
WORKDIR /root/
RUN pip install requests 'requests[security]'
RUN pip install -U setuptools
RUN pip install openshift
RUN ssh-keygen -A
RUN /usr/sbin/sshd
ENV PYTHONHTTPSVERIFY=0
ADD https://github.com/openshift/origin/releases/download/v3.9.0/openshift-origin-client-tools-v3.9.0-191fece-linux-64bit.tar.gz /root/
RUN tar -xzvf openshift-origin-client-tools-v3.9.0-191fece-linux-64bit.tar.gz
RUN cp /root/openshift-origin-client-tools-v3.9.0-191fece-linux-64bit/oc /usr/bin/
RUN git config --global http.sslVerify false
RUN oc login $OS_CLUSTER_URL --username=$OC_CLUSTER_LOGIN --password=$OC_CLUSTER_PASSWORD --insecure-skip-tls-verify=true
