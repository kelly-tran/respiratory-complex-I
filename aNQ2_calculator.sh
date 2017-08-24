#/bin/bash

# ========================================================================================
# Filename: aNQ2_calculator.sh
# Author: Kelly Tran
# Purpose: This bash script calculates the reduction potential (E0) for a[2Fe-2S] in the
#     Nqo2 subunit using the DFT+PB method.
#
#     The results are written to two output files for plotting
#     reduction potential as a function of salt concentration.
# ========================================================================================

DIR=`pwd`
out1="${DIR}/E0_a1NQ2.dat"
out2="${DIR}/E0_a2NQ2.dat"

# Calculate DELGout and E0 for Fe-S cofactors
# [2Fe-2S] with four CYS ligands
function calc2fes () {
    E0=$(grep "Global net ELEC" *.out | \
    awk '{sum+=$6} END {E=sum/96.4869} END \
    {printf"%1.5f", -(4.507+E+4.43)}')
    echo $E0
}

# Write the header to the output file
printf '#%15s%22s' "[NaCl] (mM)" "E0 (mV)" >  $out1
printf '\n#%30s%12s' "aNQ2A" "aNQ2B"       >>  $out1

printf '#%15s%22s' "[NaCl] (mM)" "E0 (mV)" >  $out2
printf '\n#%30s%12s' "aNQ2A" "aNQ2B"       >>  $out2

# Loop over concentration (M) and calculate E0
for conc in 0.01 0.1 0.5 2.0 ; do
    cd ${DIR}/${conc}/a1NQ2A && a1NQ2A=$(calc2fes)
    cd ${DIR}/${conc}/a1NQ2B && a1NQ2B=$(calc2fes) && \
    printf '\n %15s%15.5f%15.5f' $conc $a1NQ2A $a1NQ2B >> $out1

    cd ${DIR}/${conc}/a2NQ2A && a2NQ2A=$(calc2fes)
    cd ${DIR}/${conc}/a2NQ2B && a2NQ2B=$(calc2fes) && \
    printf '\n %15s%15.5f%15.5f' $conc $a2NQ2A $a2NQ2B >> $out2
done

more $out2

