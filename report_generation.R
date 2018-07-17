#run this to generate the report for the analysis

require(knitr)
require(rmarkdown)

render(spin("voth_reanalysis.R", knit = FALSE))