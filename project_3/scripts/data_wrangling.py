#!/usr/bin/env python
# coding: utf-8

# In[22]:


# Read the data files
import pandas as pd
import numpy as np
import os as os

# Raw and final data file directory paths
raw_dir = '../raw_data/'
final_dir = '../final_data/'

# Read in the raw data
# Demographic data
df_demo = pd.read_csv(os.path.join(raw_dir, 'CLIENT_191102.tsv'), sep = '\t')
# Insurance data
df_ins_1 = pd.read_csv(os.path.join(raw_dir, 'HEALTH_INS_ENTRY_191102.tsv'), sep = '\t')
df_ins_2 = pd.read_csv(os.path.join(raw_dir, 'HEALTH_INS_EXIT_191102.tsv'), sep = '\t')


# In[23]:


# Subset the demographic dataset and rename the columns
df_demo_keep = df_demo[['Client ID', 'Client Age at Entry', 'Client Gender',
       'Client Primary Race', 'Client Ethnicity', 'Client Veteran Status']]
df_demo_keep.columns = ['id', 'age_at_entry', 'gender', 'race', 'ethnicity', 'veteran_status']
# Remove the duplicate entries
df_demo_keep = df_demo_keep.drop_duplicates(subset = 'id')
# Drop the rows with empty values
df_demo_keep = df_demo_keep.dropna(how = 'any')
df_demo_keep.head()


# In[24]:


# Subset the insurance status at entry data
df_ins_1_keep = df_ins_1[['Client ID', 'Covered (Entry)', 'Health Insurance Type (Entry)']]
df_ins_1_keep.columns = ['id', 'ins_covered_entry', 'ins_type_entry']
# Find the individuals with insurance coverage
df_ins_1_final = df_ins_1_keep[df_ins_1_keep.ins_covered_entry == 'Yes']
df_ins_1_final = df_ins_1_final.drop_duplicates(subset = 'id')
df_ins_1_final.head()


# In[25]:


# Subset the insurance status at exit data
df_ins_2_keep = df_ins_2[['Client ID', 'Covered (Exit)', 'Health Insurance Type (Exit)']]
df_ins_2_keep.columns = ['id', 'ins_covered_exit', 'ins_type_exit']
# Find the individuals with insurance coverage
df_ins_2_final = df_ins_2_keep[df_ins_2_keep.ins_covered_exit == 'Yes']
df_ins_2_final = df_ins_2_final.drop_duplicates(subset = 'id')
df_ins_2_final.head()


# In[26]:


# Now we merge and output data
# First, the insurance data
df_ins = df_ins_2_final.merge(df_ins_1_final, on = ['id'], how = 'outer')
df_ins.head()


# In[27]:


# Then, we merge the insurance with the demographic data
df_total = df_demo_keep.merge(df_ins, on = ['id'], how = 'outer')
# We remove some other minor typos (such as 'nan')
df_total = df_total.dropna(subset = ['age_at_entry', 'gender', 'race', 'ethnicity', 'veteran_status'])
df_total.head()


# In[28]:


# Now we convert the non-analytic formats in race/ethnicity/veteran status to analytic formats
# We do so by setting up dictionaries annd invoking the list comprehension
set(df_total.race)
race_dic = {
    'American Indian or Alaska Native (HUD)': 'Indian/Alaskan',
    'Asian (HUD)': 'Asian',
    'Black or African American (HUD)': 'Black',
    "Client doesn't know (HUD)": 'Unknown',
    'Client refused (HUD)': 'Refused',
    'Data not collected (HUD)': 'Not-collected',
    'Native Hawaiian or Other Pacific Islander (HUD)': 'Hawaiian/Islander',
    'White (HUD)': 'White'
}

eth_dic = {
    "Client doesn't know (HUD)": 'Unknown',
    'Client refused (HUD)': 'Refused',
    'Data not collected (HUD)': 'Not-collected',
    'Hispanic/Latino (HUD)': 'Hispanic/Latino',
    'Non-Hispanic/Non-Latino (HUD)': 'Non-Hispanic/Non-Latino'
}

vet_dic = {
    'Data not collected (HUD)' : 'Not-collected',
    'No (HUD)' : 'No',
    'Yes (HUD)' : 'Yes'
}

# Replace the values with the ones in analytic formats 
df_total.race = [race_dic[x] for x in df_total.race] 
df_total.ethnicity = [eth_dic[x] for x in df_total.ethnicity]
df_total.veteran_status = [vet_dic[x] for x in df_total.veteran_status]


# In[29]:


# We fill the 'nan' values with 'No' in the binary variables for insurance coverage
df_total.ins_covered_exit = df_total.ins_covered_exit.fillna('No')
df_total.ins_covered_entry = df_total.ins_covered_entry.fillna('No')
# Then we fill the 'nan' values in insurance types with 'Uncovered' if the clients do not have an insurance
df_total.ins_type_exit = df_total.ins_type_exit.fillna('Uncovered')
df_total.ins_type_entry = df_total.ins_type_entry.fillna('Uncovered')
df_total.head()


# In[37]:


# Now we change the levels of some categorical variables to make them shorter 
# We also label all sources of unknown values (refused answers, not collected responses, etc.) to 'Unknown'
df_total.race = df_total.race.replace(['Hawaiian/Islander', 'Indian/Alaskan', 'Not-collected', 'Refused'], 
                                      ['Haw/Isl', 'Ind/Ak', 'Unknown', 'Unknown'])
df_total.gender = df_total.gender.replace('Trans Female (MTF or Male to Female)', 'Trans Female')
df_total.ethnicity = df_total.ethnicity.replace(['Hispanic/Latino', 'Non-Hispanic/Non-Latino', 'Not-collected', 'Refused'],
                                               ['His/Lat', 'Non-His/Non-Lat', 'Unknown', 'Unknown'])
df_total.veteran_status = df_total.veteran_status.replace('Not-collected', 'Unknown')
df_total.head()


# In[36]:


# Write the output CSV file
df_total.to_csv(os.path.join(final_dir, "wrangled_data.csv"), index = False)


# In[ ]:




