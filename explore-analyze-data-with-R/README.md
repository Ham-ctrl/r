# Explore and analyze data sith R

## Module source
[Explore and analyze data with R] (https://docs.microsoft.com/en-us/learn/modules/explore-analyze-data-with-r/?WT.mc_id=academic-59300-cacaste)

## Goals

Hello and welcome to this learning adventure! In this folder, you would find a data Exploration Notebook. This is an autograding guided assessment notebook that will help you test your understanding in using R to explore and analyze data! We hope that you will that R, is at its heart, a beautiful and elegant language for data Science.

| **Goal**                     |Descriptio
| ----------------------------- | ----------------------------------------------- |
| **What would you learn**      | How to use R to explore and analyze data |
| **What you'll need**          | [visual studio code] (https://code.visualstudio.com?WT.mc_id=academic-59300-cacaste), [Docker Desktop] (https://www.docker.com/products/docker-desktop), [Remote Developer Extension] (https://aka.ms/vscode-remote/download/extension) and [Git] (https://git-scm.com/downloads) | 
| **Duration**                 | 2 hours
| **Slides**                   | [Powerpoint](./slides.pptx)

## Video

[![workshop work-through](./images/promo.png)](https://youtu.be/VrVHaxarniY "workshop walk-through")
> 🎥 Click this image to watch Carlotta walk you through the workshop material and to gain some tips about delivering this workshop.
>
> ## Pre-Learning
> This workshop allows learners to use the skills learnt in the module [Explore and analyze data with R](https://docs.microsoft.com/en-us/learn/modules/explore-analyze-data-with-r/?WT.mc_id=academic-59300-cacaste) to perform data analysis and visualization. As such, learners are encourage to go through the module before hands so as to be conversant with some of the concept covered in this workshop.


## Prerequisite

To get you up and running and writing R code in no time, we have containerized this workshop such that you have a ready out of the box R coding environment.

### Setting up the development container

A **development** container is a running [Docker](https://www.docker.com) container with a well-defined tool/runtime stuck and its prerequisites. You can try out development containers with **[Github codespaces](https:www.github.com/features/codespaces)**, **[Binder](https://mybinder.org/)** or [Visual studio Code Remote - Container](https://aka.ms/vscode-remote/containers).

##### Github Codespaces
Follow these steps to open this workshop in codespaces:
1. Click the code drop down menu and select the **Open with Codespace** option.
2. Select **+ New codespace** at the bottom on the pane.

For more info, check out the [Github Documentation](https://docs.github.com/en/free-pro-team@latest/github/developing-online-with-codespaces/creating-a-codespace#creating-a-codespace).

#### Binder
This workshop is also available on Binder. To open the notebook in Binder environment, just click the button below.

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/carlotta94c/workshop-library/workshop-binding?labpath=%2Ffull%2Fexplore-analyze-data-with-R%2Fsolution%2Fchallenge-Data_Exploration.ipynb)

#### Learn sandbox
You can also go through this challenge also leveraging on learn sandbox environment, provided by [Unit 9](https://docs.microsoft.com/en-us/learn/modules/explore-analyze-data-with-r/9-challenge-data-exploration) of the MS learn module - Explore and analyze data with R. Just sign in with your Microsoft or Github account and click on **Activat sandbox** to start.

#### VS Code Remote - Containers
Follow these steps to open this container using the VS Code Remote - Containers extension:

1. If this is your first time using a development container, please ensure your system meets the pre-reqs (i.e. have Docker installed) in the [getting started steps](https://aka.ms/vscode-remote/containers/getting-started).

2. Press <kbd>F1</kbd> select and **Add Development Container Configuration File....** command for **Remote-Containers** or **Codespaces**.
 
   >**Note:** If needed, you can drag and drop the `.devcontainer` from this sub-folder in a locally clone copy of this resipotary into the VS code file explorer instead of using the command.
   
4. Select this definition. You may also need to select **Show All Definition....** for it to appear.

5. Finally, press <kbd>F1<kbd/> and run **Remote-Containers: Reopen Folders in Container** to start using the definition.

This definition includes some test code that will help you verify it is working as expected on your system. Open the `all-system-check` folder where you can choose to run the `.R`, `.Rmd` or `.ipynb` scripts. You should see "Hello, remote world!" in an R terminal window (for `.R` anf `.Rmd`) or within a jupyter Notebook (for `ipynb`) after the respective script executes.

At some point, you may want to make changes to your container, such as installing a new package. You'll need to rebuild your container for your changes to take effect.

## What you will learn

Let's say the Department of Transport is considering the addition of a new airport. As the incredible data scientist you are, you have been requested to explore existing data. The result of your analysis might form the basis of a report or a machine learning mode.

In this challenge, you'll explore a real-world dataset containing flights data from the US Department of Transportation.

## Milestone 1: Clean the data

Rarely we find data in the right form for analysis. As such, once you've imported you data, a good place to start your anlysis is by answering to the question: "Is the data accurate and appropriate for your desire data analysis?". Cleaning data to handle errors, missing values, and other issues pay off in the long run and allow for easier and more accurate Exploratory Data Analysis. 

In this section you will: 

- Identify any null or missing data and impute appropriate replacement values.

- Identify and eliminate any outlier in the DepDely and ArrDelay columns.

- ## Milestone 2: Exploratory Data Analysis (EDA)

- Exploratory data analysis (EDA) is used by data scientist to analyze and investigate dataset and summarize their main characteristics (e.g distribution), often by visualizing and transforming data.


In this section you'll:

- View summary statistics for the numeric fields in the dataset.

- Determine the distribution of DepDelay and ArrDelay column.


### More EDA

The goal of EDA is to develop more understanding of your data. More often than not, EDA will involve formulating some probing questions about your data, searching for answers by visualizing and transforming data.

In this section, you'll:

- Use statistics, aggregate functions and visualizations to answer the following questions:

What are the average (mean) departure and arrival delay?

How do the carrier compare in terms of arrival delay performance? 

Is there a noticeable difference in arrival delay for different days of the week?

Which departure airport has the highest
