# Optimizing the growth of gemma in *Marchantia polymorpha*

This project is two-fold:

1. To reanalyze previous data as it relates to media composition (and other growth conditions) and gemma production
2. To replicate these findings using the Cam-1 strain under axenic growth conditions

## Re-analysis of Voth 1941 and 1940

The following investigated gemma production in *M. polymorpha* using a system where plants were grown in specialized containers where liquid media could be changed on their rhizoids every other day:

1. Voth PD. Gemmae-Cup Production in Marchantia polymorpha and Its Response to Calcium Deficiency and Supply of Other Nutrients. *Botanical Gazette*. 1941;103(2):310-325. [doi:10.1086/335044][1]
2. Voth PD, Hamner KC. Responses of Marchantia polymorpha to Nutrient Supply and Photoperiod. *Botanical Gazette*. 1940;102(1):169-205. [doi:10.1086/334943][2]

The R scripts in this project reanalyze the data in this table. Analysis can also be found in the [OSF sub-project][4].

Two csv files contain the data from these papers. Importantly several changes have been made to these data to make processing easier:

* The constant concentrations of the compounds which are suffixed with "_constppm" were converted from ppm (0.2 and 0.02) to mol/L by dividing 0.001g/mol by the molar mass then multiplied by the dilution factor from 1 (0.2 or 0.02)
* The molar ratio of the various media salts were manually entered to allow for subsequent calculation of total ion concentrations and is reported in XX_molar
* paperID 1 refers to [Voth and Hammer 1940][1] and 2 refers to [Voth 1941][2]
* The photoperiod "long" includes the 18-20h light and the 18h light periods
* The ranks of the dry weight of the liverworts omitted in the "short" photoperiod were calculated in Excel using the RANK() function

## Replication

Since the [OpenPlant][3] collaboration uses the CAM-1 and Cam-2 isolates of *M. polymorpha* we would like to confirm the Voth findings in axenically propiagated samples of this strain as well as in a growth system which is more similar to the agar-based growth which is commonly used in modern experimental set-ups.

[1]: http://dx.doi.org/10.1086/335044 (Voth 1940)
[2]: http://dx.doi.org/10.1086/334943 (Voth and Hammer)
[3]: https://www.openplant.org/ (OpenPlant)
[4]: http://dx.doi.org/10.17605/OSF.IO/6CTD8 (OSF project)
