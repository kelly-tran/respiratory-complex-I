#!/bin/bash

# ========================================================================================
# Filename: E0_calculator.sh
# Author: Kelly Tran
# Purpose: This bash script calculates the reduction potential (E0) 
#     for the Fe-S cofactors in respiratory complex I using the DFT+PB method.
#
#     The results are written to three output files for plotting
#     reduction potential profiles in gnuplot.
# ========================================================================================

printf "\nEnter the output filename (ex. 4heaa_iso_propka_0mM) and press [ENTER]: "
read filename
DIR=`pwd`
out1="${DIR}/E0_${filename}.pts.dat"
out2="${DIR}/E0_${filename}.posE0.dat" # More positive E0 for multiple charged states
out3="${DIR}/E0_${filename}.negE0.dat" # More negative E0 for multiple charged states

# Functions to calculate DELGout and E0 for Fe-S cofactors
# [2Fe-2S] with four CYS ligands
function calc2fes () {
    if [ -e *.out ]; then
        E0=$(grep "Global net ELEC" *.out | \
        awk '{sum+=$6} END {E=sum/96.4869} END \
        {printf"%15.5f", -(4.507+E+4.43)}')
        echo $E0
    else
        printf '%15s\n' 'NaN'
    fi
}

# [4Fe-4S] with four CYS ligands
function calc4fes () {
    if [ -e *.out ]; then
        E0=$(grep "Global net ELEC" *.out | \
        awk '{sum+=$6} END {E=sum/96.4869} END \
        {printf"%15.5f", -(3.453+E+4.43)}')
        echo $E0
    else
        printf '%15s\n' 'NaN'
    fi
}

# [4Fe-4S] with one neutral His and three CYS ligands
function calc4fesh () {
    if [ -e *.out ]; then
        E0=$(grep "Global net ELEC" *.out | \
        awk '{sum+=$6} END {E=sum/96.4869} END \
        {printf"%15.5f", -(0.704+E+4.43)}')
        echo $E0
    else
        printf '%15s\n' 'NaN'
    fi
}

# [4Fe-4S] with one deprotonated His and three CYS ligands
function calc4fesd () {
    if [ -e *.out ]; then
        E0=$(grep "Global net ELEC" *.out | \
        awk '{sum+=$6} END {E=sum/96.4869} END \
        {printf"%15.5f", -(3.382+E+4.43)}')
        echo $E0
    else
        printf '%15s\n' 'NaN'
    fi
}

# Calculate E0
cd ${DIR}/a1NQ2 && E0_a1NQ2=$(calc2fes)
cd ${DIR}/a2NQ2 && E0_a2NQ2=$(calc2fes)
cd ${DIR}/1NQ1  &&  E0_1NQ1=$(calc4fes)
cd ${DIR}/21NQ3 && E0_21NQ3=$(calc2fes)
cd ${DIR}/22NQ3 && E0_22NQ3=$(calc2fes)
cd ${DIR}/3NQ3  &&  E0_3NQ3=$(calc4fes)
cd ${DIR}/4-NQ3 && E0_4_NQ3=$(calc4fesd)
cd ${DIR}/40NQ3 && E0_40NQ3=$(calc4fesh)
cd ${DIR}/bNQ3  &&  E0_bNQ3=$(calc4fes)
cd ${DIR}/5NQ9  &&  E0_5NQ9=$(calc4fes)
cd ${DIR}/6NQ9  &&  E0_6NQ9=$(calc4fes)
cd ${DIR}/7NQ6  &&  E0_7NQ6=$(calc4fes)

# Write E0 to file
# Points
printf '# X1 = Position in the FeS Chain\n'     > $out1
printf '# X2 = Center-to-Center Distance (A)\n' >> $out1
printf '# Sazanov, L. Nat. Rev. Mol. Cell Biol. 2015\n' >> $out1
printf '# X1  X2      Cofactor     E0 (mV)\n'   >> $out1
printf '  #   N/A     a1NQ2 %15.5f\n' $E0_a1NQ2 >> $out1
printf '  #   N/A     a2NQ2 %15.5f\n' $E0_a2NQ2 >> $out1
printf '  1   0.0     FMN          -0.389  \n'  >> $out1
printf '  2   10.9    1NQ1  %15.5f\n' $E0_1NQ1  >> $out1
printf '  3   25.1    21NQ3 %15.5f\n' $E0_21NQ3 >> $out1
printf '  3   25.1    22NQ3 %15.5f\n' $E0_22NQ3 >> $out1
printf '  4   39.0    3NQ3  %15.5f\n' $E0_3NQ3  >> $out1
printf '  5   51.2    4-NQ3 %15.5f\n' $E0_4_NQ3 >> $out1
printf '  5   51.2    40NQ3 %15.5f\n' $E0_40NQ3 >> $out1
printf '  #    N/A    bNQ3  %15.5f\n' $E0_bNQ3  >> $out1
printf '  6   68.1    5NQ9  %15.5f\n' $E0_5NQ9  >> $out1
printf '  7   80.3    6NQ9  %15.5f\n' $E0_6NQ9  >> $out1
printf '  8   94.5    7NQ6  %15.5f\n' $E0_7NQ6  >> $out1
printf '  9   106.4   Q            -0.08   \n'  >> $out1
echo "" && more $out1 && echo ""

