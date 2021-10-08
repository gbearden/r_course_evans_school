
<p align="center">
  <b>Syllabus</b><br>    
  <b>Autumn 2018  </b><br>
  <b>Introduction to Data Processing and Visualization Design in R  </b><br>
</p>

Graham Bearden  
gbearden@uw.edu  
Time: 8:30AM - 2:20PM  
Class Dates: 10/6, 10/13  
Location: [SMI 304](http://www.washington.edu/maps/#!/smi)

## Overview

This workshop teaches the fundamental skills required to prepare, analyze and report data in R. This is an introductory course that will avail R functionality in a way that is accessible to new R programmers. 

Course materials are prepared in order to offer a survey of selected R functionality. Students with interests in more sophisticated R programming than what is taught in the workshop are encouraged to seek additional opportunities to apply their R programming skills.

This is an applied course that focuses on successful execution of code. While students should consider theory, style, and efficiency of R programming, getting the job done right will be the first priority of the workshop.

## Course Expectations

- Attend both classes. Class dates are October 6 and 13. A full class is 5 hours and 50 minutes, breaks included.
- Submit a 1-page report generated in R Markdown that includes bullet points, at least one table, and at least one chart produced with the ggplot library
  - Due by October 22
  - Do not print code in output (echo = FALSE)
 
## Accomodations

Please let me know if you need any specific accomodations. I will help provide accomodations in accordance with Evans School policy.

## Schedule

#### [October 6 | Part 1](http://rpubs.com/gbearden/r_basics_aut18)

Part 1 will focus on the basics of R. Students will learn about key R concepts like data types and the anatomy of a function, how to read (import) and write (export) data, and the essentials of writing successful code.

We will also begin to explore the tidyverse as a data processing tool and troubleshooting tactics students can use to solve coding errors.

At the end of Part 1, students should be familiar with the R interface, know how to perform basic operations, and walk through a series of steps to troubleshoot code.

Course materials: [Base R cheat sheet](https://www.rstudio.com/wp-content/uploads/2016/05/base-r.pdf), [Data transformation cheat sheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)

#### [October 6 | Part 2](http://rpubs.com/gbearden/intro_tidyverse_aut18)

Part 2 will focus on data processing. We will use a variety of methods to manipulate data and prepare it for analysis. The Tidyverse will be emphasized. Students will learn how to manipulate data at various levels, including at the dataset-level, the variable-level, and the value-level.

At the end of Part 2, students should be able to transform datasets of varying levels of complexities into data suitable for analysis.

Class reference materials: [Data transformation cheat sheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)

#### October 13 | Part 3

Part 3 will focus on data visualization. We will use ggplot, a visualization library that is part of the tidyverse, to build a variety of charts. The modularity of ggplot charting functions will be emphasized as will the distinction between visualizing aggregated and non-aggregated data.

At the end of Part 3, students should be able to produce a standard set of charts and manipulate chart aesthetics.

Class reference materials: [Data visualization cheat sheet](https://www.rstudio.com/wp-content/uploads/2016/11/ggplot2-cheatsheet-2.1.pdf), [Coolors](https://coolors.co/)


#### [October 13 | Part 4](http://rpubs.com/gbearden/r_reporting_aut18)

Part 4 will focus on reporting analyses in markdown with knitr. Markdown is a simple language used to streamline documentation/reporting and integrates nicely with R. Markdown integration allows you to 'pipe in' analyses calculated in R in the form of text, tables, and charts. knitr is a built-in R Studio tool (as well as an independent R package) that helps R programmers produce documents derived from code at the press of a button. Mastery of knitr and markdown sets you on the path of learning to automate production of reports.

At the end of Part 4, students should be able to write documents in markdown that include R-generated analyses.

Class reference materials: [R Markdown cheat sheet](https://www.rstudio.com/wp-content/uploads/2016/03/rmarkdown-cheatsheet-2.0.pdf), [Daring Fireball](https://daringfireball.net/projects/markdown/), [Pandoc Markdown](http://rmarkdown.rstudio.com/authoring_pandoc_markdown.html)

## Data

We will use the datasets below in our workshop. These datasets are also used in the Computational Thinking for Governance Analytics course.

* [Contributions to Candidates and Political Committees](https://data.wa.gov/Politics/Contributions-to-Candidates-and-Political-Committe/kv7h-kjye)
  * [Small Contributions Dataset](https://raw.githubusercontent.com/gbearden/r_course_evans_school/master/data/small_donations_data.csv)
* [Seattle Police Department 911 Incident Response](https://data.seattle.gov/Public-Safety/Crime-Data/4fs7-3vj5)
  * [Small Police Dataset](https://raw.githubusercontent.com/gbearden/r_course_evans_school/master/data/small_police_data.csv)

## Reference Materials

R community members produce valuable content to help you learn how to program in R. Here are some of my favorite resources that you might find useful as a new R programmer:

* [R Studio](https://www.rstudio.com/). The R software we will use in the course.
* [tidyverse](http://tidyverse.org/). The launch page for tidyverse.
* [Cheat sheets](https://www.rstudio.com/resources/cheatsheets/)
    + [Base R](https://www.rstudio.com/wp-content/uploads/2016/05/base-r.pdf). This is useful to get started.
    + [Data transformation](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf). I use this all the time when working with dplyr and tidyr.
    + [Data visualization](https://www.rstudio.com/wp-content/uploads/2016/11/ggplot2-cheatsheet-2.1.pdf). A great quick-reference for the ggplot library.
    + [R Markdown](https://www.rstudio.com/wp-content/uploads/2016/03/rmarkdown-cheatsheet-2.0.pdf). A useful reference for using R Markdown.
    + [Lubridate](http://blog.yhat.com/static/pdf/R_date_cheat_sheet.pdf). Dates in R are a pain in the butt. This cheat sheet and the lubridate library will make your life easier.
* [Karl Broman on data organization](http://kbroman.org/dataorg/). Prepare your data according to Karl's recommendations and R will become a lot easier. (The tip is relevant to all other KB recommendations.)
* [Jose Manuel Magallanes on data collection and organization](https://www.amazon.com/Introduction-Science-Social-Policy-Research/dp/1107540259/ref=sr_1_1?ie=UTF8&qid=1504135785&sr=8-1&keywords=jose+manuel+magallanes). Jose teaches the Computational Thinking for Governance Analytics course at the Evans School. He recently published this book!
* [R Bloggers](https://www.r-bloggers.com/). All things R. Folks from various industries - many of whom are super smart with impressive R experience - share tips, tricks, and anecdotes here.
* [stackoverflow](https://stackoverflow.com/questions/tagged/r). This is where you come when you get stuck. Google the problem you are having and you'll see a possible solution on the stackoverflow site. Guaranteed.
* [Google R Style Guide](https://google.github.io/styleguide/Rguide.xml). Your code can get really messy really quickly. This guide can help.
* [Daring Fireball](https://daringfireball.net/projects/markdown/). A page maintained by the markdown creator, [John Gruber](https://en.wikipedia.org/wiki/John_Gruber).
* [Pandoc Markdown](http://rmarkdown.rstudio.com/authoring_pandoc_markdown.html). Among other things, Pandoc is great for formatting tables in R Markdown. I use it regularly. 
* [Coolors](https://coolors.co/). I love this site. It is great inspiration when building charts.
* [Top 50 ggplot2 Visualizations](http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html). Check this out when you want to produce new chart types. It is full of good ideas.
* [Github](https://github.com/). If you're serious about any sort of programming, you should create a Github account.
* [R Notebook Template](https://raw.githubusercontent.com/gbearden/r_course_evans_school/master/template/rmarkdown_template.Rmd)
* [PDF Document Example](https://raw.githubusercontent.com/gbearden/r_course_evans_school/master/template/pdf_template.Rmd)
