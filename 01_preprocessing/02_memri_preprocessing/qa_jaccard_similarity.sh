#! /bin/bash

# Similarity.sh

## Bin

if [[ -z $1 ]];
then
	echo "ERROR: Incorrect usage. Please provide input files directory. Output will be in the same directory as this script."
	echo "Correct Usage: ./qa_jaccard_similarity.sh <input directory>"
	exit 1
fi

wd=$1

[[ ! -d ./Inputs ]] && mkdir ./Inputs
[[ ! -d ./UNION ]] && mkdir ./UNION
[[ ! -d ./INTERSECTION ]] && mkdir ./INTERSECTION


for((n=1;n<=12;n++));
do
	if [[ $n -lt 10 ]];
	then
		m="0${n}"
	else
		m=$n
	fi
	echo $m


	(FSLOUTPUTTYPE=NIFTI fslmaths $wd/wrELS_WT_${m}_pre.ss.hist.nii -thr 1000 -div $wd/wrELS_WT_${m}_pre.ss.hist.nii ./Inputs/02_${m}_01.nii -odt char)
	(FSLOUTPUTTYPE=NIFTI fslmaths $wd/wrELS_WT_${m}_PreF.ss.hist.nii -thr 1000 -div $wd/wrELS_WT_${m}_PreF.ss.hist.nii ./Inputs/02_${m}_02.nii -odt char)
	(FSLOUTPUTTYPE=NIFTI fslmaths $wd/wrELS_WT_${m}_PostF_1.ss.hist.nii -thr 1000 -div $wd/wrELS_WT_${m}_PostF_1.ss.hist.nii ./Inputs/02_${m}_03.nii -odt char)
	(FSLOUTPUTTYPE=NIFTI fslmaths $wd/wrELS_WT_${m}_D9_Post.ss.hist.nii -thr 1000 -div $wd/wrELS_WT_${m}_D9_Post.ss.hist.nii ./Inputs/02_${m}_04.nii -odt char)

done

echo "ELA,Num,Cond,JacInd" > JaccardSim.csv
for f in ./Inputs/*.nii;
do
	f2=$(basename $f)
	echo $f2
	(FSLOUTPUTTYPE=NIFTI fslmaths $f -mul v2-MeanG_mask.nii ./INTERSECTION/${f2:0:-4}_INTERSECTION.nii)
	(FSLOUTPUTTYPE=NIFTI fslmaths $f -add v2-MeanG_mask.nii -bin ./UNION/${f2:0:-4}_UNION.nii)
	I=($(fslstats ./INTERSECTION/${f2:0:-4}_INTERSECTION.nii -V))
	U=($(fslstats ./UNION/${f2:0:-4}_UNION.nii -V))

	JI=`awk "BEGIN{print ${I[0]}/${U[0]} }"`
	echo ${f2:0:2} ${f2:3:2} ${f2:6:2} $JI | tr ' ' ',' >> JaccardSim.csv

done

cd ~