USE pensionanalytics;
CREATE DATABASE IF NOT EXISTS pensionanalytics;
USE pensionanalytics;
#importing dataset5500
CREATE TABLE IF NOT EXISTS form5500_raw (
    ACK_ID TEXT,
    FORM_PLAN_YEAR_BEGIN_DATE TEXT,
    FORM_TAX_PRD TEXT,
    TYPE_PLAN_ENTITY_CD TEXT,
    TYPE_DFE_PLAN_ENTITY_CD TEXT,
    INITIAL_FILING_IND TEXT,
    AMENDED_IND TEXT,
    FINAL_FILING_IND TEXT,
    SHORT_PLAN_YR_IND TEXT,
    COLLECTIVE_BARGAIN_IND TEXT,
    F5558_APPLICATION_FILED_IND TEXT,
    EXT_AUTOMATIC_IND TEXT,
    DFVC_PROGRAM_IND TEXT,
    EXT_SPECIAL_IND TEXT,
    EXT_SPECIAL_TEXT TEXT,
    PLAN_NAME TEXT,
    SPONS_DFE_PN TEXT,
    PLAN_EFF_DATE TEXT,
    SPONSOR_DFE_NAME TEXT,
    SPONS_DFE_EIN TEXT,
    ADMIN_SIGNED_DATE TEXT,
    ADMIN_SIGNED_NAME TEXT,
    SPONS_SIGNED_DATE TEXT,
    SPONS_SIGNED_NAME TEXT,
    DFE_SIGNED_DATE TEXT,
    DFE_SIGNED_NAME TEXT,
    TOT_PARTCP_BOY_CNT TEXT,
    TOT_ACTIVE_PARTCP_CNT TEXT,
    RTD_SEP_PARTCP_RCVG_CNT TEXT,
    RTD_SEP_PARTCP_FUT_CNT TEXT,
    SUBTL_ACT_RTD_SEP_CNT TEXT,
    BENEF_RCVG_BNFT_CNT TEXT,
    TOT_ACT_RTD_SEP_BENEF_CNT TEXT,
    PARTCP_ACCOUNT_BAL_CNT TEXT,
    SEP_PARTCP_PARTL_VSTD_CNT TEXT,
    CONTRIB_EMPLRS_CNT TEXT,
    TYPE_PENSION_BNFT_CODE TEXT,
    TYPE_WELFARE_BNFT_CODE TEXT,
    FUNDING_INSURANCE_IND TEXT,
    FUNDING_SEC412_IND TEXT,
    FUNDING_TRUST_IND TEXT,
    FUNDING_GEN_ASSET_IND TEXT,
    BENEFIT_INSURANCE_IND TEXT,
    BENEFIT_SEC412_IND TEXT,
    BENEFIT_TRUST_IND TEXT,
    BENEFIT_GEN_ASSET_IND TEXT,
    SCH_R_ATTACHED_IND TEXT,
    SCH_MB_ATTACHED_IND TEXT,
    SCH_SB_ATTACHED_IND TEXT,
    SCH_H_ATTACHED_IND TEXT,
    SCH_I_ATTACHED_IND TEXT,
    SCH_A_ATTACHED_IND TEXT,
    NUM_SCH_A_ATTACHED_CNT TEXT,
    SCH_C_ATTACHED_IND TEXT,
    SCH_D_ATTACHED_IND TEXT,
    SCH_G_ATTACHED_IND TEXT,
    FILING_STATUS TEXT,
    DATE_RECEIVED TEXT,
    VALID_DFE_SIGNATURE TEXT,
    VALID_SPONSOR_SIGNATURE TEXT,
    ADMIN_PHONE_NUM_FOREIGN TEXT,
    SPONS_DFE_PHONE_NUM_FOREIGN TEXT,
    ADMIN_NAME_SAME_SPON_IND TEXT,
    PREPARER_FOREIGN_POSTAL_CD TEXT,
    PREPARER_PHONE_NUM TEXT,
    PREPARER_PHONE_NUM_FOREIGN TEXT,
    TOT_ACT_PARTCP_BOY_CNT TEXT
);
SET GLOBAL local_infile = 1;
show global variables like"local_infile";
SET GLOBAL local_infile = 1;
USE pensionanalytics;
LOAD DATA LOCAL INFILE
'C:/Users/jincy/Downloads/5500_latest_mysql_import_ready.csv'
INTO TABLE form5500_raw
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

