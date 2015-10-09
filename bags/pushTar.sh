#!/bin/bash

#Be sure to replace the s3 path with your own receiving bucket.

for i in *.tar; do
	aws s3 cp $i s3://aptrust.receiving.uc.edu
done
