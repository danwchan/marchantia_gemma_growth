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

#+ session-info
sessionInfo() #for reproducibility

solutions_data <- read_csv("Voth_data/solutions.csv") %>%
  transform(paperID = as.integer(paperID)) %>%
  

working_data <- read_csv("Voth_data/growth_data.csv") %>%
#do we want these as factors?  
#working_data$paperID <- parse_factor(working_data$paperID, c("Voth and Hammer 1940", "Voth 1941"))
#working_data$sex <- parse_factor(working_data$sex, c("male", "female"))
#working_data$photoperiod <- parse_factor(working_data$photoperiod, c("long", "short", "long2"))

ggplot(working_data) +
  geom_point(aes(x = weight, y = gemma_cups, colour = sex))