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
      textOutput(outputId = "explanations")
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      # Output: App Manual
      textOutput(outputId = "manual"),
      
      # Output 1: The summary table
      tableOutput(outputId = "summaryTable"),
      
      # Output 2: The boxplots for summarizing numeric variables by month
      plotOutput(outputId = "byMonthPlot")
      
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
  
  # Create a text output for the manual
  output$manual <- renderText({"This is an app designed to help you check the data, especially the numeric entries and dates, by summarizing the data for you.
          For each numerical variable, it will return a table with summary statistics of the variable so you can check whether there are abnormal values that drive the data crazy. It also allows you 
          to see the distribution of data entries across 12 months to judge whether they make sense based on your practical knowledge. Just click on the button to select the variable you wish to check. For dates,
    it allows you to check the range of the years and the number of records before 1980 and after 2019 (anachronistic records) as well as for each month (plotted in a histogram) to determine the consistency of entries."})
  
}

shinyApp(ui = ui, server = server)
