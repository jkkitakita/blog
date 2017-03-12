#!bin/bash

num=`expr $RANDOM % 20`

hugo new post/$1.md
image=`curl 'https://pixabay.com/api/?key=4791769-9ef68b2d58ca0387c5e8510d4&q=landscape&image_type=photo&pretty=true' | jq -r '.hits['$num'].webformatURL' | cut -c7-`

gsed -i -e "2i coverImage = \"$image\"" content/post/$1.md
gsed -i -e "2i thumbnailImage = \"$image\"" content/post/$1.md
