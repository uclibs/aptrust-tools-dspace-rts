#!/bin/bash

#Variables -- add paths to tool directory and APTrust bag directory
tools=../tools
bagdir=../bags

#Unzip all bags
for i in *.zip; do
   unzip "$i"
done

#For each subdirectory, create apatrust-info.txt and bag-info.txt, then move everything into a APTrust bag folder
for f in */ ; do

#Process items first
if [[ $f == ITEM* ]]; then
	cd $f
	export handle=$(echo 'cat /metadata/value[@element="identifier"]/text()' | xmllint --nocdata --shell data/metadata.xml | sed '1d;$d')
	export id=${handle:39}
	bag=cin.$id
	export dir=$(pwd)
	xsltproc -o aptrust-info.txt $tools/metadata2aptrust-info.xsl data/metadata.xml
        java -jar $tools/saxon9he.jar -s:data/metadata.xml -xsl:$tools/metadata2bag-info.xsl -o:bag-info.txt
	cd ../
        mv $dir $bagdir/$bag
 	cd $bagdir
	tar -cvf $bag.tar $bag
	rm -rf $bag
	cd ../zips
fi

#Process collections next
if [[ $f == COLLECTION* ]]; then
	cd $f
	export id=${f:19}
	export hid="${id%?}"
        bag=cin.$hid
        export dir=$(pwd)
        xsltproc -o aptrust-info.txt $tools/metadata2aptrust-info-collections.xsl data/metadata.xml
        java -jar $tools/saxon9he.jar -s:data/metadata.xml -xsl:$tools/metadata2bag-info-collections.xsl -o:bag-info.txt
        cd ../
        mv $dir $bagdir/$bag
        cd $bagdir
        tar -cvf $bag.tar $bag
        rm -rf $bag
        cd ../zips
fi

#Process communities last
if [[ $f == COMMUNITY* ]]; then
        cd $f
        export id=${f:18}
        export hid="${id%?}"
        bag=cin.$hid
        export dir=$(pwd)
        xsltproc -o aptrust-info.txt $tools/metadata2aptrust-info-collections.xsl data/metadata.xml
        java -jar $tools/saxon9he.jar -s:data/metadata.xml -xsl:$tools/metadata2bag-info-community.xsl -o:bag-info.txt
        cd ../
        mv $dir $bagdir/$bag
        cd $bagdir
        tar -cvf $bag.tar $bag
        rm -rf $bag
        cd ../zips
fi
done

#Remove original DSpac eRTS produced bags (zips)
for i in *.zip; do
   rm -rf "$i"
done
