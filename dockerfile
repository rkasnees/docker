FROM centos:7

RUN yum update -y

RUN yum install -y openssh-server

RUN yum install -y openssh-clients

RUN yum install -y epel-release

RUN yum install -y ansible

RUN adduser test
 
RUN echo 'test:test' |chpasswd

RUN usermod -aG wheel test

RUN /usr/bin/ssh-keygen -A

RUN mkdir /var/run/sshd

RUN echo 'root:test' | chpasswd

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
