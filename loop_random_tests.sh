#!/usr/bin/bash

Help () {

	echo " Usage : $0 -n=Number_of_runs [-img=Number] [-server=/my/best/freeciv-server] [paramfile1 paramfile2 ...]"
	echo "  will run random_tests.sh -n=... times, see random_test.sh -h for help about other options"
	exit 1
}

if [ "$#" == 0 ]; then 
	Help
fi

INCLUDES=""
IMG=10
RUN=1
SERVER=freeciv-server
typeset -I N=10

if [ -f ./myenv.sh ]; then 
	. ./myenv.sh
fi
while [ "$#" -gt 0 ]; do
	case "$1" in
	-h*|--h*)
		Help
		exit 0
	;;
	-n=*)
		N="${1#*=}"
		shift 1
	;;
	-img=*)
		IMG="${1#*=}"
		shift 1
	;;
	-server=*)
		SERVER="${1#*=}"
		shift 1
		if [ -f $(which $SERVER) ]; then
			d=$(cd $(dirname $(which $SERVER)) && pwd) 
			SERVER="$d/$(basename $SERVER)"
		else
			echo "$SERVER not found "
			exit 1
		fi
	;;
	-*)
		echo "unknown option: $1" >&2
		exit 1
	;;

	*)
		if [ -f $1 ]; then
			#will be called from a child directory so add absolute path
			d=$(cd $(dirname $1) && pwd)
			INCLUDES="$INCLUDES $d/$(basename $1)"
			shift 1
		else 
			echo "$1 file not found" >&2
			ls $1
			exit 1
		fi
	;;
	esac
done


DATE="$(date +%y%m%d-%H%M%S)"
LOOPDIR="loop.$DATE"

mkdir -p $LOOPDIR

(
OLDPWD=$(pwd)
cd $LOOPDIR
	for (( i=1; i<=$N; i++ )); do
		$OLDPWD/random_tests.sh -run=$RUN -img=$IMG -server=$SERVER $INCLUDES
	done
)
mv $LOOPDIR $LOOPDIR.done
echo "done"
