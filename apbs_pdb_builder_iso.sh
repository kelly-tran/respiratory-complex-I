#!/bin/bash

# ===========================================================================
# Filename: apbs_pdb_builder_iso.sh
# Author: Kelly Tran
# Purpose: This bash script builds PDBs for calculating the reduction 
#     potential (E0) of the Fe-S cofactors in respiratory complex I 
#     using the DFT+PB method.
#
#     The script reads in 4HEA.pdb after missing residues and hydrogen 
#     coordinates have been built and prepares APBS-formatted PDBs 
#     in the isolated subunit. 
#     Script requires 4hea#-refo.pdb, 4hea#-refr.pdb, and 4hea#-heto.pdb 
#     in the same directory to append FeS and FMN cofactors.
# ===========================================================================

# Ask for user input
printf "\nEnter the full input filename [ex. 4heaa_pro_hbuild_hsd.pdb]: "
read infile
printf "\nInput file: ${infile}\n"

printf "\nWhich molecule in the ASU? [A or B]: "
read molASU

printf "\n    a1NQ2    21NQ3    40NQ3     5NQ9"
printf "\n    a2NQ2    22NQ3    4-NQ3     6NQ9"
printf "\n     1NQ1     3NQ3     bNQ3     7NQ6"
printf "\nSelect an Fe-S cofactor: "
read segID_ref
segID_ref="${segID_ref}${molASU}"

# Create output file
segID_pro=${segID_ref:(-4):4}
out="${segID_pro}.pdb"
grep $segID_pro $infile > $out

# Rename HETATM to ATOM 
sed -i 's/HETATM/ATOM  /g' $out

# Rename residue name to NTER for first six atoms of N-terminus
sed -i 's/ N   MET     1/N   NTER     1/' $out
sed -i 's/ HT1 MET     1/HT1 NTER     1/' $out
sed -i 's/ HT2 MET     1/HT2 NTER     1/' $out
sed -i 's/ HT3 MET     1/HT3 NTER     1/' $out
sed -i 's/ CA  MET     1/CA  NTER     1/' $out
sed -i 's/ HA  MET     1/HA  NTER     1/' $out

# Rename residue name to CTER for last three atoms of C-terminus  
sed -i '/NQ1/s/ C   ARG   438/C   CTER   438/' $out
sed -i '/NQ2/s/ C   VAL   181/C   CTER   181/' $out
sed -i '/NQ3/s/ C   ALA   783/C   CTER   783/' $out
sed -i '/NQ4/s/ C   ARG   409/C   CTER   409/' $out
sed -i '/NQ5/s/ C   GLY   207/C   CTER   207/' $out
sed -i '/NQ6/s/ C   GLY   181/C   CTER   181/' $out
sed -i '/NQ9/s/ C   ARG   182/C   CTER   182/' $out
sed -i '/N15/s/ C   ALA   129/C   CTER   129/' $out
sed -i '/N16/s/ C   ALA   131/C   CTER   131/' $out

sed -i '/NQ1/s/ OT1 ARG   438/OT1 CTER   438/' $out
sed -i '/NQ2/s/ OT1 VAL   181/OT1 CTER   181/' $out
sed -i '/NQ3/s/ OT1 ALA   783/OT1 CTER   783/' $out
sed -i '/NQ4/s/ OT1 ARG   409/OT1 CTER   409/' $out
sed -i '/NQ5/s/ OT1 GLY   207/OT1 CTER   207/' $out
sed -i '/NQ6/s/ OT1 GLY   181/OT1 CTER   181/' $out
sed -i '/NQ9/s/ OT1 ARG   182/OT1 CTER   182/' $out
sed -i '/N15/s/ OT1 ALA   129/OT1 CTER   129/' $out
sed -i '/N16/s/ OT1 ALA   131/OT1 CTER   131/' $out

sed -i '/NQ1/s/ OT2 ARG   438/OT2 CTER   438/' $out
sed -i '/NQ2/s/ OT2 VAL   181/OT2 CTER   181/' $out
sed -i '/NQ3/s/ OT2 ALA   783/OT2 CTER   783/' $out
sed -i '/NQ4/s/ OT2 ARG   409/OT2 CTER   409/' $out
sed -i '/NQ5/s/ OT2 GLY   207/OT2 CTER   207/' $out
sed -i '/NQ6/s/ OT2 GLY   181/OT2 CTER   181/' $out
sed -i '/NQ9/s/ OT2 ARG   182/OT2 CTER   182/' $out
sed -i '/N15/s/ OT2 ALA   129/OT2 CTER   129/' $out
sed -i '/N16/s/ OT2 ALA   131/OT2 CTER   131/' $out

