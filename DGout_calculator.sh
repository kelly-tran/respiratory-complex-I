#!/bin/bash

# ===========================================================================
# Filename: DGout_calculator.sh
# Author: Kelly Tran
# Purpose: This bash script calculates the DELGout and reduction 
#     potential (E0) of the Fe-S cofactors in respiratory complex I 
#     using the DFT+PB method.
# ===========================================================================

printf "\nEnter the output filename [ex. 4heaa_iso_propka_0mM]: "
read filename
DIR=`pwd`
out="${DIR}/DGout_${filename}.dat"


# Calculate DELGout and E0 for Fe-S cofactors
# ===========================================================================
# [2Fe-2S] with four CYS ligands
function calc2fes () {
    grep "Global net ELEC" *.out | \
    awk '{sum+=$6} END {E=sum/96.4869} END \
    {printf"%15.5f", E} END {printf"%15.5f\n", -(4.507+E+4.43)}'
}

# [4Fe-4S] with four CYS ligands
function calc4fes () {
    grep "Global net ELEC" *.out | \
    awk '{sum+=$6} END {E=sum/96.4869} END \
    {printf"%15.5f", E} END {printf"%15.5f\n", -(3.453+E+4.43)}'
}

# [4Fe-4S] with one neutral His and three CYS ligands
function calc4fesh () {
    grep "Global net ELEC" *.out | \
    awk '{sum+=$6} END {E=sum/96.4869} END \
    {printf"%15.5f", E} END {printf"%15.5f\n", -(0.704+E+4.43)}'
}

# [4Fe-4S] with one deprotonated His and three CYS ligands
function calc4fesd () {
    grep "Global net ELEC" *.out | \
    awk '{sum+=$6} END {E=sum/96.4869} END \
    {printf"%15.5f", E} END {printf"%15.5f\n", -(3.382+E+4.43)}'
}
# ===========================================================================

# Write DELGout and E0 to file
printf '#     Cofactor    DELGout (eV)   E0 (mV)\n'             >  $out
cd $DIR/a1NQ2 && printf '0     a1NQ2' >> $out && calc2fes       >> $out
cd $DIR/a2NQ2 && printf '0     a2NQ2' >> $out && calc2fes       >> $out
                 printf '1     FMN  %15s%15s\n' 'NA' '-0.389  ' >> $out
cd $DIR/1NQ1  && printf '2     1NQ1 ' >> $out && calc4fes       >> $out
cd $DIR/21NQ3 && printf '3     21NQ3' >> $out && calc2fes       >> $out
cd $DIR/22NQ3 && printf '3     22NQ3' >> $out && calc2fes       >> $out
cd $DIR/3NQ3  && printf '4     3NQ3 ' >> $out && calc4fes       >> $out
cd $DIR/4-NQ3 && printf '5     4-NQ3' >> $out && calc4fesd      >> $out
cd $DIR/40NQ3 && printf '5     40NQ3' >> $out && calc4fesh      >> $out
cd $DIR/bNQ3  && printf '#     bNQ3 ' >> $out && calc4fes       >> $out
cd $DIR/5NQ9  && printf '6     5NQ9 ' >> $out && calc4fes       >> $out
cd $DIR/6NQ9  && printf '7     6NQ9 ' >> $out && calc4fes       >> $out
cd $DIR/7NQ6  && printf '8     7NQ6 ' >> $out && calc4fes       >> $out
                 printf '9     Q    %15s%15s\n' 'NA' '-0.08   ' >> $out
cd $DIR/ && echo "" && more $out && echo ""
