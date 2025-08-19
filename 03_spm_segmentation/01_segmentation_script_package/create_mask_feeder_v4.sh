#!/bin/bash

# $1 = primary directory
# $2 = scripts directory
# $3 = InVivo Atlas CSV file

dir=$1
sdir=$2
csvfile=$3

echo "#!/bin/bash" > $sdir/mask_creator_v4.sh
echo "# $""1 = primary directory" >> $sdir/mask_creator_v4.sh
echo "# $""2 = scripts directory" >> $sdir/mask_creator_v4.sh
echo "# $""3 = InVivo Atlas file" >> $sdir/mask_creator_v4.sh
echo "dir=$""1" >> $sdir/mask_creator_v4.sh
echo "sdir=$""2" >> $sdir/mask_creator_v4.sh
echo "atlascsv=$""3" >> $sdir/mask_creator_v4.sh
echo "" >> $sdir/mask_creator_v4.sh
echo "mkdir $""dir/masks/" >> $sdir/mask_creator_v4.sh
echo "" >> $sdir/mask_creator_v4.sh
cnt=1
while IFS=, read -r num name abbr group domain; 
do 
	if [[ $cnt -gt 2 ]];
	then
		# echo $abbr
		echo "$""sdir/mask_creation_v4.sh $""dir ${abbr} ${num} ${num} $""atlas" >> $sdir/mask_creator_v4.sh
	# else
		# echo "Something went wrong..."
	fi
	cnt=$(($cnt+1))
done < $dir/$csvfile

max=$(($cnt-1))
echo "$""sdir/mask_creation_v4.sh $""dir WB 1 ${max} $""atlas" >> $sdir/mask_creator_v4.sh

chmod +x $sdir/mask_creator_v4.sh
$sdir/mask_creator_v4.sh $dir $sdir $atlas

