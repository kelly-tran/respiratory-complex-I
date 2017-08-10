#!/bin/bash

# ===========================================================================
# Filename: E0_calculator.sh
# Author: Kelly Tran
# Purpose: This bash script calculates the reduction potential (E0) 
#     of the Fe-S cofactors in respiratory complex I using the DFT+PB method.
#
#     The results are written to three output files for plotting
#     reduction potential profiles.
# ===========================================================================

printf "\nEnter the output filename [ex. 4heaa_iso_propka_0mM]: "
read filename
DIR=`pwd`
out1="${DIR}/E0_${filename}.pts.dat"
out2="${DIR}/E0_${filename}.posE0.dat"
out3="${DIR}/E0_${filename}.negE0.dat"

# Calculate DELGout and E0 for Fe-S cofactors
# ===========================================================================
# [2Fe-2S] with four CYS ligands
function calc2fes () {
    grep "Global net ELEC" *.out | \
    awk '{sum+=$6} END {E=sum/96.4869} END \
    {printf"%15.5f\n", -(4.507+E+4.43)}'
}

# [4Fe-4S] with four CYS ligands
function calc4fes () {
    grep "Global net ELEC" *.out | \
    awk '{sum+=$6} END {E=sum/96.4869} END \
    {printf"%15.5f\n", -(3.453+E+4.43)}'
}

# [4Fe-4S] with one neutral His and three CYS ligands
function calc4fesh () {
    grep "Global net ELEC" *.out | \
    awk '{sum+=$6} END {E=sum/96.4869} END \
    {printf"%15.5f\n", -(0.704+E+4.43)}'
}

# [4Fe-4S] with one deprotonated His and three CYS ligands
function calc4fesd () {
    grep "Global net ELEC" *.out | \
    awk '{sum+=$6} END {E=sum/96.4869} END \
    {printf"%15.5f\n", -(3.382+E+4.43)}'
}
# ===========================================================================

# Write E0 to file
# Points
printf '#    Cofactor    E0 (mV)\n'                        >  $out1
cd $DIR/a1NQ2 && printf '0    a1NQ2' >> $out1 && calc2fes  >> $out1
cd $DIR/a2NQ2 && printf '0    a2NQ2' >> $out1 && calc2fes  >> $out1
cd $DIR/      && printf '1    FMN         -0.389  \n'      >> $out1
cd $DIR/1NQ1  && printf '2    1NQ1 ' >> $out1 && calc4fes  >> $out1
cd $DIR/21NQ3 && printf '3    21NQ3' >> $out1 && calc2fes  >> $out1
cd $DIR/22NQ3 && printf '3    22NQ3' >> $out1 && calc2fes  >> $out1
cd $DIR/3NQ3  && printf '4    3NQ3 ' >> $out1 && calc4fes  >> $out1
cd $DIR/4-NQ3 && printf '5    4-NQ3' >> $out1 && calc4fesd >> $out1
cd $DIR/40NQ3 && printf '5    40NQ3' >> $out1 && calc4fesh >> $out1
cd $DIR/bNQ3  && printf '#    bNQ3 ' >> $out1 && calc4fes  >> $out1
cd $DIR/5NQ9  && printf '6    5NQ9 ' >> $out1 && calc4fes  >> $out1
cd $DIR/6NQ9  && printf '7    6NQ9 ' >> $out1 && calc4fes  >> $out1
cd $DIR/7NQ6  && printf '8    7NQ6 ' >> $out1 && calc4fes  >> $out1
cd $DIR/      && printf '9    Q           -0.08   \n'      >> $out1
cd $DIR/ && echo "" && more $out1 && echo ""

# More positive E0 for multiple charged states (a#NQ2,2#NQ3,4#NQ3)
printf '#        Cofactor    E0 (mV)\n'                          >  $out2
cd $DIR/a2NQ2 && printf -- '-0.75    a2NQ2' >> $out2 && calc2fes >> $out2
                 printf ' 0.25    a2NQ2' >> $out2 && calc2fes    >> $out2
