#/bin/bash
# this script is use to batch generate mon config file for aia 
# mon.formal.batch.sh -f filename
# the input file formal is: servername server_ip port virtual_ip
# example hkgavpllvw010 172.26.132.101 443 172.26.132.114
Oput_grp()
{
cat $FILENAME | while read PARA 
do
echo $PARA > ./tmp.para.txt
eval $(awk '{printf("var1=%s;var2=%s;var3=%s;var4=%s",$1,$2,$3,$4)}' < ./tmp.para.txt)
SERVER=$var1
IPADDR=$var2
PORT=$var3
VIP=$var4
echo "hostgroup   $SERVER   $IPADDR"
rm -f ./tmp.para.txt
done
}
Oput_wah()
{
cat $FILENAME | while read PARA 
do
echo $PARA > ./tmp.para.txt
eval $(awk '{printf("var1=%s;var2=%s;var3=%s;var4=%s",$1,$2,$3,$4)}' < ./tmp.para.txt)
SERVER=$var1
IPADDR=$var2
PORT=$var3
VIP=$var4
echo
echo "watch $SERVER"
echo "  service tcp${PORT}"
echo "       interval 5s"
echo "       monitor telnet.monitor -p ${PORT} -l \/\/"
echo "       period wd {Sun-Sat}"
echo "           alert lvs.alert -P tcp -V ${VIP}:${PORT} -R ${IPADDR} -W 1 -F g"
echo "           upalert lvs.alert -P tcp -V ${VIP}:${PORT} -R ${IPADDR} -W 1 -F g"
echo "       period LOGFILE: wd {Sun-Sat}"
echo "           alert file.alert -d /var/log/mon mon.log"
echo
rm -f ./tmp.para.txt
done
}

if [ $# != 2 ];
then
echo "please use $0 -f filename"
exit
else

while getopts f: OPT
do
 case $OPT in
 f)
 FILENAME=$OPTARG
 ;;
 ?)
 echo "please use $0 -f filename"
 ;;
 esac
done
fi

Oput_grp
Oput_wah
