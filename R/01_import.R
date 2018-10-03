#' setting up our environment by loading the required packages
#' we don't _need_ the entire tidyverse for this example, so I've only loaded
#' the packages we'll use. 
#' you can absolutely swap out `readr`, `dplyr`, and `tidyr` for `tidyverse`

library(readr)
library(dplyr)
library(tidyr)
library(here)

#' we'll be bringing in two datasets for this example
#' 
#' the first is our sample dataset, downloaded from the Data Interaction portal:
#' https://txreports.emetric.net/?domain=1&report=1
#' the .csv has three rows before the data starts, so we'll strip them out on import
#' using `skip`

sample <- readr::read_csv(here("data", "sample_001.csv"), skip = 3)

#' the second is the CREF file, which is a dataset that has all the campus names 
#' (along with additional information) for every K - 12 campus in the state of 
#' Texas (current as of November 2017)
#' https://rptsvr1.tea.texas.gov/perfreport/tapr/2017/download/DownloadData.html 
#' 
#' we're using this data to join with our sample data in order to get a column that
#' tells us if a row contains a school name or not

cref <- read_csv(here("data", "CREF.csv")) %>% 
  select(DISTNAME, CAMPNAME)  # these are the only two columns we need
  
disd <- cref %>% 
  filter(DISTNAME == "DALLAS ISD") %>%  # we only have DISD schools in our sample
  mutate(school_name = CAMPNAME) %>%  # creating a duplicate column with school names
  select(-DISTNAME)  # we no longer need the district designation

#' we won't need the cref file again in this example, so we can remove it
rm(cref)
