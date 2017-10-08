
Week 1 summary

Documents/CMEECourseWork/Week1/Code contains 8 bash files. 

UnixPrac1, a commented out bash file, the chapter 1 practical. (Ps, I didnt understand the hint 4, remove top line, since the top line had no "ATGC" and newline characters had been removed, I wasnt sure what difference it would make? And, I couldn't get expr to work , kept getting 0, I guess because I wasnt handling the decimal places, so I used bc, sorry, I know we werent supposed to use script that wasnt in the handout - but stuck!)

6 files are the exercises set during chapter 2; 
ConcatenateTwoFiles - contents of one file added to the end of another (>>) CountLines - counts lines, wc -l, saved to a variable called NumLines,
MyExampleScript - outputs Hello to the terminal user ($USER),

tabtocsv - removes tabs \t ad replaces them commas using tr. This script could be improved by not hard coding the output filename. I got as far as removing the .txt extension, but didnt work out how to addd .csv to the entered filename.
	
variables - shows how to use variables in bash - varname=Bob - no spaces!!

csvtospace is the end of chapter 2 practical. The bash rewrote files in my ~/Documents/silbiocompmasterepo/Data/Temperatures directory, and saved them in the same directory - this directory is  not pushed. So it should rewrite files in your directory?! Note that I have fist copied the files so as not to overwrite them, but it would be better if I'd cut of the extenstion, so the output filename is 1800.csv.txt - bit ugly.Also, as this bash stands, it will take everything in the temperature directory and make copies, so if there are other files, they'll be copied too. 



And ComplileLatex.sh, which repeates the commands needed to create the pdf from the latex file. (Note to self, make sure you've saved the file and created the bibliography - just create the file name and paste the citation in before compiling the latex file)

I haven't deleted all the temp, test files etc from the week1 directory, in case you wanted to use those to see that I had done the work, but for good housekeeping in future, I think I'd delete all those, or maybe try and create them all in a tmp directory for neatness. 








