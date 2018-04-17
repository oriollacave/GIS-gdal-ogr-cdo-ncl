#!/bin/sh

#wrg file in wrg path
path=$1
file=$2
var=$3

mkdir -p $path/GIS-$file
mkdir -p kk
gdal_translate -of GTiff -b 1  NETCDF:$path/$file:$var kk/foo.tif
mv kk/foo.tif $path/GIS-$file/$file.tif
mkdir gearth
./oriol2kml.sh $path/GIS-$file/ $file.tif $var-$file $var
mkdir -p $path/GIS-$file/kml/
mv gearth/* $path/GIS-$file/kml/
rmdir gearth
rmdir kk
