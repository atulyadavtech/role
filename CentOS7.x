#CentOS 7

##Run level Change 
systemctl get-default
systemctl set-default multi-user.target
systemctl get-default

chmod +x /etc/rc.d/rc.local

#Hostname Verfiycation 
hostnamectl status
hostname -A;hostname -d;hostname -f;hostname -i;hostname -I

#TimeZone Setup
timedatectl
timedatectl set-ntp yes


#Package Mangement
yum-config-manager --disable updates base extra

yum clean all
yum erase rdma -y
yum group install "Development Tools" "Compatibility Libraries" -y
yum install ntp lsscsi mlocate ipmitool nmap yum-plugin-changelog -y

systemctl mask firewalld;systemctl stop firewalld;yum -y install iptables-services;systemctl enable iptables;systemctl start iptables
sync
iptables --list;iptables --flush;iptables --delete-chain;service iptables save

systemctl enable rpcbind
systemctl enable nfs-lock
systemctl enable nfs-server
systemctl enable nfs-idmap

##disable unwanted service
systemctl disable cups bluetooth firewalld NetworkManager

## Disable Virtual Interface 
virsh net-undefine default;chkconfig libvirtd off;systemctl disable libvirtd.service

sed -i 's/=enforcing/=disabled/' /etc/selinux/config
sed -i -e 's/quiet/quiet net.ifnames=0 biosdevname=0/' /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg
echo "master1.local" > /etc/hostname

#Selinux Disabled
sed -i 's/=enforcing/=disabled/' /etc/selinux/config
echo 0 >/selinux/enforce


## Routing Enabled & Dsiable IPV6 
cat >/usr/lib/sysctl.d/51-default.conf<< EOF
net.ipv4.ip_forward = 1
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
EOF

#Network File 
mkdir /root/test
mv /etc/sysconfig/network-scripts/ifcfg-e* /root/test/
cat > /etc/sysconfig/network-scripts/ifcfg-eth0 << EOF
TYPE="Ethernet"
BOOTPROTO="dhcp"
DEFROUTE="yes"
PEERDNS="yes"
PEERROUTES="yes"
IPV4_FAILURE_FATAL="no"
IPV6INIT="yes"
IPV6_AUTOCONF="no"
IPV6_DEFROUTE="no"
IPV6_PEERDNS="no"
IPV6_PEERROUTES="no"
IPV6_FAILURE_FATAL="no"
IPV6_ADDR_GEN_MODE="stable-privacy"
NAME="eth0"
DEVICE="eth0"
ONBOOT="yes"
EOF


## File
wget https://raw.githubusercontent.com/atulyadavtech/ganana/master/limits.conf -O /etc/security/limits.conf

#Remove initial screen on CentOS 7
/etc/gdm/custom.conf
[daemon]
InitialSetupEnable=False



##SSH FineTunning
echo 'UseDNS no' >> /etc/ssh/sshd_config

## Time Update
/usr/sbin/ntpdate ntp.ucsd.edu
/sbin/hwclock --systohc
#sync your hardware clock with the system time
hwclock --systohc


#Grub Modification
sed -i -e 's/quiet/quiet net.ifnames=0 biosdevname=0/' /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg


#Build The New Intird Image
cp /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r).img.$(date +%m-%d-%H%M%S).bak;dracut -f -v
reboot
