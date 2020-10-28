
### Import libraries and data

rm(list = ls())
library(tidyverse)
library(officer)
library(magrittr)
library(knitr)
library(ggthemes)
options(scipen=999)

### Produce slide content

# Create and save data visualizations and tables below.

covid <- read_csv('https://rb.gy/lzlylj')
crime <- read_csv('https://rb.gy/5zuayh') 

### Write content to PowerPoint

read_pptx() %>%
  [...] %>% # the code you write to produce your pptx file 
  print(target = 'your_file.pptx')
  
