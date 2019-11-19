## Investigating Insurance Coverage Status and Changes from The UMD Data
### First Draft
*I had two long midterm exams last week so I dedicated most of my time to studying for them. Due to other remaining homework, I barely had time to start on the project this past weekend and could just finish data wrangling and a small part of the analysis. Consequently, this is by no means a complete analysis (and the Make and Docker parts are not added yet too). My sincere apologies if this draft does not live up to your expected levels. I had outlined what I would do in the parts I did not finish and also put my project descriptions below. Please leave your feedbacks based on them. Any constructive thoughts, even only on the questions I selected below and plan to answer with my project, are highly valuable for me! Thank you for your understandings!!!*

### Background and Questions:
Among the bundle of data we received from the UMD, there are two files that contain the insurance status of clients at their entry to and exit from the shelter. However, at first inspections, many of the clients do not have any identified insurance coverage. Therefore, combined with the demographic data also available from the bundle, we wish to investigate the following questions:

* What proportion of the clients have insurance coverage?
* What kind of demographic attributes is associated with higher chance of coverage?
* What kind of coverage (i.e., Medicare, Medicaid, etc.) people entering the shelter typically have (for those who already have coverage)? 
* Did more people get covered at their exit from the shelter compared to at their entry to?

### Data Used
Three separate data files were utilized in this project: the demographic data file (CLIENT_191102.tsv), the insurance status at entry (HEALTH_INS_ENTRY_191102.tsv), and the insurance status at exit (HEALTH_INS_EXIT_191102.tsv) 
