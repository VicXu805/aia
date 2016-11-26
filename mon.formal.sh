#/bin/bash
# this script is used to generate mon configuration for aia vitality acount
# example :  mon.formal.sh hkgavpllvw010 172.26.132.101 443 172.26.132.114
if [ $# != 4 ];
then
echo "please use $0 servername ip port vip"
exit
else
SERVER=$1
IPADDR=$2
PORT=$3
VIP=$4
echo "hostgroup   $SERVER   $IPADDR"
echo "watch $SERVER"
echo "  service tcp${PORT}"
echo "       interval 5s"
echo "       monitor telnet.monitor -p ${PORT} -l \/\/"
echo "       period wd {Sun-Sat}"
echo "           alert lvs.alert -P tcp -V ${VIP}:${PORT} -R ${IPADDR} -W 1 -F g"
echo "           upalert lvs.alert -P tcp -V ${VIP}:${PORT} -R ${IPADDR} -W 1 -F g"
echo "       period LOGFILE: wd {Sun-Sat}"
echo "           alert file.alert -d /var/log/mon mon.log"
fi
