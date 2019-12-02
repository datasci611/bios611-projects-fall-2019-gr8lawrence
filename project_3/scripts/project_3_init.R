## This is the master R file for knitting the R markdown
install.packages("knitr")
install.packages("kableExtra")
install.packages("rmarkdown")
rmarkdown::render('project_3_markdown.Rmd', 'html_document')
