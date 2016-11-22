#!/bin/bash
BASEDIR=chpw.tmp
IDPWFILE=idpw.txt
SERVERLIST=list.txt
USER=`who am i | awk '{print $1}'`
mkdir ./${BASEDIR}
echo "please input id:passwd ;example user:aa12#zdad"
read IDPW
echo $IDPW > ./${BASEDIR}/${IDPWFILE}
echo "please input server list "
#touch ./${BASEDIR}/${SERVERLIST}
> ./${BASEDIR}/${SERVERLIST}
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

for i in `cat ./${BASEDIR}/${SERVERLIST}` 
do 
scp ./${BASEDIR}/${IDPWFILE} ${USER}@${i}:/tmp
ssh ${USER}@${i} -t "sudo chpasswd < /tmp/${IDPWFILE}"
ssh ${USER}@${i} -t "sudo rm -f /tmp/${IDPWFILE}"
done

