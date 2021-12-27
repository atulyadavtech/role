yum install xauth
cp /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r).bak.$(date +%m-%d-%H%M%S).img
yum install chronyd

hostname -A;hostname -d;hostname -f;hostname -i;hostname -I

chmod +x /etc/rc.d/rc.local



wget https://raw.githubusercontent.com/atulyadavtech/ganana/master/limits.conf -O /etc/security/limits.conf
wget https://raw.githubusercontent.com/atulyadavtech/Conf-Files/master/history-sh -O /etc/profile.d/altair.sh
wget https://raw.githubusercontent.com/atulyadavtech/help/master/ssh.sh -O /etc/profile.d/ssh.sh
wget https://raw.githubusercontent.com/atulyadavtech/help/master/ssh.csh -O /etc/profile.d/ssh.csh


cat >/etc/yum.repos.d/altair.repo<< EOF
[BaseOS]
name=rhel8.3-media1-BOS
baseurl=file:///dump/rhel8.3/media1/BaseOS
enabled=1
gpgcheck=0

[AppStream]
name=rhel8.3-media1-AS
baseurl=file:///dump/rhel8.3/media1/AppStream
enabled=1
gpgcheck=0
EOF

## Routing Enabled & Dsiable IPV6 
cat >/usr/lib/sysctl.d/51-default.conf<< EOF
net.ipv4.ip_forward = 1
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
EOF

/etc/ssh/sshd_config
UseDNS no
AddressFamily inet
X11Forwarding yes
X11UseLocalhost no


yum install network-scripts -y

echo "NM_CONTROLLED=no" >> /etc/sysconfig/network-scripts/ifcfg-ens*

#########X11 Enviorment
echo "X11UseLocalhost no" >> /etc/ssh/sshd_config
echo "AddressFamily inet" >> /etc/ssh/sshd_config
systemctl restart sshd



## Altair Enviorment 
source /etc/pbsworks-pa.conf
export PATH=$PATH:/data/usr/local/altair/licensing14.5/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/data/usr/local/altair/licensing14.5/bin


useradd pbsdata
