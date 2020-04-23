# Slurm Installation  In CentOS ENV
export MUNGEUSER=1000
export SLURMUSER=1001
groupadd -g $MUNGEUSER munge
useradd  -m -c "MUNGE Uid 'N' Gid Emporium" -d /var/lib/munge -u $MUNGEUSER -g munge  -s /sbin/nologin munge
groupadd -g $SLURMUSER slurm
useradd  -m -c "SLURM workload manager" -d /var/lib/slurm -u $SLURMUSER -g slurm  -s /bin/bash slurm


yum install munge munge-libs munge-devel -y
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
chown slurm: /var/run/slurm
chown -R slurm: /var/spool/slurm
chown slurm: /var/log/slurm


