hostname --domain;hostname --short;hostname --fqdn;hostname --ip-address
# Slurm Installation  In CentOS ENV
#Delete the first user
export MUNGEUSER=1000
export SLURMUSER=1001
groupadd -g $MUNGEUSER munge
useradd  -m -c "MUNGE Uid 'N' Gid Emporium" -d /var/lib/munge -u $MUNGEUSER -g munge  -s /sbin/nologin munge
groupadd -g $SLURMUSER slurm
useradd  -m -c "SLURM workload manager" -d /var/lib/slurm -u $SLURMUSER -g slurm  -s /bin/bash slurm


yum install -y python3 readline-devel pam-devel perl-ExtUtils-MakeMaker
yum install munge munge-libs munge-devel -y
/usr/sbin/create-munge-key -r
dd if=/dev/urandom bs=1 count=1024 > /etc/munge/munge.key
chown munge: /etc/munge/munge.key
chmod 400 /etc/munge/munge.key
chown -R munge: /etc/munge/ /var/log/munge/
chmod 0700 /etc/munge/ /var/log/munge/
systemctl enable munge

yum install mariadb-server mariadb-devel -y
systemctl enable mariadb.service
systemctl start mariadb.service

mysql -u root
create database slurm_acct_db;
create user 'slurm'@'localhost';
set password for 'slurm'@'localhost' = password('slurmdbpass');
grant usage on *.* to 'slurm'@'localhost';
grant all privileges on slurm_acct_db.* to 'slurm'@'localhost';
flush privileges;
exit

Plugin Dir= /usr/lib64/slurm/


mkdir -p /var/log/slurm
mkdir -p /var/run/slurm
mkdir -p /var/spool/slurm/d
mkdir -p /var/spool/slurm/ctld

chown slurm: /var/run/slurm
chown -R slurm: /var/spool/slurm
chown slurm: /var/log/slurm


/usr/lib/systemd/system/slurmd.service 
/usr/lib/systemd/system/slurmctld.service




##https://github.com/OleHolmNielsen/Slurm_tools
##https://github.com/accre/SLURM
https://github.com/SchedMD/slurm-gcp/blob/master/etc/slurmdbd.conf.tpl
https://github.com/SchedMD/slurm-gcp/blob/master/etc/slurm.conf.tpl
