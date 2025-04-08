# Zero-setup R workshops with Github Codespaces

This is the resipotary supporting the presentation "Zero-setup R workshops with GitHub Codespaces".

* Presenter: [David Smith](https://www.linkedin.com/in/dmsmith/), Cloud Advocate at Microsoft
* Presented at: [rstudio::conf, July 28 2022](https://rstudioconf2022.sched.com/event/11iag/zero-setup-r-workshops-with-github-codespaces)
* Presentation slides: [PDF](ZeroSetupWorkshopsRStudioConf2022.pdf)
* Presentation Video: [YouTube](https://www.youtube.com/watch?v=2uXLikk30Ew) | [RStudio](https://www.rstudio.com/conference/2022/talks/zero-setup-r-workshops-github/)

You can recreate the demos in the talk using the steps outline below.

## Dev Containers in Github Codespaces

If you have access to Github CodeSpaces, click the green, "<> Code" button at the top right on this resipotary page, and then select "Create codespace on main". (Github codeSpaces is available with [GitHub Enterprise](https://github.com/enterprise) and [GitHub Education](https://education.github.com/).)

Now, browse to the file [explore-analyze-data-with-R/solution/challenge-Data_Exploration.ipynb](explore-analyze-data-with-R/solution/challenge-Data_Exploration.ipynb). Work throught the Jupyter Notebook.

To open RStudio Server, click the Forwarded Ports "Radio" icon at the bottom of the VS Code Online window.

![Forwarded Ports](img/forwarded_ports.png)

In the ports tab, click the open in Browser "World" icon that appear when you hover in the "Local Address" column for the Rstudio row.

![Ports](img/ports.png)

This will launch RStudio Server in a new window. Log in with your username and password `rstudio/rstudio`.

*NOTE: Sometimes, the RStudio window may fail to open with a timeout error. If this happen, try agian, or restart the Codespace.
