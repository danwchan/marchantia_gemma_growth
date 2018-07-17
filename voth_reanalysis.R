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