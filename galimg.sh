#!/bin/bash
set -e -x
src=$1
dest=$2

mkthumbnails() {
  mkdir -p $dest/thumbnails
  for i in $(find $src -name '*.jpeg'); 
	  do 
		  echo "Processing $i"; 
		  thumbFile=$(echo $i| cut -d \/ -f 2)
	      convert $i -resize '200x100' $dest/thumbnails/$thumbFile
  done
}

copy_originals() {
  mkdir $dest/original || true
  cp -r $src/. $dest/original
}

make_index() {
  (cd $src; ls -1) | perl -ne 'chomp; print qq(<a href="original/$_"><img src="thumbnails/$_"></a>)' > $dest/index.html
}

# mkthumbnails
# copy_originals
make_index
