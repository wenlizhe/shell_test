ENV='http:192.168.5.21:8080'
MEMBERS=1
MNO=2

help() {
    echo $0 "<MEMBERS> <MNO> [ENV]"
	exit 0
}

dump_param() {
	echo "---------------------------------"
	echo `date`
    echo "MEMBERS   :" $MEMBERS
    echo "MNO       :" $MNO
    echo "ENV       :" $ENV
	echo "---------------------------------"
}

if [ $# -gt 0 ] 
then
    MEMBERS=$1
    shift
else
	help
fi

if [ $# -gt 0 ] 
then
    MNO=$1
    shift
else
	help
fi

if [ $# -gt 0 ] 
then
    ENV=$1
fi

join_meeting() {
    mkdir log/$1
    ./ConfClient.exe -R $ENV -c $MNO -f jsm.svc -d log/$1 $1 2>&1 &
}

dump_param

PREFIX=`cat /dev/urandom | head -n 10 | md5sum | head -c 8`

for (( i=0; i<$MEMBERS; i++)); do
    USER=${PREFIX}"_"`printf "%06d" "$i"`

    join_meeting $USER
done
