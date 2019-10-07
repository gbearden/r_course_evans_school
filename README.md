
<p align="center">
  <b>Syllabus</b><br>    
  <b>Autumn 2019</b><br>
  <b>Introduction to Data Processing and Visualization Design in R  </b><br>
</p>

Graham Bearden  
gbearden@uw.edu  
Time: 9:00AM - 11:50AM  
Class Dates: 10/5, 10/12, 10/19, 10/26  
Location: [CDH 110B](http://www.washington.edu/maps/#!/cdh)

## Overview

This workshop teaches the fundamental skills required to prepare, analyze and report data in R. This is an introductory course that will avail R functionality in a way that is accessible to new R programmers. 

Course materials are prepared in order to offer a survey of selected R functionality. Students interested in R programming that is more sophisticated and/or specialized than what is taught in the workshop are encouraged to seek additional opportunities to apply their R programming skills.

This is an applied course that focuses on successful execution of code. While students should consider theory, style, and efficiency of R programming, getting the job done right will be the first priority of the workshop.

## Course Expectations

- Attend four classes. Class dates are October 5, 12, 19, and 26. A full class is 2 hours and 50 minutes, breaks included.
- Submit a 2 slide PowerPoint deck generated in R that includes bullet points, at least one table, and at least one chart produced with the ggplot library
  - Due by October 28
  - Do not print code in output (echo = FALSE)
 
## Accomodations

Washington state law requires that UW develop a policy for accommodation of student absences or significant hardship due to reasons of faith or conscience, or for organized religious activities. The UW’s policy, including more information about how to request an accommodation, is available at Religious Accommodations Policy (https://registrar.washington.edu/staffandfaculty/religious-accommodations-policy/). Accommodations must be requested within the first two weeks of this course using the Religious Accommodations Request form (https://registrar.washington.edu/students/religious-accommodations-request/). 

Please let me know if you need any specific accomodations related to religious observation or otherwise. I will help provide accomodations in accordance with Evans School policy and Washington state law.

## Schedule

#### October 5 | [Part 1](http://rpubs.com/gbearden/r_basics_aut19)

Part 1 will focus on the basics of R. Students will learn about key R concepts like data types and the anatomy of a function, how to read (import) and write (export) data, and the essentials of writing successful code.

We will also begin to explore the `tidyverse` as a data processing tool and troubleshooting tactics students can use to solve coding errors.

At the end of Part 1, students should be familiar with the R interface, know how to perform basic operations, and walk through a series of steps to troubleshoot code.

Course materials: [Base R cheat sheet](https://www.rstudio.com/wp-content/uploads/2016/05/base-r.pdf), [Data transformation cheat sheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)

#### October 12 | Part 2

Part 2 will focus on data processing. We will use a variety of methods to manipulate data and prepare it for analysis. The `tidyverse` will be emphasized. Students will learn how to manipulate data at various levels, including at the dataset-level, the variable-level, and the value-level.

At the end of Part 2, students should be able to transform datasets of varying levels of complexities into data suitable for analysis.

Class reference materials: [Data transformation cheat sheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)

#### October 19 | Part 3 

Part 3 will focus on data visualization. We will use `ggplot`, a visualization library that is part of the `tidyverse`, to build a variety of charts. The modularity of `ggplot` charting functions will be emphasized as will the distinction between visualizing aggregated and non-aggregated data.

At the end of Part 3, students should be able to produce a standard set of charts and manipulate chart aesthetics.

Class reference materials: [Data visualization cheat sheet](https://www.rstudio.com/wp-content/uploads/2016/11/ggplot2-cheatsheet-2.1.pdf), [Coolors](https://coolors.co/)


#### October 26 | Part 4

Part 4 will focus on reporting analyses with `officer`, a library that makes it easy to create PowerPoint decks. `officer` integration allows you to 'pipe into' PowerPoint analyses calculated in R in the form of text, tables, and charts. 

At the end of Part 4, students should be able to build PowerPoint decks that include R-generated analyses.

Class reference materials: [officer PowerPoint vignette](https://cran.r-project.org/web/packages/officer/vignettes/powerpoint.html), [Evans School PowerPoint Template](https://github.com/gbearden/r_course_evans_school/blob/master/evans_school_template.pptx)

## Data

We will use the datasets below in our workshop. These datasets are also used in the Computational Thinking for Governance Analytics course. ([Here](https://github.com/gbearden/r_course_evans_school/blob/master/process_course_data.r) is code to prepare the political contributions and Seattle crime data.)

* [Contributions to Candidates and Political Committees](https://data.wa.gov/Politics/Contributions-to-Candidates-and-Political-Committe/kv7h-kjye)
  * [Political Contributions Dataset](https://raw.githubusercontent.com/gbearden/r_course_evans_school/master/data/contributions_data.txt)
* [Seattle Police Department 911 Incident Response](https://data.seattle.gov/Public-Safety/Crime-Data/4fs7-3vj5)
  * [Seattle Crime Dataset](https://raw.githubusercontent.com/gbearden/r_course_evans_school/master/data/crime_data.txt)

## R Download

If you have not downloaded R and R Studio already, use the links below to set up your machines.

* Install R ([on a Mac](https://cloud.r-project.org/bin/macosx/R-3.6.1.pkg) and [on a PC](https://cloud.r-project.org/bin/windows/base/R-3.6.1-win.exe))  
* Install R Studio ([on a Mac](https://download1.rstudio.org/desktop/macos/RStudio-1.2.1335.dmg) and [on a PC](https://download1.rstudio.org/desktop/windows/RStudio-1.2.1335.exe))

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


---
Here are syllabi for previous workshops: [Autumn 2018](https://github.com/gbearden/r_course_evans_school/blob/master/previous_courses/syllabus_a18.md), [Winter 2018](https://github.com/gbearden/r_course_evans_school/blob/master/previous_courses/syllabus_w18.md)
