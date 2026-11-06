# Pension Plan Expense Analysis Using Form 5500 Data

## Executive Summary

This project analyzes U.S. pension plan financial data from the Department of Labor's Form 5500 and Schedule H datasets. The goal is to understand how pension plan expenses vary based on plan size, measured by participant count, and to identify plans with unusually high expenses per participant.

I used **MySQL** to import, clean, join, and analyze the datasets and **Power BI** to create visualizations and explore patterns in the data.

The analysis found that larger pension plans generally have higher total expenses, while smaller plans—particularly those with fewer than 100 participants—show substantially higher average expenses per participant. These findings may help identify plans that deserve further investigation.

## Business Problem

Pension plans vary significantly in size, financial activity, and administrative expenses. Understanding these differences can help identify cost patterns and potential areas for further review.

This project addresses the following business questions:

1. Do pension plans with more participants have higher total expenses?
2. Which plans have higher expenses per participant?
3. Do smaller plans appear to have higher costs per participant?
4. Are there plans with unusually high expenses that deserve further investigation?

## Data Source

The analysis uses publicly available Form 5500 and Schedule H data published by the U.S. Department of Labor, Employee Benefits Security Administration (EBSA).

**Source:** [U.S. Department of Labor – Form 5500 Datasets](https://www.dol.gov/agencies/ebsa/about-ebsa/our-activities/public-disclosure/foia/form-5500-datasets)

The analysis focuses on filings for the 2025 tax period.

## Methodology

### 1. Data Import and Preparation
- Imported the Form 5500 and Schedule H datasets into MySQL.
- Used MySQL's `LOAD DATA INFILE` approach because importing the large CSV files through the import wizard was unsuccessful.
- Reviewed the data structure and relevant fields before analysis.

### 2. Data Quality Checks
- Checked for duplicate records and missing values.
- Identified that the same plan name can appear across different plan years, so repeated plan names were not automatically treated as duplicates.
- Used plan name, plan year beginning date, and ACK_ID to examine filing records.
- Checked ACK_ID for duplicate filing identifiers.
- Verified that plan name and ACK_ID had no missing values in the Form 5500 data.
- Reviewed missing values in Schedule H financial fields, including income, assets, and expenses.
- Retained missing values rather than automatically replacing them with zero.

### 3. Data Filtering and Joining
- Filtered Form 5500 records to the 2025 tax period.
- Joined Form 5500 and Schedule H using ACK_ID.
- Created a new analysis table containing plan information, participant counts, and financial measures.

### 4. SQL Analysis
Used SQL queries to:
- Compare total expenses across participant-size categories.
- Calculate average expenses per participant.
- Identify plans with unusually high expenses.
- Review the largest plans by participant count.
- Examine income, expenses, and net income.

### 5. Power BI Visualization
Created visualizations to explore:
- The relationship between participant count and total expenses.
- Expense patterns across different plan-size categories.
- Potential outliers and unusual expense patterns.
- The relationship between plan income and expenses.

## Skills and Tools

**Technical Skills**
- SQL (MySQL): Data importing, filtering, joins, aggregations, duplicate checks, missing-value analysis, and calculations.
- Power BI: Data visualization, charts, and dashboard development.
- Excel: Data review and preliminary analysis.

**Business and Analytical Skills**
- Data cleaning and validation
- Exploratory data analysis (EDA)
- Financial data analysis
- Outlier identification


## Results and Key Findings

### 1. Larger Plans Have Higher Total Expenses

Plans with 10,000 or more participants have average total expenses of approximately **$427.37 million**, compared with approximately **$19.48 million** for plans with 1,000–4,999 participants.

This suggests that larger pension plans generally have substantially higher total expenses.

However, the relationship is not perfectly consistent. Plans with fewer than 100 participants have higher average total expenses than plans with 100–999 participants. This may be influenced by unusually high expenses in a small number of plans or potential data-quality issues.

### 2. Smaller Plans Have Higher Expenses Per Participant

The analysis identified a significant difference in average expenses per participant across plan-size categories:

| Participant Category | Average Expenses Per Participant |
|---|---:|
| Under 100 | $95,381.65 |
| 100–999 | $9,067.18 |
| 10,000+ | $11,139.04 |

Plans with fewer than 100 participants have substantially higher average expenses per participant than the other categories.

This may indicate that smaller plans experience higher costs relative to their participant populations.

### 3. Potential High-Expense Outliers

The analysis identified unusually high expenses per participant, particularly among plans with fewer than 100 participants.

These plans may deserve further investigation to determine whether the high costs are related to plan characteristics, administrative expenses, unusual financial activity, or data-quality issues.

### 4. Income and Expense Patterns

The Power BI visualizations support the patterns identified through SQL analysis.

- Most plans have higher reported income than expenses.
- The scatter plot shows a concentration of plans with relatively low participant counts and expenses.
- A smaller number of plans appear as potential outliers with unusually high expenses.

These observations provide opportunities for additional analysis rather than definitive conclusions about the causes of high expenses.
<img width="815" height="517" alt="image" src="https://github.com/user-attachments/assets/2ce1a32b-b38c-4271-a2b7-2836b886e1d8" />
<img width="1325" height="747" alt="image" src="https://github.com/user-attachments/assets/00d645a6-027f-4958-ad89-3c9d9ff7b108" />
<img width="1337" height="756" alt="image" src="https://github.com/user-attachments/assets/d1a3f792-43f2-40d2-8c4b-77793205c7ef" />



## Business Recommendations

Based on the findings, the following actions are recommended:

1. **Investigate small plans with high expenses per participant.** Review plans with fewer than 100 participants and unusually high expense ratios to determine the factors driving their costs.

2. **Compare expenses across plan sizes.** Evaluate whether smaller plans have different cost structures or administrative requirements compared with larger plans.

3. **Review outliers individually.** Examine the financial information of plans with unusually high expenses to distinguish legitimate high-cost activity from possible reporting or data-quality issues.

4. **Monitor financial trends over time.** Compare multiple filing years to identify changes in expenses, income, and expenses per participant.

## Limitations

- Approximately 15% of participant-count data is missing.
- Approximately 31% of total expense values are missing in the analysis dataset; missing values were retained rather than automatically treated as zero.
- Some plans may have unusually high financial values that influence averages.
- The analysis focuses on the 2025 tax period, so it does not yet capture multi-year trends.
- High expenses per participant do not necessarily indicate inefficient plan administration. Additional investigation is needed to understand the reasons behind these values.

## Next Steps

- Separate 401(k) plans from other retirement plan types and compare their expense patterns.
- Incorporate prior-year Form 5500 data to analyze changes over time.
- Identify recurring high-expense plans and investigate whether their expense patterns persist across years.
- Develop a predictive model to explore future expense trends.
- Improve the analysis by investigating outliers and validating missing or unusual financial values.



---


