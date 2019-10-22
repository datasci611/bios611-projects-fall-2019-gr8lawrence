# Project 2: A Shiny App for Checking Data Quality

## Background
The Urban Ministries of Durham (UMD) keeps track of its service to the members of the shelter through a spreadsheet file. However, the quality of the data is somehow inconsistent throughout the bookkeeping. Practically impossible values and an amount of anachronistic data can be found at some places within the data. I build this small application to allow the member of the UMD staff to check the quality of the data by viewing the summary statistics and plots.

## Goals
The app will allow the following operations:

* Dates:
  * Inspecting the range of the years (is there any anachronistic records?)
  * Inspecting the number of records for each of the 12 months (are some months having much more or much less records than others?)
* Numeric Variables:
  * Inspecting the mean, variance, range, and quantiles of the data through a summary table (is there evidence of practically unlikely values that are much likely due to typos?)
  * Inspecting the mean of the variable with respect to each month (is there evidence that data are not realistic for some months?)
  * Users can choose to include or exclude 0's in making the summary table and the plot.
  
After the user spots the impractical values, he or she can locate and fix them through the functions of the spreadsheet.

## App Website
The website that hosts the app is: https://gr8lawrence.shinyapps.io/611_project_2_TL/
