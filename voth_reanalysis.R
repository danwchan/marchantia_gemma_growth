#' ---
#' title: "Re-analysis of Voth data"
#'output:
#'  html_document:
#'    toc: true
#'    theme: united
#' ---

#/*making a note book with knitr.spin is preferable because of the dynamic possible code debugging*/
#/* YAML header, #' for drop into Rmarkdown (#, ## headers), #+ for chunks (try not to disrupt code chunks with Rmarkdown, place before)*/

#+ intial-setup, message=FALSE, include=FALSE, echo=FALSE
#set global knitr options
knitr::opts_chunk$set(warning = FALSE, tidy = FALSE)

#tidyverse
require(readr)
require(dplyr)
require(tidyr)
require(stringr)
require(ggplot2)
require(tibble)

#+ session-info
sessionInfo() #for reproducibility

#' #Reading in and Tidying Data
#' There are two csv files which contian hand transcribed observations from the two papers I will be reanalyzing. A description of these files can be found in the github README and/or inside the comments attached to the code.
#'
#+ data-processing-salt , message = FALSE
#this part of the first csv just has some information to make the process of making solutions easier
salts_data <- read_csv("Voth_data/solutions.csv") %>%
  select(salt, molar_mass)

#+ data-processing-solutions , message = FALSE
#the next part has the information taken from Table 1 in each paper
solutions_data <- read_csv("Voth_data/solutions.csv") %>%
  select(-molar_mass) %>%
  gather(solution, molarity, 8:19) %>% #tidy it up!
  filter(molarity != 0) %>% #and remove out the rows which will have no impact in calcualting concentrations
  separate(solution, into = c("mixID", "paperID"), sep = "-", convert = TRUE) %>% #these will be used to join this table to the working_data table
  arrange(paperID, mixID, salt)

#+ data-processing-final , message = FALSE  
#this table is used to join the mix columns to the solutions_data and calculate the concentrations of ions in the experimental solutions
concentration_calculation <- read_csv("Voth_data/growth_data.csv") %>%
  rowid_to_column("experiment") %>% #this is because of the way I will be calculating the ion concentrations via a join to the solutions_data table... I don't think this is the "right" way to do things
  transmute(experiment = experiment,
           paperID = paperID,
           K_mix = K_mix / mix_total_ratio,
           Ca_mix = Ca_mix / mix_total_ratio,
           Mg_mix = Mg_mix / mix_total_ratio,
           NO3_mix = NO3_mix / mix_total_ratio,
           PO4_mix = PO4_mix / mix_total_ratio,
           SO4_mix = SO4_mix / mix_total_ratio) %>%
  gather(mixID, ratio, -experiment, -paperID) %>%
  left_join(solutions_data, by = c("mixID" = "mixID", "paperID" = "paperID")) %>%
  mutate(K_conc = K_molar * molarity * ratio,
         Ca_conc = Ca_molar * molarity * ratio,
         Mg_conc = Mg_molar * molarity * ratio,
         NO3_conc = NO3_molar * molarity * ratio,
         PO4_conc = PO4_molar * molarity * ratio,
         SO4_conc = SO4_molar * molarity * ratio) %>%
  group_by(experiment) %>%
  summarise(K_conc = sum(K_conc),
            Ca_conc = sum(Ca_conc),
            Mg_conc = sum(Mg_conc),
            NO3_conc = sum(NO3_conc),
            PO4_conc = sum(PO4_conc),
            SO4_conc = sum(SO4_conc))

#this table will be used for the data analysis
working_data <- read_csv("Voth_data/growth_data.csv") %>%
  rowid_to_column("experiment") %>% #this is because of the way I will be the concentrations were calculated in a separate table (concent)
  left_join(concentration_calculation, by = "experiment") %>%
  select(-K_mix, -Ca_mix, -Mg_mix, -NO3_mix, -PO4_mix, -SO4_mix, -mix_total_ratio) %>%
  mutate(avg_gemma_cups = gemma_cups / n_plants, # calculate the plant per plant instead of per group (average)
         avg_area = area / n_plants,
         avg_dry_weight = dry_weight / n_plants,
         avg_weight = weight / n_plants) %>%
  gather(plant_measures, value, 6:11) %>%
  gather(ions_conc, concentration, 6:11) %>%
  gather(avg_plant_measures, avg, 6:9)

#do we want these as factors?  
#working_data$paperID <- parse_factor(working_data$paperID, c("Voth and Hammer 1940", "Voth 1941"))
#working_data$sex <- parse_factor(working_data$sex, c("male", "female"))
#working_data$photoperiod <- parse_factor(working_data$photoperiod, c("long", "short", "long2"))

#' # Validate
#' Make sure that the data that is entered makes sense in light of the study description after being manipulated
#' 
#+ Validate


#' # Data visualization
#' 
#' ## Initial view
#' Look at
#' 

#sel_columns <- c("avg_area", "avg_gemma_cups", "avg_dry_weight", "avg_weight")
sel_columns <- c("avg_plant_measures", "avg")

categorical_data <- working_data %>%
  unite(sxpd, c(3,5), sep = "_") %>%
#  spread(avg_plant_measures, avg) %>%
  bind_cols(setNames(categorical_data[sel_columns], paste0(sel_columns,"_2")))
  
ggplot(categorical_data) +
  geom_point(aes(x = concentration, y = avg, colour = sxpd)) +
  facet_grid(avg_plant_measures ~ ions_conc, scales = "free")

ggplot(categorical_data) +
  geom_point(aes(x = avg, y = avg_2, colour = sxpd)) +
  facet_grid(avg_plant_measures ~ avg_plantmeasures_2, scales = "free")

ggplot(filter(working_data, photoperiod == "long")) +
  geom_point(aes(x = PO4_conc, y = gemma_cups, colour = sex))