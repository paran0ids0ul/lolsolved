# Usage: getrekt.sh file_or_folder flag_marker
# Example: getrekt.sh for101 'flag{'

if [ -z $2 ]
   then
   echo 'Usage: lolsolved.sh file_or_folder flag_marker'
   exit 2
fi

featherduster='/tools/featherduster/featherduster.py'

FLAG="$2"
FLAG_REVERSE=`echo $FLAG | rev`
files=`find $1`

echo 'Magic CTF challenge solver GO!'
echo ''

# Do general solves
# strings | grep
for file in $files
do
   
   strings $file | grep $FLAG && echo 'GETREKT: strings | grep flag' && exit 0
   strings $file | grep $FLAG_REVERSE && echo 'GETREKT: strings | grep flag_in_reverse' && exit 0
   binwalk -e $file >/dev/null; grep -r $FLAG _$file.extracted/ && echo 'GETREKT: binwalk -e ; grep -r flag' && exit 0

   # Do crypto solves
   echo 'autopwn' | python $featherduster $file | grep $FLAG && echo 'GETREKT: featherduster autopwn' && exit 0

   # Do reversing solves
   #TODO Do RE solves

   # Do stego solves
   #TODO Do stego solves

done
