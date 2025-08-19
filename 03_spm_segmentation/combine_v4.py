#! Python

import os # operating system package
import sys
import glob # pattern recognition
import pandas as pd # pandas concatenation package

## Changing path to segstats.csv files
dir  = os.getcwd()
segdir = dir + '/segstats'
os.chdir(segdir)

if len(sys.argv) > 1:
    if ".csv" in sys.argv[1]:
        out_name=sys.argv[1]
    else:
        print "Incorrect Output Filename Extension"
        print "Usage: python combine.py <outputfilename>"
        print "Correct filename extension: outputfilename.csv"
        sys.exit()
else:
    print "No output file name provided"
    print "Usage: python combine.py <outputfilename>"
    sys.exit()

## Identifying all csv files in directory
extension = 'csv'
filenames = [i for i in glob.glob('*.{}'.format(extension))]

## Combining all csv files in directory
combined_csv = pd.concat([pd.read_csv(f, index_col=False) for f in filenames ])

## Export combined csv
combined_csv.to_csv( out_name, index=False, encoding='utf-8-sig')
