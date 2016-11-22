#!/bin/bash
BASEDIR=chpw.tmp
IDPWFILE=idpw.txt
SERVERLIST=list.txt
mkdir ./${BASEDIR}
echo "please input id:passwd ;example user:aa12#zdad"
read IDPW
echo $IDPW > ./${BASEDIR}/${IDPWFILE}
echo "please input server list "
vim ./${BASEDIR}/${SERVERLIST}
if [ -f ./${BASEDIR}/${IDPWFILE} ] ;then
ID=$(cat ./${BASEDIR}/${IDPWFILE} |awk -F ':' '{print $1}')
PW=$(cat ./${BASEDIR}/${IDPWFILE} |awk -F ':' '{print $2}')
echo "ID is : $ID"
echo "password is : $PW"
echo "============="
else 
echo "error : id and password doesn't exist"
exit
fi
if [ -f ./${BASEDIR}/${SERVERLIST} ] ;then
echo "server list is :"
cat ./${BASEDIR}/${SERVERLIST}
else
echo "error : server list doesn't exist "
exit
fi
