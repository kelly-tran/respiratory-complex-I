# respiratory-complex-I

Respiratory complex I is a multi-subunit protein complex with nine Fe-S clusters. The following bash scripts are used to characterize the reduction potentials (E0) of the Fe-S clusters using computational methods.

First, the PDB crystal structure is prepared for the APBS continuum electrostatic energy calculations. Calculations can be performed for the Fe-S cluster in the peripheral hydrophilic domain (nine subunits) or the isolated subunit.

* apbs_pdb_builder_iso.sh builds PDBs of the isolated subunit

* apbs_pdb_builder_peri.sh builds PDBs of the hydrophilic peripheral domain

Next, the solvation free energies are read from the APBS output. The E0 is calculated and written to a data file for plotting.

* DGout_calculator.sh calculates the DGout and E0

* E0_calculator.sh calculates the E0

* aNQ2_calculator.sh calculates the E0 as function of salt concentration for a[2Fe-2S] in the Nqo2 subunit
