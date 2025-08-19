#! /bin/bash

############# This is a feeder code for both the segmentation and the ROI data ################
#---------------------------------------------------------------------------------------------#
## dir = Segment_ROI main directory 
## This is the primary directory for all scripts to pull images from and create subdirectories
#---------------------------------------------------------------------------------------------#
## sdir = scripts directory 'dir/Scripts'
## This is the directory containing all the code this program feeds. 
#---------------------------------------------------------------------------------------------#
## wdir = Working Directory created within each script/code
## This directory will depend upon the scripts primary working location
#---------------------------------------------------------------------------------------------#
###############################################################################################

# Creating directory variables
sdir=$(pwd)
cd ..
dir=$(pwd)

# Atlas name input for feeder.sh
atlas=$1
atlas_csv=$2
# Output Data Name
out_name=$3

if [ -z "$atlas" ] || [ ! -f "$atlas" ];
then
    echo ""
    echo "Error: Incorrect input parameters"
    echo "Usage: feeder_v4.sh <atlas labels> <atlas csv> <output csv name>"
    exit 1
elif [ -z "$atlas_csv" ] || [ ! -f "$atlas_csv" ];
then
    echo ""
    echo "Error: Incorrect input parameters"
    echo "Usage: feeder_v4.sh <atlas labels> <atlas csv> <output csv name>"
    exit 1
elif [ -z "$out_name" ]
then
    echo ""
    echo "Error: Incorrect input parameters"
    echo "Usage: feeder_v4.sh <atlas labels> <atlas csv> <output csv name>"
    exit 1
fi

# 1st we create masks based on aligned InVivoAtlas
tmp="${dir}/masks"
if [ ! -d $tmp ]
then
    # Create Masks
    $sdir/create_mask_feeder_v4.sh $dir $sdir $atlas_csv $atlas
else
    if [ "$(ls -A $tmp)" ]
    then
        echo "Masks already exist... moving to next step."
        echo ""
        echo ""
    else
        rm -r $tmp
        echo "${tmp} is empty"
        echo "Recalculating masks..."
        echo ""
        # Create Masks
        $sdir/create_mask_feeder_v4.sh $dir $sdir $atlas_csv $atlas
    fi
fi


# Next we segment Within and Between Group SPMs using created masks
tmp="${dir}/segstats"
if [ ! -d $tmp ]
then
    # Segment 
    $sdir/segment_stats_feeder_v4.sh $dir $sdir
else
    if [ "$(ls -A $tmp)" ]
    then
        echo "Segments already exist... moving to next step."
        echo ""
        echo ""
    else
        rm -r $tmp
        echo "${tmp} is empty"
        echo "Reperforming segmentation statistics..."
        echo ""
        # Segment 
        $sdir/segment_stats_feeder_v4.sh $dir $sdir
    fi
fi


# 4th we combine all csv files into a single csv file
if [ ! -f ${tmp}/${out_name}.csv ]
then
    python2 $sdir/combine_v4.py $out_name
else
    echo "${out_name} already exists"
    echo "See ${tmp}/${out_name}"
fi


echo ""
echo ""
echo "Segmentation complete..."
echo "Woohoo!!!"
