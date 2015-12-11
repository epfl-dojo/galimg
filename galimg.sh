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
  (
## http://www.htmlgoodies.com/html5/css/how-to-create-a-css3-based-image-gallery.html
    echo "<html>"
    echo "<head><link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\"></style></head><body>"
    (cd $src; ls -1) | perl -ne 'chomp; print qq(<a href="original/$_"><img src="thumbnails/$_">$_</a><span>$_</span>\n)'
    echo "</body></html>"
   ) > $dest/index.html
}

make_css() {
  :
}

# mkthumbnails
# copy_originals
make_index
make_css
