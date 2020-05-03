#!/bin/bash
touch output_time_cpp.txt

for i in  1 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54 56 58 60 62 64 66 68 70
do
echo "************************************" >>output_time_cpp.txt
echo "Threads "$i >>output_time_cpp.txt

( time find . -iname "*.html" | xargs -l -P $i filtro) 2>>output_time_cpp.txt

rm *.html.txt
    
done
