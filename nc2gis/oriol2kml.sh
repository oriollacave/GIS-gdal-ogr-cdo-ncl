#!/bin/bash
dir=$1
input=$2
state=$3
var=$4
tag=`echo $input | awk -F ".tif" '{print $1}'`
rm -fr kk

mkdir -p  kk/

CMD="gdal_translate -a_nodata -999 -a_srs 'EPSG:4326' -of vrt $dir/$input kk/withlatlon.vrt"
echo $CMD
echo $CMD | sh

CMD="gdaldem color-relief -alpha -of vrt kk/withlatlon.vrt $var.colors.txt kk/${tag}.vrt"
echo $CMD
echo $CMD | sh


CMD="/usr/bin/gdal2tiles.py -z 6-12 -p geodetic -k kk/${tag}.vrt kk/"
echo $CMD
echo $CMD | sh

rm -fr gearth/$tag
mkdir -p gearth/$tag
echo "mv kk/* gearth/$state/$tag"
mv kk/* gearth/$tag
rm -fr kk