# Analysing the dataset,looking for duplicates and blank cells

SELECT
    ACK_ID,
    FORM_PLAN_YEAR_BEGIN_DATE,
    PLAN_NAME,
    COUNT(*) AS duplicate_count
FROM form5500_raw
GROUP BY
   ACK_ID,
    FORM_PLAN_YEAR_BEGIN_DATE,
    PLAN_NAME
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

SELECT
    ACK_ID,
    COUNT(*) AS duplicate_count
FROM form5500_raw
GROUP BY ACK_ID
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

SELECT
    PLAN_NAME,
    COUNT(*) AS duplicate_count
FROM form5500_raw
GROUP BY PLAN_NAME
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

SELECT COUNT(*) AS null_count
FROM form5500_raw
WHERE PLAN_NAME IS NULL;

SELECT COUNT(*) AS null_count
FROM form5500_raw
WHERE ack_id IS NULL;

SELECT
    PLAN_NAME,
    SUM(TOT_ACT_RTD_SEP_BENEF_CNT) AS total_ptp_count
FROM form5500_raw
GROUP BY
    PLAN_NAME
ORDER BY total_ptp_count DESC limit 5;

#importing schedule h file

USE pensionanalytics;

CREATE TABLE schedule_h (
    ACK_ID TEXT,
    SCH_H_PLAN_YEAR_BEGIN_DATE TEXT,
    SCH_H_TAX_PRD TEXT,
    SCH_H_PN TEXT,
    SCH_H_EIN TEXT,
    REAL_ESTATE_BOY_AMT TEXT,
    OTHER_LOANS_BOY_AMT TEXT,
    PARTCP_LOANS_BOY_AMT TEXT,
    INT_COMMON_TR_BOY_AMT TEXT,
    EMPLR_PROP_BOY_AMT TEXT,
    BLDGS_USED_BOY_AMT TEXT,
    TOT_ASSETS_BOY_AMT TEXT,
    BNFTS_PAYABLE_BOY_AMT TEXT,
    OPRTNG_PAYABLE_BOY_AMT TEXT,
    ACQUIS_INDBT_BOY_AMT TEXT,
    OTHER_LIAB_BOY_AMT TEXT,
    TOT_LIABILITIES_BOY_AMT TEXT,
    NET_ASSETS_BOY_AMT TEXT,
    NON_INT_BEAR_CASH_EOY_AMT TEXT,
    EMPLR_CONTRIB_EOY_AMT TEXT,
    PARTCP_CONTRIB_EOY_AMT TEXT,
    OTHER_RECEIVABLES_EOY_AMT TEXT,
    INT_BEAR_CASH_EOY_AMT TEXT,
    GOVT_SEC_EOY_AMT TEXT,
    CORP_DEBT_PREFERRED_EOY_AMT TEXT,
    CORP_DEBT_OTHER_EOY_AMT TEXT,
    PREF_STOCK_EOY_AMT TEXT,
    COMMON_STOCK_EOY_AMT TEXT,
    JOINT_VENTURE_EOY_AMT TEXT,
    REAL_ESTATE_EOY_AMT TEXT,
    OTHER_LOANS_EOY_AMT TEXT,
    PARTCP_LOANS_EOY_AMT TEXT,
    INT_COMMON_TR_EOY_AMT TEXT,
    INT_POOL_SEP_ACCT_EOY_AMT TEXT,
    INT_MASTER_TR_EOY_AMT TEXT,
    INT_103_12_INVST_EOY_AMT TEXT,
    INT_REG_INVST_CO_EOY_AMT TEXT,
    INS_CO_GEN_ACCT_EOY_AMT TEXT,
    OTH_INVST_EOY_AMT TEXT,
    EMPLR_SEC_EOY_AMT TEXT,
    EMPLR_PROP_EOY_AMT TEXT,
    BLDGS_USED_EOY_AMT TEXT,
    TOT_ASSETS_EOY_AMT TEXT,
    BNFTS_PAYABLE_EOY_AMT TEXT,
    OPRTNG_PAYABLE_EOY_AMT TEXT,
    ACQUIS_INDBT_EOY_AMT TEXT,
    OTHER_LIAB_EOY_AMT TEXT,
    TOT_LIABILITIES_EOY_AMT TEXT,
    NET_ASSETS_EOY_AMT TEXT,
    EMPLR_CONTRIB_INCOME_AMT TEXT,
    PARTICIPANT_CONTRIB_AMT TEXT,
    OTH_CONTRIB_RCVD_AMT TEXT,
    NON_CASH_CONTRIB_BS_AMT TEXT,
    TOT_CONTRIB_AMT TEXT,
    INT_BEAR_CASH_AMT TEXT,
    INT_ON_GOVT_SEC_AMT TEXT,
    INT_ON_CORP_DEBT_AMT TEXT,
    INT_ON_OTH_LOANS_AMT TEXT,
    INT_ON_PARTCP_LOANS_AMT TEXT,
    INT_ON_OTH_INVST_AMT TEXT,
    TOTAL_INTEREST_AMT TEXT,
    DIVND_PREF_STOCK_AMT TEXT,
    DIVND_COMMON_STOCK_AMT TEXT,
    REGISTERED_INVST_AMT TEXT,
    TOTAL_DIVIDENDS_AMT TEXT,
    TOTAL_RENTS_AMT TEXT,
    AGGREGATE_PROCEEDS_AMT TEXT,
    AGGREGATE_COSTS_AMT TEXT,
    TOT_GAIN_LOSS_SALE_AST_AMT TEXT,
    UNREALZD_APPRCTN_RE_AMT TEXT,
    UNREALZD_APPRCTN_OTH_AMT TEXT,
    TOT_UNREALZD_APPRCTN_AMT TEXT,
    GAIN_LOSS_COM_TRUST_AMT TEXT,
    GAIN_LOSS_POOL_SEP_AMT TEXT,
    GAIN_LOSS_MASTER_TR_AMT TEXT,
    GAIN_LOSS_103_12_INVST_AMT TEXT,
    GAIN_LOSS_REG_INVST_AMT TEXT,
    OTHER_INCOME_AMT TEXT,
    TOT_INCOME_AMT TEXT,
    DISTRIB_DRT_PARTCP_AMT TEXT,
    INS_CARRIER_BNFTS_AMT TEXT,
    OTH_BNFT_PAYMENT_AMT TEXT,
    TOT_DISTRIB_BNFT_AMT TEXT,
    TOT_CORRECTIVE_DISTRIB_AMT TEXT,
    TOT_DEEMED_DISTR_PART_LNS_AMT TEXT,
    TOT_INT_EXPENSE_AMT TEXT,
    PROFESSIONAL_FEES_AMT TEXT,
    CONTRACT_ADMIN_FEES_AMT TEXT,
    INVST_MGMT_FEES_AMT TEXT,
    OTHER_ADMIN_FEES_AMT TEXT,
    TOT_ADMIN_EXPENSES_AMT TEXT,
    TOT_EXPENSES_AMT TEXT,
    NET_INCOME_AMT TEXT,
    TOT_TRANSFERS_TO_AMT TEXT,
    TOT_TRANSFERS_FROM_AMT TEXT,
    ACCTNT_OPINION_TYPE_CD TEXT,
    ACCT_PERFORMED_LTD_AUDIT_IND TEXT,
    ACCOUNTANT_FIRM_NAME TEXT,
    ACCOUNTANT_FIRM_EIN TEXT
);

