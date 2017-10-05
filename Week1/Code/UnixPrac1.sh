#Author pg5117@ic.ac.uk
# Script: UnixPrac1
# Desc: 
# 1) Count How many lines in each file
# 2) Print everything starting from the second line in E.coli genome
# 3) Count sequence length of E. coli genome
# 4) Count matches for ATGC
# 5) Find ratio of A and T to G and C
#October 2017
#

#
# cd /home/petra/Documents/CMEECourseWork/Week1/Data # send to correct dir
#1 wc -l *.fasta
#2 cat E.coli.fasta | tail -78103
#3 tr -d "\n" < E.coli.fasta | wc -m 
#4 tr -d "\n" < E.coli.fasta | grep ATGC -o |  wc -l 
# didn't know why hint said remove first line? there were no ATCG on first line?
#5 echo "scale=3 ; $( grep AT -o E.coli.fasta | wc -l )/$( grep GC -o E.coli.fasta | wc -l )" | bc
# Used bc instead of expr because I couldnt get expr to do do floats, gave me 0 as answer.