cd $DIR/      && printf ' 0.75    FMN         -0.389  \n'        >> $out2
                 printf ' 1.25    FMN         -0.389  \n'        >> $out2
cd $DIR/1NQ1  && printf ' 1.75    1NQ1 ' >> $out2 && calc4fes    >> $out2
                 printf ' 2.25    1NQ1 ' >> $out2 && calc4fes    >> $out2
cd $DIR/21NQ3 && printf ' 2.75    21NQ3' >> $out2 && calc2fes    >> $out2
                 printf ' 3.25    21NQ3' >> $out2 && calc2fes    >> $out2
cd $DIR/3NQ3  && printf ' 3.75    3NQ3 ' >> $out2 && calc4fes    >> $out2
                 printf ' 4.25    3NQ3 ' >> $out2 && calc4fes    >> $out2
cd $DIR/40NQ3 && printf ' 4.75    40NQ3' >> $out2 && calc4fesh   >> $out2
                 printf ' 5.25    40NQ3' >> $out2 && calc4fesh   >> $out2
cd $DIR/5NQ9  && printf ' 5.75    5NQ9 ' >> $out2 && calc4fes    >> $out2
                 printf ' 6.25    5NQ9 ' >> $out2 && calc4fes    >> $out2
cd $DIR/6NQ9  && printf ' 6.75    6NQ9 ' >> $out2 && calc4fes    >> $out2
                 printf ' 7.25    6NQ9 ' >> $out2 && calc4fes    >> $out2
cd $DIR/7NQ6  && printf ' 7.75    7NQ6 ' >> $out2 && calc4fes    >> $out2
                 printf ' 8.25    7NQ6 ' >> $out2 && calc4fes    >> $out2
cd $DIR/      && printf ' 8.75    Q           -0.08   \n'        >> $out2
                 printf ' 9.25    Q           -0.08   \n'        >> $out2

# More negative E0 for multiple charged states (a#NQ2,2#NQ3,4#NQ3)
printf '#        Cofactor    E0 (mV)\n'                          >  $out3
cd $DIR/a1NQ2 && printf -- '-0.75    a1NQ2' >> $out3 && calc2fes >> $out3
                 printf ' 0.25    a1NQ2' >> $out3 && calc2fes    >> $out3
cd $DIR/      && printf ' 0.75    FMN         -0.389  \n'        >> $out3
                 printf ' 1.25    FMN         -0.389  \n'        >> $out3
cd $DIR/1NQ1  && printf ' 1.75    1NQ1 ' >> $out3 && calc4fes    >> $out3
                 printf ' 2.25    1NQ1 ' >> $out3 && calc4fes    >> $out3
cd $DIR/22NQ3 && printf ' 2.75    22NQ3' >> $out3 && calc2fes    >> $out3
                 printf ' 3.25    22NQ3' >> $out3 && calc2fes    >> $out3
cd $DIR/3NQ3  && printf ' 3.75    3NQ3 ' >> $out3 && calc4fes    >> $out3
                 printf ' 4.25    3NQ3 ' >> $out3 && calc4fes    >> $out3
cd $DIR/4-NQ3 && printf ' 4.75    4-NQ3' >> $out3 && calc4fesd   >> $out3
                 printf ' 5.25    4-NQ3' >> $out3 && calc4fesd   >> $out3
cd $DIR/5NQ9  && printf ' 5.75    5NQ9 ' >> $out3 && calc4fes    >> $out3
                 printf ' 6.25    5NQ9 ' >> $out3 && calc4fes    >> $out3
cd $DIR/6NQ9  && printf ' 6.75    6NQ9 ' >> $out3 && calc4fes    >> $out3
                 printf ' 7.25    6NQ9 ' >> $out3 && calc4fes    >> $out3
cd $DIR/7NQ6  && printf ' 7.75    7NQ6 ' >> $out3 && calc4fes    >> $out3
                 printf ' 8.25    7NQ6 ' >> $out3 && calc4fes    >> $out3
cd $DIR/      && printf ' 8.75    Q           -0.08   \n'        >> $out3
                 printf ' 9.25    Q           -0.08   \n'        >> $out3
