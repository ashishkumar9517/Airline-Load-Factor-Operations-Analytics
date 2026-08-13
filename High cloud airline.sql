SET SQL_SAFE_UPDATES = 0;
SELECT

    -- Create Date Field
    STR_TO_DATE(
        CONCAT(`Year`, '-', `Month (#)`, '-', `Day`),
        '%Y-%m-%d'
    ) AS FlightDate,
    -- A. Year
    YEAR(
        STR_TO_DATE(
            CONCAT(`Year`, '-', `Month (#)`, '-', `Day`),
            '%Y-%m-%d'
        )
    ) AS Year,
   -- B. Month Number
    MONTH(
        STR_TO_DATE(
            CONCAT(`Year`, '-', `Month (#)`, '-', `Day`),
            '%Y-%m-%d'
        )
    ) AS MonthNo,
    -- C. Month Full Name
    MONTHNAME(
        STR_TO_DATE(
            CONCAT(`Year`, '-', `Month (#)`, '-', `Day`),
            '%Y-%m-%d'
        )
    ) AS MonthFullName,
    -- D. Quarter
    CONCAT(
        'Q',
        QUARTER(
            STR_TO_DATE(
                CONCAT(`Year`, '-', `Month (#)`, '-', `Day`),
                '%Y-%m-%d'
            )
        )
    ) AS Quarter,
    -- E. YearMonth (YYYY-MMM)
    DATE_FORMAT(
        STR_TO_DATE(
            CONCAT(`Year`, '-', `Month (#)`, '-', `Day`),
            '%Y-%m-%d'
        ),
        '%Y-%b'
    ) AS YearMonth,
    -- F. Weekday Number
    WEEKDAY(
        STR_TO_DATE(
            CONCAT(`Year`, '-', `Month (#)`, '-', `Day`),
            '%Y-%m-%d'
        )
    ) + 1 AS WeekdayNo,
    -- G. Weekday Name
    DAYNAME(
        STR_TO_DATE(
            CONCAT(`Year`, '-', `Month (#)`, '-', `Day`),
            '%Y-%m-%d'
        )
    ) AS WeekdayName,
    -- H. Financial Month
    CASE
        WHEN MONTH(
            STR_TO_DATE(
                CONCAT(`Year`, '-', `Month (#)`, '-', `Day`),
                '%Y-%m-%d'
            )
        ) >= 4
        THEN MONTH(
            STR_TO_DATE(
                CONCAT(`Year`, '-', `Month (#)`, '-', `Day`),
                '%Y-%m-%d'
            )
        ) - 3

        ELSE MONTH(
            STR_TO_DATE(
                CONCAT(`Year`, '-', `Month (#)`, '-', `Day`),
                '%Y-%m-%d'
            )
        ) + 9
    END AS FinancialMonth,
    -- I. Financial Quarter
    CASE
        WHEN MONTH(
            STR_TO_DATE(
                CONCAT(`Year`, '-', `Month (#)`, '-', `Day`),
                '%Y-%m-%d'
            )
        ) BETWEEN 4 AND 6 THEN 'Q1'

        WHEN MONTH(
            STR_TO_DATE(
                CONCAT(`Year`, '-', `Month (#)`, '-', `Day`),
                '%Y-%m-%d'
            )
        ) BETWEEN 7 AND 9 THEN 'Q2'

        WHEN MONTH(
            STR_TO_DATE(
                CONCAT(`Year`, '-', `Month (#)`, '-', `Day`),
                '%Y-%m-%d'
            )
        ) BETWEEN 10 AND 12 THEN 'Q3'

        ELSE 'Q4'
    END AS FinancialQuarter

FROM maindata;

-- Q2

SELECT

    YEAR(FlightDate) AS Year,

    CONCAT('Q', QUARTER(FlightDate)) AS Quarter,

    DATE_FORMAT(FlightDate, '%Y-%m') AS Month,

    ROUND(
        SUM(`Transported Passengers`) * 100.0 /
        SUM(`Available Seats`),
        2
    ) AS LoadFactorPercentage

FROM maindata

GROUP BY
    YEAR(FlightDate),
    QUARTER(FlightDate),
    DATE_FORMAT(FlightDate, '%Y-%m')

ORDER BY
    Year,
    Quarter,
    Month;
SHOW COLUMNS FROM maindata;

-- Q3

SELECT 
    `Carrier Name`,
    ROUND(
        (SUM(`# Transported Passengers`) / 
         SUM(`# Available Seats`)) * 100,
        2
    ) AS LoadFactorPercentage
FROM maindata
GROUP BY `Carrier Name`
ORDER BY LoadFactorPercentage DESC;

-- Q4

SELECT 
    `Carrier Name`,
    SUM(`# Transported Passengers`) AS TotalPassengers
FROM maindata
GROUP BY `Carrier Name`
ORDER BY TotalPassengers DESC
LIMIT 10;

-- Q5
SELECT 
    `From - To City`,
    SUM(`# Departures Performed`) AS TotalFlights
FROM maindata
GROUP BY `From - To City`
ORDER BY TotalFlights DESC
LIMIT 10;

-- Q6
SELECT 
    CASE 
        WHEN DAYOFWEEK(FlightDate) IN (1,7) 
        THEN 'Weekend'
        ELSE 'Weekday'
    END AS DayType,

    ROUND(
        (SUM(`# Transported Passengers`) / 
         SUM(`# Available Seats`)) * 100,
        2
    ) AS LoadFactorPercentage

FROM maindata
GROUP BY DayType;

-- Q7
SELECT 
    `%Distance Group ID` AS DistanceGroup,
    SUM(`# Departures Performed`) AS TotalFlights
FROM maindata
GROUP BY `%Distance Group ID`
ORDER BY TotalFlights DESC;