SET GLOBAL local_infile = 1;
show global variables like"local_infile";
SET GLOBAL local_infile = 1;
USE pensionanalytics;
LOAD DATA LOCAL INFILE
'C:/Users/jincy/Downloads/scheduleH.csv'
INTO TABLE schedule_h
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;
#anaylysing schedule h file
SELECT COUNT(*) AS total_rows
FROM schedule_h;
SELECT COUNT(*) AS total_columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'schedule_h';
  
  select *
  from schedule_h
  limit 5
  
  
  #looking for missing values and percentage
  
  SELECT
    COUNT(*) AS total_rows,
    SUM(CASE
        WHEN NET_INCOME_AMT IS NULL
          OR TRIM(NET_INCOME_AMT) = ''
        THEN 1 ELSE 0
    END) AS missing_count,
    ROUND(
        100.0 * SUM(CASE
            WHEN NET_INCOME_AMT IS NULL
              OR TRIM(NET_INCOME_AMT) = ''
            THEN 1 ELSE 0
        END) / NULLIF(COUNT(*), 0),
        2
    ) AS missing_percentage
FROM schedule_h;

select
    COUNT(*) AS total_rows,
    SUM(CASE
        WHEN NET_ASSETS_EOY_AMT IS NULL
          OR TRIM(NET_ASSETS_EOY_AMT) = ''
        THEN 1 ELSE 0
    END) AS missing_count,
    ROUND(
        100.0 * SUM(CASE
            WHEN NET_ASSETS_EOY_AMT IS NULL
              OR TRIM(NET_ASSETS_EOY_AMT) = ''
            THEN 1 ELSE 0
        END) / NULLIF(COUNT(*), 0),
        2
    ) AS missing_percentage