# More positive E0 for multiple charged states
printf '# X1 = Position in the FeS Chain\n'            > $out2
printf '# X2 = Center-to-Center Distance (A)\n'        >> $out2
printf '# Sazanov, L. Nat. Rev. Mol. Cell Biol. 2015\n' >> $out2
printf '#  X1        X2      Cofactor     E0 (mV)\n'   >> $out2
printf '#-0.75      N/A      a2NQ2 %15.5f\n' $E0_a2NQ2 >> $out2
printf '# 0.25      N/A      a2NQ2 %15.5f\n' $E0_a2NQ2 >> $out2
printf ' 0.75     -3.50      FMN          -0.389  \n'  >> $out2
printf ' 1.25      3.50      FMN          -0.389  \n'  >> $out2
printf ' 1.75      7.40      1NQ1  %15.5f\n' $E0_1NQ1  >> $out2
printf ' 2.25     14.40      1NQ1  %15.5f\n' $E0_1NQ1  >> $out2
printf ' 2.75     21.60      21NQ3 %15.5f\n' $E0_21NQ3 >> $out2
printf ' 3.25     28.60      21NQ3 %15.5f\n' $E0_21NQ3 >> $out2
printf ' 3.75     35.50      3NQ3  %15.5f\n' $E0_3NQ3  >> $out2
printf ' 4.25     42.50      3NQ3  %15.5f\n' $E0_3NQ3  >> $out2
printf ' 4.75     47.70      40NQ3 %15.5f\n' $E0_40NQ3 >> $out2
printf ' 5.25     54.70      40NQ3 %15.5f\n' $E0_40NQ3 >> $out2
printf ' 5.75     64.60      5NQ9  %15.5f\n' $E0_5NQ9  >> $out2
printf ' 6.25     71.60      5NQ9  %15.5f\n' $E0_5NQ9  >> $out2
printf ' 6.75     76.80      6NQ9  %15.5f\n' $E0_6NQ9  >> $out2
printf ' 7.25     83.80      6NQ9  %15.5f\n' $E0_6NQ9  >> $out2
printf ' 7.75     91.00      7NQ6  %15.5f\n' $E0_7NQ6  >> $out2
printf ' 8.25     98.00      7NQ6  %15.5f\n' $E0_7NQ6  >> $out2
printf ' 8.75    102.90      Q            -0.08   \n'  >> $out2
printf ' 9.25    109.90      Q            -0.08   \n'  >> $out2

# More negative E0 for multiple charged states
printf '# X1 = Position in the FeS Chain\n'            > $out3
printf '# X2 = Center-to-Center Distance (A)\n'        >> $out3
printf '# Sazanov, L. Nat. Rev. Mol. Cell Biol. 2015\n' >> $out3
printf '#  X1        X2      Cofactor     E0 (mV)\n'   >> $out3
printf '#-0.75      N/A      a1NQ2 %15.5f\n' $E0_a1NQ2 >> $out3
printf '# 0.25      N/A      a1NQ2 %15.5f\n' $E0_a1NQ2 >> $out3
printf ' 0.75     -3.50      FMN          -0.389  \n'  >> $out3
printf ' 1.25      3.50      FMN          -0.389  \n'  >> $out3
printf ' 1.75      7.40      1NQ1  %15.5f\n' $E0_1NQ1  >> $out3
printf ' 2.25     14.40      1NQ1  %15.5f\n' $E0_1NQ1  >> $out3
printf ' 2.75     21.60      22NQ3 %15.5f\n' $E0_22NQ3 >> $out3
printf ' 3.25     28.60      22NQ3 %15.5f\n' $E0_22NQ3 >> $out3
printf ' 3.75     35.50      3NQ3  %15.5f\n' $E0_3NQ3  >> $out3
printf ' 4.25     42.50      3NQ3  %15.5f\n' $E0_3NQ3  >> $out3
printf ' 4.75     47.70      4_NQ3 %15.5f\n' $E0_4_NQ3 >> $out3
printf ' 5.25     54.70      4_NQ3 %15.5f\n' $E0_4_NQ3 >> $out3
printf ' 5.75     64.60      5NQ9  %15.5f\n' $E0_5NQ9  >> $out3
printf ' 6.25     71.60      5NQ9  %15.5f\n' $E0_5NQ9  >> $out3
printf ' 6.75     76.80      6NQ9  %15.5f\n' $E0_6NQ9  >> $out3
printf ' 7.25     83.80      6NQ9  %15.5f\n' $E0_6NQ9  >> $out3
printf ' 7.75     91.00      7NQ6  %15.5f\n' $E0_7NQ6  >> $out3
printf ' 8.25     98.00      7NQ6  %15.5f\n' $E0_7NQ6  >> $out3
printf ' 8.75    102.90      Q            -0.08   \n'  >> $out3
printf ' 9.25    109.90      Q            -0.08   \n'  >> $out3

