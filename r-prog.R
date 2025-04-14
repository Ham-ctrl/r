# r prog: challenge-Data_Explo
{
       "cells": [
           {
               "cell_type": "markdown",
               "metadata": {},
               "source": [
                   "## **Flights Data Exploration Challenge**\n",
                   "\n",
                   "A significant part of a data scientist's role is to explore, analyze. In this challenge, you'll explore a real-world dataset containing flights data from US Depattment of Transportatiin.\n",
                   "\n",
                   "Let's start by loading required packages.\n",
               ]
           },
           {
              "cell_type": "code",
              "execution_count": null,
              "metadata": {},
              "outputs": [],
              "source": [
                   "# Load packages that you'll require in this adventure\n",
                   "suppressPackageStartupMessages({\n",
                   "library(tidyverse)\n",
                   "library(summarytools)\n",
                   "library(glue)\n",
                   "library(patchwork)\n",
                   "})\n",
              ]
           },
           {
                   "cell_type": "markdown",
                   "metadata": {},
                   "source": [
                       "Now, we can import the data into R and start doing some data science on it!\n",
                       "\n",
                   ]
           },
           {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs":[],
                  "source": [
                      "Load and view thr data\n",
                      "df_flights <- read_csv(\"https://raw.githubusercontent.com/MicrosoftDocs/ml-basics/master/challenges/data/flights.csv\", show_col_types = FALSE)\n",
                      "\n",
                      "df_flights %>%\n",
                      " slice_head(n = 7)\n"
                  ]
           },
           {
                  "cell_type": "markdown",
                  "metedata": {},
                  "source": [
                      "The dataset contains observations of US domestic flights in 2013, and consist of the following fields:\n",
                      "\n",
                      "- **Year**: The year of the flight(all records are from 2013)\n",
                      "\n",
                      "- **Month**: The month of the flight\n",
                      "\n",
                      "- **DayOfMonth**: The day of the month on which the flight departed.\n",
                      "\n",
                      "- **DayOfWeek**: The day of the week on which the flight departed - from 1 (Monday) to 7 (Sunday)\n",
                      "\n",
                      "- ** Carrier**: The two-letter abbreviation for the airplane\n",
                      "\n",
                      "- **OriginAirportID**: A unique numeric identifier for departure airport\n",
                      "\n",
                      "- **OriginAirportName**: The full name of departure airport\n",
                      "\n",
                      "- **OriginCity**: The departure airport city\n",
                      "\n",
                      "- **OriginState**: The departure airport state\n",
                      "\n",
                      "- **DestAirportID**: A unique numeric identifier for destination airport\n",
                      "\n",
                      "- **DestAirportName**: The full name of destination airport\n",
                      "\n",
                      "- **DestCity**: The destination city airport\n",
                      "\n",
                      "- **DestState**: The destination state airport\n",
                      "\n",
                      "- **CRSDepTime**: The schedule departure time\n",
                      "\n",
                      "- **DepDelay**: The number of minutes departure was delay (flight that left ahead of schedule have a negative value)\n",
                      "\n",
                      "- **DelDelay15**: A binary indicator that indicates departure was delayed\n",
                      "\n",
                      "- **CRSArrTime**: The schedule arrival time\n",
                      "\n",
                      "- **ArrDelay**: The number of minutes arrival was delayed (flight that arrived ahead of schedule have a negative value)\n",
                      "\n",
                      "- **ArrDelay15**: A binary indicator that arrival was delayed by more than 15 minutes ( and therefore considered \"late\")\n",
                      "\n",
                      "- **Cancelled**: A binary indicator that the flight was cancelled\n",
                      "\n",
                      "Your challenge is to explore the flight data to analyze possible factors that affect delay in departure or arrival of a flight\n",
                      "\n",
                      "1. Start by cleaning the data\n",
                      "\n",
                      "- Identify any null or missing data, and impute appropriate replacement value.\n",
                      "\n",
                      "- Identify and eliminate any outlier in the **DepDelay** and **ArrDelay** columns.\n",
                      "\n",
                      "2. Explore the clean data\n",
                      "\n",
                      "- View summary statistics for the numeric fields in the dataset\n",
                      "\n",
                      "- Determine distribution of **DepDelay** and **ArrDelay** columns.\n",
                      "\n",
                      "- Use statistics, aggregate functions, and visualization to answer the following questions:\n",
                      "\n",
                      "  - *What are the average (mean) departure and arrival delays?*\n",
                      "\n",
                      "  - *How do carrier compare interms of arrival delays performance?*\n",
                      "\n",
                      "  - *Is there a noticeable difference in arrival delays for difference days of the week?*\n",
                      "\n",
                      "  - *Which departure airport has the highest average departure delay?*\n",
                      "\n",
                      "  - *Do **late** departure tend to result in longer arrival delays than on-time departure?\n*",
                      "\n",
                      "  - *Which route (from origin airport to destination airport) has the most **late** arrival\n*",
                      "\n",
                      "  -*which route has the highest average arrival delays?\n*",
                      "\n",
                      "Sometimes, when alot of columns in our data, it may difficult to get grip of the data at first sight using 'slice_head'\n",
                      "\n",
                      "`glimpse` produce a transpose version where columns run down the page, and data run across. This makes it possible to see every column in data frame. Into the bargain, it also shows the dimension of the tibble and the undrlying data types of the column.\n",
            ]
           },
           {
                "cell_type": "code",
                "execution_count": null,
                "metadata": {},
                "outputs": [],
                "source": [
                    "# Get a glimpse of your data\n",
                    "df_flights %>%\n",
                    "glimpse()\n"
                ]
           },
           {
                "cell_type": "markdown",
                "metadata": {},
                "sources": [
                    "## Clean missing values\n",
                    "\n",
                    "Once you have imported your data, it is always a good idea to clean it. sadly, it is often chronically underestimaed, yet it's a fundamental step required for subsequent operation in data analysis.\n",
                    "\n",
                    "Let's find how many null values there are for each column.\n",
                ]
           },
            {
               "cell_type": "code",
               "execution_count": null,
               "metadata": {},
               "outputs": [],
               "source": [
                   "# Find how many null values there are for each column.\n",
                   "colSums(is.na(df_flights))\n"
               ]
            },
            {
              "cell_type": "markdown",
              "metadata": {},
              "source": [
                  "Hmm, looks like there are some NA (missing values) `late departure` indicators (DepDel15 column). Departures are considered late if the delay is 15 minutes or more, so let's see the delays for the ones with an NA late indicator:\n"
                  "\n",
                  "**Question 1.\n**",
                  "\n",
                  "Starting with `df_flights`, **select** columns `DepDelay` and `DepDel15` then **filter** to obtain rows where the value of `DepDel15` is `NA`. Assign the results in a variable name `flights_depdel`\n",
                  "\n",
                  "Fill in the placeholder `....` with the right code."
              ]
            },
            {
              "cell_type": "code",
              "execution_count": null,
              "metadata": {},
              "outputs": []
              "source": [
                  "# Select columns DepDelay and DepDel15.\n",
                  "and then Filter the tibble to obtain.\n",
                  "# Observation where there is missing value of DepDel15."
                  "\n",
                  "flight_depdel <- df_flights %>%\n",
                  " select(....,....) %>%\n",
                  " filter(is.na(....))\n"
              ]
            },
             {
               "cell_type": "markdown",
               "metadata": {},
               "source": [
                   "Test your answer:\n",
                   "\n"
               ]
             },
              {
               "cell_type": "code",
               "execution_count": null,
               "metadata": {},
               "outputs": [],
               "source": [
                   ". <- ottr::check(\"testQuestion 1.R\")\n"
               ]
              },
               {
                "cell_type": "markdown",
                "metadat":{},
                "source": [
                    "Good job! Now, let's `glimpse` at `flight_depdel`\n",
                    "\n"
                ]
               },
                {
                "cell_type": "code",
                "execution_count": null,
                "metadata": {},
                "outputs": [],
                "source": [
                    "flights_depdel %>%\n",
                    " glimpse()\n"
                ]
                },
                {
                 "cell_type": "markdown",
                 "metadata": {},
                 "source": [
                     "From the first of few of few observations, it look like obsrtvations in `DepDel15` (binary indicator that departure was delayed by more than 15 minutes.) all have a corresponding delayed of 0 in `DepDelay` (the number of minutes departure was delayed). Let's check by looking at summary statistics for the `DepDelay` records:\n",
                     "\n"
                 ]
                },
                {
                 "cell_type": "code",
                 "executive_count": null,
                 "metadata": {},
                 "outputs": [],
                 "source": [
                     "Get summary statistics using summary function\n",
                     "df_flight %>%\n",
                     "filter(rowSums(is.na(.)) > 0) %>%\n",
                     "select(DepDelay)\n",
                     "summary()\n"
                 ]
                },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                      "The min, max and mean are all 0\n",
                      "\n",
                      "**Question 2**\n",
                      "\n",
                      "Starting with `df_flights`, replace the missing value in the column **DepDel15** with `0`. Assign to a variable name `df_flights`\n."
                      "\n",
                      "Fill in placeholder `....` with the right code.\n",
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs": [],
                  "sources": [
                      "# Replace missing value in DepDel15 with 0\n",
                      "df_flights <- df_flights %>%\n",
                      "mutate(DepDel15 = ....)\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                      "Test your answer:\n",
                      "\n"
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                      ". <- ottr::chech(\"tests/Question 2.R\")\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                  "Good job! no missing values now. Let's take this a little further.\n",
                  "\n",
                  "## **clean outliers**\n",
                  "\n",
                  "An outlier is a data point that differs significantly from other observations. Let's create a function that shows the distribution and summary statistics for a given column.\n",
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                  "Function to show summary stats and distribution for a column\n",
                  "show_distribution <- function(var_data, binwidth) {\n",
                  "\n",
                  " # Get summary statistics by first extracting values from the column\n",
                  "min_val <- min(pull(var_data))\n",
                  "max_val <- max(pull(var_data))\n",
                  "mean_val <- mean(pull(var_data))\n",
                  "med_val <- median(pull(var_data))\n",
                  "mod_val <- statip::mfv(pull(var_data))\n",
                  "\n",
                  " # Print the stats\n",
                  " stat <- glue::(\n",
                  " \"Minimum: {format(round(min_val, 2), nsmall = 2)}\n",
                  " Mean: {format(round(mean_val, 2), nsmall = 2)}\n",
                  " Median: {format(round(median_val, 2), nsmall = 2)}\n",
                  " Mode: {format(round(mode_val, 2), nsmall = 2)}\n",
                  " Maximum: {format(round(max_val, 2), nsmall = 2)}\n",
                  ")\n",
                  "\n",
                  "  theme_set(theme_light())\n",
                  "  # Plot the histogram\n",
                  " hist_gram <- ggplot(var_data) +\n",
                  "geom_histogram(aes(x = pull(var_data)), binwidth = binwidth,\n",
                  "               fill = \"midnightblue\", alpha = 0.7, boundary = 0.4)+\n",
                  "\n",
                  " # Add lines for statistics\n",
                  "geom_vline(xintercept = min_val, color = \"gray33\",\n"
                  "linetype = \"dashed\", size = 1.3) +\n",
                  "geom_vline(xintercept = mean_val, color = \"cyan\", \n",
                  "linetype = \"dashed\", size = 1.3) +\n",
                  "geom_vline(xintercept = med_val, color = \"red\", \n",
                  "linetype = \"dashed\", size = 1.3) +\n",
                  "geom_vline(xintercept = mod_val, color = \"yellow\", \n",
                  "linetype = \"dashed\", size = 1.3) +\n",
                  "geom_vline(xintercept = max_val, color = \"gray33\", \n",
                  "linetype = \"dashed\", size = 1.3) +\n",
                  "\n",
                  " # Add titles and labels\n",
                  "ggtitle(\"Data Distribution\") +\n",
                  "xlab(\"\") +\n",
                  "ylab(\"Function\") +\n",
                  "theme(plot.title = element_text(hjust = 0.5))\n",
                  "\n",
                  " # Plot the boxplot\n",
                  "bx_plt <- ggplot(data = var_data) +\n",
                  "geom_boxplot(mapping = aes(x = pull(var_data), y = 1), \n",
                  "             fill = \"#E69F00\", color = \"gray23\", alpha = 0.7)+\n",
                  "\n",
                  "  # Add titles and labels\n",
                  "xlab(\"value\")\n",
                  "ylab(\"\")\n",
                  "theme(plot.title = element_text(hjust = 0.5))\n",
                  "\n",
                  " # To return multiple outputs, use a `list`\n",
                  "return(\n",
                  "\n"
                  "  list(stats,\n",
                  "       hist_gram / bx_plt)) # END of function output\n", 
                  "\n",
"} #END of function\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                  "**Question 3.** Starting with the `df_flights` data, only keep the **`DepDelay`** column. Assign this to a variable name `df_col`.\n",
                  "\n",
                  "Once you have this figured out, call the function `show_distribution` with the arguments names and corresponding values as follows: `var_data = df_col` and `binwidth = 100`\n",
                  "\n",
                  "From the function output, what's the distribution of **DepDelay** (the number of minutes departure was delayed)?\n",
                  "\n",
                  "Fill in the placeholder `....` with the right code."
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                      "# Select DepDelay column\n",
                      "df_col <- df_flights %>%\n",
                      "  ....\n",
                      "\n",
                      "# call the function show_distribution\n",
                      "show_distribution(var_data = df_col, binwidth = 100)\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                  "Test your answer:\n",
                  "\n"
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                      ". <- ottr::check(\"testsQuestion 3.R\")\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                      "Now, let's investigate the distribution of **ArrDelay** (the number of minutes arrival was delayed)\n",
                      "\n",
                      "**Question 4.** Stating with the `df_flights` data, only keep the **`ArrDelay`** column. Assign this to variable name `df_col.`\n",
                      "\n",
                      "Once you've figured this out, call the function `show_distribution` with the arguments names and corresponding values as follows: `var_data = df_col` and `binwidth = 100` ( value of the width of each bin along the X-axis)\n"
                      "\n",
                      "From the function output, what's the distribution of **ArrDelay**?\n",
                      "\n",
                      "Fill in the placeholder `....` with the right code."
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                      "# Select DepDelay column.\n", 
                      "df_col <- df_flughts %>%\n",
                      "  ....\n",
                      "\n",
                      "# Call function show_distribution\n",
                      "show_distribution(var_data = df_col, binwidth = 100)\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                      "Test your answer:\n",
                      "\n"
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                      ". <- ottr::check(\"testsQuestion 4.R\")\n",
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                      "From both outputs, there are outliers at both the lower and upper ends of both variables.Let's trim the data so we include only rows where the values of these fields are within the 1st and 90th percentile. We begin with the **ArrDelay** obsrrvation.\n",
                      "\n"
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                      "# Trim outlier for ArrDelay based on 1% and 90% percentiles\n",
                      "# Produce quantile corresponding to 1% and 90%\n",
                      "arrdelay_01pcntile <- df_flights %>%\n",
                      "  pull(ArrDelay) %>%\n",
                      "  quantile(probs = 1/ 100, names = FALSE)\n",
                      "\n",
                      "arrdelay_90pcntile <- df_flights %>%\n",
                      "  pull(ArrDelay) %>%\n",
                      "  quantile(probs = 90 / 100, names = FALSE)\n",
                      "\n",
                      "# Print 1st and 90th quantiles respectively\n",
                      "cat(arrdelay_01pcntile, \"\\n\", arrdelay_90pcntile)\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                      "Now that we have quantiles corresponding to 1% and 90%, let's filter the `df_flights` data to only includes rows whose Arrival delay falls within this range\n",
                      "\n",
                      "**Question 5.** Starting with the `df_flights` data, filter to only include rows whose **ArrDelay** falls within 1st and 90th quantiles. Assign this to a variable name `df_flights`\n",
                      "\n",
                      "Fill in the placeholder `....` with the right code"
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs": []
                  "source": [
                      "# Fill data to remove outliers\n",
                      "df_flights <- df_flights %>%\n",
                      "filter(ArrDelay > ...., ....)\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": [],
                  "source": [
                      "Test your answer:\n",
                      "\n"
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_time": null,
                  "metadata": {},
                  "outputs": [],
                  "source":[
                      ". <- ottr::check(\"testsQuestion 5.R\")\n"
                  ]
                 },
                 {
                  "cell_type": "markdow",
                  "markdown": null,
                  "source": [
                      "Now, let's do the same for `DepDelay` column.",
                      "\n",
                      "**Question 6** Starting with the `df_flights` data, obtain quantiles corresponding to 1% and 90%. Assign these values to variable names `depdelay_01pcntile` and `depdelay_09pcntile` respectively\n",
                      "\n",
                      "Fill in the placeholder `....` with the right code."
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": [],
                  "outputs": [],
                  "source": [
                      "# Trim outlier for DepDelay based on 1% and 90% percentiles\n",
                      "# Produce quantiles corresponding to 1% and 90%\n",
                      "depdelay_01pcntile <- df_flights %>%\n",
                      " ....%>%\n",
                      " ....\n",
                      "\n",
                      "depdelay_90pcntile <- df_flights %>%\n",
                      " .... %>%\n",
                      " ....\n"
                      "\n"
                      "# Print 1st and 90th quantiles respectively\n",
                      "cat(depdelay_01pcntile, \"\\n\", depdelay_90pcntile)\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                      "Test your answer:\n",
                      "\n"
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                      ". <- ottr::check(\"testsQuestion 6.R\")\n"
                  ]
                 },
                 {
                  "cell_type", "markdown",
                  "metadata": [],
                  "source": [
                      "Good job!!\n",
                      "\n",
                      "Now that we have quantiles corresponding to 1% and 90%, let's filter the `df_flights`, data to only includes rows whose Departure delay falls within this range.\n"
                      "\n",
                      "**Question 7.** Starting with the `df_flights` data, filter to only include rows whose **DepDelay** falls within 1st and 90th quantiles. Assign this to a variable name `df_flights`.\n",
                      "\n",
                      "Fill in the placeholder  `....` with the right code."
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                      "# Filtrr data to remove outliers\n",
                      "df_flights <- df_flights %>%\n",
                      "  ....\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                      "Test your answer\n",
                      "\n"
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                      ". <- ottr::check(\"tests\"Question 7.R\")\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                      "You rock\n",
                      "\n",
                      "Now, we can check the distribution our two variables with outliers removed.\n"
                  ]
                 },
                 {
                  "cell_type": "code",
                  "exection_count": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                      "# distribution of DepDelay.\n",
                      "show_distribution(var_data = select(df_flightd, DepDelay), binwidth = 2)\n"
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                      "# Distribution of ArrDelay\n",
                      "show_distribution(var_data = select(df_flights, ArrDelay), binwidth = 2)\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                      "Much better\n",
                      "\n",
                      "Now that the data is all cleanup, we can begin doing exploratory data analysis.\n"
                      "\n",
                      "## ** explore the data**\n",
                      "\n",
                      "Let's start with an overall view of the summary statistic for numeric column.\n"
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                      "# obtain summary statistics using summarytools package.\n",
                      "df_flight %>%\n",
                      "decr(stats = \"common\")\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                      "## **What are the mean departure and arrival delays?**\n",
                      "\n",
                      "**Question 8.** Starting with the `df_flight` data use `across()` within `summarize()` to find the mean across `DepDelay` and `ArrDelay` columns. Assign this to `df_delay` variable name. What are the mean delays?\n"
                      "\n",
                      "Fill in the placeholder `....` with the right code."
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": [],
                  "outputs": [],
                  "source": [
                      "# Summarise the departure and arrival delays by finding the mean\n",
                      "df_delays <- df_flights %>%\n",
                      "summarise(across(....))\n",
                      "\n",
                      "df_delays\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                      "Test your answer\n",
                      "\n",
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                  ". <- ottr::check(\"testsQuestion 8.R\")\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                      "### **How do the carriers compare in terms of arrival delay performance?**\n",
                      "A boxplot can be a good way for graphically depicting the distribution of groups of numerical data through their quantiles. The `geom` that care of boxplot is `geomboxplot`\n"
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                      "# Compare arrival delays across different carriers\n",
                      "df_flights %>%\n",
                      "ggplot() +\n",
                      "geom_boxplot(mapping = aes(x = carrier, y = ArrDelay))\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                      "### **How do carrier compare in terms of departure departure delay performance?**\n",
                      "\n",
                      "Let's do the same for departure delay performance\n",
                      "\n",
                      "We can only try and rearrange the `carrier` levels in ascending order of delay time and sprinkle some color to the plot too.\n"
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                      "df_flights %>%\n",
                      "mutate(Carrier = fct_reorder(Carrier, DepDelay)) %>%\n",
                      "ggplot() +\n",
                      "geom_boxplot(mapping = aes(x = Carrier, y = DepDelay, color = Carrier),\n",
                      "show.legend = FALSE)\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                      "Altenatively, to create the above plots, we can use `purr::map()` which allow us to apply to apply function to each column. see `?map` for more details.\n"
                      "\n"
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                      "map(df_flights %>% ,select(ArrDelay, DepDelay), ~ggplot(df_flights) +\n",
                      "  geom_boxplot(mapping = aes(x = Carrier, y = .x)) + ylab(\"\"))\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                      "### **Are some days of the week more prone to arrival delays than others?**\n",
                      "\n",
                      "Again, let's make use of a boxplot to visualy inspect the distribution of arrival delay depending on the day of the week. To successfully accomplish this, we have to first encode the week days to `categorical` variable, ie `factors`.\n"
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_code": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                      "# Encode day of the week as a categorical and make boxplots\n",
                      "df_flights %>%\n",
                      "mutate(DayOfWeek = factor(DayOfWeek)) %>%\n",
                      "ggplot() +\n",
                      "geom_boxplot(mapping = aes(x = DayOfWeek, y = ArrDelay),\n",
                      "show.legend = FALSE)\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                      "### **Are some days of the days more prone to departure delays than others?**\n",
                      "\n",
                      "Now, over to you.\n",
                      "\n",
                      "**Question 9.** let's investigate whether some days of the week (x axis) are more prone to departure delay (y axis) than others. Start encoding day of the week as a categorical data\n",
                      "\n",
                      "Fill in the placeholder `....` with the right code."
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                      "# Encode day of the week as a categorical variable\n",
                      "df_flights <- df_flights %>%\n",
                      "mutate(....)\n",
                      "\n",
                      "# Make a box plot of DayOfWeek and DepDelay\n"
                      "dep_delay_plot <- df_flights %>%\n",
                      "ggplot() +\n",
                      "geom_boxplot(mapping = aes(x = ...., y = ...., color = DayOfWeek),\n",
                      "show.legend = FALSE) +\n",
                      "scale_color_brewer(pallete = \"\")\n",
                      "\n",
                      "dep_delay_plot\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                      "What can you make out of this\n",
                      "Test your answer\n",
                      "\n"
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                      ". <- ottr::check(\"testsQuestion 9.R\")\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                      "Great progress you are having\n",
                      "\n",
                      "## **Which departure airport has the highest average departure delay**\n",
                      "\n",
                      "To answer this, we have to first **group** the data **by** `OriginAirportName` and then **summarise** observation by the **mean** of their departure delay `DepDelay` and then **arrange** this in **descending** order of the mean departure delays.\n",
                      "\n",
                      "Let's put this into code.\n"
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                      "# Use group_by %>% summarize to find airports with the highest avg DepDelay\n",
                      "mean_departure_delay <- df_flights %>%\n",
                      "group_by(OriginAirportName) %>%\n",
                      "summarize(mean_dep_delay_time = mean(DepDelay))\n",
                      "arrange(desc(mean_dep_delay_time))\n",
                      "\n",
                      "# Print first 7 rows\n",
                      "mean_departure_delays %>%\n"
                      "slice_head(n = 7)\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                      "Fantastic!\n",
                      "\n",
                      "Let's represent this using bar plots."
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                     "mean_departure_delays %>%\n",
                     "# Sort factor levels in descending order of delay time\n",
                     "mutate(OriginAirportName = fct_reorder(OriginAirportName,\n",
                     "desc(mean_dep_delay_time))) %>%\n",
                     "ggplot() +\n",
                     "geom_col(mapping = aes(x = OriginAirportName, y = mean_dep_delay_time),\n",
                     "fill = \"midnightblue\", alpha = 0.7) +\n",
                     "theme(\n",
                     "    # Rotate X markers so that we can read them\n",
                     "axis.text.x = element_text(angle = 90)\n",
                     " )\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                      "Could you try and guess why chicago Airport has most departure delays time or why Long Beach has the least?\n",
                      "\n",
                      "### **Do late departure tend to result in longer arrival delays than on-time departure?**\n",
                      "\n",
                      "**Question 10.** Starting with the `df_flights` data, first encode `DepDel15` column ( a binary indicator that departure was delayed by more than 15 minutes) as categorical\n",
                      "\n",
                      "Use a **box plot** to investigate whether late departure (x-axis) tend to result in longer arrivals delays (y-axis) than on-time departures. Map the fill aestgetic to the `DepDelay` variable\n",
                      "\n",
                      "You can color box plot using either the `color` aesthetic (like in the previous exercises), or, more usefully with the `fill` aesthetic.\n",
                      "\n",
                      "Fill in the placeholder `....` with the right code."
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                      "# Encode DepDel15 as a categorical variable\n",
                      "df_flights <- df_flight %>%\n",
                      "mutate(DepDel15 = factor(DepDel15))\n",
                      "\n",
                      "arr_delay_plot <- df_flight %>%\n",
                      "ggplot() +\n",
                      "geom_boxplot(mapping <- aes(x = ...., y = ...., fill = ....))\n",
                      "\n",
                      "arr_delay_plot\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                      "Does this surprise you\n",
                      "\n",
                      "Test your answrr:\n"
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                      ". <- ottr::check(\"tests/Question 10.R\")\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                      "### **Which route (from origin airport to destination airport) has the most late arrivals**\n",
                      "Finally, let's investigate travel routes. We'll start by adding a column `Route` that indicates the Origin and Destination airports.\n",
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                      "# Add a \"Route\" column\n",
                      "df_flights <- flights %>%\n",
                      "mutate(Router = paste(OriginAirportName, DestAirportName, sep = \">\"))\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                  "Great!, Now we can use `gropu_by()`, `summaize()` and `arrange()` to find the routes with the most late arrivals\n",
                  ]
                 },
                 {
                  "cell_type": "code",
                  "executikn_count": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                      "# Make group summaries to find total delay\n",
                      "# Associate with a particular route\n",
                      "df_flights %>%\n",
                      "   group_by(Route) %>%\n",
                      "summarize(ArrDel15 = sum(ArrDel15)) %>%\n",
                      "arrange(desc(ArrDel15))\n"
                  ]
                 },
                 {
                  "cell_type": "code",
                  "metadata": {},
                  "source": [
                      "### **Which route has the highest average arrival delay time?\n**\n",
                      "\n",
                      "Over to you!\n",
                      "\n",
                      "**Question 11.** Starting with the `df_flights` data group observations by `Route` then create summary tibble with a column name `ArrDelay` which represent the mean arrival delay time. Arrange this in decending order.\n",
                      "\n",
                      "Assign your results to a variable name `df_route_arrdelay`.\n",
                      "\n",
                      "Fill in the placeholder `....` with the right code."
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                      "# create grouped summaries of arrival delaytime\n",
                      "df_route_arrdelay <- df_flights %>%\n",
                      "  .... %>%\n",
                      "  summarise(ArrDelay = ....) %>%\n",
                      "  ....(desc(....))\n",
                      "\n",
                      "\n",
                      "# Print the first 5 rows\n",
                      "df_route_arrdelay\n",
                      "  slice_head(n = 5)\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                      "Test your answer:\n",
                      "\n"
                  ]
                 },
                 {
                  "cell_type": "code",
                  "execution_count": null,
                  "metadata": {},
                  "outputs": [],
                  "source": [
                      ". <- ottr::check(\"tests/Question 11.R\")\n"
                  ]
                 },
                 {
                  "cell_type": "markdown",
                  "metadata": {},
                  "source": [
                      "Congratulations on finishing the first challenge! We'll wrap it at that for now. Ofcoutse there are other ways to approach this challenge. So feel free to experiment, google and share your solution with friends.\n",
                      "\n",
                      "See you in the next module where we get started with machine learning\n",
                      "\n",
                      "Happy Learning\n"
                  ]
                 },
       ],
       "metadata": {
           "anaconda-cloud": "",
           "kernel-spec": {
               "display_name": "R",
               "language": "R",
               "name": "ir",
           },
           "language_info": {
               "codemirror_mode": "r",
               "file_extension": ".r",
               "mimetype": "text/x-r-source",
               "name": "R",
               "pygments_lexer": "r",
               "version": "4.1.2"
           }
       },
       "nbformat": 4,
       "nbformat_mirror": 1
}
