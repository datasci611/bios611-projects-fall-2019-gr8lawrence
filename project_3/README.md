## Investigating Insurance Coverage Status and Changes from The UMD Data

### Background and Aims:
Homelessness and lacks of health insurance coverage are closely interwoven. Among the bundle of data we received from the UMD, there are two files that contain the insurance status of clients at their entry to and exit from the shelter. However, at first inspections, many of the clients do not have any identified insurance coverage. Therefore, combined with the demographic data also available from the bundle, we wish to investigate the following questions:

* How many clients had insurance when they entered the shelter?
* What types of insurance did the clients have?
* What demographic factors contribute to higher chances of having insurance?
* Were there more people getting insured when they exited the shelter compared to when they entered the shelter?

### Methods
The entire analysis consists of three parts:
* Showing the distributions of demographic variables
* Showing the overall health insurance coverage situations of the clients at UMD
* Using a logistic regression model to estimate the odds of a client with certain demographic characteristics of being uninsured

### Data Used
Three separate data files given in the UMD data bundle were utilized in this project: the demographic data file `CLIENT_191102.tsv`, the insurance status at entry `HEALTH_INS_ENTRY_191102.tsv`, and the insurance status at exit `HEALTH_INS_EXIT_191102.tsv`. The data were wrangled in Python and analyzed in R. Details are referred to in the output markdown file.

### How To Run The Analysis And Generate The Output Markdown File?
To generate the outputs on any computing platform, run the following bash command line:
```
git clone https://github.com/datasci611/bios611-projects-fall-2019-gr8lawrence && cd bios611-projects-fall-2019-gr8lawrence/project_3 && make
```
Then you can find the final output `project_3_markdown.html` by navigating to the `outputs` folder:
```
cd ../outputs && ls
```