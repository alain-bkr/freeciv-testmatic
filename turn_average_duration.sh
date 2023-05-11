#!/usr/bin/bash

Help() {
	echo "$0 computes average turn duration of a game, each game alone inside its own dir"
	echo "Usage : $0 DIR [DIR2] [DIR3] [DI*] ..."
	exit 1
}

if [ $# -eq 0 ]; then
	Help
fi

case "$1" in
-h*|--h*)
	Help
;;
esac

elapsed() {
	dat1=$(stat --format=%Y $1)
	dat2=$(stat --format=%Y $2)
	echo "$(( $dat2 - $dat1 ))" 2>/dev/null
}

for DIR in $@; do
	find $DIR -name \*final* -type f |while read f; do
		d=$(dirname $f)
		f1=$(ls -tr $d/*T*0001*|head -1)
		f2=$(ls -tr $d/*final*|tail -1)
		time=$(elapsed $f1 $f2)
		#final="$(ls $d/*final*|rev |cut -d- -f-2|rev)"
		final="$(basename $f2| awk -F'-T' '{ print $2 }'|cut -d- -f1)"
		# suppress leading 0 to avoid octal counting  (eg :  echo $(( 160 / 010 )) )
		turns=$(echo $final |sed -e 's/^0*//')
		average=$(( time / turns ))
		echo "$d : $turns turns : $average s per turn"
	done
done 2>/dev/null |column -t -s ':' -R 2,3|sort -k4 -n

# filter out 0 s turns
# ./duration_final.sh $(cat l)|grep -v -e '  -' -e ' 0 ' -e ' 0 s per turn'|sort -k5 -n
# 
