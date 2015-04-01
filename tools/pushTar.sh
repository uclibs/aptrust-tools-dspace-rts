#!/bin/bash

#This script may be copied into the final bag directory and run to push content to APTrust. You will need to have installed and configured AWS CLI prior to running.

for i in *.tar; do
	aws s3 cp $i s3://aptrust.receiving.uc.edu
done
