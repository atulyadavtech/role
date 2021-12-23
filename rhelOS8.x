yum install xauth
cp /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r).bak.$(date +%m-%d-%H%M%S).img
yum install chronyd
hostname -A;hostname -d;hostname -f;hostname -i;hostname -I
chmod +x /etc/rc.d/rc.local



[BaseOS]
name=rhel8.3-media1-BOS
baseurl=file:///rhel8.3/media1/BaseOS
enabled=1
gpgcheck=0


[AppStream]
name=rhel8.3-media1-AS
baseurl=file:///rhel8.3/media1/AppStream
enabled=1
gpgcheck=0


/etc/ssh/sshd_config
UseDNS no
AddressFamily inet
X11Forwarding yes
X11UseLocalhost no


yum install network-scripts -y

echo "NM_CONTROLLED=no" >> /etc/sysconfig/network-scripts/ifcfg-ens*