# Rename atom and residue name for disulfide bond:
sed -i '/NQ2/s/ CB  CYS   144/1CB DISU   144/' $out
sed -i '/NQ2/s/ SG  CYS   144/1SG DISU   144/' $out
sed -i '/NQ2/s/ CB  CYS   172/2CB DISU   172/' $out
sed -i '/NQ2/s/ SG  CYS   172/2SG DISU   172/' $out

# Delete CYS and HIS ligand side chains from the protein
sed -i -e '/CB  CYS   353.*NQ1/,+4d' $out
sed -i -e '/CB  CYS   356.*NQ1/,+4d' $out
sed -i -e '/CB  CYS   359.*NQ1/,+4d' $out
sed -i -e '/CB  CYS   400.*NQ1/,+4d' $out
sed -i -e '/CB  CYS    83.*NQ2/,+4d' $out
sed -i -e '/CB  CYS    88.*NQ2/,+4d' $out
sed -i -e '/CB  CYS   124.*NQ2/,+4d' $out
sed -i -e '/CB  CYS   128.*NQ2/,+4d' $out
sed -i -e '/CB  CYS    34.*NQ3/,+4d' $out
sed -i -e '/CB  CYS    45.*NQ3/,+4d' $out
sed -i -e '/CB  CYS    48.*NQ3/,+4d' $out
sed -i -e '/CB  CYS    83.*NQ3/,+4d' $out
sed -i -e '/CB  CYS   119.*NQ3/,+4d' $out
sed -i -e '/CB  CYS   122.*NQ3/,+4d' $out
sed -i -e '/CB  CYS   128.*NQ3/,+4d' $out
sed -i -e '/CB  CYS   181.*NQ3/,+4d' $out
sed -i -e '/CB  CYS   184.*NQ3/,+4d' $out
sed -i -e '/CB  CYS   187.*NQ3/,+4d' $out
sed -i -e '/CB  CYS   230.*NQ3/,+4d' $out
sed -i -e '/CB  CYS   256.*NQ3/,+4d' $out
sed -i -e '/CB  CYS   259.*NQ3/,+4d' $out
sed -i -e '/CB  CYS   263.*NQ3/,+4d' $out
sed -i -e '/CB  CYS   291.*NQ3/,+4d' $out
sed -i -e '/CB  CYS    45.*NQ6/,+4d' $out
sed -i -e '/CB  CYS    46.*NQ6/,+4d' $out
sed -i -e '/CB  CYS   111.*NQ6/,+4d' $out
sed -i -e '/CB  CYS   140.*NQ6/,+4d' $out
sed -i -e '/CB  CYS    53.*NQ9/,+4d' $out
sed -i -e '/CB  CYS    56.*NQ9/,+4d' $out
sed -i -e '/CB  CYS    59.*NQ9/,+4d' $out
sed -i -e '/CB  CYS    63.*NQ9/,+4d' $out
sed -i -e '/CB  CYS    98.*NQ9/,+4d' $out
sed -i -e '/CB  CYS   101.*NQ9/,+4d' $out
sed -i -e '/CB  CYS   104.*NQ9/,+4d' $out
sed -i -e '/CB  CYS   108.*NQ9/,+4d' $out
sed -i -e '/CB  HSD   115.*NQ3/,+10d' $out

# Append non-reference co-factors in the oxidized state 
# while excluding the reference cofactor (for all charge states)
segid_ref2="${segID_ref:0:1}.${segID_pro}"
grep $segID_pro *-heto.pdb | grep -Ev "$segID_ref|$segid_ref2" >> $out

# Write PDBs in the oxidized and reference charge states
# for the protein and reference cofactor
proo="${segID_ref}_proo.pdb"
cp $out $proo
printf "\n Writing ${segID_ref}_proo.pdb"
grep $segID_ref *-refo.pdb >> $proo

pror="${segID_ref}_pror.pdb"
cp $out $pror
printf "\n Writing ${segID_ref}_pror.pdb"
grep $segID_ref *-refr.pdb >> $pror

refo="${segID_ref}_refo.pdb"
printf "\n Writing ${segID_ref}_refo.pdb"
grep $segID_ref *-refo.pdb > $refo

refr="${segID_ref}_refr.pdb"
printf "\n Writing ${segID_ref}_refr.pdb\n"
grep $segID_ref *-refr.pdb > $refr