FROM schedule_h;
select
    COUNT(*) AS total_rows,
    SUM(CASE
        WHEN TOT_EXPENSES_AMT IS NULL
          OR TRIM(TOT_EXPENSES_AMT) = ''
        THEN 1 ELSE 0
    END) AS missing_count,
    ROUND(
        100.0 * SUM(CASE
            WHEN TOT_EXPENSES_AMT IS NULL
              OR TRIM(TOT_EXPENSES_AMT) = ''
            THEN 1 ELSE 0
        END) / NULLIF(COUNT(*), 0),
        2
    ) AS missing_percentage
FROM schedule_h;

#combining two tables(scheduleh and datset5500) and creating a new table
create table pension_analysis_25 as
SELECT 
f.Ack_ID,
f.form_tax_prd,
f.PLAN_NAME,
f.TOT_ACT_RTD_SEP_BENEF_CNT as Total_PTP_count, 
h.TOT_INCOME_AMT,
h.TOT_EXPENSES_AMT,
h.NET_INCOME_AMT
FROM form5500_raw AS f
INNER JOIN Schedule_h AS h
    ON f.ACK_ID = h.ACK_ID
WHERE YEAR(
    STR_TO_DATE(f.form_tax_prd, '%c/%e/%Y')
) = 2025;

#deleting duplicates and creating new table without duplicates

CREATE TABLE pension_analysis_2025_dedup AS
SELECT DISTINCT *
FROM pension_analysis_25;

select count(*) as count
from pension_analysis_2025_dedup;

SELECT
    ACK_ID,
    COUNT(*) AS number_of_records
FROM pension_analysis_2025_dedup
GROUP BY ACK_ID
HAVING COUNT(*) > 1
ORDER BY number_of_records DESC;


select *
from pension_analysis_2025_dedup
limit 10;
select count(form_tax_prd)
from pension_analysis_2025_dedup;

#analysing missing data percentage

SELECT
    COUNT(*) AS total_records,

    SUM(
        CASE
            WHEN total_PTP_count IS NULL
              OR TRIM(total_PTP_count) = ''
            THEN 1
            ELSE 0
        END
    ) AS missing_participant_records,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN total_PTP_count IS NULL
                  OR TRIM(total_PTP_count) = ''
                THEN 1
                ELSE 0
            END
        ) / COUNT(*), 2
    ) AS missing_percentage

FROM pension_analysis_2025_dedup;



SELECT
    COUNT(*) AS total_records,

    SUM(
        CASE
            WHEN tot_expenses_AMT IS NULL
              OR TRIM(tot_expenses_AMT) = ''
            THEN 1
            ELSE 0
        END
    ) AS missing_expense_records,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN tot_expenses_AMT IS NULL
                  OR TRIM(tot_expenses_AMT) = ''
                THEN 1
                ELSE 0
            END
        ) / COUNT(*), 2
    ) AS missing_percentage

FROM pension_analysis_2025_dedup ;

#top5 highest PTP plans


SELECT
    PLAN_NAME,
    ACK_ID,
    Total_PTP_count
