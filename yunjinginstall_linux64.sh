#!/bin/bash
if [ `id -u` -ne 0 ];then 
     echo "Yunjing software must run as root. Please check your account"
     exit 0
fi
system_info=`uname -a`
Is64BitSystem=` echo $system_info | grep -c "x86_64" `
if [ $Is64BitSystem -le 0 ]; then
    echo "Your system is not 64-Bit. That Yunjing is not support yet."
    exit 0
fi
regist_server="chkconfig --add YDService"
init_d_path="/etc/rc.d/init.d"
service_script_name="YDService"
rc_local_path="/etc/rc.d/rc.local"  

if type systemctl >/dev/null 2>&1; then 
  init_d_path="/usr/lib/systemd/system/" 
  service_script_name="YDService.service"
  regist_server="systemctl enable YDService.service"
fi

#ubuntu or debian no gawk command
IsUbuntuOrDebian=` echo $system_info | grep -c "ubuntu\|debian" ` 
if [ $IsUbuntuOrDebian -gt 0 ]; then
version() { echo "$@" | awk -F. '{ printf("%03d%03d%03d\n", $1,$2,$3); }'; }
init_d_path="/etc/init.d"
rc_local_path="/etc/rc.local"
service_script_name="YDService"
regist_server="update-rc.d YDService defaults"
  if type systemctl >/dev/null 2>&1; then
    init_d_path="/lib/systemd/system/"
    service_script_name="YDService.service"
    regist_server="systemctl enable YDService.service"
  fi
else
version() { echo "$@" | gawk -F. '{ printf("%03d%03d%03d\n", $1,$2,$3); }'; }
fi

IsSuse=` echo $system_info | grep -c "sles" ` 
if [ $IsSuse -gt 0 ]; then
init_d_path="/etc/init.d"
fi

first_version=2.6.18
second_version=`uname -r`
if [ "$(version "$first_version")" -gt "$(version "$second_version")" ]; then
     echo "Your system version is too old. That Yunjing is not support yet."
     exit 0
fi
if [ -w '/usr' ]; then
    myPath="/usr/local/qcloud"
else
    myPath="/var/lib/qcloud"
fi
wget --no-check-certificate https://imgcache.qq.com/qcloud/csec/yunjing/static/ydeyesinst_linux64.tar.gz
wget --no-check-certificate https://imgcache.qq.com/qcloud/csec/yunjing/static/ydeyesinst_linux64.md5
CURPATH="$( cd "$( dirname $0 )" && pwd )"
echo "checking the md5 file..."
md5_local=`md5sum ${CURPATH}/ydeyesinst_linux64.tar.gz | awk '{print $1}' `
md5_server=`head -1 ${CURPATH}/ydeyesinst_linux64.md5 | awk '{print $1}' `
if [ "$md5_local"x = "$md5_server"x ]
then
	echo "check package success"

	killall -10 YDLive
	killall -10 YDService
	killall -10 YDLive
	sleep 2
	killall -9 YDLive
	killall -9 YDService
	killall -9 YDLive
	if [ ! -e "$myPath" ]; then
    mkdir -p "$myPath"
	fi   
	if [ ! -e "$myPath/YunJing" ]; then
    mkdir -p "$myPath/YunJing"
	fi 
	tar -zxvf ${CURPATH}/ydeyesinst_linux64.tar.gz -C $myPath/YunJing
	chmod 700 $myPath/YunJing/conf
	chmod 700 $myPath/YunJing/YDLive
	chmod 700 $myPath/YunJing/YDEyes
	chmod 600 $myPath/YunJing/conf/collection.xml
	chmod 600 $myPath/YunJing/conf/security.dat
	chmod 600 $myPath/YunJing/conf/host.dat
	chmod 600 $myPath/YunJing/conf/ydeyes.xml
	chmod 700 $myPath/YunJing/YDLive/YDLive
	chmod 700 $myPath/YunJing/YDEyes/YDService
	chmod 700 $myPath/YunJing/uninst.sh
	chmod 700 $myPath/YunJing/startYD.sh
	chmod 700 $myPath/YunJing
	$myPath/YunJing/YDEyes/YDService &
	sleep 1
	$myPath/YunJing/YDLive/YDLive &
	cp  $myPath/YunJing/$service_script_name $init_d_path
  chmod u+x $init_d_path/$service_script_name
  rm -f $myPath/YunJing/$service_script_name
  $regist_server
  sed -i '/YunJing\/YDEyes\/YDService/d' $rc_local_path
  sed -i '/YunJing\/YDLive\/YDLive/d' $rc_local_path
	echo "install package success"
else
	echo "package is invalidate"
fi
rm -f ${CURPATH}/ydeyesinst_linux64.tar.gz
rm -f ${CURPATH}/ydeyesinst_linux64.md5
rm -f ${CURPATH}/yunjinginstall_linux64.sh
