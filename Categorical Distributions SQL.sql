-- create a temporary table with percentage calculated as a decimal fraction
WITH CategoryStats AS (
    SELECT 
        Status,
        COUNT(*) AS Frequency,
        CAST(COUNT(*) * 1.0 / SUM(COUNT(*)) OVER () AS DECIMAL(10,4)) AS [Relative Fraction]
    FROM [dbo].[CategoricalDistributions]
    GROUP BY Status
)

-- select rows by category, convert fractions into readable percentages, and add Grand Total
SELECT 
    Status,
    Frequency,
    CAST([Relative Fraction] * 100 AS DECIMAL(5,2)) AS [Relative Frequency, %]
FROM CategoryStats

UNION ALL

SELECT 
    'GRAND TOTAL',
    SUM(Frequency),
    CAST(SUM([Relative Fraction]) * 100 AS DECIMAL(5,2))
FROM CategoryStats;

