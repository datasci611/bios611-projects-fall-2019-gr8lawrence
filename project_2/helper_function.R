library(tidyverse)

## Data directory
# data_dir <- "/Users/gr8lawrence/Desktop/Bios_611/bios611-projects-fall-2019-gr8lawrence/project_2/data/"
data_dir <- "./data/"
## Read data
# UMD data
UMD_dat <- as_tibble(read.csv(file = paste(data_dir, "UMD_Services_Provided_20190719.tsv", sep = ""), 
                          sep = "\t", 
                          header = TRUE))

# Create the metadata
UMD_metadat <- tibble(Date = "Date service was provided",
                      Food.Provided.for = "Number of people in the family for which food was provided
",
                      Food.Pounds = "",
                      Clothing.Items = "",
                      School.Kits = "",
                      Hygiene.Kits = "",
                      Financial.Support = "Money provided to clients. Service discontinued.")

# Filtering the data
UMD_dat$Date <- as.Date(UMD_dat$Date, "%m/%d/%Y")
# numeric_dat <- UMD_dat %>% select_if(is.numeric)  

## Helper functions for creating outputs for each module
# Filtering out 0's from data based on the user selection
zero_filtering <- function(numeric_values, include_zeroes) {
  if (include_zeroes) {
    numeric_values = numeric_values %>% na.omit()
  } else {
    numeric_values1 = numeric_values %>% na.omit()
    numeric_values = numeric_values1[which(numeric_values1 != 0)]
  }
  return(numeric_values)
}
# Making summary statistics


make_summary <- function(numeric_values, include_zeroes) {
  numeric_values <- zero_filtering(numeric_values, include_zeroes)
  # Write the summary statistics into a table
  df <- tibble(Total = sum(numeric_values),
               Mean = mean(numeric_values),
               Variance = var(numeric_values),
               Min = min(numeric_values),
               Max = max(numeric_values),
               Q1 = quantile(numeric_values)[[1]],
               Q2 = quantile(numeric_values)[[2]],
               Q3 = quantile(numeric_values)[[3]])
  return(df)
}
# Summary table for months
date_month_summary <- function(df) {
  df = df %>% 
    mutate(Month = factor(months(Date), levels = c("January", "February", "March",
                                                   "April", "May", "June", "July",
                                                   "August", "September", "October",
                                                   "November", "December"))) %>%
    select(Month) %>%
    group_by(Month) %>%
    summarise(Count = n())
  return(df)
}

date_year_summary <- function(df) {
  df = df %>% 
    mutate(Year = as.numeric(substring(Date, 1, 4))) %>%
    select(Year) 
  
  too_early_df = df %>%
    filter(Year < 1980)
  
  too_late_df = df %>% 
    filter(Year > 2019)
   
  summary_df = tibble(Min = min(df$Year),
                      Max = max(df$Year),
                      Before.1980.records = length(too_early_df$Year),
                      After.2019.records = length(too_late_df$Year))
  return(summary_df)
}

date_histogram <- function(df) {
  date_summary_df = date_month_summary(df) 
  q = ggplot(date_summary_df, aes(x = Month, y = Count, fill = Month)) +
    geom_col(alpha = 0.6) + 
    theme_classic() +
    labs(title = paste("Histograms of Total Number of Service Records By Month"),
         x = "Month",
         y = "Count of Records") +
    scale_fill_discrete(name = "Month") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  return(q)
}

# Summarize the median by month
# The data frame must have a column of time stamps named "Date"
by_month_plot <- function(df, variable, include_zeroes) {
  df = df %>%
    mutate(month = factor(months(Date), levels = c("January", "February", "March",
                                                   "April", "May", "June", "July",
                                                   "August", "September", "October",
                                                   "November", "December"))) %>%
    select(month, variable) %>%
    drop_na(variable)
  
  if (include_zeroes == FALSE) {
    df = df[which(df[[variable]] > 0), ]
  }

  q = ggplot(df, aes(x = month, y = get(variable), fill = month)) +
    geom_boxplot(alpha = 0.6) +
    theme_classic() +
    labs(title = paste("Boxplots of", variable, "by Month"),
         x = "Month",
         y = variable) +
    scale_fill_discrete(name = "Month") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))

  return(q)
}






