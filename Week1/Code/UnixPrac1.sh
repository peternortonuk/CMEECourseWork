#Author pg5117@ic.ac.uk
# Script: UnixPrac1
# Desc: 1) Count How many lines in each file
# 2) Print everything starting from the second line in E.coli genome
# 3) Count sequence length of E. coli genome
# 4) Count matches for ATGC
# 5) Find ratio of A and T to G and C
#
#
cd /home/petra/CMEECourseWork/Week1/Data
wc -l *.fasta
cat E.coli.fasta | tail -78103
wc E.coli.fasta
grep A -o E.coli.fasta | wc -l



