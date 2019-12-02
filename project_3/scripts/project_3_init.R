## This is the master R file for knitting the R markdown
install.packages("knitr", repos = "http://cran.us.r-project.org")
install.packages("kableExtra", repos = "http://cran.us.r-project.org")
install.packages("rmarkdown", repos = "http://cran.us.r-project.org")
file.exists('./scripts/project_3_markdown.Rmd')
rmarkdown::render('./scrtpts/project_3_markdown.Rmd', 'html_document')