FROM pension_analysis_2025_dedup
WHERE Total_PTP_count IS NOT NULL
ORDER BY CAST(Total_PTP_count AS UNSIGNED) DESC
LIMIT 5;

SELECT
    PLAN_NAME,
    Total_PTP_count,
    TOT_EXPENSES_AMT
FROM pension_analysis_2025_dedup
WHERE Total_PTP_count IS NOT NULL
  AND TOT_EXPENSES_AMT IS NOT NULL
ORDER BY CAST(Total_PTP_count AS UNSIGNED) DESC;

#Does a plan with more participants have higher total expenses?

SELECT
    CASE
        WHEN participants < 100 THEN 'Under 100'
        WHEN participants < 1000 THEN '100-999'
        WHEN participants < 5000 THEN '1,000-4,999'
        WHEN participants < 10000 THEN '5,000-9,999'
        ELSE '10,000+'
    END AS plan_size,

    COUNT(*) AS number_of_records,
    ROUND(AVG(expenses), 2) AS average_total_expenses,
    ROUND(AVG(participants), 0) AS average_participants

FROM (
    SELECT
        CAST(REPLACE(TRIM(Total_PTP_count), ',', '') AS UNSIGNED) AS participants,
        CAST(REPLACE(TRIM(TOT_EXPENSES_AMT), ',', '') AS DECIMAL(18,2)) AS expenses
    FROM pension_analysis_2025_dedup
    WHERE Total_PTP_count IS NOT NULL
      AND TRIM(Total_PTP_count) <> ''
      AND TOT_EXPENSES_AMT IS NOT NULL
      AND TRIM(TOT_EXPENSES_AMT) <> ''
) AS plan_data

WHERE participants > 0

GROUP BY plan_size
ORDER BY MIN(participants);

#Which plans have higher expenses per participant?

SELECT
    PLAN_NAME,
    COUNT(*) AS number_of_records,

    ROUND(AVG(participants), 0) AS average_participants,

    ROUND(AVG(expenses), 2) AS average_total_expenses,

    ROUND(AVG(expenses / participants), 2)
        AS average_expense_per_participant

FROM (
    SELECT
        PLAN_NAME,

        CAST(
            REPLACE(TRIM(Total_PTP_count), ',', '')
            AS UNSIGNED
        ) AS participants,

        CAST(
            REPLACE(TRIM(TOT_EXPENSES_AMT), ',', '')
            AS DECIMAL(18,2)
        ) AS expenses

    FROM pension_analysis_2025_dedup

    WHERE PLAN_NAME IS NOT NULL
      AND Total_PTP_count IS NOT NULL
      AND TOT_EXPENSES_AMT IS NOT NULL
) AS plan_data

WHERE participants > 0
  AND expenses > 0

GROUP BY PLAN_NAME

ORDER BY average_expense_per_participant DESC
LIMIT 5;

#Do smaller plans appear to have higher costs per participant?

SELECT
    CASE
        WHEN participants < 100 THEN 'Under 100'
        WHEN participants < 1000 THEN '100-999'
        WHEN participants < 5000 THEN '1,000-4,999'
        WHEN participants < 10000 THEN '5,000-9,999'
        ELSE '10,000+'
    END AS plan_size,

    COUNT(*) AS number_of_records,

    ROUND(AVG(participants), 0) AS average_participants,

    ROUND(AVG(expenses), 2) AS average_total_expenses,

    ROUND(
        SUM(expenses) / NULLIF(SUM(participants), 0),
        2
    ) AS weighted_expense_per_participant

FROM (
    SELECT
        CAST(REPLACE(TRIM(Total_PTP_count), ',', '') AS UNSIGNED)
            AS participants,

        CAST(REPLACE(TRIM(TOT_EXPENSES_AMT), ',', '') AS DECIMAL(18,2))
            AS expenses

    FROM pension_analysis_2025_dedup

    WHERE Total_PTP_count IS NOT NULL
      AND TRIM(Total_PTP_count) <> ''
      AND TOT_EXPENSES_AMT IS NOT NULL
      AND TRIM(TOT_EXPENSES_AMT) <> ''
) AS plan_data

WHERE participants > 0
  AND expenses > 0

GROUP BY plan_size
ORDER BY MIN(participants);



   




       