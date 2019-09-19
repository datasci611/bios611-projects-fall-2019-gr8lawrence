# Urban Ministries of Durham Cafe Food Distribution

## A Little Background
The community cafe at Urban Ministries of Durham serves three meals per day to the shelter residents. In the fiscal year of 2014-2015, the cafe serves 712 meals per day on average. 90% of the food served at the cafe comes from donations by well-meaning community partners; The volunteers also prepare 90% of the food served each day (http://www.umdurham.org/what-we-do/cafe.html). To effectively allocate food for daily uses is then key to maximizing the resources Urban Ministries of Durham have at hand. In this project, I aim at providing insightsfor the best way to distribute food through modeling the average food consumption in pounds per person per day at the community cafe.  

## Data And Useful Variables
The dataset contains all records of daily distributions of items served at the Urban Ministries of Durham. For my project in particular, the variables "Dates", "Food.Provided.for", and "Food.Pounds" are important for us to sort out the food consumption in pounds per person per day and model on the data.

## Method
First, dataset will be cleaned and all the rows with missing entries removed. Then we aggregate the food in pounds and people served for each day. Next, we remove the outliers and fit a linear model on the rest of the data to work out the best estimate for food consumptions in pounds for a person per day.

