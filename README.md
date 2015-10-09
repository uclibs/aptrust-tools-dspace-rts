# Tools to Bag DSpace Content for the APTrust Preservation Repository

These bash shell scripts may be used to process bags produced by the DSpace Replication Task Suite into bags that conform to the APTrust bag specification. Each item, community, and collection is stored in it's own bag; community and collection bags are the container themselves and do not include child content. 

These scripts are written for the University of Cincinnati and will need to be customized for your local needs.

In order to push bags to your APTrust receiving bucket, you must install and configure [AWS CLI](https://aws.amazon.com/cli/).

1. Copy DSpace RTS zipped bags into the zips directory.
2. From the zips directory, run `aptrustBagger.sh` to process the DSpace bags into APTrust bags.
3. When completed, move to the zips directory and run `pushTar.sh` to send the bags to APTrust.
