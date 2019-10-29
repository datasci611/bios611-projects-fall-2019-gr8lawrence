library(shinydashboard)
source("helper_function.R")

# Define UI for app that allows users to select variables and draw violin plots----
ui <- fluidPage(
  
  # App title ----
  titlePanel("UMD Data Inspection Dashboard"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Radio buttons for selecting the x-axis variable ----
      radioButtons(inputId = "Variable",
                   label = "Variable to View:",
                   choices = c("Dates" = "Date", 
                               "Number of Bus Tickets" = "Bus.Tickets..Number.of.", 
                               "Food Provided For" = "Food.Provided.for",
                               "Food Distributed in Pounds" = "Food.Pounds" ,
                               "Clothing Items Distributed" = "Clothing.Items",
                               "Diapers Distributed" = "Diapers" ,
                               "School Kits Distributed" = "School.Kits",
                               "Hygiene Kits Distributed" = "Hygiene.Kits",
                               "Financial Support" = "Financial.Support"),),
      
      # Input: Users are allowed to select whether to include zeroes in the numeric values
      radioButtons(inputId = "IncludeZeroes",
                   label = "Include 0's ? (Numerical Variables Only)",
                   choices = c("Yes" = TRUE,
                               "No" = FALSE)),
      
      # Output: the text output
      fluidRow(
        column(width = 12,
          textOutput(outputId = "explanations")
          )
      ),
      
      # Output: helpful links
      fluidRow(
        column(h5("Helpful links:"), 
               width = 12, align = "center",
               uiOutput(outputId = "tab1")
               )
      ),
      
      fluidRow(
        column(width = 12, align = "center",
               uiOutput(outputId = "tab2")
        )
      ),
      
      fluidRow(
        column(width = 12, align = "center",
               uiOutput(outputId = "tab3")
        )
      )
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: App Manual
      fluidRow(
        textOutput(outputId = "manual_num")
      ),
      
      fluidRow(
        uiOutput(outputId = "myList_num")
      ),
      
      fluidRow(
        textOutput(outputId = "manual_num2")
      ),
      
      fluidRow(
        uiOutput(outputId = "myList_num2")
      ),
      
      # Output: Summary table and boxplots
      fluidRow(
        column(h5("Summary Statistics Table"),
               width = 12, align = "center",
               # Output 1: The summary table
               tableOutput(outputId = "summaryTable"))
        
      ),
      
      
      fluidRow(
        column(h5("Plots by Month"), 
               width = 12, align = "center",
               # Output 2: The boxplots for summarizing numeric variables by month
               plotOutput(outputId = "byMonthPlot"))
      
      )
      
    )
  )
)

# Define server logic required to show the outputs ----
server <- function(input, output) {
  
  # Create the table output to summarize the data
  output$summaryTable <- renderTable({
    if (input$Variable != "Date") {
      make_summary(UMD_dat[[input$Variable]], include_zeroes = input$IncludeZeroes)
    } else {
      date_year_summary(UMD_dat)
    } 
  })
  
  output$byMonthPlot <- renderPlot({
    if (input$Variable != "Date") {
      by_month_plot(UMD_dat, input$Variable, include_zeroes = input$IncludeZeroes)
    } else {
      date_histogram(UMD_dat)
    }
  })
  
  # Create a text output to show the explanation from the metadata
  output$explanations <- renderText({
    paste("Explanation of the variable:", UMD_metadat[[input$Variable]])
  })
  
  
  # Bullet points for the user instructions
  output$myList_num <- renderUI({
                                if (input$Variable != "Date") {
                                 HTML("<ul>
                                 <li> Return a table of summary statistics </li>
                                 <li> Return boxplots of data across 12 months </li>
                                 <li> User can choose whether to include 0's in generating the outputs </li>
                                 </ul>")
                                  } else {
                                    HTML("<ul>
                                 <li> Return a table of the range of years and the number of anachronistic entries (Year < 1980 or > 2019 ) </li>
                                 <li> Return histograms total number of records 12 months </li>
                                 </ul>")
                                 }
    })
  output$myList_num2 <- renderUI({
                                 if (input$Variable != "Date") { 
                                 HTML("<ul>
                                 <li> Check if extreme values exist in the data (is some value abnormally high?) </li>
                                 <li> Check whether data entry is explainable by variations in month based on practical knowledge </li>
                                 <li> Be able to remove 0's which could mean nothing has happened for that record and whose constant presence can distort summary statistics </li>
                                 </ul>") 
                                 } else {
                                   HTML("<ul>
                                 <li> Check if wrong dates exist in the data </li>
                                 <li> Check whether data entry is consistent across 12 months based (is there any month with abnormally many or few records?)</li>
                                 </ul>")
                                   }
    })
  # Create text outputs for the user instructions
  output$manual_num <- renderText({
    if (input$Variable != "Date") {
          "This is an app designed to help you check the the numeric variables and dates in the data.
          For each numerical variable, it will:"
    } else {
          "This is an app designed to help you check the the numeric variables and dates in the data.
          For dates, it will:"
      }
      })
  output$manual_num2 <- renderText({"So you can:"})
  
  # Creating outputs of helpful links
  url1 <- a("How to read boxplots", href = "https://www.statisticshowto.datasciencecentral.com/probability-and-statistics/descriptive-statistics/box-plot/")
  output$tab1 <- renderUI({
    tagList(url1)})
  
  url2 <- a("How to read histograms", href = "https://digital-photography-school.com/how-to-read-and-use-histograms/")
  output$tab2 <- renderUI({
    tagList(url2)})
  
  url3 <- a("Quantiles", href = "https://en.wikipedia.org/wiki/Quantile")
  output$tab3 <- renderUI({
    tagList(url3)})
  
}

shinyApp(ui = ui, server = server)
